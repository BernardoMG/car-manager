# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

maker_list = %w[BMW Toyota Renault]

# index 0 - BMW
# index 1 - Toyota
# index 2 - Renault
makers = []
maker_list.each do |name|
  makers << Maker.create(name: name)
end

models = []
model_list = [
  ['Serie3', makers[0]],
  ['X1', makers[0]],
  ['Yaris', makers[1]],
  ['RAV4', makers[1]],
  ['Clio', makers[2]],
  ['Megane', makers[2]]
]

model_list.each do |name, maker|
  models << Model.create(name: name, maker: maker)
end

color_list = [
  %w[white FFFFFF],
  %w[black 000000],
  %w[red FF0000],
  %w[yellow FFFF00],
  %w[blue 0000FF],
  %w[gray 808080]
]

colors = []
color_list.each do |name, code|
  colors << Color.create(name: name, code: code)
end

# Let's seed our join table: ModelColors

# Serie3 exists only in white, black and gray
ModelColor.create(model: models[0], color: colors[0])
ModelColor.create(model: models[0], color: colors[1])
ModelColor.create(model: models[0], color: colors[5])

# X1 exists only in white, black and blue
ModelColor.create(model: models[1], color: colors[0])
ModelColor.create(model: models[1], color: colors[1])
ModelColor.create(model: models[1], color: colors[4])

# Yaris exists only in black, yellow, gray
ModelColor.create(model: models[2], color: colors[1])
ModelColor.create(model: models[2], color: colors[3])
ModelColor.create(model: models[2], color: colors[5])

# RAV exists only in black and white
ModelColor.create(model: models[3], color: colors[0])
ModelColor.create(model: models[3], color: colors[1])

# Clio exists only in gray
ModelColor.create(model: models[4], color: colors[5])

# Megane exists only in blue and gray
ModelColor.create(model: models[5], color: colors[4])
ModelColor.create(model: models[5], color: colors[5])
