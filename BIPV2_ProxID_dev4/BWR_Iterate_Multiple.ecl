/*
Hacks:
  BIPV2_ProxID_dev4.matches: hack default force for cnp_number,cnp_name & prim_range(make sure they equal each other) 
                        in matchjoin attribute
                        add logic so that one side of cnp_name match(when SUPPORTED) is a DBA
  BIPV2_ProxID_dev4.Debug:   hack sample match join to match hacks in matchjoin in matches.            
                        change match sample key so it's score is correct
  BIPV2_ProxID_dev4._SPC:    added company_name_type_raw & company_name_type_derived to SPC as CARRY fields.
*/
import wk_ut,tools,bipv2,mdr,BIPV2_ProxID_dev4;

startiter := 30;
numiters  := 5;
version   := BIPV2.KeySuffix;
cluster   := tools.fun_Groupname('20',false);
previter  := (string)(startiter - 1);
dopatch   := true;

#workunit('name','BIPV2_ProxID_dev4 Specificites + kick off iterations ' + (string)startiter + '-' + (string)(startiter + numiters - 1));
#workunit('priority','high');
#workunit('protect' ,true);

ecltext := 'import BIPV2,BIPV2_Build,BIPV2_ProxID_dev4,tools,mdr;iteration := \'@iteration@\';pversion  := \'@version@\';lih       := if((unsigned)iteration = 1   ,BIPV2_ProxID_dev4.In_DOT_Base    ,BIPV2_ProxID_dev4.files().base.built );#workunit(\'name\',\'BIPV2_ProxID_dev4 \' + pversion + \' iter \' + iteration);#workunit(\'priority\',\'high\');#workunit(\'protect\' ,true);BIPV2_ProxID_dev4.Proc_Iterate(iteration,pversion,lih).doall;';
kickiters := wk_ut.mac_ChainWuids(ecltext,startiter,numiters,version,['PreClusterCount','PostClusterCount','MatchesPerformed'],cluster,pOutputEcl := false);
//kickiters;

//This is the code to execute in a builder window
//#workunit('name','BIPV2_ProxID_dev4.BWR_Specificities - Specificities');
IMPORT BIPV2_ProxID_dev4,SALT25;
IMPORT SALTTOOLS22;

dotbase := BIPV2_ProxID_dev4.files().base.built;

SpecMod := BIPV2_ProxID_dev4.specificities(dotbase);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
sequential(
   if(dopatch = true  ,BIPV2_ProxID_dev4.Patch_Proxids(previter,version))
  ,output(dotbase)       //ensure persist is built
 // ,BIPV2_ProxID_dev4.Promote('0').new2built    //promote it as zeroth iteration to superfile(for attribute file use)
  ,SpecMod.Build
  ,parallel(
     OUTPUT(SpecMod.Specificities ,NAMED('Specificities'))
    ,OUTPUT(SpecMod.SpcShift      ,NAMED('SpcShift'     ))
    ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_ProxID_dev4._SPC',dotbase,,false)
//    ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_ProxID_dev4._SPC',dotbase,,false,false)
  )
//  ,kickiters
);
