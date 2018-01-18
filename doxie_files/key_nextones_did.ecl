import doxie_files, doxie, data_services;

f_nextones := doxie_files.file_nextones_base;

nextones_rec := RECORD
	f_nextones;
	string25 city_name;
	string2 st;
END;

nextones_rec xpand_nexo(f_nextones le) :=  TRANSFORM 
     string zip_citys := ZipLib.ZipToCities(le.zip);
	self.city_name := map(zip_citys[1]='0' => '',
					  zip_citys[1]='1' => zip_citys[3..],
					  zip_citys[3..stringlib.StringFind(zip_citys,',',2)-1]);
	self.st := ZipLib.ZipToState2(le.zip);
	SELF := le; 
END;

f_nextones_exp := PROJECT(f_nextones,xpand_nexo(LEFT));

nextones_did := f_nextones_exp((unsigned)did<>0, (unsigned)MSISDN<>0);

export key_nextones_did := index(nextones_did,
                                {unsigned6 l_did := did},{nextones_did},
                                data_services.data_location.prefix() + 'thor_data400::key::nextones_did_'+doxie.Version_SuperKey);