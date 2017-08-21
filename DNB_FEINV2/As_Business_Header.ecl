import business_header, Business_HeaderV2,mdr;

export As_Business_Header :=
module

	#OPTION('multiplePersistInstances',FALSE);
	
	export fDnbFeinV2(dataset(layout_DNB_fein_base_main_new) pDataset, boolean IsPRCT = false) :=
	function
		
		Layouts_UniqueId :=
		record
		
			unsigned8 unique_id;
			layout_DNB_fein_base_main_new;
				
		end;

		//Add unique id
		Layouts_UniqueId tAddUniqueId(layout_DNB_fein_base_main_new l, unsigned8 cnt) :=
		transform

			self.unique_id		:= cnt	;
			self							:= l		;

		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////////////
		// -- Map to BH format
		//////////////////////////////////////////////////////////////////////////////////////////////
		bh_layout := business_header.Layout_Business_Header_New;

		bh_layout tAsBusinessHeader(Layouts_UniqueId L) := 
		transform
			SELF.bdid  										:= If(IsPRCT,(integer)l.BDID,0);
			SELF.group1_id 								:= L.unique_id;
			SELF.vl_id 								    := l.CASE_DUNS_NUMBER;
			SELF.vendor_id 								:= l.CASE_DUNS_NUMBER;
			SELF.phone 										:= 0;
			SELF.phone_score 							:= IF(self.Phone = 0, 0, 1);
			SELF.source 									:= mdr.sourceTools.src_Dunn_Bradstreet_Fein;
			SELF.source_group 						:= l.CASE_DUNS_NUMBER;
			SELF.company_name 						:= stringlib.stringtouppercase(L.orig_company_name);
			SELF.dt_first_seen 						:= (unsigned4)l.date_first_seen;
			SELF.dt_last_seen 						:= (unsigned4)l.date_first_seen;	//first seen uses DATE_OF_INPUT_DATA vendor field, last seen uses process date
			SELF.dt_vendor_first_reported	:= (UNSIGNED4)L.date_vendor_first_reported;
			SELF.dt_vendor_last_reported	:= (UNSIGNED4)L.date_vendor_last_reported;
			SELF.fein 										:= if(Business_header.ValidFEIN((UNSIGNED4)L.fein), (UNSIGNED4)L.fein, 0);;
			SELF.current 									:= true;
			SELF.prim_range 							:= L.prim_range;
			SELF.predir 									:= L.predir;
			SELF.prim_name 								:= L.prim_name;
			SELF.addr_suffix 							:= L.addr_suffix;
			SELF.postdir 									:= L.postdir;
			SELF.unit_desig 							:= L.unit_desig;
			SELF.sec_range 								:= L.sec_range;
			SELF.city 										:= L.v_city_name;
			SELF.state 										:= L.st;
			SELF.zip 											:= (UNSIGNED3)L.zip;
			SELF.zip4 										:= (UNSIGNED2)L.zip4;
			SELF.county 									:= L.county[3..5];
			SELF.msa 											:= L.msa;
			SELF.geo_lat 									:= L.geo_lat;
			SELF.geo_long 								:= L.geo_long;
			self.dppa											:= false;
			
		end;

		dAsBusinessHeader	:= project(
														 dAddUniqueId
														,tAsBusinessHeader(left)
														);

		return dAsBusinessHeader(vendor_id != '',company_name != '');

	end;
	
	export DnbFeinV2 := fDnbFeinV2(Business_HeaderV2.Source_Files.dnb_feinv2.businessheader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::DNB_FEINV2::As_Business_Header');

end;