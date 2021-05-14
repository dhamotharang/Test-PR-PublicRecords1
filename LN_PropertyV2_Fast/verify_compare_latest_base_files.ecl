IMPORT Data_Services;

compare_bases(boolean isFast,string process_date,string baseLine = '') := FUNCTION

			  getCurrentPropertyVersion(boolean isFast,boolean getFather) := FUNCTION
								superFile := Data_Services.foreign_prod+'thor_data400::key::'+if(isFast,'property_fast','ln_propertyv2')+
								'::autokey::name_'+if(getFather,'father','qa');
								logicalFound := nothor(fileservices.SuperFileContents(superFile))[1].Name;
								raw_version := regexfind('2::\\d{8}',logicalFound,0);
								RETURN raw_version[4..];
				END;

				baseline_version := if(baseLine='',getCurrentPropertyVersion(isFast,false),baseLine);
				to_check_version := process_date;


				fFix := if(isFast,'property_fast','ln_propertyV2');
				prefixForSet1 := Data_Services.foreign_prod+'thor_data400::base::'+fFix+'::';
				midfix1 := '';
				
				keyEndingNamesSet1 :=  if( isFast
				
																,dataset([	'assessment_',				'deed_mortgage_', 						'search_',						'addl::ln_names_',
																					'addl::legal_',		'addl_frs_assessment_',	'addl_frs_deed_mortgage_', 'addl::name_info_'	], {string fileName})
																
				
																,dataset([	'assesor_',				'deed_', 						'search_',						'addl::ln_names_',
																				'addl::legal_',		'addl::fares_tax_',	'addl::fares_deed_', 'addl::name_info_'							], {string fileName})
																	
																	);
																					
				twoFilesLayout := record

					string baseFileName;
					string chekFileName;
					boolean baseFileExists;
					boolean chekFileExists;
					integer8 baseRecordCount;
					integer8 baseFileSize;
					integer8 chekRecordCount;
					integer8 chekFileSize;
					integer8 sizeChange;
					decimal6_2 sizeChangePrcnt;
					integer8 cntsChange;
					decimal6_2 cntsChangePrcnt;

				end;

				twoFilesLayout makePair(recordof(keyEndingNamesSet1) L,string prefix) := TRANSFORM

					SELF.baseFileName 	:= prefix + L.fileName + baseline_version ;
					SELF.chekFileName 	:= prefix + L.fileName + to_check_version ;
					SELF.baseFileExists := fileservices.FileExists(SELF.baseFileName);
					SELF.chekFileExists	:= fileservices.FileExists(SELF.chekFileName);
					SELF.baseRecordCount := (integer8)if(SELF.baseFileExists, fileservices.GetLogicalFileAttribute(SELF.baseFileName,'recordCount'), '0');
					SELF.baseFileSize		 := (integer8)if(SELF.baseFileExists, fileservices.GetLogicalFileAttribute(SELF.baseFileName,'size'),'0');
					SELF.chekRecordCount := (integer8)if(SELF.chekFileExists, fileservices.GetLogicalFileAttribute(SELF.chekFileName,'recordCount'),'0');
					SELF.chekFileSize		 := (integer8)if(SELF.chekFileExists, fileservices.GetLogicalFileAttribute(SELF.chekFileName,'size'),'0');
					SELF.sizeChange			 := SELF.chekFileSize - SELF.baseFileSize;
					SELF.sizeChangePrcnt := ((SELF.chekFileSize / SELF.baseFileSize) - 1)*100;
					SELF.cntsChange			 := SELF.chekRecordCount - SELF.baseRecordCount;
					SELF.cntsChangePrcnt := ((SELF.chekRecordCount / SELF.baseRecordCount) - 1)*100;
						
				END;

				RETURN 	output( choosen(  nothor(
																	project(keyEndingNamesSet1,makePair(LEFT,prefixForSet1))      )
																,100,1),named(if(isFast,'Delta_Base','Full_Base')));
END;

EXPORT verify_compare_latest_base_files(boolean isFast, string process_date, string baseLine = '') := compare_bases(isFast,process_date,baseLine);