import Workman,WsWorkunits;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export get_WUInfo(

   pWorkunitID = '\'\''
  ,pesp        = 'wk_ut._Constants.localEsp'
) :=
functionmacro
  
  return
  module

    import Workman,wk_ut;

    export WUInfo     := Workman.get_WUInfo (pWorkunitID,pesp);
    export FilesRead  := wk_ut.get_FilesRead(pWorkunitID,pesp);
    
  end;

endmacro;