import business_header, ut,mdr;

export fWatercraft_as_Business_Contact(dataset(Layout_Watercraft_Search_Base) pWatercraft_Search, boolean IsPRCT = false)
 :=
  function

	dWatercraftSearch	:=	pWatercraft_Search;

	rLayoutBusinessContactFullWithType
	 :=
	  record
		business_header.Layout_Business_Contact_Full_New;
		string1	temp_name_type_code	:=	'';
	  end
	 ;

	rLayoutBusinessContactFullWithType tWatercraftAsBusinessContact(dWatercraftSearch pInput)
	 :=
	  transform
		self.source 					:=	MDR.sourceTools.fWatercraft(pInput.source_code, pInput.state_origin);	
		self.dppa						:=	pInput.state_origin in Watercraft.sDPPA_Restricted_Watercraft_States;
		self.dt_first_seen 				:=	if((unsigned)pInput.date_first_seen < 300000, (unsigned)pInput.date_first_seen * 100, (unsigned)pInput.date_first_seen);
		self.dt_last_seen 				:=	if((unsigned)pInput.date_last_seen < 300000, (unsigned)pInput.date_last_seen * 100, (unsigned)pInput.date_last_seen);
		self.prim_range					:=	pInput.prim_range;
		self.predir						:=	pInput.predir;
		self.prim_name					:=	pInput.prim_name;
		self.addr_suffix				:=	pInput.suffix;
		self.postdir					:=	pInput.postdir;
		self.unit_desig					:=	pInput.unit_desig;
		self.sec_range					:=	pInput.sec_range;
		self.city						:=	pInput.v_city_name;
		self.state						:=	pInput.st;
		self.zip						:=	(unsigned)pInput.zip5;
		self.zip4						:=	(unsigned)pInput.zip4;
		self.county						:=	pInput.county;
		self.msa						:=	pInput.msa;
		self.geo_lat					:=	pInput.geo_lat;
		self.geo_long					:=	pInput.geo_long;
		self.record_type				:=	if(pInput.history_flag = '','C','H');
		self.phone						:=	(unsigned8)pInput.phone_1;
		self.email_address				:=	'';
		self.ssn						:=	(unsigned8)pInput.orig_SSN;
		self.title						:=	pInput.title;
		self.fname 						:=	pInput.fname;
		self.mname						:=	pInput.mname;
		self.lname						:=	pInput.lname;
		self.name_suffix				:=	pInput.name_suffix;
		self.name_score					:=	business_header.CleanName(self.fname,self.mname,self.lname,self.name_suffix)[142];
		self.vl_id					    :=	pInput.state_origin + trim(pInput.watercraft_key,left,right) + trim(pInput.sequence_key,left,right);
		self.vendor_id					:=	pInput.state_origin + trim(pInput.watercraft_key,left,right) + trim(pInput.sequence_key,left,right);
		self.company_title				:=	'';
		self.company_department			:=	'';
		self.company_source_group		:=	''; // Source group
		self.company_name				:=	pInput.company_name;
		self.company_prim_range			:=	self.prim_range;
		self.company_predir				:=	self.predir;
		self.company_prim_name			:=	self.prim_name;
		self.company_addr_suffix		:=	self.addr_suffix;
		self.company_postdir			:=	self.postdir;
		self.company_unit_desig			:=	self.unit_desig;
		self.company_sec_range			:=	self.sec_range;
		self.company_city				:=	self.city;
		self.company_state				:=	self.state;
		self.company_zip				:=	self.zip;
		self.company_zip4				:=	self.zip4;
		self.company_phone				:=	(unsigned8)pInput.phone_1;
		self.company_fein				:=	(unsigned8)pInput.orig_fein;
		self.bdid						:=	(unsigned8)pInput.bdid;
		SELF.DID						:= If(IsPRCT,(unsigned6)pInput.did,0);
		self.temp_name_type_code		:=	pInput.orig_name_type_code;
	  end
	 ;

	dWatercraftAsBusCon				:=	project(dWatercraftSearch,tWatercraftAsBusinessContact(left));
	dWatercraftAsBusConDist			:=	distribute(dWatercraftAsBusCon,hash(vendor_id));
	dWatercraftAsBusConPersons		:=	dWatercraftAsBusConDist(lname != '', company_name = '', (integer)name_score < 3);
	dWatercraftAsBusConCompanies	:=	dWatercraftAsBusConDist(company_name != '' and company_name[01..09] != 'VAULT NOM' and company_name[01..16] != 'VAULT AS NOMINEE');

	business_header.Layout_Business_Contact_Full_New tGetMatchingCompany(dWatercraftAsBusConPersons pPerson, dWatercraftAsBusConCompanies pCompany)
	 :=
	  transform
		self.company_name			:=	pCompany.company_name;
		self.company_prim_range		:=	pCompany.company_prim_range;
		self.company_predir			:=	pCompany.company_predir;
		self.company_prim_name		:=	pCompany.company_prim_name;
		self.company_addr_suffix	:=	pCompany.company_addr_suffix;
		self.company_postdir		:=	pCompany.company_postdir;
		self.company_unit_desig		:=	pCompany.company_unit_desig;
		self.company_sec_range		:=	pCompany.company_sec_range;
		self.company_city			:=	pCompany.company_city;
		self.company_state			:=	pCompany.company_state;
		self.company_zip			:=	pCompany.company_zip;
		self.company_zip4			:=	pCompany.company_zip4;
		self						:=	pPerson;
	  end
	 ;

	dContactsWithMatchingCompany	:=	join(dWatercraftAsBusConPersons,dWatercraftAsBusConCompanies,
											 left.vendor_id 			= right.vendor_id
										 and left.temp_name_type_code 	= right.temp_name_type_code,
											 tGetMatchingCompany(left,right),
											 local
											);

	dContactsOnlySort				:=	sort(dContactsWithMatchingCompany,vendor_id,lname,company_name,local);
	dContactsOnlyDedup				:=	dedup(dContactsOnlySort,vendor_id,lname,company_name,local);


	// match on vendor id to as bus header file to make sure these contacts have a company record
	// that made it to business headers
	asbus := watercraft.fWatercraft_as_Business_Header(pWatercraft_Search);

	business_header.Layout_Business_Contact_Full_New matchtoasbus(dContactsOnlyDedup L, asbus R) := transform
	self.vendor_id := R.vendor_id;
	self := L;
	end;

	dContactsWithMatchingAsBus	:=	join(dContactsOnlyDedup,asbus,
						left.company_zip = right.zip and
						  left.company_prim_name = right.prim_name and
						  left.company_prim_range = right.prim_range and
						  left.company_source_group = right.source_group and
						  left.company_name = right.company_name and
						  (right.sec_range = '' or left.company_sec_range = right.sec_range) and
						  (right.phone = 0 or left.company_phone = right.phone) and
						  (right.fein = 0 or left.company_fein = right.fein),
											 matchtoasbus(left,right),
											 local
											);

	return dContactsWithMatchingAsBus((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));

  end
 ;
