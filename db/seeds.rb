# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u1 = User.create(first_name: "Raúl", last_name: "Doe", email: "raul@example.org", password: "hola.123", password_confirmation: "hola.123", role: "teacher")
u2 = User.create(first_name: "Estéban", last_name: "Roe", email: "esteban@example.org", password: "hola.123", password_confirmation: "hola.123", role: "student")

r1 = Resource.create(name: "Ruby slides", description: "Características y principales elementos del lenguaje Ruby", user: u1)
r2 = Resource.create(name: "HTTP slides", description: "HTTP y su implicancia en las rutas de Rails", user: u1)


t1 = Tag.create(name: "rails")
t2 = Tag.create(name: "ruby")
t3 = Tag.create(name: "http")
t4 = Tag.create(name: "clases")


ResourcesTag.create(user: u1, tag: t2, resource: r1)
ResourcesTag.create(user: u1, tag: t4, resource: r1)
ResourcesTag.create(user: u1, tag: t3, resource: r2)
ResourcesTag.create(user: u1, tag: t4, resource: r2)