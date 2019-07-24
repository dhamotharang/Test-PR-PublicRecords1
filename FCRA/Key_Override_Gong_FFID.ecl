﻿import data_services, vault, _control;

string_rec := record
string20 flag_file_id;
string12 l_did;
string5 current_flag;
string5 business_flag;
string1 listing_type_bus;
string1 listing_type_res;
string1 listing_type_gov;
string1 publish_code;
string3 prior_area_code;
string10 phone10;
string10 prim_range;
string2 predir;
string28 prim_name;
string4 suffix;
string2 postdir;
string10 unit_desig;
string8 sec_range;
string25 p_city_name;
string2 v_predir;
string28 v_prim_name;
string4 v_suffix;
string2 v_postdir;
string25 v_city_name;
string2 st;
string5 z5;
string4 z4;
string5 county_code;
string10 geo_lat;
string11 geo_long;
string4 msa;
string32 designation;
string5 name_prefix;
string20 name_first;
string20 name_middle;
string20 name_last;
string5 name_suffix;
string120 listed_name;
string254 caption_text;
string1 omit_address;
string1 omit_phone;
string1 omit_locality;
string64 see_also_text;
string12 did;
string12 hhid;
string12 bdid;
string8 dt_first_seen;
string8 dt_last_seen;
string1 current_record_flag;
string8 deletion_date;
string4 disc_cnt6;
string4 disc_cnt12;
string4 disc_cnt18;
unsigned8	persistent_record_id := 0;
string2 src;
end;


ds := dataset(data_services.data_location.prefix() + 'thor_data400::base::override::fcra::qa::gong', string_rec,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);

fcra.Layout_Override_Gong proj_recs(ds l) := transform
	self.l_did := (unsigned6)l.did;
	self.did := (unsigned6)l.did;
	self.hhid := (unsigned6)l.hhid;
	self.bdid := (unsigned6)l.bdid;
	self.disc_cnt6 := (unsigned2)l.disc_cnt6;
	self.disc_cnt12 := (unsigned2)l.disc_cnt12;
	self.disc_cnt18 := (unsigned2)l.disc_cnt18;
	self.current_flag := (boolean)l.current_flag;
	self.business_flag := (boolean)l.business_flag;
	self.src := if (l.src <> '', l.src, 'GO');
	self := l;
end;

kf := project(ds,proj_recs(left));

#IF(_Control.Environment.onVault) 
export Key_Override_Gong_FFID := vault.FCRA.Key_Override_Gong_FFID;
#ELSE
export Key_Override_Gong_FFID := index(kf,{flag_file_id}, {kf},
data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::gong::qa::ffid');
#END;

