#OPTION('multiplePersistInstances',FALSE);
import mdr,business_header,Equifax_Business_Data;

laybus := Business_Header.Layout_Business_Contact_Full_New;

export as_business_contact(

	 boolean 												pUsingInBizHdr		= true
	,boolean 												pUseOtherEnviron	= Equifax_Business_Data._Constants().IsDataland
	,dataset(Equifax_Business_Data.layouts.Base_contacts)	pDataset					= if(pUsingInBizHdr
																												,Equifax_Business_Data.files().base.contacts.BusinessHeader
																												,Equifax_Business_Data.files().base.contacts.qa
																											)
	,string1												pTodo							= 'R'	//'R' = recalculate persist,'P' = pull from persist(don't recalculate),'N' = Don't persist code
	,string													pPersistname			= Equifax_Business_Data.persistnames(									).AsBusinessContact
	,dataset(laybus								) pPersist 					= Equifax_Business_Data.persists		(pUseOtherEnviron	).AsBusinessContact
	
) :=
function

	equifax_contacts := pDataset;

	Business_Header.Layout_Business_Contact_Full_New Translate_Busfile_to_BCF(Equifax_Business_Data.layouts.Base_contacts l) := 
	TRANSFORM
	  self.did                  := l.did;
		self.vl_id 	 							:= L.efx_id;
		self.company_title 				:= stringlib.stringtouppercase(l.efx_titledesc);
		self.vendor_id 						:= L.efx_id; 
		self.source 							:= MDR.sourceTools.src_Equifax_Business_Data;
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
		self.company_source_group := l.efx_id;
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
		self.company_phone 				:= (unsigned6)l.clean_company_phone;
		self.company_fein 				:= 0;
		self.phone 								:= (unsigned6)l.clean_company_phone;
		self.email_address 				:= '';
		self.dt_first_seen 				:= l.dt_first_seen;
		self.dt_last_seen 				:= l.dt_last_seen;
		self.record_type 					:= l.record_type;
		self.title 								:= l.clean_name.title 			;
		self.fname 								:= l.clean_name.fname 			;
		self.mname 								:= l.clean_name.mname 			;
		self.lname 								:= l.clean_name.lname 			;
		self.name_suffix 					:= l.clean_name.name_suffix	;
		self.rawaid               := l.raw_aid;
		self.company_rawaid       := l.raw_aid;
		self 											:= l;
	end;

	equifax_contacts_init := project(equifax_contacts, Translate_Busfile_to_BCF(left));

	dasbh :=  equifax_contacts_init((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));

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
