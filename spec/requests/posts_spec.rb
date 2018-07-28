require 'rails_helper'

RSpec.describe 'Posts API', type: :request do
  # Initialize test data
  let!(:posts){ create_list(:post, 10) }
  let(:post_id){ posts.first.id }

  # Test suite for GET /posts
  describe 'GET /posts' do
  	# Make an HTTP request before each example
    before { get '/posts' }

    it 'returns posts' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
    	expect(response).to have_http_status(200)
    end
  end

  describe 'GET /posts/:id' do
  	before { get "/posts/#{post_id}" }

  	context 'when post exists' do
  	  it 'returns the post' do
  	  	expect(json).not_to be_empty
  	  	expect(json['id']).to eq(post_id)
  	  end

  	  it 'returns status code 200' do
    	expect(response).to have_http_status(200)
	  end
  	end

  	context 'when post does not exist' do
	  let(:post_id) { 100 }

	  it 'returns a status code of 404' do
	  	expect(response).to have_http_status(404)
	  end

	  it 'returns a not found message' do
	  	expect(response.body).to match(/Couldn't find Post with 'id'=100/)
	  end
	end
  end

  describe 'POST /posts' do
  	let(:valid_attributes) { { content: 'Post Content', user_id: 1 } }

  	context 'when request is valid' do
  	  before { post '/posts', params: valid_attributes, headers: headers }

  	  it 'creates a post' do
  	  	expect(json['content']).to eq('Post Content')
  	  end

  	  it 'returns status code 201' do
    	expect(response).to have_http_status(201)
	  end
  	end

  	context 'when request is invalid' do
  	  let(:invalid_attributes){ { content: nil }.to_json }
  	  before { post '/posts', params: invalid_attributes, headers: headers }

  	  it 'returns a status code of 422' do
	  	expect(response).to have_http_status(422)
	  end

	  it 'returns an error message' do
	  	expect(json['message']).to match(/Validation failed: Content can't be blank/)
	  end
  	end
  end

  describe 'PUT /posts/:id' do
  	let(:valid_attributes) { { content: 'Post Content' }.to_json }

  	context 'when the post exists' do
  	  before { put "/posts/#{post_id}", params: valid_attributes, headers: headers }

  	  it 'updates the record' do
  	  	expect(response.body).to be_empty
  	  end

  	  it 'returns a status code of 204' do
  	  	expect(response).to have_http_status(204)
  	  end
  	end
  end

  describe 'DELETE /posts/:id' do
  	before { delete "/posts/#{post_id}", params: {}, headers: headers }

  	it 'returns a status code of 204' do
  	  expect(response).to have_http_status(204)
  	end
  end
end
