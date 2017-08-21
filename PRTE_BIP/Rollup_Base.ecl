import ut;

export Rollup_Base(
										dataset(Layouts.Base)				pUpdateFile,
										dataset(Layouts.Base)				pBaseFile
									) := function
	
	pUpdateFile_dist					:=	distribute(pUpdateFile,hash(
																			 company_name
																			,prim_range
																			,predir
																			,prim_name
																			,addr_suffix
																			,postdir
																			,unit_desig
																			,sec_range
																			,p_city_name
																			,st
																			,zip
																			,fname
																			,mname
																			,lname)
																			);
																
	pUpdateFile_dist_sort			:=	sort(pUpdateFile_dist,
																 company_name
																,prim_range
																,predir
																,prim_name
																,addr_suffix
																,postdir
																,unit_desig
																,sec_range
																,p_city_name
																,st
																,zip
																,fname
																,mname
																,lname
																,local
																);	
	
	pBaseFile_dist					:=	distribute(pBaseFile,hash(
																			 company_name
																			,prim_range
																			,predir
																			,prim_name
																			,addr_suffix
																			,postdir
																			,unit_desig
																			,sec_range
																			,p_city_name
																			,st
																			,zip
																			,fname
																			,mname
																			,lname)
																			);
																
	pBaseFile_dist_sort			:=	sort(pBaseFile_dist,
																 company_name
																,prim_range
																,predir
																,prim_name
																,addr_suffix
																,postdir
																,unit_desig
																,sec_range
																,p_city_name
																,st
																,zip
																,fname
																,mname
																,lname
																,local
																);


	//Rollup only on the records that were just updated because we are only rolling up on
	//company name, address, person name and fein and not on the full record.
	layouts.base Xform(pBaseFile_dist_sort l, pUpdateFile_dist_sort r) := transform
		self	:= l;
	end;

	matched_file := join(pBaseFile_dist_sort,pUpdateFile_dist_sort,
											left.company_name  	 = right.company_name 	and
											left.prim_range  		 = right.prim_range			and
											left.predir  		 		 = right.predir					and
											left.prim_name  		 = right.prim_name			and
											left.addr_suffix  	 = right.addr_suffix		and
											left.postdir  		 	 = right.postdir				and
											left.unit_desig  		 = right.unit_desig			and
											left.sec_range  		 = right.sec_range			and											
											left.p_city_name  	 = right.p_city_name 		and
											left.st  		 				 = right.st 						and
											left.zip  	 				 = right.zip 						and
											left.zip4    				 = right.zip4 					and
											left.company_fein    = right.company_fein 	and
											left.fname  				 = right.fname 					and
											left.mname   				 = right.mname 				  and
											left.lname   				 = right.lname,									
											Xform(left,right),
											inner,
											local
											);

	non_matched_file := join(pBaseFile_dist_sort,pUpdateFile_dist_sort,
											left.company_name  	 = right.company_name 	and
											left.prim_range  		 = right.prim_range			and
											left.predir  		 		 = right.predir					and
											left.prim_name  		 = right.prim_name			and
											left.addr_suffix  	 = right.addr_suffix		and
											left.postdir  		 	 = right.postdir				and
											left.unit_desig  		 = right.unit_desig			and
											left.sec_range  		 = right.sec_range			and											
											left.p_city_name  	 = right.p_city_name 		and
											left.st  		 				 = right.st 						and
											left.zip  	 				 = right.zip 						and
											left.zip4    				 = right.zip4 					and
											left.company_fein    = right.company_fein 	and
											left.fname  				 = right.fname 					and
											left.mname   				 = right.mname 				  and
											left.lname   				 = right.lname,									
											Xform(left,right),
											full only,
											local
											);	
	
	
	max_bdid      := 	max(pBaseFile,company_bdid);
	max_did				:=	max(pBaseFile,contact_did);
	
	layouts.base RollupUpdate(layouts.base l, layouts.base r) := transform
		self.dt_first_seen									:=	ut.EarliestDate(
																														ut.EarliestDate(l.dt_first_seen, r.dt_first_seen),
																														ut.EarliestDate(l.dt_last_seen,  r.dt_last_seen)
																														);
		self.dt_last_seen										:=	ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
		self.dt_vendor_first_reported				:=	ut.EarliestDate(
																														ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported),
																														ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported)
																														);
		self.dt_vendor_last_reported				:=	ut.LatestDate(l.dt_vendor_last_reported,r.dt_vendor_last_reported);		
		self.dt_first_seen_company_name			:=	ut.EarliestDate(
																														ut.EarliestDate(l.dt_first_seen_company_name, r.dt_first_seen_company_name),
																														ut.EarliestDate(l.dt_first_seen_company_name, r.dt_first_seen_company_name)
																														);
		self.dt_last_seen_company_name			:=	ut.LatestDate(l.dt_last_seen_company_name,r.dt_last_seen_company_name);
		self.dt_first_seen_company_address	:=	ut.EarliestDate(
																														ut.EarliestDate(l.dt_first_seen_company_address, r.dt_first_seen_company_address),
																														ut.EarliestDate(l.dt_first_seen_company_address, r.dt_first_seen_company_address)
																														);
		self.dt_last_seen_company_address		:=	ut.LatestDate(l.dt_last_seen_company_address,r.dt_last_seen_company_address);
		self.dt_first_seen_contact					:=	ut.EarliestDate(
																														ut.EarliestDate(l.dt_first_seen_contact, r.dt_first_seen_contact),
																														ut.EarliestDate(l.dt_first_seen_contact, r.dt_first_seen_contact)
																														);
		self.dt_last_seen_contact						:=	ut.LatestDate(l.dt_last_seen_contact,r.dt_last_seen_contact);
		self               									:=  l;
 	end;

	matched_file_rollup 			 := rollup(matched_file,RollupUpdate(left, right),
																	 company_name
																	,prim_range
																	,predir
																	,prim_name
																	,addr_suffix
																	,postdir
																	,unit_desig
																	,sec_range
																	,p_city_name
																	,st
																	,zip
																	,fname
																	,mname
																	,lname
																	,local
																	);

	return matched_file_rollup + non_matched_file;

end;
