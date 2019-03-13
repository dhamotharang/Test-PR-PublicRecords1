//so take iteration 24 from BIPV2_ProxID 
//then do the corpkey unhack in in_dot_base when it pulls it in.
//matches: hack cnp_number_score to make sure an exact match qualifies even if the values are considered null.
//         hack prim_range_score the same way as cnp_number_score
//         add "HINT(PARALLEL_MATCH)" to match join
//match_candidates: change h0 dedup from "whole record" to "except rcid"
//debug: all same hacks as above in matches
//Run some iterations
startiter := 25;
numiters  := 5;
#workunit('name','BIPV2_ProxID kick off iterations ' + (string)startiter + '-' + (string)(startiter + numiters - 1));
#workunit('priority','high');
ecltext := '/*//do tonight -- try to kick off iteration that doesnt have contact fields in it.  see how much faster it is//remove contact fields from spc//do cnp name stuff//corpkey stuff -- check//high priority//two step specsadded hint(parallel_match to MJ in matcheschanged h0 dedup in match_candidates to except rcid instead of whole recordhack on BIPV2_Files.tools_dotid.SetSOSremove abbr from cnp namemake cnp name force(+13) instead of just force(+)remove all conditional forces on cnp nameadd force(+-2) to company_csz conceptpatch iteration1\'s bad city, bad zip recordspatch cnp_number field to split records with populated to blank cnp numberchange SPC for cnp_number field to default force from force(--) to prevent future blank to populated matches on that field.hack default force for cnp_number and prim_range(make sure they equal each other)*/import BIPV2,BIPV2_Build,BIPV2_ProxID,tools;iteration := \'@iteration@\';pversion  := \'@version@\';lih       := if((unsigned)iteration = 1   ,BIPV2_ProxID.In_DOT_Base    ,BIPV2_ProxID.files().base.built );#workunit(\'name\',\'BIPV2_ProxID \' + pversion + \' iter \' + iteration);#workunit(\'priority\',\'high\');BIPV2_ProxID.Proc_Iterate(iteration,pversion,lih).doall;';
kickiters := wk_ut.mac_ChainWuids(ecltext,startiter,numiters,BIPV2.KeySuffix,['PreClusterCount','PostClusterCount','MatchesPerformed'],tools.fun_Groupname('20',false),pOutputEcl := false);
//kickiters;
//This is the code to execute in a builder window
//#workunit('name','BIPV2_ProxID.BWR_Specificities - Specificities');
IMPORT BIPV2_ProxID,SALT25;
IMPORT SALTTOOLS22;
dotbase := BIPV2_ProxID.files().base.built;
SpecMod := BIPV2_ProxID.specificities(dotbase);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
sequential(
   output(dotbase)       //ensure persist is built
//  ,BIPV2_ProxID.Promote('0').new2built    //promote it as zeroth iteration to superfile(for attribute file use)
  ,SpecMod.Build
  ,parallel(
     OUTPUT(SpecMod.Specificities ,NAMED('Specificities'))
    ,OUTPUT(SpecMod.SpcShift      ,NAMED('SpcShift'     ))
    ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_ProxID._SPC',dotbase,,false)
    ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_ProxID._SPC',dotbase,,false,false)
  )
  ,kickiters
);
