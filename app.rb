#!/usr/bin/env ruby

require 'json'
require 'sinatra/base'
require 'httparty'
require_relative './lib/alphavantage.rb'

class AVAPI < Sinatra::Base

  get "/" do
    output = AlphaVantage::Client.get_data('TIME_SERIES_DAILY',ENV['TICKER'],ENV['API_KEY'])
    return(AlphaVantage::DataGatherer.combine_data(output,ENV['NDAYS']))
  end
end
