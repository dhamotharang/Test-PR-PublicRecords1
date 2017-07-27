export Layout_in_ProviderSanctions:= Module

export raw := record,maxlength(8192)
	string 	ProviderID ; 
	string 	SanctionDate ;
	string 	SanctioningState ;
	string 	SanctionedLicenseNumber ;
	string  LossOfLicenseIndicator ;
	string	LicenseReinstatementDate ;
	string	SanctionFraudAbuseIndicator ;
	string	SanctionType ;
	string	SanctionReason ; 
	string	SanctionTerms ;
	string	SanctionConditions ; 
	string	SanctionFines ; 
	string	SanctioningBoardType ;
	string	SanctioningSource ; 
	string	LastUpdate ;

end;

export raw_srctype := 

{
	string  FILETYP;
	string	ProcessDate;
	string	ProviderID;
	string SanctionDate ;
	string SanctioningState ;
	string SanctionedLicenseNumber ;
	string  LossOfLicenseIndicator ;
	string	LicenseReinstatementDate ;
	string	SanctionFraudAbuseIndicator ;
	string	SanctionType ;
	string	SanctionReason ; 
	string	SanctionTerms ;
	string	SanctionConditions ; 
	string	SanctionFines ; 
	string	SanctioningBoardType ;
	string	SanctioningSource ; 
	string	LastUpdate ;
};
export raw_Allsrc := 

{
	raw_srctype;
	string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
};
end;