   /* ***********************************************************************************************************
   PRTE2_X_Ins_DataGathering.BWR_Gather_VIN_Year
   ***********************************************************************************************************
   ***** RUN IN PROD THOR ***** RUN IN PROD THOR ***** RUN IN PROD THOR ***** RUN IN PROD THOR *****
   ***********************************************************************************************************
   For CT purposes, VINS have no states applied so just gather by year.
   This is always a brand new year so DO NOT need to read remote the 
      "CustomerTest_X_Data_Gathering.Files.ALL_CT_VINs_RESERVED_DS", and remove matches.
   
   NOTE: It seems like every year we have to fiddle with the filter to get reasonable VINs returned

   vina_veh_type = Code that indicates the type of vehicle
   M=motorcycle
   P=passenger car
   L=light truck				Tested 2019 and there were no "L" values... so using "T" instead
   T=heavy truck				BUT "T" include semi trucks unless you alter filter only orig_vehicle_type_code='P'  (exclude "T") 
   X=trailer
   U=unknown (we could not determine the type of vehicle by decoding the VIN) 

   NOTE: for commercial we would want "T" but including the semi trucks from time to time I imagine.
   NOTE: After deduping there are always fewer... so added a dedup here prior to the CHOOSEN
   ********************************************************************
   Oct 2020 - odd, had to comment out the filter only orig_vehicle_type_code='P' because 99% of 2021 orig_types had "U"
              checking on the 5 year search if it was only 2021 that was affected or not
              yes - trying 2020 VIN years with only orig_vehicle_type_code='P' when vina_vehType="T" worked fine
              ARGHH - previous years we checked orig_year - that's broke for 2021, using vina_model_year
   NOTE: If there are already some for GATHERYEAR in VIN_Data_DS (the 1 year file) then it will append new GATHERCOUNT records to the existing ones
   Nov 2020 - two lines with //TESLA GATHER CHANGE notes were changed to append TESLA VINs to the already gathered 30,000 2021 VINs
              commented these out and uncommented the original lines
*********************************************************************************************************** */
   IMPORT VehicleV2,STD,PRTE2_X_Ins_DataGathering,PromoteSupers,PRTE2_X_Ins_AlphaRemote;

   // *** Alter every year **************************************
   GATHERYEAR := '2021';
   GATHERCOUNT := 30000;
   // ***********************************************************
   out00 := OUTPUT(' Gathering for '+GATHERYEAR+' with count: '+GATHERCOUNT);

   // === Initial Prep ============================================================================================
   Files := PRTE2_X_Ins_DataGathering.Files;
   ReservedVINs := DISTRIBUTE(PRTE2_X_Ins_AlphaRemote.Files.ALL_CT_VINs_RESERVED_DS, HASH(vin));
   existing5yr_0 := DISTRIBUTE(PRTE2_X_Ins_DataGathering.Files.VIN_Data_5yr_DS, HASH(orig_vin));
   // Remove any that are reserved already
   existing5yr := JOIN(existing5yr_0, ReservedVINs,
                           LEFT.vina_vin = RIGHT.vin,
                                 TRANSFORM({existing5yr_0}, SELF := LEFT)
                           ,left only, local);
   upper(STRING S1) := STD.Str.ToUpperCase(S1);
   VinKey_00 := VehicleV2.file_VehicleV2_main(vina_model_year = GATHERYEAR AND vina_vin <>''
                                    AND (vina_veh_type IN ['P','M'] 
                                          OR (vina_veh_type = 'T' AND orig_vehicle_type_code IN ['P','U'] ) )
                                    // AND (upper(best_make_code[1..3])='TES') );         //TESLA GATHER CHANGE
                                    AND (vina_make_desc <> '' OR vina_series_desc <> '') );
   VinKey_01a := DISTRIBUTE(PULL(VinKey_00),HASH(vina_vin));
   VinKey_01 := DEDUP( SORT(VinKey_01a,vina_vin,local), vina_vin,local);
   UsableVINLayout := PRTE2_X_Ins_DataGathering.Layouts.UsableVINLayout;
   // Sort them randomly to get a wide variety
   UsableVINLayout tranxGath1(VinKey_01 L,INTEGER rnd) := TRANSFORM
      SELF.hashvalue := HASH32(rnd, L.vehicle_key, L.orig_year, L.orig_vin, L.vina_make_desc, L.vina_veh_type);
   SELF := L;
   END;
   VinKey_02 := SORT( PROJECT(VinKey_01,tranxGath1(LEFT,RANDOM())), hashvalue);
   // ===END: Initial Prep ============================================================================================

   // === Prep Last Yr =========================================================================================
   existing1yr := DISTRIBUTE(PRTE2_X_Ins_DataGathering.Files.VIN_Data_DS, HASH(vina_vin));
   last1Year := existing1yr(vina_model_year < GATHERYEAR);
   year1Matched := existing1yr(vina_model_year >= GATHERYEAR);
   // ===END: Prep Last Yr =========================================================================================

   // === Prep 5 Yr ============================================================================================
   // move last years older data from 1 year file into the 5 year file
   add2_5Year := JOIN(last1Year, existing5yr,
                           LEFT.vina_vin = RIGHT.vina_vin,
                                 TRANSFORM({last1Year}, SELF := LEFT)
                           ,left only, local);
   New_5Yr_Final := existing5yr+add2_5Year;
   new5Year := JOIN(New_5Yr_Final, ReservedVINs,
                     LEFT.vina_vin = RIGHT.vin,
                           TRANSFORM({New_5Yr_Final}, SELF := LEFT)
                     ,left only, local);
   out1 := OUTPUT('out1: |last1Yr|'+COUNT(last1Year)+'| 5yr|'+COUNT(existing5yr_0) +'| cleaned5yr=|'+ COUNT(existing5yr)+'| +moveLast1Yr|'+ COUNT(add2_5Year)+'|=|'+ COUNT(new5Year));
   // *************************************************************************************************
   PromoteSupers.Mac_SF_BuildProcess(new5Year, Files.VIN_Data_Name5yr, build_5yr_base,,,TRUE);
   // *************************************************************************************************
   // ===END: Prep 5 Yr ============================================================================================

   // === Finalize 1 Yr ============================================================================================
   // -------------------------------------------------------------------------
   // Filter out any year1Matched in case we re-ran it and are appending
   VinKey_03 := JOIN(VinKey_02, year1Matched,
                           LEFT.vina_vin = RIGHT.vina_vin,
                                 TRANSFORM({VinKey_02}, SELF := LEFT)
                           ,left only, local);

   New_1yr_Final := CHOOSEN(VinKey_03,GATHERCOUNT);
   // out2 := OUTPUT('out2: '+COUNT(VinKey_00) +'|dedup|'+ COUNT(VinKey_01)+'|=|'+ COUNT(VinKey_03)+'|choose Tesla|'+ COUNT(New_1yr_Final));         //TESLA GATHER CHANGE
   out2 := OUTPUT('out2: '+COUNT(VinKey_00) +'|dedup|'+ COUNT(VinKey_01)+'|=|'+ COUNT(VinKey_03)+'|choosen|'+ COUNT(New_1yr_Final));

   Appended_1yr_Final := New_1yr_Final+year1Matched;
// *************************************************************************************************
   PromoteSupers.Mac_SF_BuildProcess(Appended_1yr_Final, Files.VIN_Data_Name, build_1yr_base,,,TRUE);
// *************************************************************************************************
   // ===END:  Finalize 1 Yr ============================================================================================

   out3 := OUTPUT('out3: |existing|'+COUNT(existing1yr) +'| 1yrKeep|'+ COUNT(year1Matched)+'|+|'+ COUNT(New_1yr_Final)+'|=|'+ COUNT(Appended_1yr_Final));

   // -------------------------------------------------------------------------
   Trimit(STRING S) := TRIM(S,left,right);
   report0 := RECORD
   recTypeSrc := (STRING)Trimit(New_1yr_Final.vina_veh_type)+' |'+Trimit(New_1yr_Final.vina_make_desc)+' |'+Trimit(New_1yr_Final.vina_model_desc);
   GroupCount := COUNT(GROUP);
   END;
   report1 := RECORD
   recTypeSrc := (STRING)Trimit(New_1yr_Final.vina_veh_type)+' |'+Trimit(New_1yr_Final.vina_make_desc);
   GroupCount := COUNT(GROUP);
   END;

   RepTable0 := TABLE(New_1yr_Final,report0,vina_veh_type,vina_make_desc,vina_model_desc);
   RepTable1 := TABLE(New_1yr_Final,report1,vina_veh_type,vina_make_desc);
   out4 := OUTPUT(SORT(RepTable0,-GroupCount),NAMED('RepTable_GroupOn_3'),all);
   out5 := OUTPUT(SORT(RepTable1,-GroupCount),NAMED('RepTable_GroupOn_2'),all);
   Out6 := OUTPUT(CHOOSEN(New_1yr_Final,200));
   // -------------------------------------------------------------------------

   // SEQUENTIAL(out00,out1,out2,out3,out4,out5,out6);
   SEQUENTIAL(out00,out1,out2,out3,out4,out5,out6, build_5yr_base, build_1yr_base);