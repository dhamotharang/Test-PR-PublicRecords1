//************************************************************************************************************************************//
//BK Parent files used for key validation purposes
//Author: Vikram Pareddy
//************************************************************************************************************************************//
EXPORT BKParentFiles := module
			
			import KeyValidation, Bankruptcyv2, Bankruptcyv3, ashirey, ut, fcra;
		
		isDev := true;
////////////////NON-FCRA FILES
//////BK SEARCH
		shared bkSearchBase := dataset(ut.foreign_prod_boca + 'thor_data400::base::bankruptcy::search_v3',
																					BankruptcyV2.layout_bankruptcy_search_v3_supp_bip ,flat);
		shared bkSearchSupp := project(bkSearchBase, transform(BankruptcyV2.layout_bankruptcy_search_v3_supp, 
																					self := left));
		export eligibleBKSearch := bkSearchSupp(~(delete_flag = 'D' or court_code+
																												case_number in bankruptcyv2.Suppress.court_code_caseno));
																												
		export bkSearchForDIDKey := KeyValidation.applyProject(eligibleBKSearch((unsigned6)did != 0), recordof(KeyValidation.BKKeyFiles.bkv3DIDKey),  
																															KeyValidation.BKMappings.DIDKey, 
																															KeyValidation.BKMappings.DIDParent, 
																															KeyValidation.BKMappings.DIDIgnoredFields, isDev );
																														
		export bkSearchForSSNKey := KeyValidation.applyProject(eligibleBKSearch, recordof(KeyValidation.BKKeyFiles.bkv3SSNKey), 
																															KeyValidation.BKMappings.SSNKey, 
																															KeyValidation.BKMappings.SSNParent1, 
																															KeyValidation.BKMappings.SSNIgnoredFields, isDev );
																				
																					
////BK Search BIP
		shared bkSearchBIPSupp := project(bkSearchBase, transform(BankruptcyV2.layout_bankruptcy_search_v3_supp_bip, 
																							self.ssn := if(left.ssn <> '',  left.ssn, left.app_ssn);
																							self.tax_id := if(left.tax_id <> '',  left.tax_id, left.app_tax_id);
																					self := left));
		export eligibleBKSearchBIP := bkSearchBIPSupp(~(delete_flag = 'D' or court_code+
																												case_number in bankruptcyv2.Suppress.court_code_caseno));
																												
    export bkSearchForLinkidsKey := bkSearchBase(~(delete_flag = 'D' or court_code+
																										case_number in bankruptcyv2.Suppress.court_code_caseno) and ultid>0);																												
																												
////BK Search for Payload Autokey
		export BKSearchForPayloadAK := bankruptcyv2.file_search_autokey();		
		
		ashirey.Flatten(BKSearchForPayloadAK, flatBKSearchForPayloadAK);
		export FlattenedBKSearchForPayloadAK := flatBKSearchForPayloadAK;
		
		export BKSearchForPayloadAKFCRA := bankruptcyv3.file_search_autokey();		
		
		ashirey.Flatten(BKSearchForPayloadAKFCRA, flatBKSearchForPayloadAKFCRA);
		export FlattenedBKSearchForPayloadAKFCRA := flatBKSearchForPayloadAKFCRA;
		
		
																						
//////BK MAIN
		//Eligible BK Main records
		export bkMainBase := dataset(ut.foreign_prod_boca + 'thor_data400::base::bankruptcy::main_v3',
																	bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp ,flat);
		export eligibleBKMain := bkMainBase(~(delete_flag = 'D' or court_code+
																					case_number in bankruptcyv2.Suppress.court_code_caseno));
																					
		//BK Main for Case number key
		export filteredBKMainForCaseNumber:= eligibleBKMain((case_number<>'' or orig_case_number<>''));// and 
																																													// not(process_date<'20110000' and length(trim(orig_case_number, left, right))>7));
		
		// shared customFilterForCaseNumberKI(case_number) := if(
		shared normalizedBKMainForCaseNumber := KeyValidation.applyNormalize(filteredBKMainForCaseNumber, ['case_number'],
		['choose(c, if(regexreplace(\'^[ |0]*\',L.case_number,\'\') <> \'\', L.case_number, \'\'), regexreplace(\'^[ |0]*\',L.case_number,\'\'), if(regexreplace(\'^[ |0]*\',L.orig_case_number,\'\')  <> \'\', L.orig_case_number, \'\'), regexreplace(\'^[ |0]*\',L.orig_case_number,\'\'))'],
																																																						['qa_defined_empty'],4);
		export BKMainForCaseNumber := normalizedBKMainForCaseNumber(case_number<>'');
							
		//BK Main for DID Key					
		export bkMainForDIDKey := KeyValidation.applyProject(eligibleBKMain((unsigned6)did != 0), recordof(KeyValidation.BKKeyFiles.bkv3DIDKey), 
																														KeyValidation.BKMappings.DIDKey, 
																														KeyValidation.BKMappings.DIDParent, 
																														KeyValidation.BKMappings.DIDIgnoredFields, isDev );
																														
    export bkMainForSSNKey := KeyValidation.applyProject(eligibleBKMain, recordof(KeyValidation.BKKeyFiles.bkv3SSNKey), 
																															KeyValidation.BKMappings.SSNKey, 
																															KeyValidation.BKMappings.SSNParent2, 
																															KeyValidation.BKMappings.SSNIgnoredFields, isDev );
																															
				
		
		//BK Main for TMSID Key
		
		shared layout_status := KeyValidation.BKLayouts.layout_status;
		shared layout_comments := KeyValidation.BKLayouts.layout_comments;

		shared KeyValidation.BKLayouts.bkMainLayoutIN INTransformFunc(
																									bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp l, 
																									unsigned c) := transform
			self.status:= l.status[c];
			self.comments := l.comments;
			self.filing_status := if(l.filing_status = 'Unknown' ,'',l.filing_status);
			self:= l;
		end;

		shared bkMainStatusIN := normalize(eligibleBKMain, count(left.status), 
																														INTransformFunc(left, counter));
																														
   		shared KeyValidation.BKLayouts.bkMainLayoutN NTransformFunc(
																									recordof(bkMainStatusIN) l, 
																									unsigned c) := transform
			self.comments:= l.comments[c];
			self.filing_status := if(l.filing_status = 'Unknown' ,'',l.filing_status);
			self:= l;
		end;

		shared bkMainStatusN := normalize(bkMainStatusIN, count(left.comments), 
																														NTransformFunc(left, counter));

		ashirey.Flatten(bkMainStatusN, bkMainStatusNF);
		export BKMainForTMSIDKey := bkMainStatusNF;
		
/////////////////////FCRA FILES
		shared  todaysdate := ut.GetDate;
		export bkMainBaseFCRA := bkMainBase(fcra.bankrupt_is_ok (todaysdate,date_filed));
		export BKMainForCaseNumberFCRA := BKMainForCaseNumber(fcra.bankrupt_is_ok (todaysdate,date_filed));

																												
		export eligibleBKMainFCRA := eligibleBKMain(fcra.bankrupt_is_ok (todaysdate,date_filed));
		
		export eligibleBKSearchFCRA := eligibleBKSearch(fcra.bankrupt_is_ok (todaysdate,date_filed));
		
		export eligibleBKSearchBIPFCRA := eligibleBKSearchBIP(fcra.bankrupt_is_ok (todaysdate,date_filed));
																												
		export bkSearchForDIDKeyFCRA := KeyValidation.applyProject(eligibleBKSearchFCRA((unsigned6)did != 0), 
																															recordof(KeyValidation.BKKeyFiles.bkv3DIDKey),  
																															KeyValidation.BKMappings.DIDKey, 
																															KeyValidation.BKMappings.DIDParent, 
																															KeyValidation.BKMappings.DIDIgnoredFields, isDev );
																															
		export bkMainForDIDKeyFCRA := KeyValidation.applyProject(eligibleBKMainFCRA((unsigned6)did != 0), 
																														recordof(KeyValidation.BKKeyFiles.bkv3DIDKey), 
																														KeyValidation.BKMappings.DIDKey, 
																														KeyValidation.BKMappings.DIDParent, 
																														KeyValidation.BKMappings.DIDIgnoredFields, isDev );
																														
		export BKMainForTMSIDKeyFCRA := BKMainForTMSIDKey(fcra.bankrupt_is_ok (todaysdate,date_filed));
		
		shared BKSearchForSSN4StFCRA_Filter := eligibleBKSearch(name_type ='D' AND 
	                     ((integer)ssn > 0  or (integer)app_ssn > 0 or (integer)ssnmatch > 0) and 
						 (fcra.bankrupt_is_ok (todaysdate,process_date)));

			shared temp_rec := record
				string4   ssnLast4;
				string2   state;
				string150 lname;      //will contain company name if lname is blank.
				string50  fname;
				BKSearchForSSN4StFCRA_Filter.tmsid;
			end;

			 temp_rec treformatssn(BKSearchForSSN4StFCRA_Filter L) := transform
					//ssns can be '####     ' where #### is last 4 digits, so pad ssns with leading zeros.
					ssn := INTFORMAT((integer)L.ssn,9,1)[6..9];
					app_ssn := INTFORMAT((integer)L.app_ssn,9,1)[6..9];
					ssnmatch := INTFORMAT((integer)L.ssnmatch,9,1)[6..9];
			
				self.ssnLast4 := map ((integer)ssn > 0 => ssn,
															(integer)app_ssn > 0 => app_ssn,
																(integer)ssnmatch > 0 => ssnmatch,
										''
															);
				self.state := L.court_code[1..2];
				self.lname := if (length(trim(L.lname))>0,L.lname,L.cname);
				self := L;
			end;
		 export BKSearchForSSN4StFCRA := project(BKSearchForSSN4StFCRA_Filter,treformatssn(left));

end;