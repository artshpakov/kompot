window.Kompot ?= {}
window.Kompot.Core ?= {}


class Kompot.Core.ModelView extends Backbone.View
    tagName: 'li'
    
    initialize: (options) ->
        @template = options.template || @template
        throw "Template not specified" unless @template
        throw "Model not specified" unless @model
        
        _.bindAll @
        @model.bind "change", @render
        @model.bind "destroy", => $(@el).remove()
    
    render: ->
        $(@el).html @template { model : @model.toJSON() }
        @


class Kompot.Core.CollectionView extends Backbone.View
    rowPrototype: Kompot.Core.ModelView
    
    initialize: (options) ->
        @collection     = options.collection or new Backbone.Collection
        @rowPrototype   = options.rowPrototype or @rowPrototype
        @rowOptions     = options.rowOptions or {}
        
        _.bindAll @
        @collection.bind 'reset', @render
        @collection.bind 'add', @render
    
    render: ->
        $(@el).html('')
        @collection.each (model) =>
            view = new @rowPrototype _.extend {model}, @rowOptions
            $(@el).append view.render().el
        @
