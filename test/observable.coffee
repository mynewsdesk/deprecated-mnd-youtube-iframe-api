{Observable} = require '../src/youtube_iframe'

describe "Observable", ->
  class TestObservable
    constructor: ->
      Observable.addTo @
    testEvent: ->
      @notifyNewEvent 'eventName'

  it "accepts event listeners", ->
    observableInstance = new TestObservable()
    eventHandler = sinon.spy()
    observableInstance.on 'eventName', eventHandler

    observableInstance.testEvent()

    expect(eventHandler).to.have.been.calledOnce
