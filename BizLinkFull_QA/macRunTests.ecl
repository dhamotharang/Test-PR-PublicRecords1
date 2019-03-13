EXPORT macRunTests(dInData, dInSamples) := FUNCTIONMACRO
// EXPORT macRunTests(dInData, dInSamples) := MACRO
  
  #DECLARE(sCodeStr);
  #DECLARE(sCodeOuputStr);
  #DECLARE(iIndex);
  #DECLARE(iSizeOfData);
  #SET(sCodeStr,'');
  #SET(sCodeOuputStr,'RETURN');
  #SET(iIndex,1);
  #SET(iSizeOfData,COUNT(dInData));
  #LOOP
    #IF(%iIndex% <= %iSizeOfData%)      
      // #APPEND(sCodeStr,'dData'+%iIndex%+' := '+#TEXT(dInSamples)+'(source='+#TEXT(dInData)+'['+%iIndex%+'].srcfilter AND mode='+#TEXT(dInData)+'['+%iIndex%+'].macroCall);\n')
      #APPEND(sCodeStr,'dData'+%iIndex%+' := '+#TEXT(dInSamples)+'(source='+#TEXT(dInData)+'['+%iIndex%+'].srcCategory);\n')
      #APPEND(sCodeStr,'modData'+%iIndex%+' := BizLinkFull_QA.modRunTests(dData'+%iIndex%+',BizLinkFull_QA.modProfiles.dprofiles['+%iIndex%+']);\n')
      
      #IF(%iIndex% > 1) 
        #APPEND(sCodeOuputStr, ' &')
      #END
      
      #APPEND(sCodeOuputStr, ' CASE(' + #TEXT(dInData)+'['+%'iIndex'%+'].macroCall, 3 => modData'+%iIndex%+'.j_In_IDFUNCTIONS)')
			// #APPEND(sCodeOuputStr, ' CASE(' + #TEXT(dInData)+'['+%'iIndex'%+'].macroCall, 1 => modData'+%iIndex%+'.j_In_THOR, 2 => modData'+%iIndex%+'.j_In_ROXIE)')
      // #APPEND(sCodeOuputStr, ' CASE(' + #TEXT(dInData)+'['+%'iIndex'%+'].macroCall, 1 => modData'+%iIndex%+'.j_In_THOR, 2 => modData'+%iIndex%+'.j_In_ROXIE, 3 => modData'+%iIndex%+'.j_In_IDFUNCTIONS)')
      #SET(iIndex,%iIndex%+1)
    #ELSE
      #APPEND(sCodeOuputStr,';')
      #BREAK
    #END
  #END
  
 %sCodeStr%
 %sCodeOuputStr%
// %'sCodeStr'%
// %'sCodeOuputStr'%
ENDMACRO;
