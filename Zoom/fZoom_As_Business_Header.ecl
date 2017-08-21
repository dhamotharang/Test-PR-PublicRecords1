IMPORT Business_Header, ut,mdr;

export fZoom_As_Business_Header(dataset(layouts.base) pDataset) :=
function

	//Add unique id
	Layouts.Temporary.UniqueId tAddUniqueId(Layouts.Base l, unsigned8 cnt) :=
	transform

		self.unique_id		:= cnt	;
		self							:= l		;

	end;   
	
	dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH format
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout tAsBusinessHeader(Layouts.Temporary.UniqueId L, unsigned2 cnt) := 
	transform
		
		phone := map(cnt = 1 and l.clean_phones.Phone					!= '' =>	l.clean_phones.Phone
								,cnt = 2 and l.clean_phones.Company_Phone != '' =>	l.clean_phones.Company_Phone
								,cnt = 1 and l.clean_phones.Phone				   = '' =>	l.clean_phones.Company_Phone
								,																										l.clean_phones.Phone
					);

		SELF.group1_id 								:= L.unique_id;
		SELF.vl_id 								    := L.rawfields.Zoom_Company_ID;
		SELF.vendor_id 								:= if(L.rawfields.Zoom_Company_ID <> '', L.rawfields.ZoomID + 'C'+L.rawfields.Zoom_Company_ID,
		                                    L.rawfields.ZoomID);
		SELF.phone 										:= (unsigned6)phone;
		SELF.phone_score 							:= IF((unsigned6)Phone = 0, 0, 1);
		SELF.source 									:= mdr.sourceTools.src_ZOOM;
		SELF.source_group 						:= L.rawfields.Zoom_Company_ID;
		SELF.company_name 						:= L.Rawfields.COMPANY_NAME;
		SELF.dt_first_seen 						:= l.dt_first_seen;
		SELF.dt_last_seen 						:= l.dt_last_seen;
		SELF.dt_vendor_first_reported	:= (UNSIGNED4)L.dt_vendor_first_reported;
		SELF.dt_vendor_last_reported	:= (UNSIGNED4)L.dt_vendor_last_reported;
		SELF.fein 										:= 0;
		SELF.current 									:= if(l.record_type = 'C', TRUE, false);
		SELF.prim_range 							:= L.Clean_company_address.prim_range;
		SELF.predir 									:= L.Clean_company_address.predir;
		SELF.prim_name 								:= L.Clean_company_address.prim_name;
		SELF.addr_suffix 							:= L.Clean_company_address.addr_suffix;
		SELF.postdir 									:= L.Clean_company_address.postdir;
		SELF.unit_desig 							:= L.Clean_company_address.unit_desig;
		SELF.sec_range 								:= L.Clean_company_address.sec_range;
		SELF.city 										:= L.Clean_company_address.v_city_name;
		SELF.state 										:= L.Clean_company_address.st;
		SELF.zip 											:= (UNSIGNED3)L.Clean_company_address.zip;
		SELF.zip4 										:= (UNSIGNED2)L.Clean_company_address.zip4;
		SELF.county 									:= L.Clean_company_address.fips_county;
		SELF.msa 											:= L.Clean_company_address.msa;
		SELF.geo_lat 									:= L.Clean_company_address.geo_lat;
		SELF.geo_long 								:= L.Clean_company_address.geo_long;
		self.dppa											:= false;
		
	end;

	choosey(string pPhone, string pCompany_Phone) := 
		map(			pPhone					!= ''
					and pCompany_Phone	!= '' => 2, 1);
									
	dAsBusinessHeader	:= normalize(
													 dAddUniqueId
													,choosey(left.clean_phones.Phone, left.clean_phones.Company_Phone)
													,tAsBusinessHeader(left,counter)
													);

	dAsBusinessHeader_dist  := distribute(dAsBusinessHeader(vendor_id != '')			,random());
	dAsBusinessHeader_sort  := sort			(dAsBusinessHeader_dist	,company_name, vl_id, prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, phone, -dt_last_seen,local);
	dAsBusinessHeader_dedup := dedup		(dAsBusinessHeader_sort	,company_name, vl_id, prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, phone,local);

	return dedup(sort(dAsBusinessHeader_dedup,company_name, vl_id, prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, phone, -dt_last_seen),
	             company_name, vl_id, prim_range, prim_name, addr_suffix, predir, postdir, unit_desig, sec_range, city, state, zip, phone);	

end;