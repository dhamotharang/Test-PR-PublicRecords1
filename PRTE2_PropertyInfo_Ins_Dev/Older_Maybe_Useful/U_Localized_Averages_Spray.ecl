// PRTE2_PropertyInfo.U_Localized_Averages_Spray
IMPORT PRTE2_PropertyInfo, ut, RoxieKeyBuild,PropertyCharacteristics;
IMPORT PRTE2_Common as Common;

EXPORT U_Localized_Averages_Spray(STRING CSVName1, STRING CSVName2, STRING fileVersion) := FUNCTION
			// --------------------------------------------------
			sprayFile1    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								CSVName1, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								Files.SCRAMBLE_SPRAY1,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								TRUE												  			// do compress
																								);																					 
			// --------------------------------------------------		
			sprayFile2    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								CSVName2, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								Files.SCRAMBLE_SPRAY2,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								TRUE												  			// do compress
																								);																					 
			// --------------------------------------------------
			sprayIncoming1 := Files.SCRAMBLE_SPRAY_DS1;
			sprayIncoming2 := Files.SCRAMBLE_SPRAY_DS2;
			
			speadsheetIncoming0 := SORT(sprayIncoming1+sprayIncoming2,property_rid);
			speadsheetIncoming := speadsheetIncoming0(property_rid > 0);
			// --------------------------------------------------
			delSprayedFile1  := FileServices.DeleteLogicalFile (Files.SCRAMBLE_SPRAY1);
			delSprayedFile2  := FileServices.DeleteLogicalFile (Files.SCRAMBLE_SPRAY2);


			//-----------------------------------------------------------------------------------------------------
			cleanValue(STRING someValue) := PropertyCharacteristics.Functions.fn_remove_zeroes(someValue);
			isEMPTY(STRING s1) := cleanValue(s1)='';
			notEmpty(STRING s1) := (NOT isEMPTY(s1));
			ReplaceIF(STRING s1, STRING s2) := IF(isEMPTY(s1), s2, cleanValue(s1));							// check s1, either keep it or return s2
			ReplaceIF3(STRING s1, STRING s2, STRING s3) := IF(isEMPTY(s1), s3, s2);							// check s1, then return either s2 or s3
			ReplaceIF4(STRING s1, STRING s2, STRING s3, STRING s4) := FUNCTION
						tmpSrc := IF(s4='B' OR s4='C', 'OKCTY', 'FARES');
						fullSrc := IF( notEmpty(s1) AND isEmpty(s2),tmpSrc, s2);
						RETURN IF(isEMPTY(s1), s3, fullSrc);
			END;
			emptySOURCE := '';
			emtpyTaxDate := '';

			//----------- TRANSFORM2 -------------------------------------------------
			speadsheetIncoming transfrmIN1( speadsheetIncoming L ) := TRANSFORM		
						// First remove any field values that are zero values and make them '' value instead.
						SELF.building_square_footage 			:= ReplaceIF(L.building_square_footage,'');
						SELF.air_conditioning_type 				:= ReplaceIF(L.air_conditioning_type, '');
						SELF.construction_type 						:= ReplaceIF(L.construction_type, '');
						SELF.exterior_wall 								:= ReplaceIF(L.exterior_wall, '');
						SELF.floor_type 									:= ReplaceIF(L.floor_type, '');
						SELF.foundation 									:= ReplaceIF(L.foundation, '');
						SELF.garage 											:= ReplaceIF(L.garage, '');
						SELF.heating 											:= ReplaceIF(L.heating, '');
						SELF.garage_square_footage 				:= ReplaceIF(L.garage_square_footage, '');
						SELF.no_of_baths 									:= ReplaceIF(L.no_of_baths, '');
						SELF.no_of_bedrooms 							:= ReplaceIF(L.no_of_bedrooms, '');
						SELF.no_of_fireplaces 						:= ReplaceIF(L.no_of_fireplaces, '');
						SELF.no_of_stories 								:= ReplaceIF(L.no_of_stories, '');
						SELF.roof_cover 									:= ReplaceIF(L.roof_cover, '');
						SELF.total_assessed_value 				:= ReplaceIF(L.total_assessed_value, '');
						SELF.year_built 									:= ReplaceIF(L.year_built, '');		
						SELF.no_of_rooms 									:= ReplaceIF(L.no_of_rooms, '');		
						// Any fields that had zero values should have blank sources
						SELF.src_building_square_footage 	:= ReplaceIF4(L.building_square_footage, L.src_building_square_footage, emptySOURCE, L.vendor_source);
						SELF.src_air_conditioning_type 		:= ReplaceIF4(L.air_conditioning_type, L.src_air_conditioning_type, emptySOURCE, L.vendor_source);
						SELF.src_construction_type 				:= ReplaceIF4(L.construction_type, L.src_construction_type, emptySOURCE, L.vendor_source);
						SELF.src_exterior_wall 						:= ReplaceIF4(L.exterior_wall, L.src_exterior_wall, emptySOURCE, L.vendor_source);
						SELF.src_floor_type 							:= ReplaceIF4(L.floor_type, L.src_floor_type, emptySOURCE, L.vendor_source);
						SELF.src_foundation 							:= ReplaceIF4(L.foundation, L.src_foundation, emptySOURCE, L.vendor_source);
						SELF.src_garage 									:= ReplaceIF4(L.garage, L.src_garage, emptySOURCE, L.vendor_source);
						SELF.src_garage_square_footage 		:= ReplaceIF4(L.garage_square_footage, L.src_garage_square_footage, emptySOURCE, L.vendor_source);
						SELF.src_heating 									:= ReplaceIF4(L.heating, L.src_heating, emptySOURCE, L.vendor_source);
						SELF.src_no_of_baths 							:= ReplaceIF4(L.no_of_baths, L.src_no_of_baths, emptySOURCE, L.vendor_source);
						SELF.src_no_of_bedrooms 					:= ReplaceIF4(L.no_of_bedrooms, L.src_no_of_bedrooms, emptySOURCE, L.vendor_source);
						SELF.src_no_of_fireplaces 				:= ReplaceIF4(L.no_of_fireplaces, L.src_no_of_fireplaces, emptySOURCE, L.vendor_source);
						SELF.src_no_of_stories 						:= ReplaceIF4(L.no_of_stories, L.src_no_of_stories, emptySOURCE, L.vendor_source);
						SELF.src_roof_cover 							:= ReplaceIF4(L.roof_cover, L.src_roof_cover, emptySOURCE, L.vendor_source);
						SELF.src_total_assessed_value 		:= ReplaceIF4(L.total_assessed_value, L.src_total_assessed_value, emptySOURCE, L.vendor_source);
						SELF.src_year_built 							:= ReplaceIF4(L.year_built, L.src_year_built, emptySOURCE, L.vendor_source);
						SELF.src_no_of_rooms 							:= ReplaceIF4(L.no_of_rooms, L.src_no_of_rooms, emptySOURCE, L.vendor_source);
						// Any fields that had zero values should have blank tax dates
						SELF.tax_dt_building_square_footage := ReplaceIF3(L.building_square_footage, L.tax_dt_building_square_footage, emtpyTaxDate);
						SELF.tax_dt_air_conditioning_type := ReplaceIF3(L.air_conditioning_type, L.tax_dt_air_conditioning_type, emtpyTaxDate);
						SELF.tax_dt_construction_type 		:= ReplaceIF3(L.construction_type, L.tax_dt_construction_type, emtpyTaxDate);
						SELF.tax_dt_exterior_wall 				:= ReplaceIF3(L.exterior_wall, L.tax_dt_exterior_wall, emtpyTaxDate);
						SELF.tax_dt_floor_type 						:= ReplaceIF3(L.floor_type, L.tax_dt_floor_type, emtpyTaxDate);
						SELF.tax_dt_foundation 						:= ReplaceIF3(L.foundation, L.tax_dt_foundation, emtpyTaxDate);
						SELF.tax_dt_garage 								:= ReplaceIF3(L.garage, L.tax_dt_garage, emtpyTaxDate);
						SELF.tax_dt_garage_square_footage	:= ReplaceIF3(L.garage_square_footage, L.tax_dt_garage_square_footage, emtpyTaxDate);
						SELF.tax_dt_heating 							:= ReplaceIF3(L.heating, L.tax_dt_heating, emtpyTaxDate);
						SELF.tax_dt_no_of_baths 					:= ReplaceIF3(L.no_of_baths, L.tax_dt_no_of_baths, emtpyTaxDate);
						SELF.tax_dt_no_of_bedrooms 				:= ReplaceIF3(L.no_of_bedrooms, L.tax_dt_no_of_bedrooms, emtpyTaxDate);
						SELF.tax_dt_no_of_fireplaces 			:= ReplaceIF3(L.no_of_fireplaces, L.tax_dt_no_of_fireplaces, emtpyTaxDate);
						SELF.tax_dt_no_of_stories 				:= ReplaceIF3(L.no_of_stories, L.tax_dt_no_of_stories, emtpyTaxDate);
						SELF.tax_dt_roof_cover 						:= ReplaceIF3(L.roof_cover, L.tax_dt_roof_cover, emtpyTaxDate);
						SELF.tax_dt_total_assessed_value	:= ReplaceIF3(L.total_assessed_value, L.tax_dt_total_assessed_value, emtpyTaxDate);
						SELF.tax_dt_year_built 						:= ReplaceIF3(L.year_built, L.tax_dt_year_built, emtpyTaxDate);
						SELF.tax_dt_no_of_rooms 					:= ReplaceIF3(L.no_of_rooms, L.tax_dt_no_of_rooms, emtpyTaxDate);		

						SELF := L;
			END;
			//-----------------------------------------------------------------------------------------------------
			speadsheetCleaned := PROJECT(speadsheetIncoming, transfrmIN1(LEFT));
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(speadsheetCleaned,
																					 Files.BASE_PREFIX_NAME, 
																					 Files.SCRAMBLE_NAME,
																					 fileVersion, buildPIIBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------

			// --------------------------------------------------
			PII_Scrambled := Files.PII_ALPHA_BASE_SF_DS;
			ShowResults := CHOOSEN(PII_Scrambled, 200);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile1,
															sprayFile2,
															buildPIIBase,
															delSprayedFile1,
															delSprayedFile1,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;