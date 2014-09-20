kinesis_writer
==============

I was just looking for a simple way to get some data into Kinesis to play around with.
Here's a little Sinatra app that does exactly that!


Configuration
-------------

You'll need a Kinesis stream and an IAM user with sufficient credentials to play with.

The following variables need to be set:

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* KINESIS_STREAM_NAME
* KINESIS_PARTITION_KEY

You can set these either directly as environment variables, or by creating a `.env` file for [dotenv](https://github.com/bkeepers/dotenv).


Running the App
---------------

You can start it locally via `rackup`, or deploy it as-is on Heroku (configuration notwithstanding).

To push some data into it, from another Ruby process, you can run:

```ruby
require 'rest_client'
RestClient.post 'http://localhost:9292/put', { data: 'hello, dolly' }
```

(Substituting "localhost:9292" as needed)

As a bonus, you can tail your Kinesis stream locally by running `bundle exec ./tail.rb`
