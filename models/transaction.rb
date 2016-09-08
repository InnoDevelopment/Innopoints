class Transaction
  def self.create(account_id, amount)
    date = Date.today >> 12
    date = Date.civil(date.year, date.month, -1)
    DB.query("INSERT INTO Transactions VALUES (default, #{account_id}, #{amount}, #{amount}, now(), '#{date}', 'active');")
    transaction = nil
    id = DB.last_id
    DB.query("SELECT * FROM Transactions WHERE id=#{id};").each do |row|
      transaction = row
    end
    transaction
  end

  def self.get_list_active_by_account(account_id)
    transactions = Array.new
    DB.query("SELECT * FROM Transactions WHERE account_id=#{account_id} AND status='active' ORDER BY receiving_date ASC").each do |row|
      transactions.push(row)
    end
    transactions
  end

  def self.update_amount_and_status(id, amount, status)
    DB.query("UPDATE Transactions SET amount_to_spend=#{amount}, status='#{status}' WHERE id=#{id}")
  end
end