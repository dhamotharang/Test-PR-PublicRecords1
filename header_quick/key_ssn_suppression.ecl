import header,watchdog,doxie,ut;

suppression_file0 := header_quick.file_ssn_suppression;

//drop the crlf
r1 := record
 suppression_file0.ssn;
 suppression_file0.ssn_mask;
 suppression_file0.rc;
end;

suppression_file1 := table(suppression_file0,r1);

suppression_file := dataset([
{'','',''}
],r1);

export 	key_ssn_suppression := 
index(suppression_file,
{ssn},{suppression_file},
'~thor_data400::key::ssn_suppression_'+doxie.Version_SuperKey);