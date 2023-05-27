require 'rails_helper'

RSpec.describe PokeApi::Request do
  describe '#body' do
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

    it 'returns the body from the response' do
      stub_request(:get, 'https://pokeapi.co/api/v2/pokemon/1')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 200, body:, headers: { 'Content-Type' => 'application/json' })

      response = described_class.get('/pokemon/1')

      expect(response.body).to eq(body)
    end
  end

  describe '#serialize' do
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
      }
    end

    it 'returns the body from the response' do
      stub_request(:get, 'https://pokeapi.co/api/v2/pokemon/1')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 200, body: body.to_json, headers: { 'Content-Type' => 'application/json' })

      response = described_class.get('/pokemon/1')

      expect(response.serialize).to eq(body)
    end
  end

  describe '.get' do
    context 'when the request is successful' do
      it 'returns a GET response' do
        stub_request(:get, 'https://pokeapi.co/api/v2/pokemon/1')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: '', headers: {})

        response = described_class.get('/pokemon/1')

        expect(response).to be_a(described_class)
      end
    end

    context 'when the request is not successful' do
      it 'raises a client exception for 400 error codes' do
        stub_request(:get, 'https://pokeapi.co/api/v2/pokemon/1')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 404, body: '', headers: {})

        expect { described_class.get('/pokemon/1') }.to raise_error(PokeApi::Exception::ClientError)
      end

      it 'raises a server exception for 500 error codes' do
        stub_request(:get, 'https://pokeapi.co/api/v2/pokemon/1')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 500, body: '', headers: {})

        expect { described_class.get('/pokemon/1') }.to raise_error(PokeApi::Exception::ServerError)
      end
    end
  end
end
