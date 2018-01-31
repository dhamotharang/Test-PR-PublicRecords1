Import Data_Services,  doxie, ut,Prof_License;

// Get the file output based upon lnpid and prolic_keys being qualified
profln := Prof_License.File_prof_license_base_AID (lnpid > 0 and prolic_key <> '');

// This is the base file from Prof_LicenseV2.KeyProflic_Did
df := Prof_LicenseV2.File_Proflic_Base_Keybuild;

// Distribute both files in preparation for the join
distprofln := distribute(profln, hash(source_rec_id));
distdf     := distribute(df, hash(source_rec_id));

// Join the two files based upon a number of key parameters to eliminate spurrious duplications
joindist   := join(distdf, distprofln, left.prolic_key    = right.prolic_key    and
                                       left.source_rec_id = right.source_rec_id and
                                       left.fname         = right.fname         and
                                       left.mname         = right.mname         and
                                       left.lname         = right.lname         and
                                       left.name_suffix   = right.name_suffix,
                                       local);

// Dedup the result
ln_unique:=dedup(sort(distribute(joindist, lnpid),lnpid, prolic_key, prolic_seq_id, local),prolic_seq_id, prolic_key, lnpid, local);

// Create the index file
export Key_Proflic_lnpid := index(ln_unique,
                                  {lnpid}, {prolic_key, prolic_seq_id},
                                  Data_Services.Data_location.Prefix()+
                                  'thor_data400::key::prolicv2::'+ doxie.Version_SuperKey +'::prolicense_lnpid'); 
