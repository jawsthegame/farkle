class Die
  locked: false

  roll: ->
    @value = Math.floor((Math.random() * 6) + 1)
    this


module.exports = Die
