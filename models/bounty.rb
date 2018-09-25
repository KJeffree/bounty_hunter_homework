require('pg')

class Bounty

  attr_reader :id
  attr_accessor :name, :bounty_value, :danger_level, :favourite_weapon

  def initialize(options)
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i
    @danger_level = options['danger_level']
    @favourite_weapon = options['favourite_weapon']
  end

  def self.delete_all()
    db = PG.connect({
      dbname: 'bounty_hunters',
      host: 'localhost'
    })
    sql = "DELETE FROM bounties"
    db.exec(sql)
    db.close()
  end

  def self.all()
    db = PG.connect({
      dbname: 'bounty_hunters',
      host: 'localhost'
    })
    sql = 'SELECT * FROM bounties;'
    db.prepare('all', sql)
    order_hashes = db.exec_prepared('all')
    db.close()

    order_objects = order_hashes.map {|order_hash| Bounty.new(order_hash)}

    return order_objects
  end

  def self.find(id)
    db = PG.connect({
      dbname: 'bounty_hunters',
      host: 'localhost'
    })
    sql = 'SELECT * FROM bounties WHERE id = $1'
    db.prepare('find', sql)
    order_hash = db.exec_prepared('find', [id])
    db.close()

    order_object = order_hash.map {|order| Bounty.new(order)}

    return order_object
  end

  def save()
    db = PG.connect({
      dbname: 'bounty_hunters',
      host: 'localhost'
    })

    sql = "
      INSERT INTO bounties (name, bounty_value, danger_level, favourite_weapon)
      VALUES ($1, $2, $3, $4)
      RETURNING id;
    "

    db.prepare('save', sql)
    result = db.exec_prepared('save', [@name, @bounty_value, @danger_level, @favourite_weapon])
    db.close()

    result_hash = result[0]
    string_id = result_hash['id']
    id = string_id.to_i
    @id = id
  end

  def update()
    db = PG.connect({
      dbname: 'bounty_hunters',
      host: 'localhost'
      })
      sql = "
      UPDATE bounties
      SET (name, bounty_value, danger_level, favourite_weapon) = ($1, $2, $3, $4)
      WHERE id = $5;
      "

      values = [@name, @bounty_value, @danger_level, @favourite_weapon, @id]
      db.prepare('update', sql)
      db.exec_prepared('update', values)
      db.close()
    end

    def delete()
      db = PG.connect({
        dbname: 'bounty_hunters',
        host: 'localhost'
      })
      sql = "
      DELETE FROM bounties
      WHERE id = $1
      "

      values = [@id]
      db.prepare('delete', sql)
      db.exec_prepared('delete', values)
      db.close()
    end

end
