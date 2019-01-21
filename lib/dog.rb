Class Dog

  attr_accessor 
  
  def initialize
    
  end
  
  def self.create_table
    sql = <<-SQL
              CREATE TABLE dogs(
                id INTEGER PRIMARY KEY
              );
            SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS dogs;")
  end
  
  def self.new_from_db(row)
    new(*row)
  end
  
  def self.find_by_name(name)
    sql = <<-SQL
              SELECT * FROM dogs
              WHERE name = ?;
            SQL
    new_from_db(DB[:conn].execute(sql, name).first)
  end
    

end