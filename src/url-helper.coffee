url = require "url"
URI = require "URIjs"

urlHelper =
  isAbsoluteUrl: (uri) ->
    (new URI(uri)).is "absolute"

  resolveRelativeUrl: (to, from) ->
    return to if module.exports.isAbsoluteUrl to
    uri = new URI("/#{to}").relativeTo("/#{from}")
    if uri.filename() is "index.html"
      uri = uri.directory(".") if uri.directory() is ""
      uri = uri.filename("")
    uri.toString()

  validateAbsoluteUrl: (remoteUrl) ->
    return false unless remoteUrl?
    {protocol} = url.parse remoteUrl
    protocol is "http:" or protocol is "https:"

  normalizeUrl: (uri, pagePath) ->
    if urlHelper.isAbsoluteUrl uri
      return uri if urlHelper.validateAbsoluteUrl uri
      return null
    urlHelper.resolveRelativeUrl uri, pagePath

module.exports = urlHelper
