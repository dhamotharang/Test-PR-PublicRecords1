import Business_Header, ut,address,mdr;

export fZoom_As_Business_Contact(dataset(layouts.base) pDataset) :=
function

	layout_BH_contact 	:= Business_Header.Layout_Business_Contact_Full_New;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to Business Contact Layout
	//////////////////////////////////////////////////////////////////////////////////////////////
	layout_BH_contact tAsBusinessContact(layouts.base l, unsigned2 cnt) :=
	transform
		phone := map(cnt = 1 and l.clean_phones.Phone					!= '' =>	l.clean_phones.Phone
								,cnt = 2 and l.clean_phones.Company_Phone != '' =>	l.clean_phones.Company_Phone
								,cnt = 1 and l.clean_phones.Phone				   = '' =>	l.clean_phones.Company_Phone
								,																										l.clean_phones.Phone
					);

		cphone :=map(cnt = 1 and l.clean_phones.Phone					!= '' =>	l.clean_phones.Phone
								,cnt = 2 and l.clean_phones.Company_Phone != '' =>	l.clean_phones.Phone
								,cnt = 1 and l.clean_phones.Phone				   = '' =>	l.clean_phones.Company_Phone
								,																										l.clean_phones.Company_Phone
					);
					
		self.source 							:=	mdr.sourceTools.src_ZOOM;
		self.dppa									:=	false;
		self.dt_first_seen 				:=	l.dt_first_seen;
		self.dt_last_seen 				:=	l.dt_last_seen;
		self.prim_range						:=	l.Clean_company_address.prim_range;
		self.predir								:=	l.Clean_company_address.predir;
		self.prim_name						:=	l.Clean_company_address.prim_name;
		self.addr_suffix					:=	l.Clean_company_address.addr_suffix;
		self.postdir							:=	l.Clean_company_address.postdir;
		self.unit_desig						:=	l.Clean_company_address.unit_desig;
		self.sec_range						:=	l.Clean_company_address.sec_range;
		self.city									:=	l.Clean_company_address.v_city_name;
		self.state								:=	l.Clean_company_address.st;
		self.zip									:=	(unsigned)l.Clean_company_address.zip;
		self.zip4									:=	(unsigned)l.Clean_company_address.zip4;
		self.county								:=	l.Clean_company_address.fips_county;
		self.msa									:=	l.Clean_company_address.msa;
		self.geo_lat							:=	l.Clean_company_address.geo_lat;
		self.geo_long							:=	l.Clean_company_address.geo_long;
		self.record_type					:=	l.record_type;
		self.phone								:=	(unsigned6)phone;
		self.email_address				:=	l.rawfields.Email_Address;
		self.ssn									:=	0;
		self.title								:=	l.clean_contact_name.title;
		self.fname 								:=	l.clean_contact_name.fname;
		self.mname								:=	l.clean_contact_name.mname;
		self.lname								:=	l.clean_contact_name.lname;
		self.name_suffix					:=	l.clean_contact_name.name_suffix;
		self.name_score						:=	Business_Header.CleanName(self.fname,self.mname,self.lname,self.name_suffix)[142];
		self.vl_id						    :=	l.rawfields.zoomid;
		self.vendor_id						:=	if(l.rawfields.zoom_company_id <> '', l.rawfields.zoomid + 'C' + l.rawfields.zoom_company_id,
		                                 l.rawfields.zoomid);
		self.company_title				:=	l.rawfields.Job_Title;
		self.company_department		:=	'';
		self.company_source_group	:=	l.rawfields.zoom_company_id;
		self.company_name					:=	l.rawfields.COMPANY_NAME;
		self.company_prim_range		:=	self.prim_range;
		self.company_predir				:=	self.predir;
		self.company_prim_name		:=	self.prim_name;
		self.company_addr_suffix	:=	self.addr_suffix;
		self.company_postdir			:=	self.postdir;
		self.company_unit_desig		:=	self.unit_desig;
		self.company_sec_range		:=	self.sec_range;
		self.company_city					:=	self.city;
		self.company_state				:=	self.state;
		self.company_zip					:=	self.zip;
		self.company_zip4					:=	self.zip4;
		self.company_phone				:=	(unsigned8)cphone;
		self.company_fein					:=	0;
		self.bdid									:=	0;
	end;

	choosey(string pPhone, string pCompany_Phone) := 
		map(			pPhone					!= ''
					and pCompany_Phone	!= '' => 4, 1);
									
	dAsBusinessHeader	:= normalize(
													 pDataset
													,choosey(left.clean_phones.Phone, left.clean_phones.Company_Phone)
													,tAsBusinessContact(left,counter)
													);

	dAsBusinessHeaderFiltered := dAsBusinessHeader((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix),(vendor_id != ''));
	dAsBusinessHeaderSorted 	:= sort(dAsBusinessHeaderFiltered, vl_id, fname, lname, mname, name_suffix, company_source_group, prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, company_name, company_title, phone, company_phone, email_address, -dt_last_seen);
	dAsBusinessHeaderdedup  	:= dedup(dAsBusinessHeaderSorted,  vl_id, fname, lname, mname, name_suffix, company_source_group, prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, company_name, company_title, phone, company_phone, email_address);
	
	return	dAsBusinessHeaderdedup;	

end;