/*2013-05-17T16:40:08Z (vern_p bentley)
copied from BIPV2_ProxID
*/
//This is the code to execute in a builder window
#workunit('name','BIPV2_ProxID_dev3.BWR_Specificities - Specificities - SALT V2.5 Beta 2');
IMPORT BIPV2_ProxID_dev3,SALT25;
IMPORT SALTTOOLS22;

dotbase := BIPV2_ProxID_dev3.In_DOT_Base;

SpecMod := BIPV2_ProxID_dev3.specificities(dotbase);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
sequential(
   output(dotbase)       //ensure persist is built
  ,BIPV2_ProxID_dev3.Promote('0').new2built    //promote it as zeroth iteration to superfile(for attribute file use)
  ,SpecMod.Build
  ,parallel(
     OUTPUT(SpecMod.Specificities ,NAMED('Specificities'))
    ,OUTPUT(SpecMod.SpcShift      ,NAMED('SpcShift'     ))
    ,SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_ProxID_dev3._SPC',dotbase)
));
