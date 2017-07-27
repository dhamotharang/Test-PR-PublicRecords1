import DID_Add, Watchdog, lib_stringlib;

rSearchWithIntegers
 :=
  record
	Watercraft.Layout_Watercraft_Search_Base;
	unsigned6	temp_DID;
  end
 ;

rSearchWithIntegers tMerchantVesselAsSearchPlus(Watercraft.File_Merchant_Vessels_Prod pInput)
 :=
  transform
	self.date_first_seen			:=	pInput.date_first_seen;
	self.date_last_seen				:=	pInput.date_last_seen;
	self.date_vendor_first_reported	:=	pInput.date_first_seen;
	self.date_vendor_last_reported	:=	pInput.date_last_seen;
	self.watercraft_key				:=	lib_stringlib.stringlib.stringfindreplace(trim(pInput.vessel_id + pInput.vessel_database_key),' ','_');
	self.sequence_key				:=	pInput.date_first_seen;
	self.state_origin				:=	'CG';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';		//Per Lisa Simmons/Rick Trainor emails of 3/2/2005, all Merchant Vessel/Coast Guard are NOT DPPA
	self.orig_name					:=	pInput.organization_name_company_name;
	self.orig_name_type_code		:=	'B';
	self.orig_name_type_description	:=	'OWNER-REGISTRANT';
	self.orig_name_first			:=	pInput.person_first_name;
	self.orig_name_middle			:=	pInput.person_middle_name;
	self.orig_name_last				:=	pInput.person_last_name;
	self.orig_name_suffix			:=	pInput.person_name_suffix;
	self.orig_address_1				:=	pInput.street_address;
	self.orig_address_2				:=	'';
	self.orig_city					:=	pInput.city;
	self.orig_state					:=	pInput.state;
	self.orig_zip					:=	pInput.postal_code;
	self.orig_fips					:=	'';
	self.dob						:=	'';
	self.orig_ssn					:=	'';
	self.orig_fein					:=	'';
	self.gender						:=	'';
	self.phone_1					:=	'';
	self.phone_2					:=	'';
	self.title						:=	pInput.title;
	self.fname						:=	pInput.fname;
	self.mname						:=	pInput.mname;
	self.lname						:=	pInput.lname;
	self.name_suffix				:=	pInput.name_suffix;
	self.name_cleaning_score		:=	pInput.clean_score;
	self.company_name				:=	pInput.compname;
	self.prim_range					:=	pInput.prim_range;
	self.predir						:=	pInput.predir;
	self.prim_name					:=	pInput.prim_name;
	self.suffix						:=	pInput.suffix;
	self.postdir					:=	pInput.postdir;
	self.unit_desig					:=	pInput.unit_desig;
	self.sec_range					:=	pInput.sec_range;
	self.p_city_name				:=	pInput.p_city_name;
	self.v_city_name				:=	pInput.v_city_name;
	self.st							:=	pInput.st;
	self.zip5						:=	pInput.zip;
	self.zip4						:=	pInput.zip4;
	self.county						:=	pInput.county;
	self.cart						:=	pInput.cart;
	self.cr_sort_sz					:=	pInput.cr_sort_sz;
	self.lot						:=	pInput.lot;
	self.lot_order					:=	pInput.lot_order;
	self.dpbc						:=	pInput.dpbc;
	self.chk_digit					:=	pInput.chk_digit;
	self.rec_type					:=	pInput.rec_type;
	self.ace_fips_st				:=	pInput.ace_fips_st;
	self.ace_fips_county			:=	pInput.county;
	self.geo_lat					:=	pInput.geo_lat;
	self.geo_long					:=	pInput.geo_long;
	self.msa						:=	pInput.msa;
	self.geo_blk					:=	pInput.geo_blk;
	self.geo_match					:=	pInput.geo_match;
	self.err_stat					:=	pInput.err_stat;
	self.bdid						:=	'';
	self.fein						:=	'';
	self.did						:=	intformat(pInput.did,12,1);
	self.did_score					:=	'';
	self.ssn						:=	'';
	self.temp_DID					:=	pInput.did;
	self.history_flag				:=	'';
  end
 ;

dPreSSNAppend	:= project(Watercraft.File_Merchant_Vessels_Prod,tMerchantVesselAsSearchPlus(left));

DID_Add.MAC_Add_SSN_By_DID(dPreSSNAppend,temp_DID,SSN,dPostSSNAppend)

Watercraft.Layout_Watercraft_Search_Base tMerchantVesselAsSearch(dPostSSNAppend pInput)
 :=
  transform
	self	:= pInput;
  end
 ;

export Mapping_Merchant_Vessels_As_Search	:= project(dPostSSNAppend,tMerchantVesselAsSearch(left)) : persist('persist::watercraft_merchant_vessel_as_search');
