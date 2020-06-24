Import Prof_LicenseV2, Healthcare_Header_Services,suppress;

EXPORT Datasource_ProfLic := Module
	Export get_proflic_entity (dataset(Healthcare_Header_Services.Layouts.searchKeyResults_plus_input) input,dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg):= function
			rawdataIndividual:= join(dedup(sort(input(lnpid>0),acctno, lnpid),acctno, lnpid), Prof_LicenseV2.Key_Proflic_lnpid(),
											keyed(left.lnpid = right.lnpid),
											transform(Healthcare_Header_Services.Layouts.proflic_base_with_input, 
																		self.l_providerid := left.lnpid;
																		self.vendorid:=(string)right.prolic_seq_id;
																		self.rawData:=[];
                                    self:=right;
																		self:=left;),
											keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			noHits := join(input,rawdataIndividual,left.acctno=right.acctno,transform(Healthcare_Header_Services.Layouts.searchKeyResults_plus_input, self:=left),left only);
			
			rawdataIndividualbyVendorid:= join(rawdataIndividual, Prof_LicenseV2.Key_ProfLic_Id(),
											keyed((integer)left.vendorid = (integer)right.prolic_seq_id) and left.src = Healthcare_Header_Services.Constants.SRC_PROFLIC,
											transform(Healthcare_Header_Services.Layouts.proflic_base_with_input,
																		self.l_providerid := left.l_providerid;
																		self.vendorid:=left.vendorid;
                                    self.rawData:=right;
                                    self.global_sid:=right.global_sid;
                                    self:=left;),
											keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0)); //I believe this should be a 1:1 join...
					
			rawdataBusbyVendorid:= join(dedup(sort(noHits(vendorid<>''),record),record), Prof_LicenseV2.Key_Proflic_Bdid(),
											keyed((integer)left.bdid = right.bd) and left.vendorid = right.prolic_key,
											transform(Healthcare_Header_Services.Layouts.proflic_base_with_input,
																		self.l_providerid := left.lnpid;
																		self.vendorid:=(string)right.bdid;
																		self.rawData:=right;
																		self:=left),
											keep(Healthcare_Header_Services.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			
			baseInput := project(input,
				transform(Healthcare_Header_Services.Layouts.CombinedHeaderResults,
					isCompany 								:= LEFT.comp_name <> '';
					hasIndividual 						:= LEFT.name_last <> '' ;
					self.acctno 							:= if(isCompany and hasIndividual,skip,LEFT.acctno);
					self.LNPID 								:= LEFT.lnpid;
					self.srcID 								:= LEFT.lnpid;
					self.src 									:= Healthcare_Header_Services.Constants.SRC_PROFLIC;
					self.glb_ok								:= LEFT.glb_ok;
					self.dppa_ok							:= LEFT.dppa_ok;
					self.ProcessingMessage 		:= if(LEFT.srcBusinessHeader and LEFT.returnThresholdExceeded,203,0);
					self.srcIndividualHeader 	:= LEFT.srcIndividualHeader;
					self.srcBusinessHeader 		:= LEFT.srcBusinessHeader;
					SELF	:= LEFT,
					SELF	:= []));
			baseInput_sorted := sort(baseInput, acctno, LNPID);
			baseInput_grouped := group(baseInput_sorted, acctno, LNPID);
			baseInput_rolled := rollup(baseInput_grouped, group, Healthcare_Header_Services.Transforms.doProfLicBaseRecordSrcIdRollup(left,rows(left)));	
			mod_access:=Healthcare_Header_Services.ConvertcfgtoIdataaccess(cfg);
			supmacprof:=Suppress.MAC_FlagSuppressedSource(rawdataIndividualbyVendorid+rawdataBusbyVendorid, mod_access); 
			setOptOutproflic := project(supmacprof, transform(healthcare_header_services.Layouts.proflic_base_with_input,
																																	self.hasOptOut:= left.is_suppressed;
																																	self.acctno:=left.acctno;
																																	self.lnpid:=left.lnpid;
																																	self:=if(not left.is_suppressed,left);
																																	self:=[];));   
			baseRecs := project(sort(setOptOutproflic,-rawData.expiration_date,rawData.prolic_seq_id),Healthcare_Header_Services.Transforms.build_ProfLic_base(left));
			proflic_providers_final_sorted := sort(baseRecs, acctno, LNPID);
			proflic_providers_final_grouped := group(proflic_providers_final_sorted, acctno, LNPID);
			proflic_providers_rolled := rollup(proflic_providers_final_grouped, group, Healthcare_Header_Services.Transforms.doProfLicBaseRecordSrcIdRollup(left,rows(left)));			
			
			finalRecs	:= join(baseInput_rolled, proflic_providers_rolled, 
				left.acctno = right.acctno 
				and left.LNPID = right.LNPID,
				transform(Healthcare_Header_Services.Layouts.CombinedHeaderResults,
					self.Sources				:= RIGHT.sources;
					self.VendorId				:= RIGHT.VendorId;
					Self.Names					:= RIGHT.Names;
					self.Addresses			:= RIGHT.Addresses;
					self.dids 					:= RIGHT.dids;
					self.bdids 					:= RIGHT.bdids;
					self.dobs 					:= RIGHT.dobs;
					self.StateLicenses 	:= RIGHT.StateLicenses;
					self.ProfLicRaw 		:= RIGHT.ProfLicRaw;
					Self.SrcRecRaw 			:=  RIGHT.SrcRecRaw;
					self.hasoptout      := RIGHT.HASOPTOUT;
					self				 				:= LEFT),
				limit(0), keep(1));
				
			return finalRecs;
			
	end;
end;