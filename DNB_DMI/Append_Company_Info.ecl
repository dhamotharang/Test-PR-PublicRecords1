export Append_Company_Info(
	
	 dataset(Layouts.Base.contacts	)	pBaseContactsFile						
	,dataset(Layouts.Base.CompaniesForBIP2	)	pBaseCompaniesFile						

) :=
function

	dnb_companies 			:= pBaseCompaniesFile;
	dnb_companies_dist 	:= distribute(dnb_companies			,hash64(rawfields.duns_number	));
	dnb_contacts_dist 	:= distribute(pBaseContactsFile	,hash64(duns_number						));

	Layouts.temporary.AppendCompanyInfo AddCompanyInfo(Layouts.Base.contacts l, Layouts.Base.CompaniesForBIP2 r) :=
	transform
		self.did											:= 0;
		self.bdid											:= 0;  // Setting of BDID is done later
		self.company_name 						:= if(r.rawfields.trade_style = '' or (r.rawfields.trade_style <> '' and r.rawfields.parent_duns_number = '' and r.rawfields.ultimate_duns_number = '')
																			,r.rawfields.business_name
																			,r.rawfields.trade_style
																		);
		self.clean_company_address		:= r.clean_address;
		self.company_phone10 					:= r.rawfields.telephone_number;
		self.record_type 							:= if(r.record_type = utilities.RecordType.Deleted	,r.record_type	,l.record_type);	//if delete record came in and deleted this duns, contact is also deleted
		self.company_record_type 			:= r.record_type;
		self.active_duns_number				:= r.active_duns_number;
		self.rawaid										:= r.rawaid;
		self.aceaid										:= r.aceaid;
		self.company_date_first_seen	:= r.date_first_seen;
		self.company_date_last_seen		:= r.date_last_seen;
		self													:= l;
	end;

	//Get all company records that are in the valid date range window, then select best one after join
	dnb_contacts_getcompanyinfo := join(
														 dnb_contacts_dist
														,dnb_companies_dist
														,			left.duns_number = right.rawfields.duns_number
														 and utilities.ValidDateRange(
																							left.date_first_seen
																						 ,left.date_last_seen	
																						 ,right.date_first_seen
																						 ,right.date_last_seen
																)
														,AddCompanyInfo(left,right)
														,left outer
														,local
											);

	//select best record based on latest one per rid, because there can be multiple matches within the date window
	ddnb_contacts_dist	:= distribute	(dnb_contacts_getcompanyinfo	,rid);
	ddnb_contacts_sort	:= sort				(ddnb_contacts_dist						,rid,-company_date_last_seen,local);
	ddnb_contacts_dedup	:= dedup			(ddnb_contacts_sort						,rid,local);
	ddnb_contacts_proj	:= project(ddnb_contacts_dedup,Layouts.Base.contacts);
	
	//Propagate record type flags based on duns number
	ddnb_contacts_dist2	:= distribute	(ddnb_contacts_proj	,hash64(duns_number));
	dnb_contacts_sort2 	:= sort				(ddnb_contacts_dist2	,duns_number,-date_last_seen	,local);
	dnb_contacts_group2	:= group			(dnb_contacts_sort2		,duns_number,local);
	
	dPropagateDeletes := iterate(dnb_contacts_group2	,transform(Layouts.Base.contacts,
		self.company_record_type 		:= if(		 left.company_record_type		= utilities.RecordType.Deleted
																				or right.company_record_type	= utilities.RecordType.Deleted
																						,utilities.RecordType.Deleted
																						,right.company_record_type
																		);
		self.active_duns_number			:= if(		 left.active_duns_number	= 'N'
																				or right.active_duns_number	= 'N'
																						,'N'
																						,right.active_duns_number
																		);
		self.record_type 						:= if(		 left.record_type		= utilities.RecordType.Deleted
																				or right.record_type	= utilities.RecordType.Deleted
																						,utilities.RecordType.Deleted
																						,right.record_type
																		);
		self												:= right;
	));

	return group(dPropagateDeletes);

end;