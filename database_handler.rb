require 'mysql2'
require 'connection_pool'
require 'singleton'
require_relative 'config'

class DatabaseHandler
  include Singleton
  attr_reader :connection

  def self.connection
    instance.connection
  end

  def self.setup
    instance.setup
  end

  def setup
    # @connection = Mysql2::Client.new(:host => MYSQL_DB_HOST, :port => MYSQL_DB_PORT, :username => MYSQL_DB_USER, :password => MYSQL_DB_PASSWORD, :database => MYSQL_DB_NAME, :reconnect => true)
    # @connection.query_options.merge!(:symbolize_keys => true)
    @connection = ConnectionPool::Wrapper.new(size: 5, timeout: 5) do
      Mysql2::Client.new(:host => MYSQL_DB_HOST, :port => MYSQL_DB_PORT, :username => MYSQL_DB_USER, :password => MYSQL_DB_PASSWORD, :database => MYSQL_DB_NAME, :reconnect => true, :symbolize_keys => true)
    end
  end
end