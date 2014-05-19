EventEmitter = (require 'events').EventEmitter
clone = (require './utils').clone

# Extend this class to listen to socket events:
#
#   class User extends SocketProxy
#     @SOCKET_EVENTS:
#       send_message: 'log_sent_message'
#
#     log_sent_message: (event) ->
#       console.log(event.message)
#
class SocketProxy extends EventEmitter
  constructor: (socket) ->
    socket.on 'data', @_data.bind(@)
    @_bind_events

  # When an event is emitted by @_data(),
  # call a method by the same name.
  _bind_events: ->
    for _, event of @constructor.SOCKET_EVENTS
      method = @[event].bind(@)
      @on(event, method)

  # Emit an event for every SOCKET_EVENT
  _data: (data) ->
    unless data.event of @constructor.SOCKET_EVENTS
      return

    data = clone(data)
    event = data.event
    delete data.event

    method = @constructor.SOCKET_EVENTS[event]
    @emit(method, data)

module.exports = SocketProxy
