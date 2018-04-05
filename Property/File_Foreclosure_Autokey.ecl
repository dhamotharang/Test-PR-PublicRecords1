import dops;
// file_in := Property.File_Foreclosure_Normalized(trim(deed_category)='U');
//FC_ids := ['058118BANKOFAMERICA', '058118ESCOBARCARLOSG', '1079290090820TRUCAPREOCORP', '1079290090820TRUCAPGRANTORTRUST2010-1'];
FC_ids(boolean isFCRA=false) := dops.SuppressID('foreclosure').GetIDsAsSet(isFCRA);
file_in := Property.File_Foreclosure_Normalized(trim(deed_category)='U' and Trim(foreclosure_id, left, right) not in FC_ids());
Autokey_layout:=record
	string70		foreclosure_id;
	string20 		name_first;
	string20 		name_middle;
	string20 		name_last;
	string5  		name_suffix;
	unsigned6 	did := 0;
	unsigned1 	did_score := 0;
	unsigned6 	bdid := 0;
	unsigned1 	bdid_score := 0;
	string9 		ssn := '';
	string60  	name_Company;
	string10		site_prim_range;
	string2		site_predir;
	string28		site_prim_name;
	string4		site_addr_suffix;
	string2		site_postdir;
	string10		site_unit_desig;
	string8		site_sec_range;
	string25		site_p_city_name;
	string25		site_v_city_name;
	string2		site_st;
	string5		site_zip;
	string4		site_zip4;
	unsigned 		zero :=0;
	string1		blank :='';
end;

export File_Foreclosure_Autokey := dedup(project(file_in(site_prim_name<>'' and site_zip<>''),Autokey_layout),record,all) : persist('~thor_data400::persist::file_foreclosure_Autokey');

