export layout_ALS0845 := MODULE
export Licensee := 
  record
		string30   	first_name;
		string50		last_name;			// may include suffix		
		string30   	mid_name;
		string10		suffix;
		string5			title;
		string100  	officename;
		string15		bus_phone;			// include long distance indicator(1)
		string30   	city;
		string100  	address1_1;
		// string100  	address2_1;
		string10   	zip;
		string30   	state;

		string30   	lic_number;
		string5			certified_dte;		// fmt YYYY		
		string50		lic_cert_status;

		string30   	lic_status;
		string2			congress_dist;		
		string30   	county;

		string10		metUSPAP_dte;		// chg column format handle the conversion properly.
		string12		USPAPexpire_dte;			// USPAP expiration date; fmt MM/DD/YYYY
		string100   email;          // new in Update 20161014
						
	end;
	
	export Common := RECORD
		string30   	first_name;
		string30   	mid_name;
		string50		last_name;			// may include suffix
		string5			title;
		string10		suffix;
		string15		bus_phone;			// include long distance indicator(1)
		string100  	officename;
		string100  	address1_1;
		string100  	address2_1;
		string30   	city;
		string30   	state;
		string10   	zip;
		string30   	lic_number;
		string50		lic_cert_status;
		string5			certified_dte;		// fmt YYYY
		string30   	lic_status;
		string30   	county;
		string2			congress_dist;
		string10		metUSPAP_dte;		// chg column format handle the conversion properly.
		string12		USPAPexpire_dte;			// USPAP expiration date; fmt MM/DD/YYYY
		string100   email;          // new in Update 20161014
		string8     LN_filedate;			//internal
	end;
end;







