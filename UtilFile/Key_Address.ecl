/*2016-12-09T00:58:38Z (Wendy Ma)

*/
Import Data_Services, address, doxie, ut, header_services,Data_Services;

layout_orig_util_in := record
	string15        id;
	string10        exchange_serial_number;
	string8         date_added_to_exchange;
	string8         connect_date;
	string8         date_first_seen;
	string8         record_date;
	string10        util_type;
	string25        orig_lname;
	string20        orig_fname;
	string20        orig_mname;
	string5         orig_name_suffix;
	string1         addr_type;
	string1         addr_dual;
	string10        address_street;
	string100       address_street_Name;
	string5         address_street_Type;
	string2         address_street_direction;
	string10        address_apartment;
	string20        address_city;
	string2         address_state;
	string10        address_zip;
	string9         ssn;
	string10        work_phone;
	string10        phone;
	string8         dob;
	string2         drivers_license_state_code;
	string22        drivers_license;
	address.Layout_Clean182;
	string12        did;
	string5         title;
	string20        fname;
	string20        mname;
	string20        lname;
	string5         name_suffix;
	string3         name_score;
end;

layout_orig_util_in_TEMP := RECORD
	layout_orig_util_in;
	unsigned6 did_temp;
END;

layout_orig_util_in_TEMP remove_csa_indicator(utilfile.file_util.full_base_for_index l) := transform
	self.did_temp := (unsigned6) l.did;
	self := l;
end;

util := project(utilfile.file_util.full_base_for_index, remove_csa_indicator(left));

//blank out invalid phone
utilfile.Mac_clean_phone(util,cleanphone_out); 

suppData := utilfile.file_supplemental.out_supp;

layout_orig_util_in_TEMP reformat(Layout_DID_Out l) := transform
	self.did_temp := (unsigned6) l.did;
	self := l;
end;

supp_ds := project(suppData, reformat(left));

file_util_orig_in_TEMP := cleanphone_out + supp_ds;

//***********************************CODE TO SUPRESS WA CELL PHONES********************************************
//Supress WA Cell Phones
ut.mac_suppress_by_phonetype(file_util_orig_in_TEMP,work_phone,st,PhSuppressed1,true,did_temp);
ut.mac_suppress_by_phonetype(PhSuppressed1,phone,st,PhSuppressed2,true,did_temp);

//Reformat back to the standard format layout of the Base search file 
file_util_orig_in := PROJECT(PhSuppressed2,transform(layout_orig_util_in,self.ssn := '', self := left));

//************************************************************************************************************	
export Key_Address := 
       index(file_util_orig_in(trim(prim_name)<>''),
             {prim_name,st,zip,prim_range,sec_range},
						 {file_util_orig_in},
						Data_Services.Data_Location.Prefix('Utility')+'thor_data400::key::utility_address_' + doxie.Version_SuperKey);