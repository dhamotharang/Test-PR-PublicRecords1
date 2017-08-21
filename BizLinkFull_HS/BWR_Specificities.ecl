//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BizLinkFull_HS.BWR_Specificities - Specificities - SALT V3.3.1');
IMPORT BizLinkFull_HS,SALT33;
IMPORT SALTTOOLS30;
SpecMod := BizLinkFull_HS.specificities(BizLinkFull_HS.File_BizHead);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
 
// Uncommenting the line below gives a detailed profile of the specificities of each field
// OUTPUT(SpecMod.AllProfiles,NAMED('SpcProfiles'));
 
// On repository-based HPCC platforms, the following macro will patch your SPC attribute with the
// latest POPULATION count and specificity/switch values.  See comments in the macro for more options!
// SALTTOOLS30.mac_Patch_SPC(SpecMod.Specificities,'BizLinkFull_HS.<your_spc_attribute>',BizLinkFull_HS.File_BizHead);
 
  OUTPUT(BizLinkFull_HS.SEE_Specificities_Comp.SEE_Specificities_Comp_Ins001_DDL,NAMED('SEE_Specificities_Comp_Ins001_DDL'));
  BizLinkFull_HS.SEE_Specificities_Comp.Build_Ins001_StatsType.BuildAll;
  BizLinkFull_HS.SEE_Specificities_Comp.Build_Ins001_vSpecificities.BuildAll;
  OUTPUT(DATASET([  {'(a.innerHTML ? a : b.innerHTML ? b : c.innerHTML ? c : d).innerHTML = "<a href=\'http://viz.hpccsystems.com/v1.2.2/apps/legacyDash.html?Hostname=" + document.location.hostname + "&Port=" + document.location.port + "&Protocol=" + document.location.protocol.substring(0,document.location.protocol.length-1) + "&Wuid=" + this.Wuid + "&ResultName=" + "SEE_Specificities_Comp_Ins001_DDL" + "\'>Dashboard for Salt Specificities(Ins001)</a>"'}
], {varstring Test__javascript}),NAMED('Dashboard_Links'));
  BizLinkFull_HS.SEE_Specificities_Comp.Build_Ins001_vDetail.BuildAll;
 
