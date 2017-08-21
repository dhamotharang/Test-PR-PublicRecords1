IMPORT ut,Data_Services;

compare_keys(boolean isFast
						,string v_to_check=''
						,string v_baseline=''
						,boolean evenIfMissing
						) := FUNCTION

				getCurrentPropertyVersion(boolean isFast,boolean getFather) := FUNCTION
								superFile := Data_Services.foreign_prod+'thor_data400::key::'+if(isFast,'property_fast','ln_propertyv2')+
								'::autokey::name_'+if(getFather,'father','qa');
								logicalFound := nothor(fileservices.SuperFileContents(superFile))[1].Name;
								raw_version := regexfind('2::\\d{8}',logicalFound,0);
								RETURN raw_version[4..];
				END;

				version_baseline := if(v_baseline=''
															,getCurrentPropertyVersion(isFast,true)
															,v_baseline)
															;
				version_to_check := if(v_to_check=''
															,getCurrentPropertyVersion(isFast,false)
															,v_to_check)
															;

				fFix := if(isFast,'ln_propertyV2','ln_propertyV2');
				fFix2 := if(isFast,'property_fast','ln_propertyV2');
				prefixForSet1 := Data_Services.foreign_prod+'thor_data400::key::'+fFix+'::';
				midfix1 := '';
				keyEndingNamesSet1 := dataset([	// 44 keys
								
								'addlfaresdeed.fid',					'addlfarestax.fid',				'addllegal.fid',							'addlnames.fid',	
								'addr.full_v4',								'addr.full_v4_no_fares',	'addr_search.fid',						'assessor.fid',
								'assessor.parcelnum',					'autokey::address',				'autokey::addressb2',					'autokey::citystname',
								'autokey::citystnameb2',			'autokey::fein2',					'autokey::name',							'autokey::nameb2',
								'autokey::namewords2',				'autokey::payload',				'autokey::phone2',						'autokey::phoneb2',
								'autokey::ssn2',							'autokey::stname',				'autokey::stnameb2',					'autokey::zip',
								'autokey::zipb2',							'deed.fid',								'deed.parcelnum',							'deed.zip_loanamt',
								'deed::zip_avg_sales_price',	'did.ownership_v4',				'did.ownership_v4_no_fares',	'ownership.did',				
								'ownership_addr',							'ownership_bdid',					'ownership_did',							'ownership_fipsapn',			
								'ownership_rawaid',						'search.bdid',						'search.did',									'search.fid',
								'search.fid_county',					'search.fid_linkids',			'search.linkids',							'tax_summary'
																	
																				], {string fileName});

				prefixForSet2 := Data_Services.foreign_prod+'thor_data400::key::'+fFix+'::fcra::';
				midfix2 := '';
				keyEndingNamesSet2 := dataset ([ // 13

								'addllegal.fid',	'addlnames.fid',		'addr.full_v4',		'addr_search.fid',	'assessor.fid',
								'deed.fid',				'did.ownership_v4',	'ownership.did',	'ownership_addr',		'ownership_did',
								'search.did',			'search.fid',				'search.fid_county'
								
																					], {string fileName});

				prefixForSet3_1 := Data_Services.foreign_prod+'thor_data400::key::'+fFix2+'::assessment::';
				prefixForSet3_2 := Data_Services.foreign_prod+'thor_data400::key::'+fFix2+'::deeds::';
				midfix3 := '';
				keyEndingNamesSet3 := dataset ([ // 16 (8 x 2)

								'dictindx3',	'doc.fares_id',		'dtldictx',		'exkeyi',	
								'exkeyo',			'nidx3',					'xdstat2',		'xseglist'
								
																					], {string fileName});
																					
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

				twoFilesLayout makePair(recordof(keyEndingNamesSet1) L,string prefix, string midfix) := TRANSFORM

					SELF.baseFileName 	:= prefix + version_baseline + midfix +'::'+ L.fileName;
					SELF.chekFileName 	:= prefix + version_to_check + midfix +'::'+ L.fileName;
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
																	project(keyEndingNamesSet1,makePair(LEFT,prefixForSet1  , midfix1))(evenIfMissing OR chekfilesize>0)+
																	project(keyEndingNamesSet2,makePair(LEFT,prefixForSet2  , midfix2))(evenIfMissing OR chekfilesize>0)+				
																	project(keyEndingNamesSet3,makePair(LEFT,prefixForSet3_1, midfix3))(evenIfMissing OR chekfilesize>0)+
																	project(keyEndingNamesSet3,makePair(LEFT,prefixForSet3_2, midfix3))(evenIfMissing OR chekfilesize>0) )
																,100,1),named(if(isFast,'Delta_keys','Full_keys')));
END;

EXPORT verify_compare_latest_keys(boolean isFast,string v_to_check='',string v_baseline='',boolean evenIfMissing = true) := 
					compare_keys(isFast,v_to_check, v_baseline,evenIfMissing);