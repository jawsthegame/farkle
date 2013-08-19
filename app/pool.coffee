Die = require 'die'


class Pool

  dice: []
  rolled: []
  held: []
  timesRolled: 0

  roll: ->
    @pool = []
    @rolled = []
    @timesRolled++
    diceToRoll = 5 - @held.length
    for die in @held
      die.locked = true
    for i in [0...diceToRoll]
      die = new Die().roll()
      @rolled.push die
    @dice = @held.concat @rolled

  hold: (die) ->
    if die in @held
      @held.splice @held.indexOf(die), 1
    else
      @held.push die

  score: ->
    score = 0

    ones    = (d for d in @held when d.value is 1).length
    twos    = (d for d in @held when d.value is 2).length
    threes  = (d for d in @held when d.value is 3).length
    fours   = (d for d in @held when d.value is 4).length
    fives   = (d for d in @held when d.value is 5).length
    sixes   = (d for d in @held when d.value is 6).length

    counts = [ones, twos, threes, fours, fives, sixes]

    if @timesRolled is 1
      if 2 in counts and 3 in counts # full house
        score = 1000
      else
        score += if ones is 3 then 1000 else 100 * ones
        score += if fives is 3 then 500 else 50 * fives
        score += 200  if twos is 3
        score += 300  if threes is 3
        score += 400  if fours is 3
        score += 600  if sixes is 3
    else
      score += 100 * ones
      score += 50 * fives

    score

  isFarkle: ->
    rolled = (d.value for d in @rolled)
    rolled.length and 1 not in rolled and 5 not in rolled


module.exports = Pool
