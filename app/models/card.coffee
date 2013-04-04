###
  You'll probably want to define some kind of Card model.

  If you need to define a collection of cards as well, you could also put that in 
  this file if you want to.
###
class window.Card extends Backbone.Model
  value: ->
    return @get('rank') if @get('rank') <= 10
    return 10 if _(['Jack', 'Queen', 'King']).contains(@get('rank'))
    return 11 if @get('rank') == 'Ace'

class window.Deck extends Backbone.Collection
  model: Card
  initialize: ->
    ranks = [2..10]
    ranks = ranks.concat ['Jack', 'Queen', 'King', 'Ace']
    suits = ['Spades', 'Hearts', 'Diamonds', 'Clubs']
    @add(card = new Card({rank: r, suit: s})) for r in ranks for s in suits

class window.Hand extends Backbone.Collection
  model: Card
  busted: false
  value: ->
    maxValue = @reduce((a, b) ->
      (a + b.value())
    0)

    minValue = maxValue - @aces() * 10
    if ((minValue) > 21)
      @busted = true
      console.log(@)
      return minValue
    mod = Math.floor((maxValue - 12) /10)
    result = maxValue - mod * 10
    if (result == 21)
      console.log "Winner!"
    result


  aces: ->
    @reduce((a,b) ->
      (a + (b.get('rank') == 'Ace'))
    0)