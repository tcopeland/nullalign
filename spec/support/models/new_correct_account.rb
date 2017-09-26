class NewCorrectAccount < CorrectAccount
  self.table_name = 'new_correct_account'

  def readonly?
    true
  end
end
