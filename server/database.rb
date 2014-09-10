gem 'dm-core'
gem 'dm-migrations'

DataMapper.setup(:default, "sqlite://#{File.dirname(__FILE__)}/database.sqlite")


class Tarefa
  include DataMapper::Resource

  property :id, Serial, :key => true
  property :atividade, String, :required => true
  property :concluido, Boolean, :default => false
end

DataMapper.finalize
DataMapper.auto_upgrade!