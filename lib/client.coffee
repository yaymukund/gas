SocketProxy = require './socket-proxy'

class Client extends SocketProxy
  @SOCKET_EVENTS:
    # event_name: method_to_call
    join_room: 'join_room'
    disconnect: 'leave_room'
    leave_room: 'leave_room'

  @_clients: {}

  @find: (socket) ->
    @_clients[socket]

  constructor: (socket) ->
    super(socket)
    Client._clients[socket] = @

  join_room: (event) ->
    #room_id = event.id

module.exports = Client
