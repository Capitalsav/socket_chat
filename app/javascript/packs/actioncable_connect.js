ActionCable = require('actioncable')

var cable = ActionCable.createConsumer('ws://localhost:3000/cable')

$(document).ready(function(){
    var messages, messages_to_bottom;
    messages = $('#messages');
    if ($('#messages').length > 0) {
        messages_to_bottom = function() {
            return messages.scrollTop(messages.prop("scrollHeight"));
        };
        messages_to_bottom();
        appGlobalChat = cable.subscriptions.create({
            channel: "ChatRoomsChannel",
            chat_room_id: messages.data('chat-room-id')
        }, {
            connected: function() {
                console.log('fadsfasdfasdfasd');
            },
            disconnected: function() {},
            received: function(data) {
                messages.append(data['message']);
                return messages_to_bottom();
            },
            send_message: function(message, chat_room_id) {
                return this.perform('send_message', {
                    message: message,
                    chat_room_id: chat_room_id
                });
            }
        });
        return $('#new_message').submit(function(e) {
            var $this, textarea;
            $this = $(this);
            textarea = $this.find('#message_body');
            if ($.trim(textarea.val()).length > 1) {
                appGlobalChat.send_message(textarea.val(), messages.data('chat-room-id'));
                textarea.val('');
            }
            e.preventDefault();
            return false;
        });
    }
});
