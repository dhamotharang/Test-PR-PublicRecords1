import BIPV2, tools, BIPV2_Build;
export HighRiskIndustries := module


		 shared highRiskCodeLists  := Files().HighRiskCodes.qa;
		 shared highRiskSicCodes   := set(highRiskCodeLists(code_type='SIC'), code); 
     shared highRiskNAICSCodes := set(highRiskCodeLists(code_type='NAICS'), code);

		 export removeCodes(dataset(BIPV2_Build.Layouts.HighRiskCodesListLayout) codesToRemove, string pversion = thorlib.wuid()[2..9]) := function
        
				existingCodes := highRiskCodeLists;
				removedCodes  := join(existingCodes, codesToRemove,
				                      left.code      = right.code and
															left.code_type = right.code_type,
															transform(left), left only, hash);
				dedupCodes    := dedup(removedCodes, all, hash);
				
				tools.mac_WriteFile(BIPV2_Build.Filenames(pversion).HighRiskCodes.new	,dedupCodes,Build_Code_File	,pShouldExport := false);

				go := sequential(
             Build_Code_File
		        ,tools.mod_PromoteBuild(pversion,BIPV2_Build.Filenames(pversion).HighRiskCodes.dall_filenames,'',false,false,,,,false,false,'').new2built
		        ,tools.mod_PromoteBuild(pversion,BIPV2_Build.Filenames(pversion).HighRiskCodes.dall_filenames,'',false,false,,,,false,false,'').built2QA
				);
				
				return go;
		 end;
		 
		 export addCodes(dataset(BIPV2_Build.Layouts.HighRiskCodesListLayout) newCodes, string pversion = thorlib.wuid()[2..9]) := function
        
				existingCodes := highRiskCodeLists;
				combinedCodes := highRiskCodeLists + newCodes;
				dedupCodes    := dedup(combinedCodes, all, hash);
				
				tools.mac_WriteFile(BIPV2_Build.Filenames(pversion).HighRiskCodes.new	,dedupCodes,Build_Code_File	,pShouldExport := false);

				go := sequential(
             Build_Code_File
		        ,tools.mod_PromoteBuild(pversion,BIPV2_Build.Filenames(pversion).HighRiskCodes.dall_filenames,'',false,false,,,,false,false,'').new2built
		        ,tools.mod_PromoteBuild(pversion,BIPV2_Build.Filenames(pversion).HighRiskCodes.dall_filenames,'',false,false,,,,false,false,'').built2QA
				);
				
				return go;
		 end;
		 
		 export HighRiskCodesPhoneMapLayout := record
		      BIPV2.CommonBase.Layout.company_phone;
					BIPV2.CommonBase.Layout.seleid;
		 end;
		 
		 export HighRiskCodesAddressMapLayout := record
		      unsigned6 locid;
		      BIPV2.CommonBase.Layout.seleid;
		 end;
		 
		 export HighRiskCodesLayout := record
		      BIPV2.CommonBase.Layout.seleid;
		      string6 code;
					string5 code_type;
					BIPV2.CommonBase.Layout.dt_first_seen;
					BIPV2.CommonBase.Layout.dt_last_seen;
		 end;
	
     shared phone_superfile_name := keynames(, false).highRiskIndustriesPhone.QA;
     shared addr_superfile_name  := keynames(, false).highRiskIndustriesAddr.QA;
     shared superfile_name       := keynames(, false).highRiskIndustriesCodes.QA;
		 
		 shared emptyDsPhone   := dataset([],HighRiskCodesPhoneMapLayout);
		 shared emptyDsAddr    := dataset([],HighRiskCodesAddressMapLayout);
		 shared emptyDsCodes   := dataset([],HighRiskCodesLayout);
		 
     export phoneIndexDef(
		               string indexName                          = phone_superfile_name, 
	                 dataset(HighRiskCodesPhoneMapLayout) inDs = emptyDsPhone
								  ) := index(inDs, {company_phone}, {inDs}, indexName);
									
     export addrIndexDef(
		               string indexName                            = addr_superfile_name, 
	                 dataset(HighRiskCodesAddressMapLayout) inDs = emptyDsAddr
								  ) := index(inDs, {locid}, {inDs}, indexName);
									
     export codeIndexDef(
		               string indexName                  = superfile_name, 
	                 dataset(HighRiskCodesLayout) inDs = emptyDsCodes
								  ) := index(inDs, {seleid}, {inDs}, indexName);

     shared buildPhoneFileNames := keynames(, false).highRiskIndustriesPhone.dall_filenames;
     shared buildAddrFileNames  := keynames(, false).highRiskIndustriesAddr.dall_filenames;
     shared buildCodesFileNames := keynames(, false).highRiskIndustriesCodes.dall_filenames;
		 																	 
		 export buildKeys(string  pVersion    = BIPV2.KeySuffix
			               ,boolean promoteToQA = false) := function

          phone_outfile_name := keynames(pVersion, false).highRiskIndustriesPhone.new;
          addr_outfile_name  := keynames(pVersion, false).highRiskIndustriesAddr.new;
          output_file_name   := keynames(pVersion, false).highRiskIndustriesCodes.new;
		 
		      bipPayloadKey   := pull(BIPV2.Key_BH_Linking_Ids.keyversions('built',false).Built); 

          
          // Get High Risk industries
		      highRiskRecs := bipPayloadKey(company_sic_code1   in highRiskSicCodes
		                                 or company_sic_code2   in highRiskSicCodes
		                                 or company_sic_code3   in highRiskSicCodes
		                                 or company_sic_code4   in highRiskSicCodes
		                                 or company_sic_code5   in highRiskSicCodes
		                                 or company_naics_code1 in highRiskNAICSCodes
		                                 or company_naics_code2 in highRiskNAICSCodes
		                                 or company_naics_code3 in highRiskNAICSCodes
		                                 or company_naics_code4 in highRiskNAICSCodes
		                                 or company_naics_code5 in highRiskNAICSCodes	
	                                     );
					
					
					getSeleIDInHighRisk  := join(bipPayloadKey, dedup(highRiskRecs, seleid, all, hash),
					                             left.seleid = right.seleid, 
																			 transform(left), hash);
					
					highRiskPhoneNumbers := project(dedup(getSeleIDInHighRisk(company_phone!=''), seleid, company_phone, all, hash),  HighRiskCodesPhoneMapLayout);
					highRiskAddrs        := project(dedup(getSeleIDInHighRisk(locid>0), seleid, locid, all, hash), HighRiskCodesAddressMapLayout);				
					
          flattenDs   := normalize(highRiskRecs,10,
					                         transform(HighRiskCodesLayout,
																	           self.code   := map(counter = 1 => left.company_sic_code1[1..4],
																						                    counter = 2 => left.company_sic_code2[1..4],
																						                    counter = 3 => left.company_sic_code3[1..4],
																						                    counter = 4 => left.company_sic_code4[1..4],
																						                    counter = 5 => left.company_sic_code4[1..4],
																						                    counter = 6 => left.company_naics_code1,
																						                    counter = 7 => left.company_naics_code2,
																						                    counter = 8 => left.company_naics_code3,
																						                    counter = 9 => left.company_naics_code4,
					                                                      left.company_naics_code5),
																	           self.code_type  := if(counter < 6, 'SIC', 'NAICS');																						 
																						 self            := left;
																						 ));

          filterCodes              := flattenDs(code!='');
					highRiskSICKeys          := filterCodes(code_type='SIC' and code in highRiskSicCodes);
					highRiskNAICSKeys        := filterCodes(code_type='NAICS' and code in highRiskNAICSCodes);
					allCodes                 := highRiskSICKeys + highRiskNAICSKeys;
					
					sortCodes    := sort(distribute(allCodes, hash32(seleid)), seleid, code, code_type,local);
										
					rollInfo      := rollup(sortCodes,
					                        left.seleid     = right.seleid 
														  and left.code       = right.code  
														  and left.code_type  = right.code_type,
															transform(HighRiskCodesLayout,
															          self.dt_first_seen := if(right.dt_first_seen > 0 and right.dt_first_seen < left.dt_first_seen,
																				                         right.dt_first_seen, left.dt_first_seen),
																				self.dt_last_seen  := if(right.dt_last_seen > left.dt_last_seen,
																				                         right.dt_last_seen, left.dt_last_seen),			
																			  self               := left),local);
																				
          
					go_build := parallel(
					      buildindex(phoneIndexDef(phone_outfile_name, highRiskPhoneNumbers))
					     ,buildindex(addrIndexDef(addr_outfile_name, highRiskAddrs))
					     ,buildindex(codeIndexDef(output_file_name, rollInfo))
					);
					

          go_add_built := parallel(
					     tools.mod_PromoteBuild(pversion,buildPhoneFileNames,'',false,false,,,,false,false,'').new2built
					    ,tools.mod_PromoteBuild(pversion,buildAddrFileNames,'',false,false,,,,false,false,'').new2built
					    ,tools.mod_PromoteBuild(pversion,buildCodesFileNames,'',false,false,,,,false,false,'').new2built
					);
					 
					go_promote_qa := parallel(
					     tools.mod_PromoteBuild(pversion,buildPhoneFileNames,'',false,false,,,,false,false,'').built2QA
					    ,tools.mod_PromoteBuild(pversion,buildAddrFileNames,'',false,false,,,,false,false,'').built2QA
					    ,tools.mod_PromoteBuild(pversion,buildCodesFileNames,'',false,false,,,,false,false,'').built2QA
					);
					
          go := sequential(
							 go_build
	            ,go_add_built
	            ,if(promoteToQA,go_promote_qa)
           );
			
          return go;
		end; // end getCodes
end; //end module