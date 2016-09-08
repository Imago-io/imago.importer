
walk  = require('walkdir')
# async = require('async')
p  = require('path')


class Importer

  constructor: ->

    acceptFileTypes = /(\.|\/)(zip|gif|jpe?g|jpg|png|psd|photoshop|mov|tif|tiff|m4v|mp4|wmv|mpg|mpeg|avi|vob|dv|flv|pdf)$/i

    @tenant = 'demo'
    @importPath = '/import'
    # @queue =

    # emitter = walk 'filestore'

    # emitter.on 'file', (path, stat) ->
    #   return if p.basename(path) is '.DS_Store'
    #   return unless p.basename(path).match(acceptFileTypes)
    #   console.log 'file', path


    # emitter.on 'directory', (path, stat, cb) ->
    #   console.log 'directory', path

    # emitter.on 'end', -> console.log 'end'

    walk.sync 'filestore', no_return: true, (path,stat) ->

      return if p.basename(path)[0] is '.'
      return if stat.size is 0
      return unless p.basename(path).match acceptFileTypes

      # if stat.isDirectory()
      # create collection

      console.log path


  getSettings: ->
    # gret the settings for the tenant


  createAsset: (type, name) ->

    # creates the asset
    # post to https://api.imago.io/api/assets
    #
    # [{
    #   "type":"image",
    #   "types":["image"],
    #   "name":"69",
    #   "uuid":"069aa665-9e0d-f31e-c645-604af265bb4c",
    #   "status":"processing",
    #   "order":86666.66666666667,
    #   "parent":"557722a2a173e8bce3efd8a5"
    # }]


  getUploadUrl: ->
    # post to https://api.imago.io/api/assets/getUploadUrl


  uploadAsset: ->
    # http upload the asset via upload url to temp binaries.
    # on done hit api to start post process with the features

new Importer

# modules.export Importer






