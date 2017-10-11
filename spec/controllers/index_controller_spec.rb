require 'spec_helper'

describe 'IndexController' do
  it 'returns OK status' do
    get '/'
    expect(last_response).to be_ok
  end
end
