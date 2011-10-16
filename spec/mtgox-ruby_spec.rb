$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'mtgox-ruby'
require 'fakeweb'

FakeWeb.register_uri(:any, 'https://mtgox.com/code/data/getTrades.php', 
  :body => ::File.open(::File.expand_path('../get_trades.json', __FILE__)).read
)

describe MtgoxClient do

	before :each do	
		@mtgox_client = MtgoxClient.new
	end

	it "should receive recent trades as MtgoxOrder objects" do
		recent_trades = @mtgox_client.recent_trades
		recent_trades.should be_a(Array)
		recent_trades.length.should > 0
		recent_trades.each do |trade|
			trade.should be_a(MtgoxOrder)
			trade.amount.should > 0
		end
	end

end
