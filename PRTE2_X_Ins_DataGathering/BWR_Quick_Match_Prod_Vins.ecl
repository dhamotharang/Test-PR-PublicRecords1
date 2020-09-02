/* **************************************************************************************************
************************************************************************************************** */
IMPORT VehicleV2,PRTE2_X_Ins_AlphaRemote,promotesupers;

All_DS := VehicleV2.file_VehicleV2_main;
Mini_DS := PROJECT(All_DS,Layouts.MiniVIN_V2_Layout);
D_Mini := DISTRIBUTE(Mini_DS,HASH(orig_VIN));
QuickT2 := DEDUP(SORT(PRTE2_X_Ins_AlphaRemote.Files.Quick_TelematicsII_DS(LexID>0),VIN),VIN);
D_T2 := DISTRIBUTE(QuickT2,HASH(VIN));
OUTPUT(QuickT2);

Fix_DS := JOIN(D_T2,D_Mini,
               LEFT.VIN = RIGHT.Orig_VIN,
               TRANSFORM({PRTE2_X_Ins_AlphaRemote.Layouts.Quick_Tele2Fix},
                     SELF.Fix_VIN := RIGHT.Orig_VIN,
                     SELF.Fix_MAKE := RIGHT.best_make_code,
                     SELF.Fix_MODEL := RIGHT.best_model_code,
                     SELF.Fix_YEAR := RIGHT.best_model_year,
                     SELF.vina_veh_type := RIGHT.vina_veh_type,
                     SELF := LEFT),
               left outer, local);
OUTPUT(Fix_DS);
OutputName := Files.VIN_Tmp_Name;
// OutputName := Files.VIN_Enh_Name;      // thinking I'll use that for true VIN file fixes, but still use same small input
promotesupers.mac_create_superfiles(OutputName);
PromoteSupers.Mac_SF_BuildProcess(Fix_DS, OutputName, build_main_base,,,TRUE);
Build_main_base;

