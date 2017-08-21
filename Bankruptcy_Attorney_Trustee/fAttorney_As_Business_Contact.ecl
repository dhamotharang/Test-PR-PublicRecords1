import Business_Header, ut, address,mdr;

export fAttorney_As_Business_Contact (dataset(Layouts.layout_attorneys_out) pDataset) :=
function

 Business_Header.Layout_Business_Contact_Full_New Translate_to_BCF(pDataset L) := transform
	    company_name 							:= stringlib.StringToUpperCase(trim(L.Firm,left,right));
	    self.source 							:= mdr.sourceTools.src_Bankruptcy_Attorney;
			self.vl_id  							:= '';
			self.vendor_id  					:= (string) hash(L.FullName)  + hash(company_name);
			self.dt_first_seen 				:= (unsigned)L.date_first_seen;
			self.dt_last_seen 				:=  (unsigned)L.date_last_seen;
			self.city 								:= L.v_city_name;
			self.state 								:= L.st;
			self.county 							:= L.fips_county;
			self.zip 									:= (unsigned3)L.zip;
			self.zip4 								:= (unsigned2)L.zip4;
			self.phone 								:= (unsigned6)L.clean_phone;
			self.email_address 				:= L.Email;
			self.company_title 				:= '';
			self.company_source_group := (string) hash(company_name); // Source group
			self.company_name 				:= company_name;
			self.company_prim_range 	:= L.prim_range;
			self.company_predir 			:= L.predir;
			self.company_prim_name 		:= L.prim_name;
			self.company_addr_suffix 	:= L.addr_suffix;
			self.company_postdir 			:= L.postdir;
			self.company_unit_desig 	:= L.unit_desig;
			self.company_sec_range 		:= L.sec_range;
			self.company_city 				:= L.v_city_name;
			self.company_state 				:= L.st;
			self.company_zip 					:= (unsigned3)L.zip;
			self.company_zip4 				:= (unsigned2)L.zip4;
			self.company_phone 				:= (unsigned6)L.clean_phone;
			self.record_type 					:= if(L.active_flag = 'Y', 'C', 'H');          // Current/Historical indicator
			self 											:= l;
	end;

	dAsBusinessContact := project(pDataset(active_flag = 'Y' and lname <> '' and (unsigned)lname = 0 ), Translate_To_BCF(left));

	return dedup(sort(dAsBusinessContact,lname, fname, mname, company_name, prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, phone, email_address,-dt_last_seen),
	             lname, fname, mname, company_name,prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, phone, email_address);	

	
end;
	
	
