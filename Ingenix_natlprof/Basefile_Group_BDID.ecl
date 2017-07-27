basicLayout	:=	record
	string12	BDID;
	string3 	BDID_SCORE;
	string8 	dt_first_seen;
	string8 	dt_last_seen;
	string8 	dt_vendor_first_reported;
	string8 	dt_vendor_last_reported;
	string  	FILETYP;
	string		ProcessDate;
	string		ProviderID;
	string		GroupName;
	string		GroupNameCompanyCount;
	string		GroupNameTierTypeID;
end;
						
export Basefile_Group_BDID := PROJECT(Ingenix_NatlProf.Basefile_Group_BDID_extended,TRANSFORM(basicLayout,SELF := LEFT;));	