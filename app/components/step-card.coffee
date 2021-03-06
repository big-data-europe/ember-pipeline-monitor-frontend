`import Ember from 'ember'`

StepCardComponent = Ember.Component.extend
  statusIcon: Ember.computed 'step.status', ->
    switch @get('step.status')
      when 'starting' then 'hourglass_empty'
      when 'running' then 'play_arrow'
      when 'ready' then 'swap_horiz'
      when 'done' then 'done'
      when 'failed' then 'bug_report'
      else 'snooze'
  userCanFinish: Ember.computed 'step.status', ->
    @get('step.status') == 'not_started'
  didInsertElement: ->
    performUpdate = () =>
      Ember.run.next () =>
        unless @get('step.isDestroyed')
          @get('step').reload()
          setTimeout performUpdate, 1000
    performUpdate()
  actions:
    finish: ->
      @set('step.status', 'done')
      @get('step').save()

`export default StepCardComponent`
