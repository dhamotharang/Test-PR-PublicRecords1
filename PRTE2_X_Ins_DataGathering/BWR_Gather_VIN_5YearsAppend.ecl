/* ***********************************************************************************************************
Copy of PRTE2_X_Ins_DataGathering.BWR_Gather_VIN_5Years with a few alterations to gather a few more specific VINs
and append them to the 5yr base file 

*********************************************************************************************************** */
IMPORT VehicleV2,STD,PRTE2_X_Ins_DataGathering,PromoteSupers,PRTE2_X_Ins_AlphaRemote;

// yearsToPull := ['2014', '2015'];			// Special we want a few more NISSAN and INFINITY in these two years
yearsToPull := ['2010', '2011', '2012', '2013', '2014'];
// MakeToPull := ['Nissan','Infinity'];
howManytoPull := 22000;
ReservedVINs := DISTRIBUTE(PRTE2_X_Ins_AlphaRemote.Files.ALL_CT_VINs_RESERVED_DS, HASH(vin));

kvMain00 := VehicleV2.file_VehicleV2_main(orig_year IN yearsToPull AND orig_vin <>''
																			AND (vina_veh_type IN ['P','M'] 
																							OR (vina_veh_type = 'T' AND orig_vehicle_type_code = 'P')
																			)
																			// AND vina_make_desc IN MakeToPull AND (vina_model_desc > '' OR vina_series_desc > '')
																			AND vina_make_desc > '' AND (vina_model_desc > '' OR vina_series_desc > '')
																			);
kvMain01a := DISTRIBUTE(PULL(kvMain00),HASH(vina_vin));
kvMain01b := DEDUP(SORT(kvMain01a,vina_vin,local),vina_vin,local);
kvMain01 := JOIN(kvMain01b, ReservedVINs,
									LEFT.vina_vin = RIGHT.vin,
											TRANSFORM({kvMain01b}, SELF := LEFT)
									,left only, local);

UsableVINLayout := PRTE2_X_Ins_DataGathering.Layouts.UsableVINLayout;
// Sort them randomly to get a wide variety
UsableVINLayout tranxGath1(kvMain01 L,INTEGER rnd) := TRANSFORM
		SELF.hashvalue := HASH32(rnd, L.vehicle_key, L.orig_year, L.orig_vin, L.vina_make_desc, L.vina_veh_type);
	SELF := L;
END;
kvMain02 := SORT( PROJECT(kvMain01,tranxGath1(LEFT,RANDOM())), hashvalue);


All_Next := CHOOSEN(kvMain02,howManytoPull);
OUTPUT(COUNT(kvMain00) +'|'+ COUNT(kvMain01)+'|'+ COUNT(kvMain02)+'|'+ COUNT(All_Next));

Trimit(STRING S) := TRIM(S,left,right);
report0 := RECORD
	recTypeSrc := (STRING)Trimit(All_Next.vina_veh_type)+'|'+Trimit(All_Next.vina_make_desc)+'|'+Trimit(All_Next.vina_model_desc);
	GroupCount := COUNT(GROUP);
END;
report1 := RECORD
	recTypeSrc := (STRING)Trimit(All_Next.vina_veh_type)+'|'+Trimit(All_Next.vina_make_desc);
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(All_Next,report0,vina_veh_type,vina_make_desc,vina_model_desc);
RepTable1 := TABLE(All_Next,report1,vina_veh_type,vina_make_desc);
out1 := OUTPUT(SORT(RepTable0,-GroupCount),all);
out2 := OUTPUT(SORT(RepTable1,-GroupCount),all);
Files := PRTE2_X_Ins_DataGathering.Files;

// *** OR APPEND NEW DATA TO EXISTING 5yr DATA ***
// also in UsableVINLayout
existing5yr := PRTE2_X_Ins_DataGathering.Files.VIN_Data_5yr_DS;
AppendedDS := All_Next+existing5yr;
PromoteSupers.Mac_SF_BuildProcess(AppendedDS, Files.VIN_Data_Name5yr, build_main_base,,,TRUE);


SEQUENTIAL(out1,out2, build_main_base);