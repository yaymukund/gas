exports.clone = (object) ->
  clone = {}

  for key, value of object
    clone[key] = value

  clone
