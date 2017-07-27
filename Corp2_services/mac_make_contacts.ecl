export mac_make_contacts(format_child,format_parent,indataset,outdataset, latest_for_MAs) := MACRO


	// When this is called from search self := le includes the lowest penalty for each corpkey
	recordof(format_parent) rolledconts(indataset le, indataset ri):= transform
	self.contact :=choosen(le.contact & ri.contact,50);
	self :=le;
	end;
	
	recordof(format_child) peoplegroup(format_child le,format_child ri):=transform		
	
	pre_sorted_by_date_all := sort(le+ri,-dt_last_seen,cont_fname,cont_mname,cont_lname);
	pre_sorted_by_date_pop_addr:= pre_sorted_by_date_all(cont_prim_name<>'' or cont_prim_range<>'' or cont_p_city_name<>'');
	sorted_by_date := if(count(pre_sorted_by_date_pop_addr)=0,pre_sorted_by_date_all,pre_sorted_by_date_pop_addr);
	
	self.names :=choosen(dedup(normalize(sorted_by_date,left.names,transform(layout_names,self:=right)),record,all),if(latest_for_MAs,10,1));
	self.addresses :=choosen(dedup(normalize(sorted_by_date,left.addresses,transform(layout_addresses,self:=right)),record,all),if(latest_for_MAs,10,1));
	self.title_descriptions :=choosen(dedup(normalize(pre_sorted_by_date_all,left.title_descriptions,transform(layout_titles,self:=right))(cont_title_desc <>'' or cont_type_desc <>''),record,all),10);
	self.cont_filing_reference_nbr :=if(count(sorted_by_date(cont_filing_reference_nbr <>''))>0,sorted_by_date(cont_filing_reference_nbr <>'')[1].cont_filing_reference_nbr,'');
	self.cont_filing_date :=if(count(sorted_by_date(cont_filing_date <> ''))>0,sorted_by_date(cont_filing_date <> '')[1].cont_filing_date,'');
	self.cont_filing_desc :=if(count(sorted_by_date(cont_filing_desc <> ''))>0, sorted_by_date(cont_filing_desc <> '')[1].cont_filing_desc,'');
	self.cont_fein := if(count(sorted_by_date(cont_fein <>''))>0, sorted_by_date(cont_fein <>'')[1].cont_fein,'');
	self.cont_ssn := if(count(sorted_by_date(cont_ssn <>''))>0, sorted_by_date(cont_ssn <>'')[1].cont_ssn,'');
	self.cont_dob := if(count(sorted_by_date(cont_dob <>''))>0, sorted_by_date(cont_dob <>'')[1].cont_dob,'');
	self.cont_status_desc :=if(count(sorted_by_date(cont_status_desc <>''))>0, sorted_by_date(cont_status_desc<>'')[1].cont_status_desc,'');
	self.cont_effective_date :=if(count(sorted_by_date(cont_effective_date <>''))>0, sorted_by_date(cont_effective_date <>'')[1].cont_effective_date,'');
	self.cont_effective_desc :=if(count(sorted_by_date(cont_effective_desc <>''))>0, sorted_by_date(cont_effective_desc <>'')[1].cont_effective_desc,''); // new
	self.cont_addl_info :=if(count(sorted_by_date(cont_addl_info <>''))>0, sorted_by_date(cont_addl_info <>'')[1].cont_addl_info,'');
	self :=sorted_by_date[1];
	end;
	
	// join records by same did (not equal to zero) or both dids equal zero and same name (if contact is a person) or
	// similar company name (if contact is a company)
	
	recordof(format_parent) group_same_people(format_parent le):=transform

	rolled :=if(latest_for_MAs=TRUE,
					rollup(sort(le.contact,-(unsigned1)(did=''),did,cont_fname,cont_lname,cont_mname,cont_name),
					(left.did=right.did and left.did <> '') or ((left.did='' and right.did='') and ((left.cont_fname=right.cont_fname and left.cont_lname=right.cont_lname and left.cont_mname=right.cont_mname
					and left.cont_name_suffix=right.cont_name_suffix and left.cont_name =right.cont_name and (left.cont_lname <>'' or left.cont_fname <>'' or left.cont_mname <>'')) or  (left.cont_cname <>'' and ut.CompanySimilar(left.cont_cname,right.cont_cname)<3))) ,peoplegroup(left,right)),
					rollup(sort(le.contact,-(unsigned1)(did=''),did,dt_last_seen,cont_fname,cont_lname,cont_mname,cont_predir,cont_prim_name,cont_addr_suffix,
									cont_postdir,cont_unit_desig,cont_sec_range,cont_p_city_name,cont_v_city_name,cont_state,cont_zip5,
									cont_zip4),(left.did=right.did and left.did <> '' and left.dt_last_seen=right.dt_last_seen and left.cont_lname=right.cont_lname and
									((left.cont_prim_name=right.cont_prim_name and left.cont_prim_range=right.cont_prim_range and left.cont_p_city_name=right.cont_p_city_name and
									left.cont_zip5=right.cont_zip5 and left.cont_sec_range=right.cont_sec_range) or (left.cont_prim_range='' and left.cont_prim_name='' and left.cont_p_city_name='' and left.cont_zip5=''))) 
									or 
									(left.dt_last_seen=right.dt_last_seen and left.cont_fname=right.cont_fname and left.cont_lname =right.cont_lname and left.cont_mname = right.cont_mname and 
									((left.cont_lname <>'' or left.cont_fname <>'' or left.cont_mname <>'') or  (left.cont_cname <>'' and ut.CompanySimilar(left.cont_cname,right.cont_cname)=0)) and		
									((left.cont_predir=right.cont_predir and
									left.cont_prim_name=right.cont_prim_name and left.cont_addr_suffix = right.cont_addr_suffix and left.cont_postdir =right.cont_postdir and left.cont_unit_desig =right.cont_unit_desig and
									left.cont_sec_range=right.cont_sec_range and left.cont_p_city_name=right.cont_p_city_name and left.cont_v_city_name =right.cont_v_city_name and left.cont_state=right.cont_state and left.cont_zip5 =right.cont_zip5 and
									left.cont_zip4 =right.cont_zip4) or (left.cont_prim_range='' and left.cont_prim_name='' and left.cont_p_city_name='' and left.cont_zip5='')) and (left.did=right.did or left.did='' or right.did='')), peoplegroup(left,right)));

	self.contact :=rolled;
	self :=le;
	END;

	
	res_rolled :=rollup(indataset,left.corp_key=right.corp_key,rolledconts(left,right));
	outdataset :=project(res_rolled,group_same_people(left));

	endMacro;