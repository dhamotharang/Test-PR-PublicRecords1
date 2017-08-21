arecord:= { unsigned8 seleid, unsigned8 proxid, unsigned8 __internal_fpos__ };

buildindex(index(dataset([],arecord),{seleid,proxid},{dataset([],arecord)},'keyname'),'~prte::key::bipv2_suppression::20170420::seleprox',update);
