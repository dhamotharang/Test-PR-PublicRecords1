IMPORT Data_Services,Seed_Files;

d := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN') + '~thor_data400::base::testseed_identifier2', Seed_Files.layout_identifier2, CSV(QUOTE('"'),HEADING(1)));

newrec := RECORD
	DATA16 hashvalue := seed_files.Hash_InstantID(d.name_first,d.name_last,d.ssn,'',d.zip5,d.home_phone,'');
	d;
END;

newtable := TABLE(d,newrec);

EXPORT Key_Identifier2 := INDEX(newtable,{table_name,hashvalue},
                                  {newtable},
																	Data_Services.Data_location.Prefix('NONAMEGIVEN') + '~thor_data400::key::testseed::qa::identifier2');
																	