import Business_Header, Lib_StringLib;

rLayoutBusinessContactFullWithSourceCode
 :=
  record
	business_header.Layout_Business_Contact_Full;
	string2		temp_source_code;
  end
 ;

rLayoutBusinessContactFullWithSourceCode tAsBusinessContact(LN_Property.LN_Property_as_Business_Prep pInput)
 :=
  transform
	self.source 					:=	'LP';
	self.dppa						:=	false;
	self.dt_first_seen				:=	pInput.dt_first_seen;
	self.dt_last_seen				:=	pInput.dt_last_seen;
	self.prim_range					:=	pInput.prim_range;
	self.predir						:=	pInput.predir;
	self.prim_name					:=	pInput.prim_name;
	self.addr_suffix				:=	pInput.addr_suffix;
	self.postdir					:=	pInput.postdir;
	self.unit_desig					:=	pInput.unit_desig;
	self.sec_range					:=	pInput.sec_range;
	self.city						:=	pInput.city;
	self.state						:=	pInput.state;
	self.zip						:=	pInput.zip;
	self.zip4						:=	pInput.zip4;
	self.county						:=	pInput.county;
	self.msa						:=	pInput.msa;
	self.geo_lat					:=	pInput.geo_lat;
	self.geo_long					:=	pInput.geo_long;
	self.record_type				:=	'C';				// All current at this point
	self.phone						:=	pInput.phone;
	self.email_address				:=	'';
	self.ssn						:=	0;
	self.title						:=	pInput.title;
	self.fname 						:=	pInput.fname;
	self.mname						:=	pInput.mname;
	self.lname						:=	pInput.lname;
	self.name_suffix				:=	pInput.name_suffix;
	self.name_score					:=	business_header.CleanName(self.fname,self.mname,self.lname,self.name_suffix)[142];
	self.vendor_id					:=	pInput.vendor_id;
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
	self.company_phone				:=	pInput.phone;
	self.company_fein				:=	pInput.fein;
	self.bdid						:=	pInput.bdid;
	self.temp_source_code			:=	pInput.source_code;
  end
 ;

dPropertyPrepNoPartialOwnership		:=	LN_Property.LN_Property_as_Business_Prep(lib_stringlib.StringLib.StringFilterOut(partial_interest_transferred,' 0') = '');
dPropertyPreoDist					:=	distribute(dPropertyPrepNoPartialOwnership,hash(vendor_id));
dPropertyPrepCompanyOnly			:=	dPropertyPreoDist(company_name <> '');
dPropertyPrepPersonOnly				:=	dPropertyPreoDist(company_name = '' and lname <> '' and fname <> '');
dPropertyPrepCompanyAsBusContact	:=	project(dPropertyPrepCompanyOnly,tAsBusinessContact(left));
dPropertyPrepPersonAsBusContact		:=	project(dPropertyPrepPersonOnly,tAsBusinessContact(left));

Business_Header.Layout_Business_Contact_Full tGetMatchingCompany(dPropertyPrepPersonAsBusContact pPerson, dPropertyPrepCompanyAsBusContact pCompany)
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

dContactsWithMatchingCompany	:=	join(dPropertyPrepPersonAsBusContact,dPropertyPrepCompanyAsBusContact,
										 left.vendor_id 			= right.vendor_id
									 and left.temp_source_code		= right.temp_source_code,	// should be S=S, O=O, B=B only
										 tGetMatchingCompany(left,right),
										 local
										);

dContactsOnlySort				:=	sort(dContactsWithMatchingCompany,vendor_id,lname,company_name,local);
dContactsOnlyDedup				:=	dedup(dContactsOnlySort,vendor_id,lname,company_name,local);

// match on vendor id to as bus header file to make sure these contacts have a company record
// that made it to business headers
asbus := ln_property.LN_Property_as_Business_Header;

business_header.Layout_Business_Contact_Full matchtoasbus(dContactsOnlyDedup L, asbus R) := transform
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

export LN_Property_as_Business_Contact
 :=	dContactsWithMatchingAsBus((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix))
	: persist(business_header._dataset().thor_cluster_Persists +  'persist::LN_Property::LN_Property_as_Business_Contact')
 ;
