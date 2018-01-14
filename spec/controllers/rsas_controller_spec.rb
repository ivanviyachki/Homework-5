#require 'simplecov'
#SimpleCov.start

RSpec.describe RsasController do
	it "creates and checks a rsa key" do
		post :create
		expect(Rsa.where(id: JSON.parse(response.body)["id"])).to exist
	end
	
	it "creates and checks a rsa key with arguments" do
		post :create, params: {n: 3, e: 2, d: 12}
		key = Rsa.find_by id: JSON.parse(response.body)["id"]
		expect([key.n, key.e, key.d]).to eq [3, 2, 12]
	end
end
