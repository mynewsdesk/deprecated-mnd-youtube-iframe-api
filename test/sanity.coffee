describe "Sanity", ->
  it "is sane", ->
    expect(true).to.be.true
  it "is mochajs", ->
    expect(process.env).to.exist
