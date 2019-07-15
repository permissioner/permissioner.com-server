# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
          email: 'n.autzen@gmail.com',
          email_normalized: 'n.autzen@gmail.com',
          username: 'Nico',
          username_normalized: 'nico'
        )

Apps.create(
          access_list_type: 'white',
          app_key: 'cnvsrkromrc1c8ob005cqqo41d1v888uhha8eselv40e0sjf41afhqt9pmq0oe88gq5erh3fudch22c5',
          contact_email: 'permissioner.com@gmail.com',
          name: 'Permissioner',
          status: 'active',
          user_access_list: 'n.autzen@gmail.com permissioner.com@gmail.com hauke.olf@gmail.com tobi.pollmann@gmail.com *@neusta.de *@guest-solutions.com',
          website: 'https://permissioner.com',
        )
