basicLayout	:=	record
	string12	BDID;
	string3		BDID_SCORE;
	string8		dt_first_seen;
	string8		dt_last_seen;
	string8		dt_vendor_first_reported;
	string8		dt_vendor_last_reported;
	string		FILETYP;
	string		ProcessDate;
	string		ProviderID;
	string		HospitalName;
	string		HospitalNameCompanyCount;
	string		HospitalNameTierTypeID;
end;

export Basefile_Hospital_BDID := PROJECT(Ingenix_NatlProf.Basefile_Hospital_BDID_extended,TRANSFORM(basicLayout,SELF := LEFT;));