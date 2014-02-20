describe "Sanity", ->
  it "is sane", ->
    expect(true).to.be.true

  it "is testing", ->
    expect(Testing).to.be.defined

  it "has a dom", ->
    expect(document.body).to.be.defined
