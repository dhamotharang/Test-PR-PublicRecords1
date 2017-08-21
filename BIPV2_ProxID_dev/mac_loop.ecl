import BIPV2_ProxID_dev;
export mac_loop(pversion,ih = 'BIPV2_ProxID_dev.In_DOT_Base',offset = '0',mt = 'BIPV2_ProxID_dev._Proc_Iterate_Experimental().lMT',finalloop = 'true',pIsTesting = 'false') := 
functionmacro
import BIPV2_ProxID_dev;
  #uniquename(lnumiterations)
  %lnumiterations% := 1 : stored('numProxidIters');
  
  #uniquename(LoopFun)
  #SET(LoopFun  ,'Loop' + %'lnumiterations'%)
  
  #uniquename(out)
  #SET(out  ,'BIPV2_ProxID_dev._Proc_Iterate_Experimental(,' + #TEXT(pIsTesting) + ').' + %'LoopFun'% + '(' + mt + ',' + ih + ',' + #TEXT(pversion) + ',' + #TEXT(offset) + ',' + #TEXT(finalloop) + ');');
  
  return %'out'%;
  
endmacro;
