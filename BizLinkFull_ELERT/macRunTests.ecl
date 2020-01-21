EXPORT macRunTests(dInData, dInSamples, sVersion, sMode, sConstantValue, fFunctionIdAppendThor, fFunctionIdAppendRoxie, fFunctionIdFunctions, fFunctionMMF, iExpireTime, sInPrefix) := FUNCTIONMACRO
  
  #CONSTANT('Superfile_Name',sConstantValue);
  #DECLARE(sCodeStr);
  #DECLARE(sCodeOuputStr);
  #DECLARE(iIndex);
  #DECLARE(iSizeOfData);
  #DECLARE(sMacroCall);
  #SET(sMacroCall,IF(sMode='ORIG','macroCallOrig','macroCallNew'));
  #SET(sCodeStr,'');
  #SET(sCodeOuputStr,'');
  #SET(iIndex,1);
  #SET(iSizeOfData,COUNT(dInData));
  #LOOP
    #IF(%iIndex% <= %iSizeOfData%)      
      #APPEND(sCodeStr,'dData'+%iIndex%+' := '+#TEXT(dInSamples)+'(profile_bucket = '+#TEXT(dInData)+'['+%iIndex%+'].srcCategory AND mode='+#TEXT(dInData)+'['+%iIndex%+'].macroCallOrig AND compareMode='+#TEXT(dInData)+'['+%iIndex%+'].macroCallNew);\n')
      #APPEND(sCodeStr,'modData'+%iIndex%+' := BizLinkFull_ELERT.modRunTests(dData'+%iIndex%+','+#TEXT(dInData)+'['+%iIndex%+'],'+#TEXT(sMode)+','+#TEXT(fFunctionIdAppendThor)+','+#TEXT(fFunctionIdAppendRoxie)+','+#TEXT(fFunctionIdFunctions)+','+#TEXT(fFunctionMMF)+');\n')
      
      #IF(%iIndex% > 1) 
        #APPEND(sCodeOuputStr, ' &')
      #END
      //Expand modes here to match your data. -ZRS 4/8/2019    
      #APPEND(sCodeOuputStr, ' CASE(' + #TEXT(dInData)+'['+%'iIndex'%+'].' + #TEXT(%sMacroCall%) + 
			                       ',1 => modData'+%iIndex%+'.mode1' + // DEFUALT ROXIE. DONT CHANGE!!!!
								   ',2 => modData'+%iIndex%+'.mode2' + // DEFUALT THOR. DONT CHANGE!!!!
								   ',3 => modData'+%iIndex%+'.mode3' +
								   ',4 => modData'+%iIndex%+'.mode4' +
								   ',5 => modData'+%iIndex%+'.mode5' +
								   ',6 => modData'+%iIndex%+'.mode6' +
								   ',7 => modData'+%iIndex%+'.mode7' +
								   ',8 => modData'+%iIndex%+'.mode8' +
								   ',9 => modData'+%iIndex%+'.mode9' +
								   ',10 => modData'+%iIndex%+'.mode10' +
								   ',11 => modData'+%iIndex%+'.mode11' +
								   ',12 => modData'+%iIndex%+'.mode12' +
								   ',13 => modData'+%iIndex%+'.mode13' +
								   ',14 => modData'+%iIndex%+'.mode14' +
								   ',15 => modData'+%iIndex%+'.mode15' +
								   ',16 => modData'+%iIndex%+'.mode16' +
									 ',17 => modData'+%iIndex%+'.mode17' +
									 ',18 => modData'+%iIndex%+'.mode18' +
									 ',19 => modData'+%iIndex%+'.mode19' +
									 ',20 => modData'+%iIndex%+'.mode20' +
									 ',21 => modData'+%iIndex%+'.mode21' +
									 ',22 => modData'+%iIndex%+'.mode22' +
									 ',23 => modData'+%iIndex%+'.mode23' +
                   ',24 => modData'+%iIndex%+'.mode24' +
									 ',25 => modData'+%iIndex%+'.mode25' +
								   ')')

      #SET(iIndex,%iIndex%+1)
    #ELSE
      #APPEND(sCodeOuputStr,';')
      #BREAK
    #END
  #END
  // output(#TEXT(%sCodeStr%));
  // output(#TEXT(%sCodeOuputStr%));
	%sCodeStr%
  dData := %sCodeOuputStr%
  
  #IF(sMode = 'ORIG') 
    aOutput := OUTPUT(dData,,BizLinkFull_ELERT.modFilenames(sInPrefix).kOrigRunResultLF(sVersion),COMPRESSED,EXPIRE(iExpireTime),OVERWRITE);
    aPromoteSuperfile := BizLinkFull_ELERT.modSuperfiles(sInPrefix).macUpdateSF(BizLinkFull_ELERT.modFilenames(sInPrefix).kOrigRunResultLF(sVersion),BizLinkFull_ELERT.modFilenames(sInPrefix).kOrigRunResultsSF);
  #ELSEIF(sMode = 'NEW') 
    aOutput := OUTPUT(dData,,BizLinkFull_ELERT.modFilenames(sInPrefix).kNewRunResultsLF(sVersion),COMPRESSED,EXPIRE(iExpireTime),OVERWRITE);
    aPromoteSuperfile := BizLinkFull_ELERT.modSuperfiles(sInPrefix).macUpdateSF(BizLinkFull_ELERT.modFilenames(sInPrefix).kNewRunResultsLF(sVersion),BizLinkFull_ELERT.modFilenames(sInPrefix).kNewRunResultsSF);
  #END
  
  RETURN SEQUENTIAL(STD.File.StartSuperFileTransaction(),
                      aOutput,
                      aPromoteSuperfile,
                      STD.File.FinishSuperFileTransaction());
ENDMACRO;
    
