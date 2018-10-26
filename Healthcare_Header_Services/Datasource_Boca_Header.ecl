import Doxie,didville, header;
EXPORT Datasource_Boca_Header := Module
	Export get_boca_header_entity (dataset(Layouts.autokeyInput) input):= function
      mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
      glb_ok := mod_access.isValidGLB();
      dppa_ok := mod_access.isValidDPPA();

			//Get the dids for the input criteria
			fmtInputToDidville := project(input,Transforms.convertToDidvilleBatch(left,false));
			
			hdrRecs := didville.did_service_common_function(fmtInputToDidville, 'BEST_ALL', 'BEST_ALL', 'ALL', true, 0, false, false, false, 
																									false, false, false, 8,false,,TRUE, '', 0,
																									IndustryClass_val := mod_access.industry_class);
			results := join(input,hdrRecs, (integer)left.acctno=right.seq,
											transform(Layouts.searchKeyResults, self.prov_id:=right.did; self.acctno:=left.acctno;self.src:=Constants.SRC_BOCA_PERSON_HEADER;self.isAutokeysResult:=true),
											keep(Constants.MAX_RECS_ON_JOIN),limit(0)); 
			
			dup_res := dedup(sort(results,record),record);
			base_data0:= join(dup_res, doxie.key_header,
											keyed((integer)left.prov_id = right.s_did), 
											transform(recordof(doxie.Key_Header), self := right), 
											keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 

			Header.MAC_GlbClean_Header(base_data0, base_data_cleaned, , , mod_access);
		
			base_data := join(dup_res, base_data_cleaned,
												left.prov_id = right.s_did, 
												transform(Layouts.bocahdr_base_with_input,self.l_providerid:=right.s_did;self.rawData:=right;
																																		self.name_first:=right.fname;self.name_middle:=right.mname;self.name_last:=right.lname;
																																		self:=left;self:=right), 
												keep(Constants.MAX_RECS_ON_JOIN), limit(0));
			baseRecs := project(sort(base_data,-rawdata.dt_last_seen),Transforms.build_BocaHdr_base(left, counter));
			bocaHeader_providers_final_sorted := sort(baseRecs, acctno, LNPID, Src, (integer)subsrc);
			bocaHeader_providers_final_grouped := group(bocaHeader_providers_final_sorted, acctno, LNPID, Src);
			bocaHeader_providers_rolled := rollup(bocaHeader_providers_final_grouped, group, Transforms.doBocaHeaderBaseRecordSrcIdRollup(left,rows(left)));			
			return bocaHeader_providers_rolled;
	end;
end;