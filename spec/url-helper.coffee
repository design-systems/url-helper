chai = require "chai"
{expect} = chai

urlHelper = require "../lib/url-helper"

describe "url helper", ->

  describe "relative", ->

    context "absolute URL", ->
      it "should pass through unchanged", ->
        to = "https://twitter.com/thegrid"
        from = "index.html"
        resolved = urlHelper.resolveRelativeUrl to, from
        expect(resolved).to.equal "https://twitter.com/thegrid"


    context "URL relative to index", ->
      it "should resolve to the correct URL", ->
        to = "index.html"
        from = "faq/index.html"
        resolved = urlHelper.resolveRelativeUrl to, from
        expect(resolved).to.equal "../"


    context "URL relative to named page", ->
      it "should resolve to the correct URL", ->
        to = "foo.html"
        from = "bar/baz.html"
        resolved = urlHelper.resolveRelativeUrl to, from
        expect(resolved).to.equal "../foo.html"


    context "URL relative to itself", ->
      it "should resolve to the correct URL", ->
        to = "faq/index.html"
        from = "faq/index.html"
        resolved = urlHelper.resolveRelativeUrl to, from
        expect(resolved).to.equal ""


    context "URL relative to another URL", ->
      it "should resolve to the correct URL", ->
        to = "blog/foo/index.html"
        from = "categories/noflo/index.html"
        resolved = urlHelper.resolveRelativeUrl to, from
        expect(resolved).to.equal "../../blog/foo/"


    context "Sibling page URL relative to index", ->
      it "should resolve to the correct URL", ->
        to = "index.html"
        from = "index.abcde.html"
        resolved = urlHelper.resolveRelativeUrl to, from
        expect(resolved).to.equal "./"


  describe "absolute", ->

    context "without a URL", ->
      it "should be invalid", ->
        isValid = urlHelper.validateAbsoluteUrl null
        expect(isValid).to.equal false

    context "empty URL", ->
      it "should be invalid", ->
        isValid = urlHelper.validateAbsoluteUrl ""
        expect(isValid).to.equal false

    context "relative URL", ->
      it "should be invalid", ->
        isValid = urlHelper.validateAbsoluteUrl "../index.html"
        expect(isValid).to.equal false

    context "protocol-relative URL", ->
      it "should be invalid", ->
        isValid = urlHelper.validateAbsoluteUrl "//thegrid.io"
        expect(isValid).to.equal false

    context "URL with a file:// protocol", ->
      it "should be invalid", ->
        isValid = urlHelper.validateAbsoluteUrl "file://thegrid.png"
        expect(isValid).to.equal false

    context "URL with http:// protocol", ->
      it "should be valid", ->
        isValid = urlHelper.validateAbsoluteUrl "http://thegrid.io"
        expect(isValid).to.equal true

    context "URL with https:// protocol", ->
      it "should be valid", ->
        isValid = urlHelper.validateAbsoluteUrl "https://thegrid.io"
        expect(isValid).to.equal true
