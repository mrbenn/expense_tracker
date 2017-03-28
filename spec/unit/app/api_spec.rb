require_relative '../../../app/api'
require 'rack/test'

module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  RSpec.describe API do
    
    include Rack::Test::Methods
    let(:ledger){ instance_double('ExpenseTracker::Ledger') }
    let(:app) { API.new(ledger: ledger) }
    
    describe 'POST / expenses' do
      context 'when the expense is successfully recorded' do
        let(:expense) { {'some' => 'data'}}
      
        before do 
          allow(ledger).to receive(:record)
            .with(expense)
            .and_return(RecordResult.new(true, 417, nil))
        end
      
        it 'repsonds with a 200 (OK)' do
        #expense = {'some' => 'data'}
        
        #allow(ledger).to receive(:record)
        #  .with(expense)
        #  .and_return(RecordResult.new(true, 717, nil))
          
          post '/expenses', JSON.generate(expense)
          expect(last_response.status).to eq(200)
        end
          
        it 'returns the expense id' do
        #expense ={'some' => 'data'}
        
        #allow(ledger).to receive(:record)
        #.with(expense)
        #.and_return(RecordResult.new(true, 417, nil))
        
        post '/expenses', JSON.generate(expense)
        
        parsed = JSON.parse(last_response.body)
        expect(parsed).to include('expense_id' => 417)
        
        end
        
      context 'when the expense fails validation' do
        it 'responds with a 422 (unproccessable entity)'
        end
                
        it 'returns and error message'
        
        end  
      end 
    end
  end