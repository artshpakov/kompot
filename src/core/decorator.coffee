window.Kompot ?= {}
window.Kompot.Core ?= {}


Kompot.decorate = (view) ->
    throw "View must extend a Backbone view class" unless _.isFunction view
    {
        with: (decorator) ->
            throw "Decorator not specified" unless _.isFunction decorator
            
            class Decorated extends Backbone.View
            
            uber = Decorated.prototype.uber = {}
            for name, property of view.prototype
                if _.has decorator, name
                    uber[name] = property 
                else
                    Decorated.prototype[name] = property
            for own name, property of decorator.prototype
                Decorated.prototype[name] = property
            
            Decorated.prototype.events = _.extend {}, view.prototype.events, decorator.prototype.events
            
            Decorated
    }
