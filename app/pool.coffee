class Pool

  rolled: []
  held: []

  roll: ->
    @rolled = []
    diceToRoll = 5 - @held.length
    for i in [0...diceToRoll]
      @rolled.push Math.floor((Math.random() * 6) + 1)

  hold: (indexes) ->
    for i in indexes
      held.push rolled[i]

  score: ->
    score = 0

    ones    = (d for d in @rolled when d is 1).length
    twos    = (d for d in @rolled when d is 2).length
    threes  = (d for d in @rolled when d is 3).length
    fours   = (d for d in @rolled when d is 4).length
    fives   = (d for d in @rolled when d is 5).length
    sixes   = (d for d in @rolled when d is 6).length

    counts = [ones, twos, threes, fours, fives, sixes]

    if 2 in counts and 3 in counts # full house
      score = 1000
    else
      switch (ones)
        when 3 then score += 1000
        else score += (100 * ones)

      switch (fives)
        when 4 then score += 500
        else score += (50 * fives)

      score += 200 if twos is 3
      score += 300 if threes is 3
      score += 400 if fours is 3
      score += 600 if sixes is 3

    score

  isFarkle: -> @rolled.length and 1 not in @rolled and 5 not in @rolled


module.exports = Pool
