require('pg')

class Bounty

  attr_reader :id
  attr_accessor :name, :species, :bounty_value, :danger_level

  def initialize(options)
    @id = options['id'].to_i()
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value'].to_i()
    @danger_level = options['danger_level']
  end


#-------- Delete -------------------------

  def Bounty.delete_all()
      dbname: 'space_cowboys',
      host: 'localhost'
      })
      sql = 'DELETE FROM bounty_hunters;'

       db.exec(sql)
       db.close()
    end


#------ CREATE--------

  def save()
    db = PG.connect ({
      dbname: 'space_cowboys',
      host: 'localhost'
      })

      sql = "
      INSERT INTO bounty_hunters(
        name,
        species,
        bounty_value,
        danger_level
        )
        VALUES ($1, $2, $3, $4)
        RETURNING id;
        "

        db.prepare('save', sql)
        result = db.exec_prepared('save',[
          @name,
          @species,
          @bounty_value,
          @danger_level])
        db.close()

        result_hash = result[0]
        string_id = result_hash['id']
        id = string_id.to_i()
        @id = id

    end

#------------- Read -----------------------

    def Bounty.all()
      db = PG.connect ({
        dbname: 'space_cowboys',
        host: 'localhost'
        })
    sql = 'SELECT * FROM bounty_hunters;'

    db.prepare('all', sql)
    order_hashes = db.exec_prepared('all')
    db.close()

    order_objects = order_hashes.map do |order_hashes|
      Bounty.new(order_hashes)
    end

    return order_objects

    end

#----------------UPDATE


  def update()
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
      })
    sql = "UPDATE bounty_hunters
            SET(
              name,
              species,
              bounty_value,
              danger_level
            ) = ( $1, $2, $3, $4 )
            WHERE id = $5;
            "
            values = [
                @name,
                @species,
                @bounty_value,
                @danger_level,
                @id
              ]

      db.prepare('update', sql)
      db.exec_prepared('update',values)
      db.close()
     end

end
