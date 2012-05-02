window.SampleApp = window.SampleApp ?= {}

SampleApp.api_baseURL = 'http://twitter.com/statuses/'


class SampleApp.TweetCollection extends Backbone.Collection
    model:  Backbone.Model
    url:    (SampleApp.api_baseURL).concat 'public_timeline.json?callback=?'


$ ->
    feed = new Kompot.Core.CollectionView
        el: $('#feed')
        collection: new SampleApp.TweetCollection
        rowOptions:
            template: _.template $("#tweet-template").html()
    feed.collection.fetch()
