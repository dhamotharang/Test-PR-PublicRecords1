   /* ***********************************************************************************************************
   Copy of PRTE2_X_Ins_DataGathering.BWR_Gather_VIN_5Years with a few alterations to gather a few more specific VINs
   and append them to the 5yr base file 
   ***********************************************************************************************************
   ***** RUN IN PROD THOR ***** RUN IN PROD THOR ***** RUN IN PROD THOR ***** RUN IN PROD THOR *****
   ***********************************************************************************************************

   //TODO - SHOULD READ IN THE REMOTE ALPHA "CustomerTest_X_Data_Gathering.Files.ALL_CT_VINs_RESERVED_DS", and remove those.
   using -- PRTE2_X_Ins_AlphaRemote.Files.ALL_CT_VINs_RESERVED_DS

   For CT purposes, VINS have no states applied so just gather by years.

   vina_veh_type = Code that indicates the type of vehicle
   M=motorcycle
   P=passenger car
   L=light truck				Tested 2019 and there were no "L" values... so using "T" instead
   T=heavy truck				BUT "T" include semi trucks unless you alter filter only orig_vehicle_type_code='P'  (exclude "T") 
   ** Oct 2020 - SPOTTED SUVs are in the "T" category in the VINA file - "T" holds a lot of different Vehicles **
   X=trailer
   U=unknown (we could not determine the type of vehicle by decoding the VIN) 

   NOTE: for commercial we would want "T" but including the semi trucks from time to time I imagine.
   NOTE: After deduping there are always fewer... so added a dedup here prior to the CHOOSEN
   ********************************************************************
   Oct 2020 - odd, had to comment out the filter only orig_vehicle_type_code='P' because 99% of 2021 orig_types had "U"
            checking on the 5 year search if it was only 2021 that was affected or not
            yes - trying 2021 VIN years with this worked fine:
                  vina_model_year IN yearsToPull AND vina_vin <>''
                  AND (vina_veh_type IN ['P','M'] 
                        OR (vina_veh_type = 'T' AND orig_vehicle_type_code IN ['P','U'] ) )
                  AND (vina_make_desc <> '' OR vina_series_desc <> '') );
             ALSO! - previous years we checked orig_year - that's broke for 2021, using vina_model_year                     
   *********************************************************************************************************** */
   IMPORT VehicleV2,STD,PRTE2_X_Ins_DataGathering,PromoteSupers,PRTE2_X_Ins_AlphaRemote;

   // *** Alter every year **************************************
   // yearsToPull := ['2014', '2015'];			// Special we want a few more NISSAN and INFINITY in these two years
   yearsToPull := ['2016','2017','2018','2019','2020'];
   // MakeToPull := ['Nissan','Infinity'];
   howManytoPull := 22000;
   SimpleSetDs := DATASET(yearsToPull,{STRING eachString});
   SimpleSetRolled := ROLLUP(SimpleSetDs, TRUE, TRANSFORM({string eachString}, SELF.eachString := LEFT.eachString + ',' + RIGHT.eachString));
   ypString := SimpleSetRolled[1].eachString;
   // ypString := yearsToPull[1]+','+yearsToPull[2]+','+yearsToPull[3]+','+yearsToPull[4]+','+yearsToPull[5];
   out00 := OUTPUT(' Pulling random new 5 years using ['+ypString+'] to gather another '+howManytoPull);
   // ***********************************************************
   
   Files := PRTE2_X_Ins_DataGathering.Files;
   ReservedVINs := DISTRIBUTE(PRTE2_X_Ins_AlphaRemote.Files.ALL_CT_VINs_RESERVED_DS, HASH(vin));
   existing5yr_0 := DISTRIBUTE(PRTE2_X_Ins_DataGathering.Files.VIN_Data_5yr_DS, HASH(orig_vin));
   // Remove any that are reserved already
   existing5yr := JOIN(existing5yr_0, ReservedVINs,
                           LEFT.vina_vin = RIGHT.vin,
                                 TRANSFORM({existing5yr_0}, SELF := LEFT)
                           ,left only, local);

   kvMain00 := VehicleV2.file_VehicleV2_main(vina_model_year IN yearsToPull AND vina_vin <>''
                                    AND (vina_veh_type IN ['P','M'] 
                                          OR (vina_veh_type = 'T' AND orig_vehicle_type_code IN ['P','U'] ) )
                                    AND (vina_make_desc <> '' OR vina_series_desc <> '') );

   kvMain01a := DISTRIBUTE(PULL(kvMain00),HASH(vina_vin));
   kvMain01b := DEDUP(SORT(kvMain01a,vina_vin,local),vina_vin,local);
   // Remove any that are in the 5 year base
   kvMain01c := JOIN(kvMain01b, existing5yr,
                           LEFT.vina_vin = RIGHT.orig_vin,
                                 TRANSFORM({kvMain01b}, SELF := LEFT)
                           ,left only);
   // Remove any that are reserved already
   kvMain01 := JOIN(kvMain01c, ReservedVINs,
                           LEFT.vina_vin = RIGHT.vin,
                                 TRANSFORM({kvMain01c}, SELF := LEFT)
                           ,left only, local);
   UsableVINLayout := PRTE2_X_Ins_DataGathering.Layouts.UsableVINLayout;
   // Sort them randomly to get a wide variety
   UsableVINLayout tranxGath1(kvMain01 L,INTEGER rnd) := TRANSFORM
      SELF.hashvalue := HASH32(rnd, L.vehicle_key, L.orig_year, L.orig_vin, L.vina_make_desc, L.vina_veh_type);
   SELF := L;
   END;
   kvMain02 := SORT( PROJECT(kvMain01,tranxGath1(LEFT,RANDOM())), hashvalue);

   // *** OR APPEND NEW DATA TO EXISTING 5yr DATA ***
   // also in UsableVINLayout
   All_Next := CHOOSEN(kvMain02,howManytoPull);    // Sorted Random so we should get a good mixture
   Final5yrDS := All_Next+existing5yr;
   out1 := OUTPUT('Out1: prodQualify('+COUNT(kvMain00) +') cleanedProd('+ COUNT(kvMain02)+')' );
   out2 := OUTPUT('Out2: exist5('+COUNT(existing5yr_0) +'), clean5('+ COUNT(existing5yr)+'), allNew('+ COUNT(All_Next)+') = ToReplace('+ COUNT(Final5yrDS)+')' );

   PromoteSupers.Mac_SF_BuildProcess(Final5yrDS, Files.VIN_Data_Name5yr, build_5yr_base,,,TRUE);

   Trimit(STRING S) := TRIM(S,left,right);
   report0 := RECORD
   recTypeSrc := (STRING)Trimit(Final5yrDS.vina_veh_type)+' |'+Trimit(Final5yrDS.vina_make_desc)+' |'+Trimit(Final5yrDS.vina_model_desc);
   GroupCount := COUNT(GROUP);
   END;
   report1 := RECORD
   recTypeSrc := (STRING)Trimit(Final5yrDS.vina_veh_type)+' |'+Trimit(Final5yrDS.vina_make_desc);
   GroupCount := COUNT(GROUP);
   END;

   RepTable0 := TABLE(Final5yrDS,report0,vina_veh_type,vina_make_desc,vina_model_desc);
   RepTable1 := TABLE(Final5yrDS,report1,vina_veh_type,vina_make_desc);
   out3 := OUTPUT(SORT(RepTable0,-GroupCount),NAMED('RepTable_GroupOn_3'),all);
   out4 := OUTPUT(SORT(RepTable1,-GroupCount),NAMED('RepTable_GroupOn_2'),all);

   // SEQUENTIAL(out00,out1,out2,out3,out4);
   SEQUENTIAL(out00,out1,out2,out3,out4, build_5yr_base);