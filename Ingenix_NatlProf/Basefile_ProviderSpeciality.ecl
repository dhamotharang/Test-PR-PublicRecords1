import Ingenix_natlprof;

Layout_Providerspecialitygroup := {
string  FILETYP;
string  PROCESSDATE;  
string	ProviderID;
string	SpecialityID;
string	SpecialtyCompanyCount;
string	SpecialtyTierTypeID;
string	SpecialityName;
string	SpecialityGroupID;
string	SpecialityGroupName;
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported;

};


ProviderSpeciality := 

dataset('~thor_data400::base::ingenix_speciality', 
	          Layout_Providerspecialitygroup, flat);

export Basefile_ProviderSpeciality := ProviderSpeciality;

