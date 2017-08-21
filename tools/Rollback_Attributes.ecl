/*
  Example:

set_atts := [
  'BIPV2.fn_derive_pn                                          '
 ,'BIPV2.KeySuffix_mod2                                        '
];

tools.Rollback_Attributes.mac_rollback_attributes(
   pSet_Attributes  := set_atts
  ,pOutputECL       := false
  ,pDo_Rollback     := false
  ,rollback_user    := 'david'
  ,latest_user      := 'vern'
);

*/

import tools;

EXPORT Rollback_Attributes :=
module
// ds_att_history := tools.mod_Soapcalls.fFindAttributes('BIPV2','KeySuffix_mod2'
// ds_att_history := tools.mod_Soapcalls.fFindAttributes('BIPV2','fn_derive_pn'
// tools.mod_Soapcalls.fSaveAttribute('BIPV2','fn_derive_pn')
// BIPV2.KeySuffix_mod2
// rollback_version := ds_att_history(version = (latestversion - 1));

// output(ds_att_history);
// output(rollback_version);

export fRollback(string attribute,boolean pDo_Rollback = false,string rollback_user = 'harrison',string latest_user = 'wright') := 
function

  modulename  := regexreplace('^([^.]+)[.](.+)$',trim(attribute),'$1',nocase);
  attname     := regexreplace('^([^.]+)[.](.+)$',trim(attribute),'$2',nocase);
  
  ds_att_history := project(dedup(tools.mod_Soapcalls.fFindAttributes(modulename,'^' + attname + '$',pShouldIncludeHistory := true),all),transform(recordof(left),self.text := regexreplace('^(.*?)[[:space:]]*$',left.text,'$1',nocase),self := left));
  // ds_att_history := tools.mod_Soapcalls.fFindAttributes('BIPV2','fn_derive_pn'
  // tools.mod_Soapcalls.fSaveAttribute('BIPV2','fn_derive_pn')
  // BIPV2.KeySuffix_mod2
  latest_version    := ds_att_history(version =  latestversion     , issandbox = false,    (count(ds_att_history(issandbox = false)) = 1 or regexfind(latest_user  ,modifiedby,nocase) or text = ds_att_history(version =  (latestversion - 1), issandbox = false)[1].text));
  latest_version2   := ds_att_history(version =  latestversion     , issandbox = false,count(ds_att_history(issandbox = false)) != 1,not (regexfind(latest_user  ,modifiedby,nocase) or text = ds_att_history(version =  (latestversion - 1), issandbox = false)[1].text));
  // other_latest_version := ds_att_history(version =  latestversion, issandbox = false,not regexfind(latest_user  ,modifiedby,nocase));
  rollback_version  := ds_att_history(version = (latestversion - 1), issandbox = false,    (regexfind(rollback_user,modifiedby,nocase) or text = ds_att_history(version =  latestversion, issandbox = false)[1].text));
  rollback_version2 := ds_att_history(version = (latestversion - 1), issandbox = false,not (regexfind(rollback_user,modifiedby,nocase) or text = ds_att_history(version =  latestversion, issandbox = false)[1].text));
  new_attributes    := if(count(ds_att_history(issandbox = false)) = 1 ,ds_att_history,dataset([],recordof(ds_att_history)));
  sandbox_version   := ds_att_history(issandbox = true);


  sandboxed := ds_att_history[1].issandbox;
  // output(ds_att_history);
  // output(rollback_version);

  mytext := map(count(rollback_version ) > 0 => rollback_version [1].text 
               ,count(rollback_version2) > 0 => rollback_version2[1].text
               ,''
  );

  notfound_atts := if(not exists(ds_att_history)  ,output(dataset([{attribute}],{string attribute}) ,named('Not_Found_Attributes'),extend));
  
  return parallel(
     // output(modulename)  
    // ,output(attname)
     output(dataset([{attribute}],{string attribute})  ,named('Passed_In_Attributes'),extend)
    ,notfound_atts
    ,output(ds_att_history    ,named('All_Versions'                 ),extend)
    ,output(latest_version    ,named('latest_versions_correct'      ),extend)
    ,output(latest_version2   ,named('latest_versions_not_correct'  ),extend)
    ,output(rollback_version  ,named('Rollback_Versions_correct'    ),extend)
    ,output(rollback_version2 ,named('Rollback_Versions_not_correct'),extend)
    ,output(new_attributes    ,named('new_attributes'               ),extend)
    ,output(sandbox_version   ,named('sandbox_version'              ),extend)
    ,if(pDo_Rollback = true and mytext != '',output(tools.mod_Soapcalls.fSaveAttribute(modulename,attname,mytext),named('SavedAttributes'),extend))
  );
  
end;

set_atts := [
  'BIPV2.fn_derive_pn                                          '
 ,'BIPV2.KeySuffix_mod2                                        '

];
/*
  mac_rollback_attributes() functionmacro
  IMPORTANT: with pDo_Rollback set to true, it will rollback all attributes in the Rollback_Versions_correct and Rollback_Versions_not_correct outputs.
  if you don't want those attributes rolled back because they are special cases, then remove them from the set passed in, and take care of them manually.
  it only rolls back to your sandbox, this will not check in any attributes.
    
*/
export mac_rollback_attributes(
   pSet_Attributes                //set of attributes that need rolled back
  ,pOutputECL       = 'false'     //output ecl as a string, or run that ecl?
  ,pDo_Rollback     = 'false'     //do the rollback or just output information gathered?  Important to first run this set to false, then once it looks ok, then set to true to do the rollback
  ,rollback_user    = 'harrison'  //who checked in the previous version of the attribute(modified by)?  if it doesn't match this, it will alert you in the Rollback_Versions_not_correct result
  ,latest_user      = 'wright'    //who checked in the current version of the attribute(modified by)?  if it doesn't match this, it will alert you in the latest_versions_not_correct result
) := 
functionmacro

  #uniquename(cnt)
  #uniquename(latt)
  #uniquename(count_set)
  #uniquename(resultout)

  #SET(cnt,1)
  #SET(count_set,count(pSet_Attributes))
  #SET(resultout ,'return sequential(\n')
  #LOOP
    #IF(%cnt% > %count_set%)
      #BREAK
    #END
      
    #IF(%cnt% != 1)
      #APPEND(resultout ,'\t,')
    #ELSE
      #APPEND(resultout ,'\t ')
    #END
    
    #SET    (latt       ,pSet_Attributes[%cnt%])
    #APPEND (resultout  ,'tools.Rollback_Attributes.fRollback(\'' + %'latt'% + '\',' + #TEXT(pDo_Rollback) + ',\'' + rollback_user + '\',\'' + latest_user + '\')\n')
    #SET    (cnt        ,%cnt% + 1)
  #END

  #APPEND(resultout ,'\t);')

  #IF(pOutputECL = true)
    return %'resultout'%;
  #ELSE
    %resultout%
  #END

endmacro;
// output(ds_atts);
// apply(ds_atts ,output(dataset([{attname}],{string stuff}),named('attname'),extend));
// apply(ds_atts ,fRollback(stuffs)); //no worky for some reason--weird because it works in other applications
// shared examples := mac_rollback_attributes(set_atts,false,false,'david','vern');


end;