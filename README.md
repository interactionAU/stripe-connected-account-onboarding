# Onboard accounts to your Connect platform

Build a Connect integration which creates an account and onboards it to your platform.

Here are some basic scripts you can use to build and run the application.

You also need a .env file with the following variables:

```
STRIPE_SECRET_KEY=sk_test_...
```

## Run the sample

1. Build the server

~~~
bundle install
~~~

2. Run the server

~~~
ruby server.rb -o 0.0.0.0
~~~

3. Go to [http://localhost:4242](http://localhost:4242)
