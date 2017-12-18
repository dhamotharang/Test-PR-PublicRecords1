import address, doxie, ut, header_services,data_services;

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

layout_orig_util_in_TEMP remove_csa_indicator(UtilFile.file_util.full_did l) := transform
	self.did_temp := (unsigned6) l.did;
	self := l;
end;

util := project(UtilFile.file_util.full_did((unsigned6)did<>0), remove_csa_indicator(left));

header_services.Supplemental_Data.mac_verify('file_utility_inj.thor',Utilfile.Layout_DID_Out,read);
 
suppData := read();

layout_orig_util_in_TEMP reformat(utilfile.Layout_DID_Out l) := transform
	self.did_temp := (unsigned6) l.did;
	self := l;
end;

supp_ds := project(suppData, reformat(left));

file_util_orig_in_TEMP := util + supp_ds;

//***********************************CODE TO SUPRESS WA CELL PHONES********************************************
//Supress WA Cell Phones
ut.mac_suppress_by_phonetype(file_util_orig_in_TEMP,work_phone,st,PhSuppressed1,true,did_temp);
ut.mac_suppress_by_phonetype(PhSuppressed1,phone,st,PhSuppressed2,true,did_temp);

//Reformat back to the standard format layout of the Base search file 
file_util_orig_in := PROJECT(PhSuppressed2,transform(layout_orig_util_in,self := left));

//************************************************************************************************************	
export Key_DID := 
       index(file_util_orig_in,
             {unsigned6 s_did := (unsigned6)did},
						 {file_util_orig_in},
						 data_services.data_location.prefix() + 'thor_data400::key::utility_did_' + doxie.Version_SuperKey);