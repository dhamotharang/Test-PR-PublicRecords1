import BatchServices,iesp, Suppress;

EXPORT functions := MODULE

/* 
 This function cleans input SSN 
*/

export fn_CleanSSN ( String DirtySSN ) := function
			CleanSSN := REGEXREPLACE( '-', DirtySSN, '');
			CleanTrimSSN := trim(CleanSSN,ALL);
			LenSSN := LENGTH(CleanTrimSSN);
			
			return StringLib.StringCleanSpaces((TRIM(MAP(LenSSN < 7 =>'',
																									 LenSSN > 9 =>'',
																									 LenSSN = 7 =>'00'  + CleanTrimSSN,
																									 LenSSN = 8 =>'0' 	+ CleanTrimSSN,
																																				CleanTrimSSN))));
end;

/*
 This function converts TRIS records in batch format to esdl response format.
*/
	
 export ConvertTRIS_BatchToESDL(dataset(BatchServices.Layouts.TaxRefundIS.batch_out) BatchResult,  
                                 unsigned1 dob_mask_value=Suppress.Constants.DateMask.NONE) := function
    recCount := count(BatchResult);
		out_rec := iesp.taxrefundinvestigation.t_TaxRefundInvestigativeResponse;
		in_rec  := BatchServices.Layouts.TaxRefundIS.batch_out;
		header_row 	 :=  iesp.ECL2ESP.GetHeaderRow();
		
    
 // Steps to fill a temp HRI child datastructure 		
		out_Risk_rec := RECORD (iesp.share.t_SequencedRiskIndicator)
			string30 acctno; 
		END;
		
		
// transform to fill the child data structure :
	      out_Risk_rec normXform( in_rec le ,integer c ) := TRANSFORM ,
					SKIP((c = 1 and TRIM(le.hri_1_indicator) = '')  or (c = 2 and TRIM(le.hri_2_indicator) = '' ) or 
							 (c = 3 and TRIM(le.hri_3_indicator) = '') or (c = 4 and TRIM(le.hri_4_indicator) = '')  or 
							 (c = 5 and TRIM(le.hri_5_indicator) = '') or (c = 6 and TRIM(le.hri_6_indicator) = '')) 
		
							self.acctno := le.acctno;
							self.Sequence := c;
							self.RiskCode :=  choose(c ,le.hri_1_indicator, le.hri_2_indicator, le.hri_3_indicator,
																				  le.hri_4_indicator, le.hri_5_indicator, le.hri_6_indicator);
																					
							self.Description := choose(c , le.hri_1_description, le.hri_2_description , le.hri_3_description,
																						 le.hri_4_description, le.hri_5_description , le.hri_6_description	);
				END;
			 
    normOut := normalize(BatchResult,6,normXform(left,counter));
		
		
		
		out_rec  xformResultBatchToESP(in_rec l , dataset(out_Risk_rec) r) := transform
		 
		  self._Header :=  project(header_row, transform(iesp.taxrefundinvestigation.t_TrisHeader,
																					self.status := (string) left.status,
																					self := left, ));
			self.RecordCount := recCount;																																				
			self.TrisRecord.SubjectData.Name.Full   := '' ; 
			self.TrisRecord.SubjectData.Name.First  := l.name_first ; 
			self.TrisRecord.SubjectData.Name.Middle := l.name_middle ; 
			self.TrisRecord.SubjectData.Name.Last   := l.name_last ; 
			self.TrisRecord.SubjectData.Name.Suffix := l.name_suffix; 
			self.TrisRecord.SubjectData.Name.Prefix := ''; 
			self.TrisRecord.SubjectData.SSN   := l.ssn ; 
			self.TrisRecord.SubjectData.DOB  	:= iesp.ECL2ESP.toDatestring8(l.dob);
			self.TrisRecord.SubjectData.Address.StreetNumber 				:= l.prim_range;
			self.TrisRecord.SubjectData.Address.StreetPreDirection 	:= l.predir;
			self.TrisRecord.SubjectData.Address.StreetName  				:= l.prim_name;
			self.TrisRecord.SubjectData.Address.StreetSuffix  			:= l.addr_suffix;
			self.TrisRecord.SubjectData.Address.StreetPostDirection := l.postdir;
			self.TrisRecord.SubjectData.Address.UnitDesignation  		:= l.unit_desig;
			self.TrisRecord.SubjectData.Address.UnitNumber  				:= l.sec_range;
			self.TrisRecord.SubjectData.Address.StreetAddress1  		:= '';
			self.TrisRecord.SubjectData.Address.StreetAddress2  		:= '';
			self.TrisRecord.SubjectData.Address.City  							:= l.p_city_name;
			self.TrisRecord.SubjectData.Address.State  							:= l.st;
			self.TrisRecord.SubjectData.Address.Zip5  							:= l.z5 ;
			self.TrisRecord.SubjectData.Address.Zip4  							:= l.zip4;
			self.TrisRecord.SubjectData.Address.County 							:= l.county_name ;
			self.TrisRecord.SubjectData.Address.PostalCode   				:= '';
			self.TrisRecord.SubjectData.Address.StateCityZip 				:= '' ;
			self.TrisRecord.SubjectData.HomePhone  									:= l.homephone;
			self.TrisRecord.SubjectData.WorkPhone  									:= l.workphone;
			
			self.TrisRecord.SubjectVerificationRecord.BestSSN  							:= l.best_ssn;
			self.TrisRecord.SubjectVerificationRecord.SSNInvalidFlag  			:= l.ssn_invalid_flag;
			self.TrisRecord.SubjectVerificationRecord.SSNRandomizationFlag	:= l.ssn_randomization_flag;
			self.TrisRecord.SubjectVerificationRecord.PossibleAgeDOB  			:= l.possible_age_dob;
			self.TrisRecord.SubjectVerificationRecord.PossibleAgeSSNIssuance  	:=  l.possible_age_ssn_issuance;
			self.TrisRecord.SubjectVerificationRecord.AddressOutsideOfHomeState := l.address_outside_of_home_state;
			self.TrisRecord.SubjectVerificationRecord.AddressConfidence  				:= l.Address_Confidence;
			self.TrisRecord.SubjectVerificationRecord.BestFName  		:= l.best_fname;
			self.TrisRecord.SubjectVerificationRecord.BestLName  		:= l.best_lname;
			self.TrisRecord.SubjectVerificationRecord.BestAddr1  		:= l.best_addr1;
			self.TrisRecord.SubjectVerificationRecord.BestCity   		:= l.best_city;
			self.TrisRecord.SubjectVerificationRecord.BestState  		:= l.best_state;
			self.TrisRecord.SubjectVerificationRecord.BestZip    		:= l.best_zip;
			self.TrisRecord.SubjectVerificationRecord.DateLastSeen  := l.date_last_seen;
			self.TrisRecord.SubjectVerificationRecord.InputAddrDate := l.InputAddrDate;
			self.TrisRecord.SubjectVerificationRecord.MatchedInputAddr  := l.MatchedInputAddr ;
			self.TrisRecord.SubjectVerificationRecord.InputAddrZipDate  	:= l.InputAddrZipDate;
			self.TrisRecord.SubjectVerificationRecord.InputAddrRel  			:= l.inputAddrRel;
			
			self.TrisRecord.ConsumerInstantIdResult.IdentityVerificationNASCode  := l.Identity_Verification_NAS_Code;
			self.TrisRecord.ConsumerInstantIdResult.IdentityVerificationCVICode  := l.Identity_Verification_CVI_Code;
			self.TrisRecord.ConsumerInstantIdResult.RiskIndicators := r;
			
			self.TrisRecord.DeceasedRecord.DeceasedFirstName  := 	l.deceased_first_name;
			self.TrisRecord.DeceasedRecord.DeceasedLastName   :=  l.deceased_last_name;
			self.TrisRecord.DeceasedRecord.DOD 								:= iesp.ECL2ESP.toDatestring8( l.DOD);
			self.TrisRecord.DeceasedRecord.DeceasedMatchCode 	:= l.deceased_matchcode ;

			self.TrisRecord.CriminalRecord.DOCStateOrigin  		:= l.doc_state_origin ;
			self.TrisRecord.CriminalRecord.DOCsDID  					:= l.doc_sdid;
			self.TrisRecord.CriminalRecord.DOCSSN1  					:= l.doc_ssn_1;
			self.TrisRecord.CriminalRecord.DOCLName 					:= l.doc_lname;
			self.TrisRecord.CriminalRecord.DOCFName 					:= l.doc_fname;
			self.TrisRecord.CriminalRecord.DOCMName 					:= l.doc_mname;
			self.TrisRecord.CriminalRecord.DOCNum   					:= l.doc_num;
			dt1 := iesp.ECL2ESP.toMaskableDatestring8(l.doc_dob);
			self.TrisRecord.CriminalRecord.DOCDob  						:= iesp.ECL2ESP.ApplyDateStringMask (dt1 ,dob_mask_value,true);
			self.TrisRecord.CriminalRecord.CurrIncarFlag  		:= l.curr_incar_flag;
			self.TrisRecord.CriminalRecord.CurrParoleFlag  		:= l.curr_parole_flag;
			self.TrisRecord.CriminalRecord.CurrProbationFlag	:= l.curr_probation_flag;
			self.TrisRecord.CriminalRecord.DOCStateOriginBestSSN  := l.doc_state_origin_BestSSN ;
			self.TrisRecord.CriminalRecord.DOCsDIDBestSSN  		:= l.doc_sdid_BestSSN;
			self.TrisRecord.CriminalRecord.DOCSSN1BestSSN  		:= l.doc_ssn_1_BestSSN;
			self.TrisRecord.CriminalRecord.DOCLNameBestSSN  	:= l.doc_lname_BestSSN;
			self.TrisRecord.CriminalRecord.DOCFNameBestSSN  	:= l.doc_fname_BestSSN;
			self.TrisRecord.CriminalRecord.DOCMNameBestSSN  	:= l.doc_mname_BestSSN;
			self.TrisRecord.CriminalRecord.DOCNumBestSSN  	 	:= l.doc_num_BestSSN;
			dt2:= iesp.ECL2ESP.toMaskableDatestring8(l.doc_dob_BestSSN);
			self.TrisRecord.CriminalRecord.DOCDobBestSSN  		:= iesp.ECL2ESP.ApplyDateStringMask (dt2 ,dob_mask_value,true) ;
			self.TrisRecord.CriminalRecord.CurrIncarFlagBestSSN   := l.curr_incar_flag_BestSSN;
			self.TrisRecord.CriminalRecord.CurrParoleFlagBestSSN  := l.curr_parole_flag_BestSSN;
			self.TrisRecord.CriminalRecord.CurrProbationFlagBest  := l.curr_probation_flag_BestSSN;;
			
			self.TrisRecord.NPIIndicator  										:= l.npi_indicator;
			self.TrisRecord.IdentifyFilter 										:= l.identity_filter;
		 end; // end of transform 
		 
	   esp_records := denormalize(BatchResult,normOut,left.acctno=right.acctno,GROUP,xformResultBatchToESP(left,rows(right)));
     return esp_records;
  end; // end of function
	
END;