### define
underscore : _
jquery : $
kinetic : Kinetic
###

$ ->

  width = $("#content").width()
  height = 1000

  boxWidth = 100
  boxHeight = 50
  textSize = 15

  stage = new Kinetic.Stage {
    container: "content", width, height
  }

  layer = new Kinetic.Layer()

  $.when((for i in [1..200]
    deferred = new $.Deferred()
    image = new Image()
    do (image, deferred) ->
      image.onload = -> deferred.resolve(image); return
    image.src = "http://placehold.it/#{boxWidth}x#{i}"
    deferred.promise()
  )...).done (images...) ->

    for i in [0...1000]

      group = new Kinetic.Group(
        x : Math.floor(Math.random() * (width - boxWidth))
        y : Math.floor(Math.random() * (height - boxHeight))
        width : boxWidth
        height : boxHeight + textSize * 1.5
        draggable : true
      )
      group.on 'mouseover', -> $(document.body).css( cursor : 'pointer' ); return
      group.on 'mouseout',  -> $(document.body).css( cursor : 'default' ); return

      rect = new Kinetic.Rect(
        x : 2
        y : 2
        width : boxWidth - 4
        height : boxHeight - 4
        fill : "hsl(#{Math.floor(Math.random() * 256)}, 100%, 50%)"
        stroke : 'black'
        strokeWidth : 4
      )

      image = new Kinetic.Image(
        x : 10
        y : 10
        width : boxWidth - 20
        height : boxHeight - 20
        image : images[i % 200]
      )

      text = new Kinetic.Text(
        x : 0
        y : 0.25 * textSize + boxHeight
        width : boxWidth
        text : 'Simple Text'
        fontSize : textSize
        fontFamily : "Open Sans"
        fill : "green"
        align : "center"
      )

      group.add(rect)
      group.add(image)
      group.add(text)


      layer.add(group)

    stage.add(layer)