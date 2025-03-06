require 'sinatra'
require 'stripe'
require 'dotenv'
Dotenv.load

# This is your test secret API key.
Stripe.api_key = ENV['STRIPE_API_KEY']

Stripe.api_version = '2023-10-16'

set :static, true
set :port, 4242
set :public_folder, 'dist'

#create a page to server checkout.html
get '/checkout' do
  send_file File.join(settings.public_folder, 'checkout.html')
end

get '/*path' do
  send_file File.join(settings.public_folder, 'index.html')
end

post '/account_link' do
  content_type 'application/json'

  body = JSON.parse(request.body.read)
  connected_account_id = body["account"]

  begin
    account_link = Stripe::AccountLink.create({
      account: connected_account_id,
      return_url: "http://localhost:4242/return/#{connected_account_id}",
      refresh_url: "http://localhost:4242/refresh/#{connected_account_id}",
      type: "account_onboarding",
    })

    {
      url: account_link.url
    }.to_json
  rescue => error
    puts "An error occurred when calling the Stripe API to create an account link: #{error.message}";
    return [500, { error: error.message }.to_json]
  end
end

post '/account' do
  content_type 'application/json'

  begin
    account = Stripe::Account.create

    {
      account: account[:id]
    }.to_json
  rescue => error
    puts "An error occurred when calling the Stripe API to create an account: #{error.message}";
    return [500, { error: error.message }.to_json]
  end
end
