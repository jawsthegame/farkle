Pool  = require 'pool'
$     = require 'jqueryify'


class Game
  score: 0

  start: ->
    pool = new Pool

    $(document).ready =>
      $('#roll').click =>
        score = pool.score()
        $('#score').text(score)

        $('.die').removeClass 'held'
        pool.roll()
        for value, i in (d.value for d in pool.dice)
          $die = $(".die[data-die=#{i}]")
          $die.text(value)
          $die.removeClass 'one'
          $die.removeClass 'five'
          if value is 1
            $die.addClass 'one'
          if value is 5
            $die.addClass 'five'

          die = pool.dice[$die.data('die')]
          if die in pool.held
            $die.addClass 'held'

      $('.die').click (e) ->
        $die = $(e.currentTarget)
        die = pool.dice[$die.data('die')]
        if not die.locked
          if $die.hasClass('one') or $die.hasClass('five')
            $die.toggleClass 'held'
            pool.hold(die)


module.exports = Game
