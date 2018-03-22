require 'test_helper'

class PetPredictorApiTest < ActionDispatch::IntegrationTest

  setup { host! ENV["api_host_url"] }

  test 'return a guess' do
    get '/petpredictor?height=68&weight=171'

    assert_equal 200, response.status
    refute_empty response.body
  end

  test 'guess should return dog' do
    rawstat = raw_stats(:likedogs)
    get "/petpredictor?height=" + rawstat.height.to_s + "&weight=" + rawstat.weight.to_s

    assert_equal 200, response.status
    refute_empty response.body

    json = JSON.parse(response.body)
    assert_equal json["dogorcat"], 0 # 0 - dog
  end  

  test 'guess should return cat' do
    rawstat = raw_stats(:likecats)
    get "/petpredictor?height=" + rawstat.height.to_s + "&weight=" + rawstat.weight.to_s

    assert_equal 200, response.status
    refute_empty response.body

    json = JSON.parse(response.body)
    assert_equal json["dogorcat"], 1 # 1 - cat
  end   

  test 'save the dog or cat confirmation for a new height and weight' do
    postparams = { 'raw_stats' => {
      'height' => 57,
      'weight' => 124,
      'dog_count' => 4,
      'cat_count' => 1 }
    }
    post '/petpredictor', params: postparams, as: :json

    assert_equal 201, response.status
    assert_equal Mime[:json], response.content_type
    refute_empty response.body
  end  

  test 'update the dog or cat confirmation for an existing height and weight' do
    rawstat = raw_stats(:valid)
    rawstat.cat_count += 1 
    postparams = { 'raw_stats' => {
      'height' => rawstat.height,
      'weight' => rawstat.weight,
      'dog_count' => rawstat.dog_count,
      'cat_count' => rawstat.cat_count }
    }
    request_headers = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    post '/petpredictor', params: postparams, as: :json
    assert_equal 204, response.status
  end

end
