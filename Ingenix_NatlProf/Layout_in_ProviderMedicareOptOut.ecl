export Layout_in_ProviderMedicareOptOut:= Module

export raw := record,maxlength(8192)
	string ProviderID ;
	string OptOutSiteDescription ;
	string AffidavitReceivedDate ;
	string OptOutEffectiveDate ;
	string DateOptOutTerminationDate;
	string OptOutStatus;
	string LastUpdate;
end;

export raw_srctype := 

{
string  FILETYP;
string	ProcessDate;
string	ProviderID;
string OptOutSiteDescription ;
string AffidavitReceivedDate ;
string OptOutEffectiveDate ;
string DateOptOutTerminationDate;
string OptOutStatus;
string LastUpdate;
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
