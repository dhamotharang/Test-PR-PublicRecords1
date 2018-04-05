// PRTE2_PropertyInfo.Get_Payload
// JOIN the existing Property Info key files into one expanded payload file. 
// Create a new payload with new Customer Test data
// (change 'propertybluebook' to 'propertyinfo').

IMPORT PRTE_CSV,PRTE, ut,NID,Doxie,address,_control,PRTE,iesp,ut,Doxie,address,STD,NID,AutoKeyB2,autokey,AutoKeyI;

EXPORT Get_payload := MODULE

	EXPORT PropertyExpandedRec := Layouts.PropertyExpandedRec;

	// NOTE: We discovered that the "Boca" base that was lost on edata12, was actually Linda's dataloaded by her
	// SO IT WAS NOT Boca data - we emptied the Boca Base file - someday when they want data for PropInfo they can add some
	EXPORT EXISTING_PROPERTYINFOV2 := FUNCTION	
		 RETURN Files.BOCA_BASE_SF_DS_PROD;
	END;	

//* Create new payload from Customer Test data	
	EXPORT NEW_PROPERTYINFOV2 := FUNCTION
			string8 today_date := ut.GetDate; 
			AlphaTempExpandedName := Files.NewAlphaExpandedName;

			// LCAIN300 - This is the ancient original alpharetta data file.
			// AlphaDS := Files.Linda_Scrambled_DS;
			AlphaDS := Files.PII_ALPHA_BASE_SF_DS;

			// next step simply renews clean address info
			Reformat_DS 			:= PROJECT(AlphaDS, Transform_Alpha_Data.Prepare_Alpharetta_Data (Left, Counter));
			Sort_Reformat_DS  := SORT(Reformat_DS, RECORD,EXCEPT property_rid);
			Dedup_Reformat_DS := DEDUP(Sort_Reformat_DS,RECORD,EXCEPT property_rid);

			// *****************************************************************************************
			// fn_remove_zeroes(string	pField)	:=	regexreplace('^([0]*[.]?[0]*)$',stringlib.stringcleanspaces(pField),'');
			// Generate duplicate vendor source A and C records. Copy D to A.
			// Alter all the sources to be "best of breed" like production ???  
			// Would we join both A and D to fill empty slots?
			// Looking at production, in creating an A record:
			//      * if there is a OKCTY value in B, they put that in A
			//      * if not and there is a FARES value from D, they put that in A.
			createVendorSourceDs_D2A := PROJECT(Dedup_Reformat_DS (vendor_source='D'), 
																	TRANSFORM(RECORDOF(Dedup_Reformat_DS),
																			SELF.vendor_source := 'A';
																			SELF := LEFT));
			// Refer to PropertyCharacteristics.Map_LNProperty_Common attribute .. lines 565
			// Clean fields which contain all zeroes
			// PropertyCharacteristics.Functions.Mac_Remove_Zeroes(dTaxDeedCombined,dTaxDeedCleaned);
			// Take a look at PropertyCharacteristics.Mac_Property_Rollup 
			// *****************************************************************************************


			// *****************************************************************************************
			// Generate duplicate vendor source A and C records. Copy B to C.
			// Localized Averages: as we create C records, replace any of the new DEFLT sources in "B" records with OKCTY
			noDEFLTs2(STRING S1,STRING S2) 	:= IF(S1='DEFLT','',S2);								// If source has DEFAULT then zap the value
			noDEFLTs(STRING S1) 						:= IF(S1='DEFLT','',S1);								// If source has DEFAULT then zap the source
			createVendorSourceDs_B2C := PROJECT(Dedup_Reformat_DS (vendor_source='B'), 
																	TRANSFORM(RECORDOF(Dedup_Reformat_DS),
																			SELF.vendor_source := 'C';
																			SELF.building_square_footage 		:= noDEFLTs2(left.src_building_square_footage,left.building_square_footage);
																			SELF.air_conditioning_type 			:= noDEFLTs2(left.src_air_conditioning_type,left.air_conditioning_type);
																			SELF.construction_type 					:= noDEFLTs2(left.src_construction_type,left.construction_type);
																			SELF.exterior_wall 							:= noDEFLTs2(left.src_exterior_wall,left.exterior_wall);
																			SELF.floor_type 								:= noDEFLTs2(left.src_floor_type,left.floor_type);
																			SELF.foundation 								:= noDEFLTs2(left.src_foundation,left.foundation);
																			SELF.garage 										:= noDEFLTs2(left.src_garage,left.garage);
																			SELF.heating 										:= noDEFLTs2(left.src_heating,left.heating);
																			SELF.garage_square_footage 			:= noDEFLTs2(left.src_garage_square_footage,left.garage_square_footage);
																			SELF.no_of_baths 								:= noDEFLTs2(left.src_no_of_baths,left.no_of_baths);
																			SELF.no_of_bedrooms 						:= noDEFLTs2(left.src_no_of_bedrooms,left.no_of_bedrooms);
																			SELF.no_of_fireplaces 					:= noDEFLTs2(left.src_no_of_fireplaces,left.no_of_fireplaces);
																			SELF.no_of_stories 							:= noDEFLTs2(left.src_no_of_stories,left.no_of_stories);
																			SELF.roof_cover 								:= noDEFLTs2(left.src_roof_cover,left.roof_cover);
																			SELF.total_assessed_value 			:= noDEFLTs2(left.src_total_assessed_value,left.total_assessed_value);
																			SELF.year_built 								:= noDEFLTs2(left.src_year_built,left.year_built);		
																			SELF.no_of_rooms 								:= noDEFLTs2(left.src_no_of_rooms,left.no_of_rooms);		
																																			
																			SELF.src_building_square_footage := noDEFLTs(left.src_building_square_footage);
																			SELF.src_air_conditioning_type 	 := noDEFLTs(left.src_air_conditioning_type);
																			SELF.src_construction_type 			 := noDEFLTs(left.src_construction_type);
																			SELF.src_exterior_wall 					 := noDEFLTs(left.src_exterior_wall);
																			SELF.src_floor_type 						 := noDEFLTs(left.src_floor_type);
																			SELF.src_foundation 						 := noDEFLTs(left.src_foundation);
																			SELF.src_garage 								 := noDEFLTs(left.src_garage);
																			SELF.src_garage_square_footage	 := noDEFLTs(left.src_garage_square_footage);
																			SELF.src_heating 								 := noDEFLTs(left.src_heating);
																			SELF.src_no_of_baths 						 := noDEFLTs(left.src_no_of_baths);
																			SELF.src_no_of_bedrooms 				 := noDEFLTs(left.src_no_of_bedrooms);
																			SELF.src_no_of_fireplaces 			 := noDEFLTs(left.src_no_of_fireplaces);
																			SELF.src_no_of_stories 					 := noDEFLTs(left.src_no_of_stories);
																			SELF.src_roof_cover 						 := noDEFLTs(left.src_roof_cover);
																			SELF.src_total_assessed_value 	 := noDEFLTs(left.src_total_assessed_value);
																			SELF.src_year_built 						 := noDEFLTs(left.src_year_built);
																			SELF.src_no_of_rooms 						 := noDEFLTs(left.src_no_of_rooms);
																			
																			SELF.tax_dt_building_square_footage  := noDEFLTs2(left.src_building_square_footage,left.tax_dt_building_square_footage);
																			SELF.tax_dt_air_conditioning_type := noDEFLTs2(left.src_air_conditioning_type, left.tax_dt_air_conditioning_type);
																			SELF.tax_dt_construction_type 		:= noDEFLTs2(left.src_construction_type, left.tax_dt_construction_type);
																			SELF.tax_dt_exterior_wall 				:= noDEFLTs2(left.src_exterior_wall, left.tax_dt_exterior_wall);
																			SELF.tax_dt_floor_type 						:= noDEFLTs2(left.src_floor_type, left.tax_dt_floor_type);
																			SELF.tax_dt_foundation 						:= noDEFLTs2(left.src_foundation, left.tax_dt_foundation);
																			SELF.tax_dt_garage 								:= noDEFLTs2(left.src_garage, left.tax_dt_garage);
																			SELF.tax_dt_garage_square_footage	:= noDEFLTs2(left.src_garage_square_footage, left.tax_dt_garage_square_footage);
																			SELF.tax_dt_heating 							:= noDEFLTs2(left.src_heating, left.tax_dt_heating);
																			SELF.tax_dt_no_of_baths 					:= noDEFLTs2(left.src_no_of_baths, left.tax_dt_no_of_baths);
																			SELF.tax_dt_no_of_bedrooms 				:= noDEFLTs2(left.src_no_of_bedrooms, left.tax_dt_no_of_bedrooms);
																			SELF.tax_dt_no_of_fireplaces 			:= noDEFLTs2(left.src_no_of_fireplaces, left.tax_dt_no_of_fireplaces);
																			SELF.tax_dt_no_of_stories 				:= noDEFLTs2(left.src_no_of_stories, left.tax_dt_no_of_stories);
																			SELF.tax_dt_roof_cover 						:= noDEFLTs2(left.src_roof_cover, left.tax_dt_roof_cover);
																			SELF.tax_dt_total_assessed_value	:= noDEFLTs2(left.src_total_assessed_value, left.tax_dt_total_assessed_value);
																			SELF.tax_dt_year_built 						:= noDEFLTs2(left.src_year_built, left.tax_dt_year_built);
																			SELF.tax_dt_no_of_rooms 					:= noDEFLTs2(left.src_no_of_rooms, left.tax_dt_no_of_rooms);																					
			
																			SELF := LEFT));
			// *****************************************************************************************

			// *****************************************************************************************
			// Generate duplicate vendor source A and C records. Append all the D and B and the new A and C
			allVendorSourceDs := Dedup_Reformat_DS + createVendorSourceDs_D2A+createVendorSourceDs_B2C;

			// ----- Renumber RIDs after the DEDUP just in case  -------------------------- 
			// TODO - if Boca ever adds data, talk to them about keeping RIDs unique so we don't clash
			PropertyExpandedRec  Resequence_AlphaDS (allVendorSourceDs L, Integer C) := TRANSFORM
					self.property_rid   := (unsigned) Constants.ALPHA_RID_CONSTANT + C;
					SELF := L;
					SELF := [];
			END;		
			Resequence_DS 	:= PROJECT(allVendorSourceDs, Resequence_AlphaDS (Left, Counter));
			// ---------------------------------------------------------------------------- 
			NEWPropertyInfo := Resequence_DS :PERSIST(AlphaTempExpandedName);			
			RETURN NEWPropertyInfo;
	END;
	
	EXPORT All_Expanded := EXISTING_PROPERTYINFOV2 + NEW_PROPERTYINFOV2;
	
END;
