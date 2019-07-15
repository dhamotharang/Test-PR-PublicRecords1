import BIPV2_ProxID;
export mac_loop(pversion,ih = 'BIPV2_ProxID.In_DOT_Base',offset = '0',mt = 'BIPV2_ProxID._Proc_Iterate_Experimental().lMT',finalloop = 'true',pIsTesting = 'false') := 
functionmacro
import BIPV2_ProxID;
  #uniquename(lnumiterations)
  %lnumiterations% := 1 : stored('numProxidIters');
  
  #uniquename(LoopFun)
  #SET(LoopFun  ,'Loop' + %'lnumiterations'%)
  
  #uniquename(out)
  #SET(out  ,'BIPV2_ProxID._Proc_Iterate_Experimental(,' + #TEXT(pIsTesting) + ').' + %'LoopFun'% + '(' + mt + ',' + ih + ',' + #TEXT(pversion) + ',' + #TEXT(offset) + ',' + #TEXT(finalloop) + ');');
  
  return %'out'%;
  
endmacro;
