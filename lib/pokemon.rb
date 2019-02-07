class Pokemon
  attr_reader :id, :name, :type, :db, :hp

  def initialize(id:, name:, type:, db:, hp: nil)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(id, db)
    results = db.execute("SELECT * FROM pokemon WHERE id = ?", id)[0]
    Pokemon.new(id: results[0], name: results[1], type: results[2], hp: results[3], db: db)
  end

  def alter_hp(new_hp, db)
    sql = <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE id = ?
    SQL

    db.execute(sql, new_hp, self.id)
  end
end

# [1, "Pikachu", "electric"]
# @db = SQLite3::Database.new(':memory:')
# db.execute("CREATE TABLE IF NOT EXISTS pokemon
# (
#     id INTEGER PRIMARY KEY
#   , name TEXT
#   , type TEXT
#   , hp INTEGER
# );
# ")
