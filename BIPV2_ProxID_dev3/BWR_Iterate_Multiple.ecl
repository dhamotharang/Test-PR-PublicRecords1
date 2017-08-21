/*
So all I need to do i:
set the proxid to the dotid for the recs that dont have prox
patch the proxs like I did last time to make sure no dot changes broke integrity of prox.
Do Todd hacks below to generated prox salt code:
  HACK	BIPV2_DotID.match_candidates	On line 7, I added two references to a new field named SALT_Partition
  HACK	BIPV2_DotID.matches	On line 221, I added a SALT_Partition join condition in parenthesis.  I also added HINT(parallel_match), but thats a performance thing that had nothing to do with partitioning.
  HACK	BIPV2_DotID.specificities	On line 2, I added a couple new imports.  On line 53, I added a new line that creates the SALT_Partition field. On lines 65-69, added an additional step that manipulates the SALT_Partition field
  HACK	BIPV2_DotID.Proc_Iterate	Added line 26.  Added a reference to it on line 27.
Rollback any sandboxed attributes because of layout mismatches
Do rest of hacks:
added hint(parallel_match to MJ in matches
changed h0 dedup in match_candidates to except rcid instead of whole record
hack default force for cnp_number and prim_range(make sure they equal each other) in matches attribute
Remove Zoom from base file to see if it lowers the amount of matches significantly
add two extra MJs in matches attribute:
  for mj1 add "AND LEFT.cnp_name[1..4] = RIGHT.cnp_name[1..4]" to join condition and to atmost
  for mj2 add "AND LEFT.sec_range = RIGHT.sec_range" to join condition and to atmost
add all mjs up here:
  last_mjs_t :=mj0 + mj1 + mj2;
*/
import wk_ut,tools,bipv2,mdr,BIPV2_ProxID_dev3;

startiter := 25;
numiters  := 5;
version   := BIPV2.KeySuffix;
cluster   := tools.fun_Groupname('20',false);

#workunit('name','BIPV2_ProxID_dev3 Specificites + kick off iterations ' + (string)startiter + '-' + (string)(startiter + numiters - 1));
#workunit('priority','high');
#workunit('protect' ,true);

ecltext := 'import BIPV2,BIPV2_Build,BIPV2_ProxID_dev3,tools,mdr;iteration := \'@iteration@\';pversion  := \'@version@\';lih       := if((unsigned)iteration = 1   ,BIPV2_ProxID_dev3.In_DOT_Base    ,BIPV2_ProxID_dev3.files().base.built )(not mdr.sourceTools.sourceisZoom(source));#workunit(\'name\',\'BIPV2_ProxID_dev3 \' + pversion + \' iter \' + iteration);#workunit(\'priority\',\'high\');#workunit(\'protect\' ,true);BIPV2_ProxID_dev3.Proc_Iterate(iteration,pversion,lih).doall;';
kickiters := wk_ut.mac_ChainWuids(ecltext,startiter,numiters,version,['PreClusterCount','PostClusterCount','MatchesPerformed'],cluster,pOutputEcl := false);
//kickiters;

//This is the code to execute in a builder window
//#workunit('name','BIPV2_ProxID_dev3.BWR_Specificities - Specificities');
IMPORT BIPV2_ProxID_dev3,SALT25;
IMPORT SALTTOOLS22;

dotbase := BIPV2_ProxID_dev3.files().base.built(not mdr.sourceTools.sourceisZoom(source));

SpecMod := BIPV2_ProxID_dev3.specificities(dotbase);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
sequential(
   output(dotbase)       //ensure persist is built
 // ,BIPV2_ProxID_dev3.Promote('0').new2built    //promote it as zeroth iteration to superfile(for attribute file use)
  ,SpecMod.Build
  ,parallel(
     OUTPUT(SpecMod.Specificities ,NAMED('Specificities'))
    ,OUTPUT(SpecMod.SpcShift      ,NAMED('SpcShift'     ))
    ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_ProxID_dev3._SPC',dotbase,,false)
//    ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_ProxID_dev3._SPC',dotbase,,false,false)
  )
  ,kickiters
);
