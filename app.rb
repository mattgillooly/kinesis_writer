#!/usr/bin/env ruby

require 'dotenv'
Dotenv.load

require 'sinatra'
require 'aws'
require 'time'

c = AWS::Kinesis::Client.new(
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
)

get '/' do
  "Site's up!"
end

post '/put' do
  c.put_record(
    stream_name: ENV['KINESIS_STREAM_NAME'],
    partition_key: ENV['KINESIS_PARTITION_KEY'],
    data: params[:data]
  )
end
