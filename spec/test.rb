require 'rspec/autorun'
require_relative '../lib/rickmorty.rb'

describe Rickmorty do
  let(:rickmortycheck) {Rickmorty.new}
  it "Se solicitan correctamente todos los caracteres a la API" do
    expect(rickmortycheck.characters.size).to eq(826) # chequeamos que estén todos los caracteres
    expect(rickmortycheck.characters[0].name.class).to eq(String) # chequeamos que estén todos los caracteres en formato String
  end

  it "Se solicitan correctamente todos las localizaciones a la API" do
    expect(rickmortycheck.locations.size).to eq(126) # chequeamos que estén todos los caracteres
    expect(rickmortycheck.locations[0].name.class).to eq(String) # chequeamos que estén todos los localizaciones en formato String
  end

  it "Se solicitan correctamente todos los episodios a la API" do
    expect(rickmortycheck.episodes.size).to eq(51) # chequeamos que estén todos los caracteres
    expect(rickmortycheck.episodes[0].name.class).to eq(String) # chequeamos que estén todos los caracteres en formato String
  end

  it "El metodo count letter funciona correctamente y retorna un número" do
    expect(rickmortycheck.count_letter("a",rickmortycheck.characters).class).to eq(Integer)
  end

end
