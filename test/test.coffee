root.Testing = true

chai = require 'chai'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'

expect = chai.expect
chai.use(sinonChai)

{Observable, YouTubeIframePlayer} = require '../src/youtube_iframe'

describe "Sanity", ->
  it "is sane", ->
    expect(true).to.be.true
  it "is mochajs", ->
    expect(process.env).to.exist

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

