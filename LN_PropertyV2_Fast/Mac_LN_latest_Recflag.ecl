import ut,LN_PropertyV2,LN_PropertyV2_Fast;

export Mac_LN_latest_Recflag(dataset(recordof(LN_PropertyV2.File_Search_DID))  file) := module
			
	SHARED search_dist := distribute(file(source_code[2] = 'P'),hash(ln_fares_id));
	
//******************** setup current record for assessor ********************************************************
	export current_assessor(dataset(recordof(LN_PropertyV2.Layout_Property_Common_Model_BASE)) in_assessor)
					:= function
		assessor_dist := distribute(in_assessor,hash(ln_fares_id));
		
		layout_assessor_clean_address := record
			LN_PropertyV2.Layout_Property_Common_Model_BASE;
			string10  prim_range;
			string28  prim_name;
			string8   sec_range;
			string5   zip;
		end;
		
		layout_assessor_clean_address populate_clean_address(assessor_dist l, search_dist r) := transform
			self.prim_range := r.prim_range;
			self.prim_name	:= r.prim_name;
			self.sec_range	:= r.sec_range;
			self.zip		:= r.zip;
			self			:= l;
		end;
		
		assessor_clean_address := join(assessor_dist, search_dist,
										left.ln_fares_id = right.ln_fares_id,
										populate_clean_address(left,right),
										left outer,
										keep(1),
										local);
		asses_addr_populated 					:= assessor_clean_address(prim_range != '' and prim_name != '' and zip != '');
		asses_no_addr_populated 			:= assessor_clean_address(~(prim_range != '' and prim_name != '' and zip != ''));
		asses_dist										:= distribute(asses_addr_populated,hash(prim_range,prim_name,sec_range,zip));
		asses_sort      							:= sort(asses_dist,prim_range,prim_name,sec_range,zip,local); 
		asses_fares										:= asses_sort(vendor_source_flag in ['F','S']); 
		asses_lexis										:= asses_sort(vendor_source_flag not in ['F','S']);
		fares_sort_grpd 							:= group(asses_fares,prim_range,prim_name,sec_range,zip,local);
		lexis_sort_grpd 							:= group(asses_lexis,prim_range,prim_name,sec_range,zip,local);
		fares_grpd_sort 							:= sort(fares_sort_grpd,-(integer)tax_year,-(integer)assessed_value_year,-(integer)process_date);
		lexis_grpd_sort 							:= sort(lexis_sort_grpd,-(integer)tax_year,-(integer)assessed_value_year,-(integer)process_date);
		 
		fares_grpd_sort tkeepflag(fares_grpd_sort L, fares_grpd_sort R) := transform
			 self.current_record   := if(l.current_record = '', 'Y','N'); 
			//self.current_record := if(l.current_record = '', 'Y', if( l.current_record = 'Y' and  ((integer)r.recdate >= (integer)l.recdate) ,'Y','N'));
			self := R;
		end;

		fares_assesor_iterate := GROUP(iterate(fares_grpd_sort, tkeepflag(left, right)));
		lexis_assesor_iterate := GROUP(iterate(lexis_grpd_sort, tkeepflag(left, right)));

		LN_PropertyV2.Layout_Property_Common_Model_BASE  reformat(fares_assesor_iterate l) := transform
			 self.current_record := if(l.current_record = 'N', '',l.current_record); 
			 self := l ;
		end; 

		Assesor_current_flag_with_addr 		:= project(fares_assesor_iterate + lexis_assesor_iterate, reformat(left));
		Assesor_current_flag_with_no_addr := project(asses_no_addr_populated, reformat(left));
		
		Assesor_current_flag := Assesor_current_flag_with_addr + Assesor_current_flag_with_no_addr;

		return Assesor_current_flag;
	end;

//******************** setup current record for deeds ********************************************************

	export current_deeds(dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) in_deeds) 
					:= function
		deed_dist		:= distribute(in_deeds,hash(ln_fares_id));
		
		layout_deeds_clean_address := record
			LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE;
			string10  prim_range;
			string28  prim_name;
			string8   sec_range;
			string5   zip;
		end;
		
		layout_deeds_clean_address populate_clean_address(deed_dist l, search_dist r) := transform
			self.prim_range := r.prim_range;
			self.prim_name	:= r.prim_name;
			self.sec_range	:= r.sec_range;
			self.zip		:= r.zip;
			self			:= l;
		end;
		
		deeds_clean_address := join(deed_dist, search_dist,
									left.ln_fares_id = right.ln_fares_id,
									populate_clean_address(left,right),
									left outer,
									keep(1),
									local);
		
		deeds_addr_populated := deeds_clean_address(prim_range != '' and prim_name != '' and zip != '');
		deeds_no_addr_populated := deeds_clean_address(~(prim_range != '' and prim_name != '' and zip != ''));
		deeds_dist	:= distribute(deeds_addr_populated,hash(prim_range,prim_name,sec_range,zip));
		deeds_sort  := sort(deeds_dist,prim_range,prim_name,sec_range,zip,-(integer)recording_date,-(integer)contract_date,-(integer)process_date,local);
		fares_sort	:= deeds_sort(vendor_source_flag in ['F','S']);
		lexis_sort	:= deeds_sort(vendor_source_flag not in ['F','S']);
		fares_dedup	:= dedup(fares_sort,prim_range,prim_name,sec_range,zip,local);
		lexis_dedup	:= dedup(lexis_sort,prim_range,prim_name,sec_range,zip,local);
		 
		LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE tkeepfaresflag(fares_sort L, fares_dedup R) := transform
			self.current_record  := if(L.ln_fares_id = R.ln_fares_id,'Y','');
			self := L;
		end;

		fares_current_flag := join(fares_sort,fares_dedup,
									left.ln_fares_id = right.ln_fares_id,
									tkeepfaresflag(left,right),
									left outer,
									local);
									
		LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE tkeeplexisflag(lexis_sort L, lexis_dedup R) := transform
			self.current_record  := if(L.ln_fares_id = R.ln_fares_id,'Y','');
			self := L;
		end;

		lexis_current_flag := join(lexis_sort,lexis_dedup,
									left.ln_fares_id = right.ln_fares_id,
									tkeeplexisflag(left,right),
									left outer,
									local);

		LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE reformat(deeds_no_addr_populated l) := transform
			self.current_record := '';
			self := l;
		end;
		
		deed_current_flag_no_addr := project(deeds_no_addr_populated,reformat(left));

		return fares_current_flag+lexis_current_flag+deed_current_flag_no_addr;
	end;

end;