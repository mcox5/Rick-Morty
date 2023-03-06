require 'rspec/autorun'
require 'csv'
require_relative '../lib/rickmorty.rb'
require_relative '../lib/models/character.rb'

describe Rickmorty do
  let(:rickmortycheck) { Rickmorty.new("/Users/matiascoxedwards/code/mcox5/chipax-original/Rick&Morty/lib/characters.csv", "/Users/matiascoxedwards/code/mcox5/chipax-original/Rick&Morty/lib/episodes.csv", "/Users/matiascoxedwards/code/mcox5/chipax-original/Rick&Morty/lib/locations.csv") }
  let(:character_url) { 'https://rickandmortyapi.com/api/character' }
  let(:episode_url) { 'https://rickandmortyapi.com/api/episode' }
  let(:location_url) { 'https://rickandmortyapi.com/api/location' }

  let(:number_characters) { rickmortycheck.get_request(character_url)['info']['count'] }
  let(:number_episodes) { rickmortycheck.get_request(episode_url)['info']['count'] }
  let(:number_locations) { rickmortycheck.get_request(location_url)['info']['count'] }


  it "Se solicitan correctamente todos los caracteres a la API" do
    expect(rickmortycheck.characters.size).to eq(number_characters) # chequeamos que estén todos los caracteres
    expect(rickmortycheck.characters[0].name.class).to eq(String) # chequeamos que estén todos los caracteres en formato String
  end

  it "Se solicitan correctamente todos las localizaciones a la API" do
    expect(rickmortycheck.locations.size).to eq(number_locations) # chequeamos que estén todos los caracteres
    expect(rickmortycheck.locations[0].name.class).to eq(String) # chequeamos que estén todos los localizaciones en formato String
  end

  it "Se solicitan correctamente todos los episodios a la API" do
    expect(rickmortycheck.episodes.size).to eq(number_episodes) # chequeamos que estén todos los caracteres
    expect(rickmortycheck.episodes[0].name.class).to eq(String) # chequeamos que estén todos los caracteres en formato String
  end

  it "El metodo count letter funciona correctamente y retorna un número" do
    expect(rickmortycheck.count_letter("a",rickmortycheck.characters).class).to eq(Integer)
  end

  it "El metodo count letter es case insensitive" do
    rickmortycheck_copy = rickmortycheck
    rickmortycheck_copy.characters[0] = Character.new(rickmortycheck.characters[0].name.upcase, rickmortycheck.characters[0].origin)
    expect(rickmortycheck.count_letter("c",rickmortycheck.characters)).to eq(rickmortycheck_copy.count_letter("c",rickmortycheck_copy.characters))
  end
end
