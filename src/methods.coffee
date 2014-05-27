
Meteor.methods 
  xueKillJob: (id) ->
    Xue.Job.create({_id: id}).kill()
