//all files
mac(bname, currentlogical) := macro		
	#uniquename(a);
	%a% := 13;
	sequential(
		FileServices.CreateSuperFile(bname),
		FileServices.CreateSuperFile(bname + '_father'),
		FileServices.CreateSuperFile(bname + '_Grandfather'),
		FileServices.CreateSuperFile(bname + '_delete'),
		FileServices.AddSuperFile(bname, currentlogical)
	);
endmacro;

//dofiles := sequential(
	/*mac('BASE::Business_Relatives_Group', 'BASE::Business_Relatives_Group_20040810')
	mac('BASE::Business_Relatives', 'BASE::Business_Relatives_20040810')
	mac('BASE::Business_Header', 'BASE::Business_Header_20040810')
	mac('BASE::Business_Header_Stat', 'BASE::Business_Header_Stat_20040810')
	mac('BASE::People_At_Work_Stats', 'BASE::People_At_Work_Stats_20040810')
	mac('BASE::Business_Contacts', 'BASE::Business_Contacts_20040810')
	mac('BASE::business_header.Best', 'BASE::business_header.Best_20040810')
	mac('BASE::business_header.CompanyName','BASE::business_header.CompanyName_20040810')
	mac('BASE::business_header.CompanyName_Address','BASE::business_header.CompanyName_Address_20040810')
	mac('BASE::business_header.CompanyName_Phone','BASE::business_header.CompanyName_Phone_20040810')
	mac('BASE::business_header.CompanyName_FEIN','BASE::business_header.CompanyName_FEIN_20040810')
	//two below here will fail in add...temp is gone
	mac('BASE::bh_co_name_words','TEMP::bh_co_name_words_20040810')
	mac('BASE::bh_bdid.city.zip.fein.phone','TEMP::bh_bdid.city.zip.fein.phone_20040810')*/
	
//);

//files that have keys built on them
bmac(bname) := macro
	#uniquename(a);
	%a% := 13;
	sequential(
		FileServices.CreateSuperFile(bname + '_building'),
		FileServices.CreateSuperFile(bname + '_built'),
		FileServices.ClearSuperFile(bname + '_Built'),
		FileServices.AddSuperFile(bname + '_Built', bname,0,true)
	);
endmacro;

//dobases := sequential(
	/*bmac('BASE::Business_Contacts')
	bmac('BASE::People_At_Work_Stats')
	bmac('BASE::business_header.Best')
	bmac('BASE::business_header.CompanyName')
	bmac('BASE::business_header.CompanyName_Address')
	bmac('BASE::business_header.CompanyName_Phone')
	bmac('BASE::business_header.CompanyName_FEIN')
	bmac('BASE::Business_Header')
	bmac('BASE::Business_Relatives')
	bmac('BASE::Business_Relatives_Group')
	bmac('BASE::bh_co_name_words')
	bmac('BASE::bh_bdid.city.zip.fein.phone')*/
//);

//for the keys themselves
kmac(kname, currentlogical) := macro
	#uniquename(a);
	%a% := 13;
	sequential(
		FileServices.CreateSuperFile(kname + '_Grandfather'),
		FileServices.CreateSuperFile(kname + '_father'),
		FileServices.CreateSuperFile(kname + '_built'),
		FileServices.CreateSuperFile(kname + '_qa'),
		FileServices.CreateSuperFile(kname + '_prod'),
		FileServices.AddSuperFile(kname + '_built', currentlogical)
	);

endmacro;

//dokeys := sequential(
	/*kmac('key::business_contacts.bdid','key::business_contacts.bdid_20040810')
	kmac('key::business_contacts.state.lfname','key::business_contacts.state.lfname_20040810')
	kmac('key::business_contacts.did','key::business_contacts.did_20040810')
	kmac('key::business_contacts_stat','key::business_contacts_stat_20040810')
	kmac('key::business_contacts.ssn','key::business_contacts.ssn_20040810')
	kmac('key::business_header.Best','key::business_header.Best_20040810')
	kmac('key::business_header.CompanyName_3', 'key::business_header.CompanyName_3_20040810')
	kmac('key::business_header.Addr_pr_pn_sr_st', 'key::business_header.Addr_pr_pn_sr_st_20040810')
	kmac('key::business_header.Addr_pr_pn_zip', 'key::business_header.Addr_pr_pn_zip_20040810')
	kmac('key::business_header.FEIN_2','key::business_header.FEIN_2_20040810')
	kmac('key::business_header.BDID','key::business_header.BDID_20040810')
	kmac('key::business_header.BusinessRelatives','key::business_header.BusinessRelatives_20040810')
	kmac('key::business_header.Business_Relatives_Group','key::business_header.Business_Relatives_Group_20040810')
	kmac('key::business_header.src','key::business_header.source') 
	kmac('key::business_header.CoNameWords','key::business_header.CoNameWords_20040810')
	kmac('key::business_header_bdid.city.zip.fein.phone','key::business_header_bdid.city.zip.fein.phone_20040810')
	kmac('key::business_contacts.state.city.name','key::business_contacts.state.city.name20040810')
	kmac('key::business_header.Phone_2','key::business_header.Phone_2_20040810')
	*/
//);



/*  storage for the one that i might want to use on dev
THIS IS WRONG BC THE TRUE IS MISSING ON THE ADD
kmac(k, kname, bname) := macro
	#uniquename(a);
	%a% := 13;
	
	ut.MAC_SK_BuildProcess(k, kname,kname, build_key)
	
	sequential(
	FileServices.AddSuperFile(bname + '_building',bname),
	FileServices.CreateSuperFile(kname + '_Grandfather'),
	FileServices.CreateSuperFile(kname + '_father'),
	FileServices.CreateSuperFile(bname + '_built'),
	FileServices.CreateSuperFile(kname + '_built'),
	FileServices.CreateSuperFile(kname + '_qa'),
	FileServices.CreateSuperFile(kname + '_prod'),
	build_key,
	FileServices.AddSuperFile(bname + '_built',bname + '_building')
	)

endmacro;
*/