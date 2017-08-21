#OPTION('multiplePersistInstances',FALSE);
import mdr,business_header;

laybus := Business_Header.Layout_Business_Contact_Full_New;

export as_business_contact(

	 boolean 												pUsingInBizHdr		= true
	,boolean 												pUseOtherEnviron	= _Constants().IsDataland
	,dataset(layouts.Base.contacts)	pDataset					= if(pUsingInBizHdr
																												,files(,pUseOtherEnviron).base.contacts.BusinessHeader
																												,files(,pUseOtherEnviron).base.contacts.qa
																											)
	,string1												pTodo							= 'R'	//'R' = recalculate persist,'P' = pull from persist(don't recalculate),'N' = Don't persist code
	,string													pPersistname			= persistnames(									).AsBusinessContact
	,dataset(laybus								) pPersist 					= persists		(pUseOtherEnviron	).AsBusinessContact
	
) :=
function

	dnb_contacts := pDataset;

	Business_Header.Layout_Business_Contact_Full_New Translate_Busfile_to_BCF(layouts.Base.contacts l) := 
	TRANSFORM
		self.vl_id 	 							:= L.duns_number;
		self.company_title 				:= stringlib.stringtouppercase(l.rawfields.exec_vanity_title);
		self.vendor_id 						:= IF(L.active_duns_number = 'Y', L.duns_number, 'D' + L.duns_number + '-' + stringlib.stringtouppercase(L.company_name));
		self.source 							:= MDR.sourceTools.src_Dunn_Bradstreet;
		self.name_score 					:= Business_Header.CleanName(l.clean_name.fname,l.clean_name.mname,l.clean_name.lname, l.clean_name.name_suffix)[142];
		self.prim_range 					:= l.clean_company_address.prim_range;
		self.predir 							:= l.clean_company_address.predir;
		self.prim_name 						:= l.clean_company_address.prim_name;
		self.addr_suffix 					:= l.clean_company_address.addr_suffix;
		self.postdir 							:= l.clean_company_address.postdir;
		self.unit_desig 					:= l.clean_company_address.unit_desig;
		self.sec_range 						:= l.clean_company_address.sec_range;
		self.city 								:= l.clean_company_address.v_city_name;
		self.state 								:= l.clean_company_address.st;
		self.zip 									:= (unsigned3)l.clean_company_address.zip;
		self.zip4 								:= (unsigned2)l.clean_company_address.zip4;
		self.county 							:= l.clean_company_address.fips_county;
		self.msa 									:= l.clean_company_address.msa;
		self.geo_lat 							:= l.clean_company_address.geo_lat;
		self.geo_long 						:= l.clean_company_address.geo_long;
		self.company_name 				:= l.company_name;
		self.company_source_group := IF(L.active_duns_number = 'Y', L.duns_number, 'D' + L.duns_number + '-' + stringlib.stringtouppercase(L.company_name));
		self.company_prim_range 	:= l.clean_company_address.prim_range;
		self.company_predir 			:= l.clean_company_address.predir;
		self.company_prim_name 		:= l.clean_company_address.prim_name;
		self.company_addr_suffix 	:= l.clean_company_address.addr_suffix;
		self.company_postdir 			:= l.clean_company_address.postdir;
		self.company_unit_desig 	:= l.clean_company_address.unit_desig;
		self.company_sec_range 		:= l.clean_company_address.sec_range;
		self.company_city 				:= l.clean_company_address.v_city_name;
		self.company_state 				:= l.clean_company_address.st;
		self.company_zip 					:= (unsigned3)l.clean_company_address.zip;
		self.company_zip4 				:= (unsigned2)l.clean_company_address.zip4;
		self.company_phone 				:= (unsigned6)((unsigned8)l.company_phone10);
		self.company_fein 				:= 0;
		self.phone 								:= (unsigned6)((unsigned8)l.company_phone10);
		self.email_address 				:= '';
		self.dt_first_seen 				:= l.date_first_seen;
		self.dt_last_seen 				:= l.date_last_seen;
		self.record_type 					:= utilities.RT2CurrentHistoricalFlag(l.record_type);
		self.title 								:= l.clean_name.title 			;
		self.fname 								:= l.clean_name.fname 			;
		self.mname 								:= l.clean_name.mname 			;
		self.lname 								:= l.clean_name.lname 			;
		self.name_suffix 					:= l.clean_name.name_suffix	;
		self.rawaid               := l.rawaid;
		self.company_rawaid       := l.rawaid;

		self 											:= l;
	end;

	dnb_contacts_init := project(dnb_contacts, Translate_Busfile_to_BCF(left));

	dasbh :=  dnb_contacts_init((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));

	dasbh_persisted := dasbh : persist(pPersistname);
	dasbh_persist		:= pPersist;
	
	decision := map(
		 pTodo = 'R' => dasbh_persisted
		,pTodo = 'P' => dasbh_persist
		,pTodo = 'N' => dasbh
		,								dasbh_persisted
	);

	return decision;

end;
