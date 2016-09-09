
# walk  = require('walkdir')
# walk = require('fs-walk')

async         = require('async')
walk          = require('walk')
p             = require('path')
_             = require('lodash')
normalizeName = require('normalizeName')
restler       = require('restler')


APIKEY = "APIKEY HERE"
HOST   = "https://api.imago.io"

class Importer

  constructor: (@tenant, @importPath, folder)->

    acceptFileTypes = /(\.|\/)(zip|gif|jpe?g|jpg|png|psd|photoshop|mov|tif|tiff|m4v|mp4|wmv|mpg|mpeg|avi|vob|dv|flv|pdf)$/i

    @tenant       = 'demo'
    @importPath or= '/import'
    @folder     or= p.normalize("#{__dirname}/../filestore")

    console.log "folder #{@folder}"

    @collections = []

    async.waterfall [
      (callback) =>
        # TODO: get the settings via restler and apikey

        # for now the collection is pushed manually
        @collections.push {path: @importPath, fspath: @folder, _id: 'xyz'}

        callback()
      (callback) =>
        # TODO
        # get the iportPaths collection id to use as root parentId
        # use /api/search
        # create the collection if it doesn't exist yet
        callback()

      ], (err) =>
        console.log '@collections', @collections
        @walk()


  walk: ->

    console.log '##########################'
    console.log 'step 1: create the collection tree'
    console.log '##########################'

    walker = walk.walk(@folder, {followLinks: false})
    walker.on("directories", @createDirs)

    walker.on "end", =>
      # start looping over the dirs and upload the files
      @uploadFiles()


    # walker.on "file", (root, fileStats, next) =>
    #   # next()
    #   # console.log 'found file', root, fileStats.name
    #   next()



  createDirs: (root, dirStatsArray, next) =>

    parentPath   = "#{@importPath}#{_.last(root.split(@folder))}"

    # console.log 'parentPath', parentPath

    parentObject = _.find @collections, {path: parentPath}

    async.eachSeries (dir.name for dir in dirStatsArray),
      (name, cb) =>
        @createAsset name, 'collection', parentObject, (err, collection) =>
          @collections.push {
            _id    : "xyz789098" # collection._id
            path   : "#{parentObject.path}/#{normalizeName(name)}" # collection.path
            fspath : "#{root}/#{name}"
          }
          cb()
      (err) =>
        next()


  uploadFiles: ->
    # start uploading files for each directory
    console.log '##########################'
    console.log 'step 2: create and upload assets inside collections'
    console.log '##########################'

    # loop synchronously over the directories and start uploading files

    async.eachSeries @collections,
      (collection, cb) =>
        console.log "would upload files from folder #{collection.fspath} to #{collection.path}"
        walker = walk.walk(collection.fspath, {followLinks: false})
        walker.on "files", (root, stats, next) =>
          console.log "processing file #{stats.name}"
          next()

        walker.on "end", =>
          # start looping over the dirs and upload the files
          cb()




      (err) ->
        console.log 'done!!!'



  createAsset: (name, type, parent, cb) ->

    # creates the asset
    # post to https://api.imago.io/api/assets
    console.log "going to create #{type}: #{parent?.path}/#{normalizeName(name)}"
    #
    # [{
    #   "type"  : type,
    #   "types" : [type],
    #   "name"  : name,
    #   "uuid"  : uuid.v1(),
    #   "status": "processing",
    #   "order" : 86666.66666666667,
    #   "parent":parent
    # }]
    cb(null, {})

  getUploadUrl: ->
    # post to https://api.imago.io/api/assets/getUploadUrl


  uploadAsset: ->
    # http upload the asset via upload url to temp binaries.
    # on done hit api to start post process with the features

new Importer

# modules.export Importer






