import Workman,WsDFU;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export get_DFUInfo(

   string filename  = ''
  ,string cluster   = ''
  ,string pesp      = _constants.LocalEsp
  
) :=
module

  export DFUInfo          := WsDFU.soapcall_DFUInfo (filename,cluster,,,pesp);
  export DFUInfoOutRecord := recordof(DFUInfo);
  
end;
