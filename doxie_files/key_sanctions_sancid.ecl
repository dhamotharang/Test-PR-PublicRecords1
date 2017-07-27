import Ingenix_NatlProf, doxie;

temp_rec := record
  string12	Bdid;
  unsigned6 BDID_Score; 
  recordOf(Ingenix_NatlProf.File_Sanctions_Cleaned_DIDed_dates);
end;

bdided_file := Ingenix_NatlProf.Sanctioned_providers_Bdid;

// Need to convert bdid from unsigned6 to string12 because of all the places 
// this attribute is used.
base_file := project(bdided_file,
                     transform(temp_rec,
										   self.bdid := (string12) left.bdid,
										   self      := left));

export key_sanctions_sancid := index(base_file,
                                 {unsigned6 l_sancid := (unsigned6)SANC_ID},
						   {base_file},
						   '~thor_data400::key::ingenix_sanctions_sancid_' + doxie.Version_SuperKey);
												