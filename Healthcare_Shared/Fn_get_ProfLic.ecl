Import Prof_LicenseV2, Healthcare_Shared;
EXPORT Fn_get_ProfLic := Module
	Export get_proflic_entity (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
			rawdataIndividual:= join(dedup(sort(recs(lnpid>0),acctno, lnpid),acctno, lnpid), Prof_LicenseV2.Key_Proflic_lnpid(),
											keyed(left.lnpid = right.lnpid),
											transform(Healthcare_Shared.Layouts.proflic_base_with_input, 
																		self.acctno:=left.acctno;
																		self.internalID:=if(left.srcIndividualHeader,left.lnpid,left.lnfid);
																		self.lnpid:=left.lnpid;
																		self.lnfid:=left.lnfid;
																		self.src:=left.src;
																		self.isSearchFailed := left.isSearchFailed;
																		self.keysfailed_decode := left.keysfailed_decode;
																		self.returnThresholdExceeded := left.returnThresholdExceeded;
																		self.srcIndividualHeader := left.srcIndividualHeader;
																		self.srcBusinessHeader := left.srcBusinessHeader;
																		self.vendor_id:=(string)right.prolic_seq_id;
																		self.rawData:=[];
																		self:=left),
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			noHits := join(recs,rawdataIndividual,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts_Header.CandidateRecords, self:=left),left only);
			
			rawdataIndividualbyVendorid:= join(rawdataIndividual, Prof_LicenseV2.Key_ProfLic_Id(),
											keyed((integer)left.vendor_id = (integer)right.prolic_seq_id) and left.src = Healthcare_Shared.Constants.SRC_PROFLIC,
											transform(Healthcare_Shared.Layouts.proflic_base_with_input,
																		self.acctno:=left.acctno;
																		self.internalID:=if(left.srcIndividualHeader,left.lnpid,left.lnfid);
																		self.lnpid:=left.lnpid;
																		self.lnfid:=left.lnfid;
																		self.src:=left.src;
																		self.isSearchFailed := left.isSearchFailed;
																		self.keysfailed_decode := left.keysfailed_decode;
																		self.returnThresholdExceeded := left.returnThresholdExceeded;
																		self.srcIndividualHeader := left.srcIndividualHeader;
																		self.srcBusinessHeader := left.srcBusinessHeader;
																		self.vendor_id:=left.vendor_id;
																		self.rawData:=right;
																		self:=left),
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)); //I believe this should be a 1:1 join...
					
			rawdataBusbyVendorid:= join(dedup(sort(noHits(vendor_id<>''),record),record), Prof_LicenseV2.Key_Proflic_Bdid(),
											keyed((integer)left.bdid = right.bd) and left.vendor_id = right.prolic_key,
											transform(Healthcare_Shared.Layouts.proflic_base_with_input,
																		self.acctno:=left.acctno;
																		self.internalID:=if(left.srcIndividualHeader,left.lnpid,left.lnfid);
																		self.lnpid:=left.lnpid;
																		self.lnfid:=left.lnfid;
																		self.src:=left.src;
																		self.isSearchFailed := left.isSearchFailed;
																		self.keysfailed_decode := left.keysfailed_decode;
																		self.returnThresholdExceeded := left.returnThresholdExceeded;
																		self.srcIndividualHeader := left.srcIndividualHeader;
																		self.srcBusinessHeader := left.srcBusinessHeader;
																		self.vendor_id:=(string)right.bdid;
																		self.rawData:=right;
																		self:=left),
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)); 

			baseRecs := project(sort(rawdataIndividualbyVendorid+rawdataBusbyVendorid,-rawData.expiration_date,rawData.prolic_seq_id),Healthcare_Shared.Transforms_ProfLic.build_ProfLic(left,cfg));
			baseRecsWithInput := join(baseRecs,input,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.userinput:=right,self := left;),keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			return baseRecsWithInput;
	end;
end;