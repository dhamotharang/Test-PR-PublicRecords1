IMPORT Business_Header, ut,mdr;

export fAttorney_As_Business_Header(dataset(Layouts.layout_attorneys_out) pDataset) :=
function

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH format
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout tAsBusinessHeader(pDataset L) := 
	transform
		company_name := stringlib.StringToUpperCase(trim(L.Firm,left,right));
		SELF.group1_id 								:= 0;
		SELF.vl_id 								    := '';
		SELF.vendor_id 								:= (string) hash(L.FullName)  + hash(company_name);
		SELF.phone 										:= (unsigned)L.clean_phone;
		SELF.phone_score 							:= IF((unsigned6)l.clean_phone = 0, 0, 1);
		SELF.source 									:= mdr.sourceTools.src_Bankruptcy_Attorney;
		SELF.source_group 						:= (string) hash(company_name);
		SELF.company_name 						:= company_name;
		SELF.dt_first_seen 						:= (unsigned)l.date_first_seen;
		SELF.dt_last_seen 						:= (unsigned)l.date_last_seen;
		SELF.dt_vendor_first_reported	:= (unsigned)L.date_vendor_first_reported;
		SELF.dt_vendor_last_reported	:= (unsigned)L.date_vendor_last_reported;
		SELF.fein 										:= 0;
		SELF.current 									:= if(L.active_flag = 'Y', true, false);
		SELF.prim_range 							:= L.prim_range;
		SELF.predir 									:= L.predir;
		SELF.prim_name 								:= L.prim_name;
		SELF.addr_suffix 							:= L.addr_suffix;
		SELF.postdir 									:= L.postdir;
		SELF.unit_desig 							:= L.unit_desig;
		SELF.sec_range 								:= L.sec_range;
		SELF.city 										:= L.v_city_name;
		SELF.state 										:= L.st;
		SELF.zip 											:= (unsigned)L.zip;
		SELF.zip4 										:= (unsigned)L.zip4;
		SELF.county 									:= L.fips_county;
		SELF.msa 											:= L.msa;
		SELF.geo_lat 									:= L.geo_lat;
		SELF.geo_long 								:= L.geo_long;
    SELf 													:= L;		
	end;

	dAsBusinessHeader	:= project(pDataset(~ut.isNumeric(Firm) and Firm <> ''),tAsBusinessHeader(left));

	return dedup(sort(dAsBusinessHeader(current),company_name, prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, phone, -dt_last_seen),
	             company_name,prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, phone);	

end;