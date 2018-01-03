# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Language.create(name: 'Spanish', code: 'es')
Language.create(name: 'French', code: 'fr')
Language.create(name: 'German', code: 'de')
Language.create(name: 'Italian', code: 'it')

User.create(name: "alex", password: "alex")
User.create(name: "meryl", password: "meryl")
User.create(name: "es", password: "es")
