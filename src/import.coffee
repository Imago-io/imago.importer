
walk  = require('walkdir')
async = require('async')
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
      # return if p.basename(path) is '.DS_Store'
      # return unless p.basename(path).match(acceptFileTypes)
      if stat.size is 0
        console.log 'direcotyr', path, stat.size
      else
        console.log 'file', path, stat.size






  collectFiles: ->
    # for file in @files
    #   @upload file


  createAsset: ->

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


  uploadAsset: ->
    # ext      = pathMod.extname(@data.name).toLowerCase()
    # filename = "#{@tenant}|#{@data.uuid}#{ext}"

    # # @uploadToGs 'tempbinaries', filename, ->
    # mimetype = @getMimeType filename
    # @data.features or= []

    # # console.log 'uploadDone name', @data.name
    # cloudVision = if 'imageSense' in @data.features then true else false

    # jsondata =
    #   namespace   : @tenant
    #   uuid        : @data.uuid
    #   cloudVision : cloudVision
    #   filename    : @data.name
    #   gs_path     : filename
    #   bucket      : 'tempbinaries'
    #   debug       : config.DEBUG
    #   type        : mimetype


    # # console.log 'data...cloudVision', @tenant, jsondata.cloudVision

    # url = utils.extractorUrl(@tenant)

    # # console.log 'extractorUrl', url
    # restler.postJson(url, jsondata).on 'complete', (respdata, resp) =>

    #   # console.log 'respdata', respdata, resp
    #   if resp.statusCode isnt 200
    #     msg = "call to extractor (uploadAsset) statusCode: #{resp.statusCode} <br><br>
    #           #{JSON.stringify(jsondata)} <br><br> response: #{respdata}"
    #     utils.log(msg, @tenant)
    #   # console.log '.....', respdata
    #   @response()


new Importer

# modules.export Importer






