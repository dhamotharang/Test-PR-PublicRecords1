import address, ut;

export StandardizeInputFile := module

	export fPreProcess(dataset(layouts.input_slim_sprayed) pRawFileInput, string pversion) := function    
	
		PRTE_BIP.layouts.base	X2BIPBH(layouts.input_slim_sprayed l)	:=	transform
			 hash_value														:= hash32(ut.fntrim2upper(l.company_name) 	+
																											ut.fntrim2upper(l.company_street) +
																											ut.fntrim2upper(l.company_city) 	+
																											ut.fntrim2upper(l.company_st)   	+
																											ut.fntrim2upper(l.company_zip)		+
																											ut.fntrim2upper(l.company_zip4) 	+
																											ut.fntrim2upper(l.company_fein) 	+
																											ut.fntrim2upper(l.contact_fname) 	+
																											ut.fntrim2upper(l.contact_mname)  +
																											ut.fntrim2upper(l.contact_lname));
				//Please note that _Constants().BH_INIT_BDID > hash_value is always true.																							
				bdid_lth_diff												:= length((string)_Constants().BH_INIT_BDID) - length((string)hash_value) + 1;
				//Please note that _Constants().BH_INIT_DID  > hash_value > hash_value is always true.																											
				did_lth_diff												:= length((string)_Constants().BH_INIT_DID)  - length((string)hash_value) + 1;
				self.company_bdid										:= (unsigned6)((string)_Constants().BH_INIT_BDID[1..bdid_lth_diff] + (string)hash_value);
				self.contact_did										:= (unsigned6)((string)_Constants().BH_INIT_DID[1..did_lth_diff] 	 + (string)hash_value);
				self.company_name										:= ut.fntrim2upper(l.company_name);
				string182 clean_address 						:= address.cleanaddress182(ut.fntrim2upper(l.company_street),
																																			 ut.fntrim2upper(l.company_city) + ' ' + 
																																			 ut.fntrim2upper(l.company_st)   + ' ' + 
																																			 ut.fntrim2upper(l.company_zip));
				self.prim_range 										:= clean_address[1..10];
				self.predir 												:= clean_address[11..12];
				self.prim_name 											:= clean_address[13..40];
				self.prim_name_derived 							:= clean_address[13..40];
				self.addr_suffix 										:= clean_address[41..44];
				self.postdir 												:= clean_address[45..46];
				self.unit_desig 										:= clean_address[47..56];
				self.sec_range 											:= clean_address[57..64];
				self.p_city_name										:= clean_address[65..89];
				self.v_city_name										:= clean_address[65..89];		
				self.st 														:= clean_address[115..116];
				self.zip 														:= clean_address[117..121];
				self.zip4 													:= clean_address[122..125];
				self.fips_county 										:= clean_address[143..145];
				self.geo_lat 												:= clean_address[146..155];
				self.geo_long 											:= clean_address[154..164];
				self.msa 														:= clean_address[165..168];
				self.err_stat 											:= clean_address[179..182];
				self.company_fein										:= ut.fntrim2upper(l.company_fein);
				self.fname													:= ut.fntrim2upper(l.contact_fname);
				self.mname													:= ut.fntrim2upper(l.contact_mname);
				self.lname													:= ut.fntrim2upper(l.contact_lname);
				self.dt_first_seen									:= (unsigned4)pversion;
				self.dt_last_seen										:= (unsigned4)pversion;
				self.dt_vendor_first_reported				:= (unsigned4)pversion;
				self.dt_vendor_last_reported				:= (unsigned4)pversion;
			  self.dt_first_seen_company_name			:= (unsigned4)pversion;
				self.dt_last_seen_company_name			:= (unsigned4)pversion;
				self.dt_first_seen_company_address	:= (unsigned4)pversion;
				self.dt_last_seen_company_address		:= (unsigned4)pversion;	
				self.dt_first_seen_contact					:= (unsigned4)pversion;
				self.dt_last_seen_contact						:= (unsigned4)pversion;		
				self																:= l;
				self																:= [];
		end;

		project_raw_2_bh_layout	:= project(pRawFileInput, X2BIPBH(left));
		
		temp_layout := record
			unsigned8 	unique_id;
			recordof(project_raw_2_bh_layout);
		end;		
		
		project_2_temp_layout		:= project(project_raw_2_bh_layout, transform(temp_layout, self := left; self.unique_id := 0;));
		
		ut.MAC_Sequence_Records(project_2_temp_layout, unique_id, project_2_temp_layout_seq);

		project_2_fakeId_layout	:= project(project_2_temp_layout_seq,transform(prte_bip.Layout_Append_FakeIDs.LinkIds
																																					 ,self	:= left;
																																					 )
																			 );

		dAppendedFakedIds				:= fn_Append_Fake_LinkIDs(project_2_fakeId_layout);

		PRTE_BIP.layouts.base AssignIDs(temp_layout l, prte_bip.Layout_Append_FakeIDs.LinkIds r) := transform
			self.DotID			:= r.DotID;
			self.EmpID			:= r.EmpID;
			self.POWID			:= r.POWID;
			self.ProxID			:= r.ProxID;
			self.SELEID			:= r.SELEID;
			self.OrgID			:= r.OrgID;
			self.UltID			:= r.UltID;
			self 						:= l;
			self						:= [];
		end;

		dslim_file_with_fake_linkids	:= join(project_2_temp_layout_seq,
																					dAppendedFakedIds,
																					left.unique_id = right.unique_id,
																					AssignIDs(left, right),
																					left outer
																					);
																					
		dPreprocess := dslim_file_with_fake_linkids;

		return dPreprocess;

	end; //end fPreProcess function

	export fAll( dataset(layouts.input_slim_sprayed) pRawFileInput, string pversion) := function

		HasData := ut.fnTrim2Upper(pRawFileInput.company_name) 	 <> '' or 
							 ut.fnTrim2Upper(pRawFileInput.company_street) <> '' or 
							 ut.fnTrim2Upper(pRawFileInput.company_city) 	 <> '' or 
							 ut.fnTrim2Upper(pRawFileInput.company_st) 		 <> '' or 
							 ut.fnTrim2Upper(pRawFileInput.company_zip) 	 <> '' or 
							 ut.fnTrim2Upper(pRawFileInput.company_zip4) 	 <> '' or 
							 ut.fnTrim2Upper(pRawFileInput.company_fein) 	 <> '' or 
							 ut.fnTrim2Upper(pRawFileInput.contact_fname)  <> '' or 
							 ut.fnTrim2Upper(pRawFileInput.contact_mname)  <> '' or 
							 ut.fnTrim2Upper(pRawFileInput.contact_lname)  <> ''; 
							 
		dPreprocess	:= fPreProcess(pRawFileInput(HasData),pversion);
		return dPreprocess;
	end; 

end; //end StandardizeInputFile														 
