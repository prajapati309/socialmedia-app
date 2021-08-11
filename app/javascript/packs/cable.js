//= require action_cable
//= require_self
//= require_tree ./channels

@App = {}
App.cable = Cable.createConsumer

(function() {
  this.App || (this.App = {});
  App.cable = ActionCable.createConsumer();
}).call(this);