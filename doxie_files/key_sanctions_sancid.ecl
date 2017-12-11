Import Data_Services, Ingenix_NatlProf, doxie, Data_Services;

temp_rec := record
  string12	Bdid;
  unsigned6 BDID_Score; 
  ingenix_natlprof.layout_sanctions_did_file;
end;

bdided_file := Ingenix_NatlProf.Basefile_Sanctions_Bdid;

// Need to convert bdid from unsigned6 to string12 because of all the places 
// this attribute is used.
base_file := project(bdided_file,transform(temp_rec,self.bdid := (string12) left.bdid, self := left) );
dedup_base := dedup(base_file, record, all, local);

export key_sanctions_sancid := index(dedup_base,//base_file,
																		 {unsigned6 l_sancid := (unsigned6)SANC_ID},
																		 {base_file},
																		 Data_Services.Data_Location.Prefix('Provider')+'thor_data400::key::ingenix_sanctions_sancid_' + doxie.Version_SuperKey);
												