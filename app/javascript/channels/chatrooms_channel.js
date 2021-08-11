App.chatrooms = App.cable.subscriptions.create ("ChatroomsChannel",
 {
  connected() {
  	alert("Hey ")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
 	active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']").append(data.message)
 	if(active_chatroom.length > 0)
 		active_chatroom.append(data.message)
 	else
 		$("[data-behavior='chatroom-link'][data-chatroom-id='#{data-chatroom-id}']").css("font-weight", "bold")
    // Called when there's incoming data on the websocket for this channel
  }
});
