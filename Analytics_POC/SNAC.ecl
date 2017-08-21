export SNAC := module


export spray :=
	fileservices.sprayVariable( Constants.landing_ip, // dev
                            //'172.25.246.94', // IQ
                            'w:\\poc\\cred_view_data.tsv',
														8192,
														'\\t',
														, , 'thor20_11',
														'poc::fs_snac_raw'
														,,,,true
													 );
													 

export layout_snac_raw := record
	string SNAC_app_id;
	string SNAC_entity_id;
	string SNAC_std_addr_primary;
	string SNAC_std_addr_secondary;
	string SNAC_std_addr_city;
	string SNAC_std_addr_state;
	string SNAC_std_addr_postal_cd;
	string SNAC_std_addr_zip4;
	string SNAC_std_addr_province;
	string SNAC_std_addr_country;
	string SNAC_acct_num;
	string SNAC_source_system_full;
	string SNAC_name_business;
	string SNAC_dba;
	string SNAC_phone;
end;

export file_raw :=
	dataset('~thor20_11::poc::fs_snac_raw', 
	        layout_snac_raw, 
					csv(heading(1), quote('"'), separator('\t'), terminator(['\r\n', '\n']), maxlength(2048000)), 
					opt);


end;