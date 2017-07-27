import ut;

irs_party	:=	dataset(ut.foreign_prod+'~thor_data400::vehv2::irs_party',VehicleV2.Layout_Base_Party,flat);
    
VehicleV2.Layout_Base.Party_Bid	reformat(VehicleV2.Layout_Base_Party	l)	:=
transform
	self.Date_Last_Seen							:=	(unsigned3)(ut.GetDate[1..6]);
	self.Date_Vendor_Last_Reported	:=	(unsigned3)(ut.GetDate[1..6]);
	self.History 										:=	if(l.Orig_Name_Type = '4','E','');
	
	self.title											:=	l.append_clean_name.title;
	self.fname											:=	l.append_clean_name.fname;
	self.mname											:=	l.append_clean_name.mname;
	self.lname											:=	l.append_clean_name.lname;
	self.name_suffix								:=	l.append_clean_name.name_suffix;
	self.name_score									:=	l.append_clean_name.name_score;
	
	self.prim_range									:=	l.Append_Clean_Address.prim_range;
	self.predir											:=	l.Append_Clean_Address.predir;
	self.prim_name									:=	l.Append_Clean_Address.prim_name;
	self.addr_suffix								:=  l.Append_Clean_Address.addr_suffix;
	self.postdir										:=	l.Append_Clean_Address.postdir;
	self.unit_desig									:=	l.Append_Clean_Address.unit_desig;
	self.sec_range									:=	l.Append_Clean_Address.sec_range;
	self.v_city_name								:=	l.Append_Clean_Address.v_city_name;
	self.st													:=	l.Append_Clean_Address.st;
	self.zip5												:=	l.Append_Clean_Address.zip5;
	self.zip4												:=	l.Append_Clean_Address.zip4;
	self.fips_state									:=	l.Append_Clean_Address.fips_state;
	self.fips_county								:=	l.Append_Clean_Address.fips_county;
	self.geo_lat										:=	l.Append_Clean_Address.geo_lat;
	self.geo_long										:=	l.Append_Clean_Address.geo_long;
	self.cbsa												:=	l.Append_Clean_Address.cbsa;
	self.geo_blk										:=	l.Append_Clean_Address.geo_blk;
	self.geo_match									:=	l.Append_Clean_Address.geo_match;
	self.err_stat										:=	l.Append_Clean_Address.err_stat;
	
	self.ace_prim_range							:=	l.Append_Clean_Address.prim_range;
	self.ace_predir									:=	l.Append_Clean_Address.predir;
	self.ace_prim_name							:=	l.Append_Clean_Address.prim_name;
	self.ace_addr_suffix						:=  l.Append_Clean_Address.addr_suffix;
	self.ace_postdir								:=	l.Append_Clean_Address.postdir;
	self.ace_unit_desig							:=	l.Append_Clean_Address.unit_desig;
	self.ace_sec_range							:=	l.Append_Clean_Address.sec_range;
	self.ace_v_city_name						:=	l.Append_Clean_Address.v_city_name;
	self.ace_st											:=	l.Append_Clean_Address.st;
	self.ace_zip5										:=	l.Append_Clean_Address.zip5;
	self.ace_zip4										:=	l.Append_Clean_Address.zip4;
	self.ace_fips_state							:=	l.Append_Clean_Address.fips_state;
	self.ace_fips_county						:=	l.Append_Clean_Address.fips_county;
	self.ace_geo_lat								:=	l.Append_Clean_Address.geo_lat;
	self.ace_geo_long								:=	l.Append_Clean_Address.geo_long;
	self.ace_cbsa										:=	l.Append_Clean_Address.cbsa;
	self.ace_geo_blk								:=	l.Append_Clean_Address.geo_blk;
	self.ace_geo_match							:=	l.Append_Clean_Address.geo_match;
	self.ace_err_stat								:=	l.Append_Clean_Address.err_stat;
	self														:=	l;
	self														:=	[];
end; 

export	irs_dummy_recs_party	:=	project(irs_party,reformat(left));