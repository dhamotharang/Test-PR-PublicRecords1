import Business_Header, ut,address,mdr;

export fAMS_As_Business_Contact(
	 dataset(Layouts.Base.Main) pDatasetMain
	,dataset(Layouts.Base.Affiliation) pDatasetAffiliation) :=
function

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- First, use associations to connect people to businesses
	//////////////////////////////////////////////////////////////////////////////////////////////
	// Join the association file to the parent
	parent_records :=
		join(
			pDatasetMain,
			pDatasetAffiliation,
			left.AMS_ID = right.AMS_PARENT_ID,
			transform({recordof(pDatasetAffiliation);recordof(pDatasetMain) parentInfo;},
				self.parentInfo := left,
				self := right));
	// Join the association file to the child
	child_records :=
		join(
			pDatasetMain,
			parent_records,
			left.AMS_ID = right.AMS_CHILD_ID,
			transform({recordof(parent_records);recordof(pDatasetMain) childInfo;},
				self.childInfo := left,
				self := right));
	// Eliminate any that are business-to-business or person-to-person
	filter_down := child_records(
		(parentInfo.rawdemographicsfields.FULL_NAME != '' and childInfo.rawdemographicsfields.ACCT_NAME != '') or
		(parentInfo.rawdemographicsfields.ACCT_NAME != '' and childInfo.rawdemographicsfields.FULL_NAME != ''));
	
	layout_BH_contact 	:= Business_Header.Layout_Business_Contact_Full_New;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to Business Contact Layout
	//////////////////////////////////////////////////////////////////////////////////////////////
	layout_BH_contact tAsBusinessContact(filter_down l, unsigned2 cnt) :=
	transform
		businessParent := l.parentInfo.rawdemographicsfields.ACCT_NAME != '';
		
		phone := map(
			    businessParent and cnt % 2 = 1 and l.childInfo .clean_phones.Phone != '' => l.childInfo .clean_phones.Phone,
			    businessParent and cnt % 2 = 0 and l.childInfo .clean_phones.Fax   != '' => l.childInfo .clean_phones.Fax,
			not businessParent and cnt % 2 = 1 and l.parentInfo.clean_phones.Phone != '' => l.parentInfo.clean_phones.Phone,
			not businessParent and cnt % 2 = 0 and l.parentInfo.clean_phones.Fax   != '' => l.parentInfo.clean_phones.Fax,
			'');
		cphone := map(
			    businessParent and (cnt + 1) div 2 = 1 and l.parentInfo.clean_phones.Phone != '' => l.parentInfo.clean_phones.Phone,
			    businessParent and (cnt + 1) div 2 = 2 and l.parentInfo.clean_phones.Fax   != '' => l.parentInfo.clean_phones.Fax,
			not businessParent and (cnt + 1) div 2 = 1 and l.childInfo .clean_phones.Phone != '' => l.childInfo .clean_phones.Phone,
			not businessParent and (cnt + 1) div 2 = 2 and l.childInfo .clean_phones.Fax   != '' => l.childInfo .clean_phones.Fax,
			'');
		self.source 							:=	mdr.sourceTools.src_AMS;
		self.dppa									:=	false;
		self.dt_first_seen 				:=	max(l.dt_first_seen,l.parentInfo.dt_first_seen,l.childInfo.dt_first_seen),
		self.dt_last_seen 				:=	min(l.dt_last_seen ,l.parentInfo.dt_last_seen ,l.childInfo.dt_last_seen ),
		self.record_type					:=	map(
			l.record_type = 'C' and l.parentInfo.record_type = 'C' and l.childInfo.record_type = 'C' => 'C',
			/*otherwise*/                                                                               'H'),
		self.phone								:=	(unsigned6)phone;
		self.email_address				:=	if(businessParent,l.childInfo.rawaddressfields.email,l.parentInfo.rawaddressfields.email),
		self.ssn									:=	0; // TODO: SEE IF WE HAVE SSN
		self                      :=  if(businessParent,l.childInfo.clean_name,l.parentInfo.clean_name);
		person_address := if(businessParent,l.childInfo.clean_company_address,l.parentInfo.clean_company_address);
		self.city                 :=  person_address.p_city_name;
		self.state                :=  person_address.st;
		self.zip                  :=  (unsigned)person_address.zip;
		self.zip4                 :=  (unsigned)person_address.zip4;
		self.county               :=  person_address.fips_county;
		self                      :=  person_address;
		self.vl_id						    :=	if(businessParent,l.parentInfo.AMS_ID,l.childInfo.AMS_ID);
		self.vendor_id						:=	if(businessParent,l.parentInfo.AMS_ID,l.childInfo.AMS_ID);
		self.company_title				:=	'';
		self.company_department		:=	'';
		self.company_source_group	:=	if(businessParent,l.parentInfo.AMS_ID,l.childInfo.AMS_ID);
		self.company_name					:=	if(businessParent,l.parentInfo.rawdemographicsfields.ACCT_NAME,l.childInfo.rawdemographicsfields.ACCT_NAME);
		company_address := if(businessParent,l.parentInfo.clean_company_address,l.childInfo.clean_company_address);
		self.company_prim_range		:=	company_address.prim_range;
		self.company_predir				:=	company_address.predir;
		self.company_prim_name		:=	company_address.prim_name;
		self.company_addr_suffix	:=	company_address.addr_suffix;
		self.company_postdir			:=	company_address.postdir;
		self.company_unit_desig		:=	company_address.unit_desig;
		self.company_sec_range		:=	company_address.sec_range;
		self.company_city					:=	company_address.p_city_name;
		self.company_state				:=	company_address.st;
		self.company_zip					:=	(unsigned)company_address.zip;
		self.company_zip4					:=	(unsigned)company_address.zip4;
		self.company_phone				:=	(unsigned6)cphone;
		self.company_fein					:=	(unsigned)if(businessParent,l.parentInfo.rawdemographicsfields.tax_id,l.childInfo.rawdemographicsfields.tax_id);
		self.bdid									:=	0;
		self.name_score           :=  '0';
    self.rawaid               :=  if(businessParent,l.parentInfo.rawaddressfields.raw_aid,l.childInfo.rawaddressfields.raw_aid);
	end;

	dAsBusinessHeader	:= normalize(
													 filter_down
													,4
													,tAsBusinessContact(left,counter)
													);

	dAsBusinessHeaderFiltered := dAsBusinessHeader((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix),(vendor_id != ''));
	dAsBusinessHeaderSorted 	:= sort(dAsBusinessHeaderFiltered, vl_id, fname, lname, mname, name_suffix, company_source_group, prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, company_name, company_title, phone, company_phone, email_address, -dt_last_seen);
	dAsBusinessHeaderdedup  	:= dedup(dAsBusinessHeaderSorted,  vl_id, fname, lname, mname, name_suffix, company_source_group, prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, company_name, company_title, phone, company_phone, email_address);
	
	return	dAsBusinessHeaderdedup;	

end;