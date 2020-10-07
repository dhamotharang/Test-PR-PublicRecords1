import MDR, Phones;

export Functions := module
	
	// -- Lookup functions --

	export string20 	GetRoyaltyType(unsigned2 pCode) := TRIM(Master(file_name='ROYALTY', field_name2=(string)pCode)[1].field_name, LEFT, RIGHT);
	export unsigned2 	GetRoyaltyCode(string20 pType) 	:= (unsigned2) Master(file_name='ROYALTY', field_name=pType)[1].field_name2;	

	export string20 	GetEmailRoyaltyType(string2 pEmailSrc) := 
		Master(file_name='ROYALTY', field_name[1..5]='EMAIL', code=pEmailSrc)[1].field_name;						
	export unsigned2	GetEmailRoyaltyCode(string2 pEmailSrc) := 
		(unsigned2) Master(file_name='ROYALTY', field_name[1..5]='EMAIL', code=pEmailSrc)[1].field_name2;					
	export unsigned2 	GetWorkplaceTypeCode(string2 pSrc, boolean spouse=false) := IF(spouse,
			(unsigned2) Master(pSrc<>'',file_name='ROYALTY', field_name[1..12]='WORKPLACE_SP', code=pSrc)[1].field_name2,
			(unsigned2) Master(pSrc<>'',file_name='ROYALTY', field_name[1..9]='WORKPLACE' or field_name[1..13]='NETWISE_EMAIL', code=pSrc)[1].field_name2);			

	export string20 	GetGDCRoyaltyType(string2 pCountryCode) := function
		rtype := Master(file_name='ROYALTY', field_name[1..3]='GDC', code=pCountryCode)[1].field_name;
		return if(rtype<>'', rtype, Constants.RoyaltyType.GDC);
	end;
	export unsigned2	GetGDCRoyaltyCode(string2 pCountryCode) := function
		unsigned2 rcode := (unsigned2) Master(file_name='ROYALTY', field_name[1..3]='GDC', code=pCountryCode)[1].field_name2;
		return if(rcode>0, rcode, Constants.RoyaltyCode.GDC);
	end;
	
	export string20 	GetGG2RoyaltyType(string2 pCountryCode) := function
		rtype := Master(file_name='ROYALTY', field_name[1..3]='GG2', code=pCountryCode)[1].field_name;
		return if(rtype<>'', rtype, Constants.RoyaltyType.GG2);
	end;
	export unsigned2	GetGG2RoyaltyCode(string2 pCountryCode) := function
		unsigned2 rcode := (unsigned2) Master(file_name='ROYALTY', field_name[1..3]='GG2', code=pCountryCode)[1].field_name2;
		return if(rcode>0, rcode, Constants.RoyaltyCode.GG2);
	end;

	export unsigned2 GetInviewRoyaltyCode(boolean Include_BCRC, boolean Include_BFRL, boolean Include_BCIR ) := function
		unsigned2 rcode := MAP(
			Include_BCRC and Include_BFRL and Include_BCIR => Royalty.Constants.RoyaltyCode.INVIEW_REPORT,
			Include_BCRC and Include_BFRL  => Royalty.Constants.RoyaltyCode.INVIEW_BCRCI_BFRL,
			Include_BCRC and Include_BCIR => Royalty.Constants.RoyaltyCode.INVIEW_BCRCI_BCIR,
			Include_BFRL and Include_BCIR => Royalty.Constants.RoyaltyCode.INVIEW_BFRL_BCIR,
			Include_BCRC => Royalty.Constants.RoyaltyCode.INVIEW_BCRCI,
			Include_BFRL => Royalty.Constants.RoyaltyCode.INVIEW_BFRL,
			Include_BCIR => Royalty.Constants.RoyaltyCode.INVIEW_BCIR,
			Royalty.Constants.RoyaltyCode.INVIEW_DEFAULT);
		return rcode;
	end;		
	export string20 GetInviewRoyaltyType(boolean Include_BCRC, boolean Include_BFRL, boolean Include_BCIR ) := function
		string20 rtype := MAP(
			Include_BCRC and Include_BFRL and Include_BCIR => Royalty.Constants.RoyaltyType.INVIEW_REPORT,
			Include_BCRC and Include_BFRL  => Royalty.Constants.RoyaltyType.INVIEW_BCRCI_BFRL,
			Include_BCRC and Include_BCIR => Royalty.Constants.RoyaltyType.INVIEW_BCRCI_BCIR,
			Include_BFRL and Include_BCIR => Royalty.Constants.RoyaltyType.INVIEW_BFRL_BCIR,
			Include_BCRC => Royalty.Constants.RoyaltyType.INVIEW_BCRCI,
			Include_BFRL => Royalty.Constants.RoyaltyType.INVIEW_BFRL,
			Include_BCIR => Royalty.Constants.RoyaltyType.INVIEW_BCIR,
			Royalty.Constants.RoyaltyType.INVIEW_DEFAULT);
		return rtype;
	end;		
	
	// some convenience functions for Targus GW royalties
	
	export boolean isTargusPDE(string pTargusType) 	:= stringlib.stringfind(pTargusType, Phones.Constants.TargusType.PhoneDataExpress, 1) > 0;	
	export boolean isTargusWCS(string pTargusType) 	:=  // Wireless Connection Searches are flagged as both 'W' and 'C'
		stringlib.stringfind(pTargusType, Phones.Constants.TargusType.WirelessConnectionSearch, 1) > 0 or 
		stringlib.stringfind(pTargusType, Phones.Constants.TargusType.ConfirmConnect, 1) > 0;
	export boolean isTargusVE (string pTargusType) 	:= stringlib.stringfind(pTargusType, Phones.Constants.TargusType.VerifyExpress, 1) > 0;
	export boolean isTargusNV (string pTargusType) 	:= stringlib.stringfind(pTargusType, Phones.Constants.TargusType.NameVerification, 1) > 0;	

	// ----------------------
	
end;

