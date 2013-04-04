class window.CardView extends Backbone.View
  className: 'card'

  events: 
    "click": "cardClick"

  initialize: ->
    @listenTo(@model, 'change', @render)
  
  template: _.template('<div><%= rank %> of <%= suit %></div')
  render: (event)->
    @$el.html(@template(@model.attributes))
    @

  cardClick: => alert @$el.text()


class window.DeckView extends Backbone.View
  className: 'deck'

  initialize: ->
    @collection.on('add', @addOne, @)

  events:
    'click .reset-button': 'shuffle'

  shuffle: ->
    console.log("collection" + @collection)

  addOne: (card)->
    cardView = new CardView({model: card})
    @$el.append(cardView.render().el)

  render: ->
    @collection.forEach(@addOne, @)
    @


class window.HandView extends Backbone.View
  initialize: ->
    @collection.on('add', @addOne, @)

  addOne: (card) ->
    cardView = new CardView({model: card})
    @$el.append(cardView.render().el)

  render: ->
    @collection.forEach(@addOne, @)
    @