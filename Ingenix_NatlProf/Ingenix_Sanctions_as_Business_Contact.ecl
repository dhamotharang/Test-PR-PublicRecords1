#OPTION('multiplePersistInstances',FALSE);

IMPORT Business_Header, ut;
Ingsanc_contacts := Ingenix_NatlProf.File_Ingenix_Sanctions_DIDed_BDIDed;

//*************************************************************************
// Translate Contact from dca to Business Contact Format
//*************************************************************************

Business_Header.Layout_Business_Contact_Full Translate_ingsanc_to_BCF(Ingsanc_contacts l) := TRANSFORM
self.bdid := (unsigned6)l.bdid;
self.title := l.Prov_Clean_title;
self.fname := l.Prov_Clean_fname;
self.mname := l.Prov_Clean_mname;
self.lname := l.Prov_Clean_lname;
self.name_suffix := l.Prov_Clean_name_suffix;
self.company_title := ''; 
self.vendor_id := L.sanc_id;
self.source := 'IP';
self.name_score := Business_Header.CleanName(l.Prov_Clean_fname,l.Prov_Clean_mname,l.Prov_Clean_lname, l.Prov_Clean_name_suffix)[142]														;
//#####################################

	self.prim_range										:= l.ProvCo_Address_Clean_prim_range;
	self.predir											  := l.ProvCo_Address_Clean_predir;
	self.prim_name										:= l.ProvCo_Address_Clean_prim_name;
	self.addr_suffix									:= l.ProvCo_Address_Clean_addr_suffix;
	self.postdir										  := l.ProvCo_Address_Clean_postdir;
	self.unit_desig										:= l.ProvCo_Address_Clean_unit_desig;
	self.sec_range										:= l.ProvCo_Address_Clean_sec_range;
	self.city											    := l.ProvCo_Address_Clean_p_city_name;
	self.state										  	:= l.ProvCo_Address_Clean_st;
	self.zip 											    := (unsigned3)l.ProvCo_Address_Clean_zip;
	self.zip4											    := (unsigned2)l.ProvCo_Address_Clean_zip4;
	self.county										  	:= l.ProvCo_Address_Clean_fipscounty;
	self.msa										    	:= l.ProvCo_Address_Clean_msa;
	self.geo_lat									  	:= l.ProvCo_Address_Clean_geo_lat;
	self.geo_long										  := l.ProvCo_Address_Clean_geo_long;

self.phone										  := 0			;
self.email_address							:= ''																				;
self.ssn												:= (unsigned4)l.sanc_tin																;
self.company_source_group				:= l.sanc_id																;
self.company_name								:= l.sanc_busnme														;
self.company_prim_range					:= l.ProvCo_Address_Clean_prim_range			;
self.company_predir							:= l.ProvCo_Address_Clean_predir					;
self.company_prim_name					:= l.ProvCo_Address_Clean_prim_name				;
self.company_addr_suffix				:= l.ProvCo_Address_Clean_addr_suffix			;
self.company_postdir						:= l.ProvCo_Address_Clean_postdir					;
self.company_unit_desig					:= l.ProvCo_Address_Clean_unit_desig			;
self.company_sec_range	 				:= l.ProvCo_Address_Clean_sec_range				;
self.company_city								:= l.ProvCo_Address_Clean_p_city_name			;
self.company_state							:= l.ProvCo_Address_Clean_st	 						;
self.company_zip								:= (unsigned3)l.ProvCo_Address_Clean_zip	;
self.company_zip4								:= (unsigned2)l.ProvCo_Address_Clean_zip4	;
self.company_phone							:= 0																			;
self.company_fein								:= 0																			;

  SELF.dt_first_seen := (unsigned4)l.date_first_seen;
  SELF.dt_last_seen  := (unsigned4) l.date_last_seen;
	self.record_type := 'C';
	self.did := (unsigned6)l.did;
end;

//--------------------------------------------
// Normalize names
//--------------------------------------------
from_ingsanc_out := Project(Ingsanc_contacts,Translate_ingsanc_to_BCF(left));

// Removed extra contacts with blank addresses
from_ingsanc_dist := distribute(from_ingsanc_out, hash(trim(vendor_id), trim(company_name)));

from_ingsanc_sort := sort(from_ingsanc_dist, vendor_id, company_name,
                     fname, mname, lname, name_suffix, company_title, phone, if(zip <> 0, 0, 1), zip, prim_name, prim_range, 
										 local);

from_ingsanc_dedup := dedup(from_ingsanc_sort,
               left.vendor_id = right.vendor_id and
							 left.company_name = right.company_name and
							 left.fname= right.fname and
							 left.mname = right.mname and
							 left.lname = right.lname and
							 left.name_suffix = right.name_suffix and
							 left.company_title = right.company_title and
							 ((left.zip = right.zip and
							 left.prim_name = right.prim_name and
							 left.prim_range = right.prim_range) or
               (left.zip <> 0 and right.zip = 0)),
							 local);

export Ingenix_Sanctions_as_Business_Contact := from_ingsanc_dedup((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix)) : persist('~thor_dataland_linux::TEMP::Ingenix_Sanctions_Contacts_As_BC');