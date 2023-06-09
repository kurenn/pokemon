require 'rails_helper'

RSpec.describe PokeApi::Pokemon do
  describe '.search' do
    context 'when it finds pokemons' do
      it 'returns a pokemon collection' do
        stub_request(:get, 'https://pokeapi.co/api/v2/pokemon?limit=1281')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: File.read("#{Rails.root}/spec/json_responses/pokemons.json"), headers: { 'Content-Type' => 'application/json' })

        stub_request(:get, 'https://pokeapi.co/api/v2/pokemon/bulbasaur')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: File.read("#{Rails.root}/spec/json_responses/bulbasaur.json"), headers: { 'Content-Type' => 'application/json' })

        pokemons = described_class.search('bulb')

        expect(pokemons.count).to eq(1)
        expect(pokemons[0].name).to eq('bulbasaur')
      end
    end
  end

  describe '.find' do
    context 'when the request is successful' do
      let(:body) do
        {
          id: 1,
          height: 7,
          weight: 69,
          name: 'bulbasaur',
          abilities: [
            {
              ability: {
                name: 'overgrow',
                url: 'https://pokeapi.co/api/v2/ability/65/'
              },
              is_hidden: false,
              slot: 1
            },
            {
              ability: {
                name: 'chlorophyll',
                url: 'https://pokeapi.co/api/v2/ability/34/'
              },
              is_hidden: true,
              slot: 3
            }
          ],
          moves: [
            {
              move: {
                name: 'razor-wind',
                url: 'https://pokeapi.co/api/v2/move/13/'
              }
            },
            {
              move: {
                name: 'swords-dance',
                url: 'https://pokeapi.co/api/v2/move/14/'
              }
            }
          ]
        }.to_json
      end

      it 'returns a pokemon' do
        stub_request(:get, 'https://pokeapi.co/api/v2/pokemon/1')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body:, headers: { 'Content-Type' => 'application/json' })

        pokemon = described_class.find(1)

        expect(pokemon).to be_a(described_class)
        expect(pokemon.name).to eq('bulbasaur')
      end
    end

    context 'when the request is not successful' do
      before do
        stub_request(:get, 'https://pokeapi.co/api/v2/pokemon/1')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 404, body: '', headers: {})
      end

      it 'raises a client exception' do
        expect { described_class.find(1) }.to raise_error(PokeApi::Exception::ClientError)
      end

      it 'raises a server exception' do
        stub_request(:get, 'https://pokeapi.co/api/v2/pokemon/1')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 500, body: '', headers: {})

        expect { described_class.find(1) }.to raise_error(PokeApi::Exception::ServerError)
      end
    end
  end
end
