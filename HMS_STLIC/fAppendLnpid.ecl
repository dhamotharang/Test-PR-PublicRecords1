IMPORT Ut, HMS_STLIC,HealthCare_Provider_Header;

EXPORT fAppendLnpid(DATASET(hms_stlic.layouts.statelicense_base) pDataset) := FUNCTION

												Layout_In := RECORD
																				{pDataset};
																				UNSIGNED8 UniqId;
																				UNSIGNED8 LNPID_Out := 0;
																				INTEGER2 xlink_distance;
																				STRING xlink_matches;
																				UNSIGNED xlink_keys;
																				INTEGER xlink_weight;
																				INTEGER xlink_score;
																				STRING xlink_segmentation;
																				INTEGER score;
												END;

												inFields := MODULE(HealthCare_Provider_Header.IxLinkInput)
																				EXPORT Input_UniqueID              := 'UniqId';
																				EXPORT Input_FNAME                 := 'fname';
																				EXPORT Input_MNAME                 := 'mname';
																				EXPORT Input_LNAME                 := 'lname';
																				EXPORT Input_SNAME                 := 'name_suffix';
																				EXPORT Input_GENDER                := 'gender';
																				EXPORT Input_TAXONOMY              := 'taxonomy_code';
																				EXPORT Input_LIC_TYPE              := 'license_class_type';
																				EXPORT Input_PRAC_PRIM_RANGE       := 'prim_range';
																				EXPORT Input_PRAC_PRIM_NAME        := 'prim_name';
																				EXPORT Input_PRAC_SEC_RANGE        := 'sec_range';
																				EXPORT Input_PRAC_CITY             := 'p_city_name';
																				EXPORT Input_PRAC_ST               := 'st';
																				EXPORT Input_PRAC_ZIP              := 'zip';
																				EXPORT Input_PRAC_PHONE            := 'clean_phone';
																				EXPORT Input_NPI_NUMBER            := 'npi_number';
																				EXPORT Input_UPIN                  := '';
																				EXPORT Input_DEA_NUMBER            := 'dea_number';
																				EXPORT Input_LIC_STATE             := 'license_state';
																				EXPORT Input_LIC_NBR               := 'license_number';
																				EXPORT Input_SSN                   := 'best_ssn';
																				EXPORT Input_DOB                   := 'best_dob';
												END;
												
												pDatasetPrep    := project(pDataset, transform(layout_in, self := left, self := []));
												
												ut.MAC_Sequence_Records(pDatasetPrep,UniqID,pDataset_seq);
												
												pDataset_in := sort(distribute(pDataset_seq,hash(UniqID)),UniqID,local);
												
												// uncomment for desired mode
												HealthCare_Provider_Header.mac_xlinking_on_thor(pDataset_in, inFields, results,
																0, //Change from original dev version
																				HealthCare_Provider_Header.Constants.XLinkMode.BestAppend,
																// HealthCare_Provider_Header.Constants.XLinkMode.MatchesInclDetail,
																// 'dummy_mode',
																LNPID,
																34, 6);                    
																												
			RETURN PROJECT(results, hms_stlic.layouts.statelicense_base);
END;