IMPORT AddrBest, iesp, AutoStandardI, Address;

EXPORT AddressSummaryService_Records(iesp.addresssummary.t_AddressSummaryRequest in_recs) := FUNCTION
	// Module Values
	tempmod := AutoStandardI.GlobalModule();
	// Cleaned Address
	Full_Addr := StringLib.StringToUpperCase(trim(tempmod.Addr, left, right));
	Full_CSZ  := StringLib.StringToUpperCase(trim(tempmod.city + ' ' + 
																								tempmod.state + ' ' + 
																								tempmod.zip, left, right));
	Clean_Addr := Address.GetCleanAddress(Full_Addr, Full_CSZ, Address.Components.Country.US).results;
	// Cleaned Name
	Full_Name := trim(StringLib.StringToUpperCase(stringlib.stringfilterout(tempmod.unparsedfullname, '*?')), left, right);
	Clean_Name := Address.CleanNameFields(Address.CleanPersonFML73(Full_Name));

	AddrBest.Layout_BestAddr.Batch_in xfrm_bestaddr_in():=transform
		SELF.name_first := if(Full_Name != '', Clean_Name.fname,  stringlib.stringfilterout(tempmod.firstname, '*?'));
		SELF.name_middle:= if(Full_Name != '', Clean_Name.mname, stringlib.stringfilterout(tempmod.middlename, '*?'));
		SELF.name_last	:= if(Full_Name != '', Clean_Name.lname, stringlib.stringfilterout(tempmod.lastname, '*?'));
		SELF.name_suffix:= if(Full_Name != '', Clean_Name.name_suffix, stringlib.stringfilterout(tempmod.namesuffix, '*?'));
		SELF.prim_range := Clean_Addr.prim_range;
		SELF.predir	 		:= Clean_Addr.predir;
		SELF.prim_name  := Clean_Addr.prim_name;
		SELF.suffix     := Clean_Addr.suffix;
		SELF.postdir    := Clean_Addr.postdir;
		SELF.unit_desig := Clean_Addr.unit_desig;
		SELF.sec_range  := Clean_Addr.sec_range;
		SELF.p_city_name:= Clean_Addr.p_city;
		SELF.st					:= Clean_Addr.state;
		SELF.z5		 			:= Clean_Addr.zip;
		// SELF.z4		 	:= Clean_Addr.zip4;	//NOT IN LAYOUT AddrBest.Layout_BestAddr.Batch_in
		SELF.ssn		 		:= tempmod.ssn;
		SELF.phoneno		:= tempmod.phone;
		SELF.dob				:= (qstring8) tempmod.dob;
		SELF.did 				:= (unsigned6) tempmod.did;
		SELF := [];
	END;

	BestAddressInput := dataset([xfrm_bestaddr_in()]);
	BestAddressCommon := AddrBest.BestAddr_common(BestAddressInput);
	BestAddressWithSummary := AddressSummaryService_Functions.fnBestAddressWithSummary(BestAddressCommon, in_recs);
	AddressSummaryResult := AddressSummaryService_Functions.fnAddressSummaryResult(in_recs, BestAddressWithSummary);
	
	// TESTING - START
	// output(in_recs, named('AddressSummaryInput'));
	// output(BestAddressInput, named('BestAddressInput'));
	// output(BestAddressWithSummary, named('BestAddressWithSummary'));	
	// TESTING - END
	
	RETURN AddressSummaryResult;
END;
