import doxie, data_services;

suppression_file0 := header_quick.file_ssn_suppression;

//drop the crlf
r1 := record
 suppression_file0.ssn;
 suppression_file0.ssn_mask;
 suppression_file0.rc;
end;

suppression_file := table(suppression_file0,r1);

export 	key_ssn_suppression := 
index(suppression_file,
{ssn},{suppression_file},
data_services.data_location.prefix() + 'thor_data400::key::ssn_suppression_'+doxie.Version_SuperKey);