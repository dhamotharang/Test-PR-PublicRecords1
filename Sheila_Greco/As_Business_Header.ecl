import Business_HeaderV2, ut, business_header;

export As_Business_Header :=
module

	//#OPTION('multiplePersistInstances',FALSE);

	export fCompanies(dataset(layouts.base.Companies) pDataset) :=
	function

		//Add unique id
		Layouts.Temporary.Companies.UniqueId tAddUniqueId(layouts.base.Companies l, unsigned8 cnt) :=
		transform

			self.unique_id		:= cnt	;
			self							:= l		;

		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////////////
		// -- Map to BH format
		//////////////////////////////////////////////////////////////////////////////////////////////
		bh_layout := business_header.Layout_Business_Header_New;

		bh_layout tAsBusinessHeader(Layouts.Temporary.Companies.UniqueId L) := 
		transform
			
			SELF.group1_id 								:= L.unique_id;
			SELF.vl_id 								    := L.rawfields.MainCompanyID;
			SELF.vendor_id 								:= L.rawfields.MainCompanyID;
			SELF.phone 										:= (unsigned6)l.clean_phones.Phone;
			SELF.phone_score 							:= IF((unsigned6)self.phone = 0, 0, 1);
			SELF.source 									:= Source_Codes.Companies;
			SELF.source_group 						:= L.rawfields.MainCompanyID;
			SELF.company_name 						:= L.Rawfields.COMPANYNAME;
			SELF.dt_first_seen 						:= l.dt_first_seen;
			SELF.dt_last_seen 						:= l.dt_last_seen;
			SELF.dt_vendor_first_reported	:= (UNSIGNED4)L.dt_vendor_first_reported;
			SELF.dt_vendor_last_reported	:= (UNSIGNED4)L.dt_vendor_last_reported;
			SELF.fein 										:= 0;
			SELF.current 									:= if(l.record_type = 'C', TRUE, false);
			SELF.prim_range 							:= L.Clean_address.prim_range;
			SELF.predir 									:= L.Clean_address.predir;
			SELF.prim_name 								:= L.Clean_address.prim_name;
			SELF.addr_suffix 							:= L.Clean_address.addr_suffix;
			SELF.postdir 									:= L.Clean_address.postdir;
			SELF.unit_desig 							:= L.Clean_address.unit_desig;
			SELF.sec_range 								:= L.Clean_address.sec_range;
			SELF.city 										:= L.Clean_address.v_city_name;
			SELF.state 										:= L.Clean_address.st;
			SELF.zip 											:= (UNSIGNED3)L.Clean_address.zip;
			SELF.zip4 										:= (UNSIGNED2)L.Clean_address.zip4;
			SELF.county 									:= L.Clean_address.fips_county;
			SELF.msa 											:= L.Clean_address.msa;
			SELF.geo_lat 									:= L.Clean_address.geo_lat;
			SELF.geo_long 								:= L.Clean_address.geo_long;
			self.dppa											:= false;
			
		end;

		dAsBusinessHeader	:= project(
														 dAddUniqueId
														,tAsBusinessHeader(left)
														);

		return dAsBusinessHeader(vendor_id != '');

	end;


	export Companies	:= fCompanies(files().base.Companies.BusinessHeader) : persist(persistnames.AsBusinessHeader);

	export all :=
	sequential(

		 output(enth(Companies	,1000),named('As_Business_Header_Companies'	),all)
	                                                            
	);

end;