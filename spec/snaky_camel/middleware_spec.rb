require 'spec_helper'

describe SnakyCamel::Middleware do
  describe 'converting request' do
    context 'when it is a GET request' do
      it 'snake-cases it' do
        params_hash = nil
        app = -> (env) do
          params_hash = env['rack.request.query_hash']
          [200, {}, ["{}"]]
        end
        env = Rack::MockRequest.env_for('/', method: :get, params: { pageName: 'ACxDC' })
        described_class.new(app).call(env)
        expect(params_hash['page_name']).not_to be_nil
      end
    end

    context 'when it is a POST request' do
      it 'snake-cases it' do
        params_hash = nil
        app = -> (env) do
          params_hash = env['rack.request.form_hash']
          [200, {}, ["{}"]]
        end
        env = Rack::MockRequest.env_for('/', method: :post, params: { pageName: 'ACxDC' })
        described_class.new(app).call(env)
        expect(params_hash['page_name']).not_to be_nil
      end
    end
  end

  describe 'converting response' do
    context 'when the JSON is correct' do
      it 'camel-cases response if top level object is a Hash' do
        app = -> (env) do
          [200, {'Content-Type' => 'application/json'}, ['{"post":{"page_name":"ACxDC"}}']]
        end
        request = Rack::MockRequest.new(described_class.new(app))
        response = request.get('/').body
        expect(JSON.parse(response)['post']['pageName']).not_to be_nil
      end

      it 'camel-cases response if top level object is an Array' do
        app = -> (env) do
          [200, {'Content-Type' => 'application/json'}, ['[{"post":{"page_name":"ACxDC"}}]']]
        end
        request = Rack::MockRequest.new(described_class.new(app))
        response = request.get('/').body
        expect(JSON.parse(response).first['post']['pageName']).not_to be_nil
      end
    end

    context 'when the response is not of Content-Type json' do
      it 'does nothing' do
        app = -> (env) do
          [200, {'Content-Type' => 'text/html'}, ['{"post":{"page_name":"ACxDC"}}']]
        end
        request = Rack::MockRequest.new(described_class.new(app))
        response = request.get('/').body
        expect(JSON.parse(response)['post']['pageName']).to be_nil
      end
    end

    context 'when response is invalid JSON' do
      it 'throws a BadResponseFormat exception' do
        app = -> (env) do
          [200, {'Content-Type' => 'application/json'}, ['{"post":{"page_name":"ACxDC"}']]
        end
        request = Rack::MockRequest.new(described_class.new(app))
        expect{ request.get('/') }.to raise_error(SnakyCamel::Exception::BadResponseFormat)
      end
    end
  end
end

