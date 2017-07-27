import risk_indicators, doxie, seed_files;

//***** Call traditional InstantID
iir_temp := Risk_Indicators.InstantID_records;
iir := project(iir_temp, risk_indicators.Layout_InstandID_NuGen);

//***** Pull the DID off of the InstantID result and use it to get more addresses and names
doxie.MAC_Selection_Declare();
doxie.MAC_Header_Field_Declare();
DIDs := project(iir(DID > 0), Doxie.layout_references);
csa := 
	doxie.Comp_Subject_Addresses(
		dids,dateVal,dppa_purpose,glb_purpose,ln_branded_value,,probation_override_value,industry_class_value,no_scrub,dial_contactprecision_value);

//***** rollup the addrs and get them into the right layout
addr_unrolled := project(csa.addresses, bs_services.layouts.addresses);
doxie.MAC_Address_Rollup(addr_unrolled, bs_services.Constants.max_addresses, addr)

//***** get the names in the right layout
// name := project(csa.names, bs_services.layouts.names);

//***** get the best info
besti := 
	project(
		doxie.best_records (dids, , , , , false, , , useNonBlankKey := true,checkRNA:=false ,includeDOD:=true), 
		transform(
			bs_services.layouts.best_info,
			self := left, 
			self := []
		)
	);

//***** pack it up
real_transaction := project(  
		iir,
		transform(
			bs_services.Layouts.out,
			self.addresses_children := choosen(addr, bs_services.Constants.max_addresses),
			self.best_information_children := choosen(besti, bs_services.Constants.max_best),
			// self.names_children := [],//choosen(name, bs_services.Constants.max_names),
			self := left
		)
	);
	
boolean Test_Data_Enabled2 := FALSE   	: stored('TestDataEnabled');
string20 Test_Data_Table_Name2 := ''  	: stored('TestDataTableName');

export InstantID_records := if(Test_Data_Enabled2, seed_files.GetBS_Services_History(iir, Test_Data_Table_Name2), real_transaction );

	