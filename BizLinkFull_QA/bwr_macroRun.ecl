ds := dataset('~thor::bipheader::validation::xlink_samples', 	BizLinkFull_QA.modLayouts.lSrcLayout, thor);			

pj_data := project(ds, transform(BIPV2.IdAppendLayouts.AppendInput, 
															SELF.Request_id 			:= COUNTER,
														  SELF.company_name 		:=LEFT.company_name,
															SELF.prim_range 			:=LEFT.prim_range,
															SELF.prim_name 				:=LEFT.prim_name,
															SELF.sec_range 				:=LEFT.sec_range,
															SELF.city 						:=LEFT.p_city_name,
															SELF.state 						:=LEFT.st,
															SELF.zip5  						:=LEFT.zip,
															SELF.phone10 					:=LEFT.company_phone,
															SELF.fein				  		:=LEFT.company_fein,
															SELF.url				  		:=LEFT.company_url,
															SELF.email						:=LEFT.contact_email,
															SELF.contact_fname 		:=LEFT.fname,
															SELF.contact_mname		:=LEFT.mname,
															SELF.contact_lname 		:=LEFT.lname,
															SELF.contact_ssn 			:=LEFT.contact_ssn,
															SELF.contact_did 			:=LEFT.contact_did,
															SELF.source 					:=LEFT.source,
															SELF.source_record_id :=LEFT.source_record_id,
															SELF.proxid 					:=LEFT.proxid,
															SELF.seleid 					:=LEFT.seleid,
															SELF 									:= [];)
															);
pj_data;

// BizLinkFull_QA.macRunTests(BizLinkFull_QA.modProfiles.dprofiles,pj_data);		
													
macro_output := BizLinkFull_QA.macRunTests(BizLinkFull_QA.modProfiles.dprofiles,pj_data);
OUTPUT(macro_output(score >=75), NAMED('result_1'));
OUTPUT(count(macro_output(uniqueid=1)),named('total_candidates_returned'));
OUTPUT(count(macro_output(score >=75)), NAMED('cnt_result_1'));
// OUTPUT(macro_output,,'~thor::bipheader::macroRun::output', overwrite, compressed);

// tab_req_id := table(macro_output, {l.request_id; cnt:= count(group)}, l.request_id);
// tab_req_id(cnt>1);