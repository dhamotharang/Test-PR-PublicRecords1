import CLIA,Codes;
EXPORT Fn_get_CLIA := Module
	Export get_clia_entity (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
			// rawdataIndividual:= join(dedup(sort(recs(lnpid>0),record),record), clia.keys().LNPID.qa,
											// keyed(left.lnpid = right.lnpid),
											// transform(Healthcare_Shared.Layouts.clia_base_with_input, 
																		// self.l_providerid := left.lnpid;
																		// self.vendorid:=right.clia_number;
																		// self:=right;
																		// self:=left),
											// keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			// noHits := join(recs,rawdataIndividual,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts_Header.CandidateRecords, self:=left),left only);
			noHits := recs;
			rawdataIndividualbyVendorid:= join(dedup(sort(noHits(vendor_id<>''),record),record),  clia.keys().CLIA_Number.qa,
											keyed(left.vendor_id = right.clia_number),
											transform(Healthcare_Shared.Layouts.clia_base_with_input,
																		self.acctno:=left.acctno;
																		self.internalID:=if(left.srcIndividualHeader,left.lnpid,left.lnfid);
																		self.lnpid:=left.lnpid;
																		self.lnfid:=left.lnfid;
																		self.src:=left.src;
																		self.vendor_id := left.vendor_id;
																		self.isSearchFailed := left.isSearchFailed;
																		self.keysfailed_decode := left.keysfailed_decode;
																		self.returnThresholdExceeded := left.returnThresholdExceeded;
																		self.srcIndividualHeader := left.srcIndividualHeader;
																		self.srcBusinessHeader := left.srcBusinessHeader;
																		self:=right;
																		self:=left),
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			
			// base_w_TermCodes	:= join(rawdataIndividual+rawdataIndividualbyVendorid,Codes.Key_Codes_V3,
												// keyed(right.file_name = 'CLIA_LAB_TYPE') and keyed(right.field_name = 'TERMINATION_CODE') and left.lab_term_code = right.code,
												// transform(Healthcare_Shared.Layouts.clia_base_with_input,self.TermCodeDesc:=right.long_desc;self:=left), left outer);
			base_w_TermCodes	:= join(rawdataIndividualbyVendorid,Codes.Key_Codes_V3,
												keyed(right.file_name = Healthcare_Shared.Constants.CLIA_CODESV3_FILENAME) and keyed(right.field_name = Healthcare_Shared.Constants.CLIA_CODESV3_FIELDNAME) and left.lab_term_code = right.code,
												transform(Healthcare_Shared.Layouts.clia_base_with_input,self.TermCodeDesc:=right.long_desc;self:=left), left outer,keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			baseRecs := project(base_w_TermCodes,Healthcare_Shared.Transforms_CLIA.build_CLIA(left,cfg));
			baseRecsWithInput := join(baseRecs,input,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.userinput:=right,self := left;),keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			return baseRecsWithInput;
	end;
end;