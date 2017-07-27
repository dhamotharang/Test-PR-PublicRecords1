Import NPPES,Healthcare_Shared;
EXPORT Fn_get_NPPES := Module
	Export get_nppes_entity (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input, boolean isBusiness=false,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
			// rawdataIndividual:= join(dedup(sort(recs(lnpid>0),record),record), NPPES.Key_NPPES_lnpid,
											// keyed(left.lnpid = right.lnpid),
											// transform(Healthcare_Shared.Layouts.npi_base_with_input, 
																		// SELF.clean_prim_range:=right.prim_range;
																		// SELF.clean_predir:=right.predir;
																		// SELF.clean_prim_name:=right.prim_name;
																		// SELF.clean_addr_suffix:=right.addr_suffix;
																		// SELF.clean_postdir:=right.postdir;
																		// SELF.clean_unit_desig:=right.unit_desig;
																		// SELF.clean_sec_range:=right.sec_range;
																		// SELF.clean_p_city_name:=right.p_city_name;
																		// SELF.clean_st:=right.st;
																		// SELF.clean_z5:=right.zip;
																		// self.vendorid:=right.npi;
																		// self:=left,
																		// self:=right),
											// keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			// noHits := join(recs,rawdataIndividual,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts_Header.CandidateRecords, self:=left),left only);
			noHits := recs(vendor_id<>'');
			rawdataIndividualbyVendorid:= join(dedup(sort(recs,record),record),  NPPES.Key_NPPES_npi,
											keyed((string)left.vendor_id = right.npi), 
											transform(Healthcare_Shared.Layouts.npi_base_with_input,
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
																		self:=right;self:=left;self:=[];), 
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			// baseRecs := project(sort(rawdataIndividual+rawdataIndividualbyVendorid,acctno,-Provider_Enumeration_Date,-NPI_Reactivation_Date),Healthcare_Shared.Transforms.build_npi_base(left));
			baseRecs := project(sort(rawdataIndividualbyVendorid,acctno,-Provider_Enumeration_Date,-NPI_Reactivation_Date),Healthcare_Shared.Transforms_NPI.build_npi(left,cfg));
			baseRecsWithInput := join(baseRecs,input,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.userinput:=right,self := left;),keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			return baseRecsWithInput;
	end;
	Export get_nppes_forBusHits (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
			return get_nppes_entity(recs,input,true,cfg);
	end;
end;
