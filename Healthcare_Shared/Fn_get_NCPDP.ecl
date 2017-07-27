import NCPDP,Healthcare_Shared;
EXPORT Fn_get_NCPDP := Module
	Export get_ncpdp_entity (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
			noHits := recs;
			rawdataIndividualbyVendorid:= join(dedup(sort(noHits(vendor_id<>''),record),record),  NCPDP.key_ProviderID,
											keyed(left.vendor_id = right.NCPDP_provider_id),
											transform(Healthcare_Shared.Layouts.ncpdp_base_with_input,
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
			baseRecs := project(rawdataIndividualbyVendorid,Healthcare_Shared.Transforms_NCPDP.build_NCPDP(left,cfg));
			baseRecsWithInput := join(baseRecs,input,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.userinput:=right,self := left;),keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			return baseRecsWithInput;
	end;
end;