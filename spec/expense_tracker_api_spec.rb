require 'rack/test'
require 'json'
require_relative '../app/api'
require 'pry'
# binding.pry

module ExpenseTracker
  describe 'Expense Track API' do
    
    include Rack::Test::Methods
    
    def app
      ExpenseTracker::API.new
    end
    
    def post_expense(expense)
      post '/expenses', JSON.generate(expense)
      expect(last_response.status).to eq(200)

      parsed = JSON.parse(last_response.body)
      expect(parsed).to include('expense_id' => an_instance_of(Fixnum))
      expense.merge('id' => parsed['expense_id'])
    end
    
    
    it 'records submitted expenses' do
      
       pending 'Need to persist expenses'
      coffee = {
        'payee' => 'starbucks',
        'amount' => '5.75',
        'date' => '2017-19-02'
        }
        
        zoo = post_expense(
          'payee'  => 'Zoo',
          'amount' => 15.25,
          'date'   => '2014-10-17'
        )

        groceries = post_expense(
          'payee'  => 'Whole Foods',
          'amount' => 95.20,
          'date'   => '2014-10-18'
        )
     
     get '/expenses/2014-10-17'
     expect(last_response.status).to eq(200)

     expenses = JSON.parse(last_response.body)
     expect(expenses).to contain_exactly(coffee, zoo)
         
    end
  end
end