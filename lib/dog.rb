Class Dog

  attr_accessor :id
  
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
  
  def update
    sql = <<-SQL
              UPDATE dogs
              SET name = ?
              WHERE id = ?;
            SQL
    DB[:conn].execute(sql, self.name, self.id)
  end
  
  def save
    if self.id
      self.update
    else
      sql = <<-SQL
                INSERT INTO dogs(name)
                VALUES (?);
              SQL
      DB[:conn].execute(sql, self.name)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs;")[0][0]
    end
    return self
  end

end