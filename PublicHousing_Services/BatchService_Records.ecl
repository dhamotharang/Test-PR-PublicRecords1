
IMPORT BatchDatasets;

EXPORT BatchService_Records := MODULE

	EXPORT BatchView(DATASET(PublicHousing_Services.Layouts.batch_in) ds_batch_in, PublicHousing_Services.IParams.BatchParams in_mod) := 
		FUNCTION
			/*
			The following datasets are retrieved in this function:
			  o  Instant ID
			  o  ADL Best
			  o  Department of Corrections
			  o  Deceased
			  o  Criminal Felony
			  o  Sex Offender
			  o  Best Address with Dedup
			  o  Driver License
			  o  Voter Registration
			  o  Property
			  o  RT-MVR2
			  o  Watercraft
			  o  Aircraft
			*/
			
			// NOTE: All Requirements referenced below are described in the _documentation attribute.
			
			// ---------------------------------------------------------------------------
			// 
			// 1. Get Instant ID recs. Fulfills Requirement 4.1.7 
			// 
			// ---------------------------------------------------------------------------
			
			SET OF STRING2 ACCEPTABLE_NAS_VALUES := ['9','10','11','12'];
			
			PublicHousing_Services.Layouts.rec_instantid
					ds_instantID_recs := PublicHousing_Services.fn_getIIDRecs(ds_batch_in, in_mod);
			
			// 0.a. Use ds_instantID_recs as the seed for constructing the batch_out layout.
			ds_batch_out_seed := 
				PROJECT( 
					ds_instantID_recs(identity_verification_nas IN ACCEPTABLE_NAS_VALUES), 
					TRANSFORM(PublicHousing_Services.Layouts.batch_out,
						SELF := LEFT,
						SELF := []
					)
				);		
			
			// Filter the batch_in records so that only those having acceptable NAS values
			// continue being processed. But, near the bottom of this code we will return 
			// also those records that don't have ACCEPTABLE_NAS_VALUES.
			ds_batch_in_filt :=
				JOIN(
					ds_batch_in, ds_batch_out_seed,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(LEFT),
					INNER,
					KEEP(1)
				);
			
			// ---------------------------------------------------------------------------
			// 
			// 2. Get Best ADL records. Fulfills Requirement 4.1.8 
			// 
			// ---------------------------------------------------------------------------
			PublicHousing_Services.Layouts.rec_adl_best
					ds_ADL_best_recs := PublicHousing_Services.fn_getADLBestRecs(ds_batch_in_filt, in_mod);
			
			// ...and append to output. 
			ds_batch_out_with_ADL_best :=
				JOIN(
					ds_batch_out_seed, ds_ADL_best_recs,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(PublicHousing_Services.Layouts.batch_out, 
						SELF.acctno := LEFT.acctno, 
						SELF.LexID  := RIGHT.LexID, 
						SELF := RIGHT, 
						SELF := LEFT, 
						SELF := [] 
					),
					LEFT OUTER,
					KEEP(1)
				);
			
			// Append the LexID/did obtained here to the batch input. We'll use this
			// dataset having the LexID to fetch all subsequent records.
			ds_batch_in_having_DID :=
				JOIN(
					ds_batch_in_filt, ds_ADL_best_recs,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(PublicHousing_Services.Layouts.batch_in,
						SELF.acctno := LEFT.acctno,
						SELF.did    := (UNSIGNED6)RIGHT.LexID,
						SELF        := LEFT
					),
					INNER,
					KEEP(1)
				);		
				
			// ---------------------------------------------------------------------------
			// 
			// 3. Get Deceased records. Fulfills Requirement 4.1.10 
			// 
			// ---------------------------------------------------------------------------		
			PublicHousing_Services.Layouts.rec_deceased
					ds_deceased_recs := PublicHousing_Services.fn_getDeceasedRecs(ds_batch_in_having_DID, in_mod);
			
			// ...and append to output. Set flag.
			ds_batch_out_with_deceased := 
				JOIN(
					ds_batch_out_with_ADL_best, ds_deceased_recs,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(PublicHousing_Services.Layouts.batch_out, 
						SELF.acctno := LEFT.acctno, 
						SELF.deceased_flag := IF( LEFT.acctno = RIGHT.acctno, 'X', '' ),
						SELF := RIGHT, 
						SELF := LEFT, 
						SELF := [] 
					),
					LEFT OUTER,
					KEEP(1)
				);
				
			// ---------------------------------------------------------------------------
			// 
			// 4. Get Criminal records. Fulfills Requirements 4.1.9 and 4.1.11 
			// 
			// ---------------------------------------------------------------------------
			PublicHousing_Services.Layouts.rec_DOC_and_Criminal
					ds_doc_and_criminal_recs := PublicHousing_Services.fn_getDOCandCriminalRecs(ds_batch_in_having_DID, in_mod);
			
			// ...and then append to output. Set flag.
			ds_batch_out_with_criminal := 
				JOIN(
					ds_batch_out_with_deceased, ds_doc_and_criminal_recs,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(PublicHousing_Services.Layouts.batch_out, 
						SELF.acctno := LEFT.acctno, 
						SELF.incarceration_Flag := IF( RIGHT.curr_incar_flag = 'Y', 'I', '' ),
						SELF := RIGHT, 
						SELF := LEFT, 
						SELF := [] 
					),
					LEFT OUTER,
					KEEP(1)
				);
				
			// ---------------------------------------------------------------------------
			// 
			// 5. Get Sex Offender records. Fulfills Requirement 4.1.12 
			// 
			// ---------------------------------------------------------------------------
			PublicHousing_Services.Layouts.batch_in
				ds_sexoffender_recs := PublicHousing_Services.fn_getSexOffenderRecs(ds_batch_in_having_DID, in_mod);

			// ...and append to output. Set flag.
			ds_batch_out_with_sex_offender := 
				JOIN(
					ds_batch_out_with_criminal, ds_sexoffender_recs,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(PublicHousing_Services.Layouts.batch_out, 
						SELF.acctno := LEFT.acctno, 
						SELF.sex_offender := IF( LEFT.acctno = RIGHT.acctno, 'SO', '' ),
						SELF := LEFT, 
						SELF := [] 
					),
					LEFT OUTER,
					KEEP(1)
				);		

			// ---------------------------------------------------------------------------
			// 
			// 6. Get Best Address records.  Fulfills Requirement 4.1.13 
			// 
			// ---------------------------------------------------------------------------
			PublicHousing_Services.Layouts.rec_best_addr
					ds_bestaddress_recs := PublicHousing_Services.fn_getBestAddressRecs(ds_batch_in_having_DID, in_mod);

			// ...and append to output.
			ds_batch_out_with_best_address := 
				JOIN(
					ds_batch_out_with_sex_offender, ds_bestaddress_recs,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(PublicHousing_Services.Layouts.batch_out, 
						SELF.acctno := LEFT.acctno, 
						SELF := RIGHT, 
						SELF := LEFT, 
						SELF := [] 
					),
					LEFT OUTER,
					KEEP(1)
				);

			// ---------------------------------------------------------------------------
			// 
			// 7. Get Drivers License records. Fulfills Requirement 4.1.14 
			// 
			// ---------------------------------------------------------------------------	
			PublicHousing_Services.Layouts.rec_driver_lic
					ds_drivers_license_recs := PublicHousing_Services.fn_getDriversLicenseRecs(ds_batch_in_having_DID, in_mod);		

			// ...and append to output.
			ds_batch_out_with_drivers_license := 
				JOIN(
					ds_batch_out_with_best_address, ds_drivers_license_recs,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(PublicHousing_Services.Layouts.batch_out, 
						SELF.acctno := LEFT.acctno, 
						SELF := RIGHT, 
						SELF := LEFT, 
						SELF := [] 
					),
					LEFT OUTER,
					KEEP(1)
				);

			// ---------------------------------------------------------------------------
			// 
			// 8. Get Voter records. Fulfills Requirement 4.1.15 
			// 
			// ---------------------------------------------------------------------------	
			PublicHousing_Services.Layouts.rec_voter
					ds_voter_recs := PublicHousing_Services.fn_getVoterRecs(ds_batch_in_having_DID, in_mod);		

			// ...and append to output.
			ds_batch_out_with_voter_data := 
				JOIN(
					ds_batch_out_with_drivers_license, ds_voter_recs,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(PublicHousing_Services.Layouts.batch_out, 
						SELF.acctno := LEFT.acctno, 
						SELF := RIGHT, 
						SELF := LEFT, 
						SELF := [] 
					),
					LEFT OUTER,
					KEEP(1)
				);		

			// ---------------------------------------------------------------------------
			// 
			// 9. Get Property records. Fulfills Requirement 4.1.16 
			// 
			// ---------------------------------------------------------------------------	
			
			// TODO: update comment here; we're doing something a little different for Property.
			Layouts.batch_out
					ds_batch_out_with_property_data := PublicHousing_Services.fn_getPropertyRecs(ds_batch_in_having_DID, ds_batch_out_with_voter_data, in_mod);

			
			// ---------------------------------------------------------------------------
			// 
			// 10. Get RealTime Motor Vehicle records. Fulfills Requirement 4.1.17 
			// 
			// ---------------------------------------------------------------------------
			PublicHousing_Services.Layouts.rec_vehicle
				ds_vehicle_recs := PublicHousing_Services.fn_getVehicleRecs(ds_batch_in_having_DID, ds_bestaddress_recs, in_mod);

			// ...and append to output. Set flag.
			ds_batch_out_with_vehicle_data := 
				JOIN(
					ds_batch_out_with_property_data, ds_vehicle_recs,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(PublicHousing_Services.Layouts.batch_out, 
						SELF.acctno := LEFT.acctno, 
						SELF.mvr_flag := IF( LEFT.acctno = RIGHT.acctno, 'C', '' ),
						SELF := RIGHT, 
						SELF := LEFT, 
						SELF := [] 
					),
					LEFT OUTER,
					KEEP(1)
				);		
			
			// ---------------------------------------------------------------------------
			// 
			// 11. Get Watercraft records. Fulfills Requirement 4.1.18 
			// 
			// ---------------------------------------------------------------------------	
			PublicHousing_Services.Layouts.batch_in
				ds_watercraft_recs := PublicHousing_Services.fn_getWatercraftRecs(ds_batch_in_having_DID, in_mod);

			// ...and append to output. Set flag.
			ds_batch_out_with_watercraft_data := 
				JOIN(
					ds_batch_out_with_vehicle_data, ds_watercraft_recs,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(PublicHousing_Services.Layouts.batch_out, 
						SELF.acctno := LEFT.acctno, 
						SELF.watercraft_flag := IF( LEFT.acctno = RIGHT.acctno, 'W', '' ),
						SELF := LEFT, 
						SELF := [] 
					),
					LEFT OUTER,
					KEEP(1)
				);		
			
			// ---------------------------------------------------------------------------
			// 
			// 12. Get Aircraft records. Fulfills Requirement 4.1.19 
			// 
			// ---------------------------------------------------------------------------			
			PublicHousing_Services.Layouts.batch_in
				ds_aircraft_recs := PublicHousing_Services.fn_getAircraftRecs(ds_batch_in_having_DID, in_mod);

			// ...and append to output. Set flag.
			ds_batch_out_with_all_data := 
				JOIN(
					ds_batch_out_with_watercraft_data, ds_aircraft_recs,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(PublicHousing_Services.Layouts.batch_out, 
						SELF.acctno := LEFT.acctno, 
						SELF.aircraft_flag := IF( LEFT.acctno = RIGHT.acctno, 'P', '' ),
						SELF := LEFT, 
						SELF := [] 
					),
					LEFT OUTER,
					KEEP(1)
				);				

			// Return also those records that don't have ACCEPTABLE_NAS_VALUES.
			ds_having_unacceptable_NAS_values :=
				PROJECT( 
					ds_instantID_recs(identity_verification_nas NOT IN ACCEPTABLE_NAS_VALUES), 
					TRANSFORM(PublicHousing_Services.Layouts.batch_out,
						SELF.acctno := LEFT.acctno,
						SELF := []
					)
				);
				
			ds_batch_out := ds_batch_out_with_all_data + ds_having_unacceptable_NAS_values;
					
			RETURN ds_batch_out;
		END;
	
END;