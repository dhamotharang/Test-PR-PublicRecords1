import doxie;

export index_files(string filedate = '') := MODULE

	/* base names */
	shared base_file_name := CNLD_Facilities.file_Facilities_AID;
	shared base_key_name := CNLD_Facilities.thor_cluster+ 'key::cnldfacilities::';
	
	/* index files */
	shared key_deanbr_file := base_key_name + 'deanbr';
	shared key_taxid_file := base_key_name + 'taxid';
	shared key_license_file := base_key_name + 'license_nbr';
	shared key_ncpdp_file := base_key_name + 'ncpdp';
	shared key_npi_file := base_key_name + 'npi';
	shared key_bdid_file := base_key_name + 'bdid';
	shared key_gennum_file := base_key_name + 'gennum';
	shared key_zipcode_file := base_key_name + 'zipcode';
		
	export key_deanbr := INDEX(base_file_name(deanbr != ''), { deanbr}, {gennum}, key_deanbr_file);
	export key_taxid := INDEX(base_file_name(cln_ssn_taxid != ''), { cln_ssn_taxid}, {gennum},key_taxid_file);
	export key_license := INDEX(base_file_name(st_lic_num != ''), { st_lic_num,st_lic_in }, {gennum}, key_license_file);
	export key_ncpdp := INDEX(base_file_name(ncpdpnbr != ''), { ncpdpnbr }, {gennum}, key_ncpdp_file);
	export key_npi := INDEX(base_file_name(npi != ''), { npi }, {gennum}, key_npi_file);	
	export key_dbid := INDEX(base_file_name((unsigned6)BDID != 0), { bdid }, {gennum}, key_bdid_file);
	export key_gennum := INDEX(base_file_name, {gennum}, {base_file_name }, key_gennum_file);
	export key_zipcode := INDEX(base_file_name(addr_zip != ''), {addr_zip}, {gennum }, key_zipcode_file);
END;


