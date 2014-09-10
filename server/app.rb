#encoding: UTF-8

require 'rubygems'
require 'bundler'
Bundler.require
require 'json'
require './database.rb'


get '/' do
  'Hello World!'
end

# Busca todas as tarefas
get '/tarefas' do
  content_type :json

  tarefas = Tarefa.all.collect {|t| t.attributes}

  tarefas.to_json
end

# Busca a tarefa :id
get '/tarefas/:id' do
  content_type :json

  Tarefa.get(params[:id]).attributes.to_json
end

# Cria nova tarefa
post '/tarefas' do
  content_type :json

  conteudo = JSON.parse(request.body.read)
  nova_tarefa = Tarefa.create(conteudo)

  nova_tarefa.attributes.to_json
end

# Atualiza tarefa :id
put '/tarefas/:id' do
  content_type :json

  conteudo = JSON.parse(request.body.read)
  tarefa = Tarefa.get(params[:id])
  halt 404, "Not Found" if tarefa.nil?

  tarefa.update(conteudo)
  tarefa.attributes.to_json
end