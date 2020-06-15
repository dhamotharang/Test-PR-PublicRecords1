﻿import Doxie,didville, header,Healthcare_Header_Services;
EXPORT Datasource_Boca_Header := Module
	Export get_boca_header_entity (dataset(Healthcare_Header_Services.Layouts.autokeyInput) input, dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg):= function
     mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
      glb_ok := mod_access.isValidGLB();
      dppa_ok := mod_access.isValidDPPA();

			//Get the dids for the input criteria
			fmtInputToDidville := project(input,Transforms.convertToDidvilleBatch(left,false));
			
			hdrRecs := didville.did_service_common_function(fmtInputToDidville, 'BEST_ALL', 'BEST_ALL', 'ALL', true, 0, false, false, false, 
																									false, false, false, 8,false,,TRUE, '', 0,
																									IndustryClass_val := mod_access.industry_class);
			results := join(input,hdrRecs, (integer)left.acctno=right.seq,
											transform(Healthcare_Header_Services.Layouts.searchKeyResults, self.prov_id:=right.did; self.acctno:=left.acctno;self.src:=Constants.SRC_BOCA_PERSON_HEADER;self.isAutokeysResult:=true;self.glb_ok:=cfg[1].glb_ok),
											keep(Constants.MAX_RECS_ON_JOIN),limit(0)); 
			
			dup_res := dedup(sort(results,record),record);
			base_data0:= join(dup_res, doxie.key_header,
											keyed((integer)left.prov_id = right.s_did) and right.valid_ssn = 'G' and right.dob <> 0,
											transform(recordof(doxie.Key_Header), self := right), 
											keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 

			Header.MAC_GlbClean_Header(base_data0, base_data_cleaned, , , mod_access);
		
			base_data := join(dup_res, base_data_cleaned,
												left.prov_id = right.s_did, 
												transform(Healthcare_Header_Services.Layouts.bocahdr_base_with_input,self.l_providerid:=right.s_did;self.rawData:=right;
																																		self.name_first:=right.fname;self.name_middle:=right.mname;self.name_last:=right.lname;
																																		self:=left;self:=right), 
												keep(Constants.MAX_RECS_ON_JOIN), limit(0));   
				
			supmacbocahdr:=Suppress.MAC_FlagSuppressedSource(base_data, mod_access); 
      setOptOutbocahdr := project(supmacbocahdr, transform(Healthcare_Header_Services.Layouts.bocahdr_base_with_input,
																																	self.hasOptOut:= left.is_suppressed;
																																	self.acctno:=left.acctno;
																																	self.lnpid:=left.lnpid; 
																																	self:=if(not left.is_suppressed,left);
																																	self:=[];));    
			baseRecs := project(sort(setOptOutbocahdr,-rawdata.dt_last_seen),Transforms.build_BocaHdr_base(left, counter));
			bocaHeader_providers_final_sorted := sort(baseRecs, acctno, LNPID, Src, (integer)subsrc);
			bocaHeader_providers_final_grouped := group(bocaHeader_providers_final_sorted, acctno, LNPID, Src);
			bocaHeader_providers_rolled := rollup(bocaHeader_providers_final_grouped, group, Transforms.doBocaHeaderBaseRecordSrcIdRollup(left,rows(left)));			
			return bocaHeader_providers_rolled;
	end;
end;