Pool  = require 'pool'
$     = require 'jqueryify'


class Game

  start: ->
    pool = new Pool

    $(document).ready ->
      dice = [
        $('#die1'),
        $('#die2'),
        $('#die3'),
        $('#die4'),
        $('#die5')
      ]

      $('#roll').click ->
        pool.roll()
        for value, i in pool.rolled
          dice[i].text(value)
          dice[i].removeClass 'one'
          dice[i].removeClass 'five'
          if value is 1
            dice[i].addClass 'one'
          if value is 5
            dice[i].addClass 'five'

        score = pool.score()
        $('#score').text(score)

      $('.die').click (e) ->
        die = $(e.currentTarget)
        if die.hasClass('one') or die.hasClass('five')
          die.toggleClass 'held'

module.exports = Game
