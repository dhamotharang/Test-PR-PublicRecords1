export mac_make_contacts_search(format_child,format_parent,indataset,outdataset) := MACRO


	// When this is called from search self := le includes the lowest penalty for each corpkey
	recordof(format_parent) rolledconts(indataset le, indataset ri):= transform
	self.contact :=choosen(le.contact & ri.contact,50);
	self :=le;
	end;
	
	recordof(format_child) peoplegroup(format_child le,format_child ri):=transform		
	pre_sorted_by_date_all := sort(le+ri,-dt_last_seen,cont_fname,cont_mname,cont_lname);
	pre_sorted_by_date_pop_addr:= pre_sorted_by_date_all(cont_prim_name<>'' or cont_prim_range<>'' or cont_p_city_name<>'');
	sorted_by_date := if(count(pre_sorted_by_date_pop_addr)=0,pre_sorted_by_date_all,pre_sorted_by_date_pop_addr);
	
	
	
	//sorted_by_date :=  sort(le + ri, -dt_last_seen);
		
	self.title_description :=choosen(dedup(normalize(pre_sorted_by_date_all,left.title_description,transform(layout_search_title,self:=right))(cont_type_desc <>''),record,all),10);
	self.names := choosen(dedup(normalize(sorted_by_date,left.names,transform(layout_search_names,self:=right)),record,all),10);
	self.addresses := choosen(dedup(normalize(sorted_by_date,left.addresses,transform(layout_search_addresses,self:=right)),record,all),10);
	self.cont_sos_charter_nbr := if(count(sorted_by_date(cont_sos_charter_nbr <>''))>0,sorted_by_date(cont_sos_charter_nbr <>'')[1].cont_sos_charter_nbr,'');
	self.penalt_1 := min(sorted_by_date,penalt_1);
	self.penalt_2 := min(sorted_by_date,penalt_2);
	self :=sorted_by_date[1];
	end;
	
	// join records by same did (not equal to zero) or both dids equal zero and same name (if contact is a person) or
	// similar company name (if contact is a company)
	
	recordof(format_parent) group_same_people(format_parent le):=transform
	rolled :=rollup(sort(le.contact,-(unsigned1)(did=''),did,cont_fname,cont_lname,cont_mname,cont_name),
		(left.did=right.did and left.did <> '') or ((left.did='' and right.did='') and ((left.cont_fname=right.cont_fname and left.cont_lname=right.cont_lname and left.cont_mname=right.cont_mname and left.cont_name=right.cont_name
		 and left.cont_name_suffix=right.cont_name_suffix and (left.cont_lname <>'' or left.cont_fname <>'' or left.cont_name <>'')) or  (left.cont_cname <>'' and ut.CompanySimilar(left.cont_cname,right.cont_cname)<3))) ,peoplegroup(left,right));
	self.contact := rolled;
	self :=le;
	end;
	
	res_rolled :=rollup(indataset,left.corp_key=right.corp_key,rolledconts(left,right));
	outdataset :=project(res_rolled,group_same_people(left));
	

	endMacro;