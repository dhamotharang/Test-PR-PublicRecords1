import data_services,Foreclosure_Vacancy,Seed_Files;

d := seed_files.file_FOVInteractive;

newrec := record
	data16 hashvalue := foreclosure_vacancy.functions.Hash_FOV(d.first_name_in, d.last_name_in, d.street_address_in, d.zip_in);
	d;
end;

newtable := table(d,newrec);

export key_FOVInteractive := index(newtable,{hashvalue,dataset_name},
																	{newtable},
																	Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::testseed::qa::FOV_Interactive');

