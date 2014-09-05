require 'pry'
require_relative './lib/connection'
require_relative './lib/category'
require_relative './lib/comment'
require_relative './lib/post'
require_relative './lib/subscriber'

boiler = Category.create({
  name: "Boiler", 
  description: "Boiler maintenance",
  vote_up: 0,
  vote_down: 0
})

lawyer = Category.create({
  name: "Lawyer", 
  description: "Co-op lawyers",
  vote_up: 0,
  vote_down: 0
})

Post.create({
  subject: "Annual tube punch",
  category_id: 1,
  expiration: 20500101,
  content: "What time of the year do you all recommend the tube punch?",
  vote_up: 0,
  vote_down: 0
})

Post.create({
  subject: "Searching for New Lawyer",
  category_id: 2,
  expiration: 20500101,
  content: "Can anybody recommend a lawyer for my building? Ours has a paralegal who is a neglectful moron and we can't take it anymore.",
  vote_up: 0,
  vote_down: 0
})

Subscriber.create({
  email: "thefirst@boardmember.com",
  kind: "category",
  foreign_key: 1
})

Subscriber.create({
  email: "anotherone@coopboard.com",
  kind: "post",
  foreign_key: 1
})

Comment.create({
  content: "I like to punch the tubes in the spring as soon as the heating season is over.",
  post_id: 1,
  vote_up: 0,
  vote_down: 0
  })

Comment.create({
  content: "I hate our lawyer, too.",
  post_id: 2,
  vote_up: 0,
  vote_down: 0
  })
