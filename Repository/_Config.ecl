import _control;
EXPORT _Config(

  string pEsp = _Control.Config.LocalEsp

) :=
module

  export Esp  := pEsp  + ':8145';
  export Url  := 'http://' + Esp + '/WsAttributes?ver_=1.21';

end;