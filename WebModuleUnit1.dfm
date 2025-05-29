object WebModule1: TWebModule1
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      Name = 'ActHealth'
      PathInfo = '/health'
      OnAction = WebModule1ActHealthAction
    end>
  Height = 230
  Width = 415
end
