import doxie_files, ut, doxie, autokey;

f_nextones := doxie_files.file_nextones_base;

xl_nextones := RECORD
	f_nextones;
	unsigned6 fdid;
	string25 city_name;
	string2 st;
END;

xl_nextones xpand_nexo(f_nextones le, integer nxto_cntr) :=  TRANSFORM 
	string zip_citys := ZipLib.ZipToCities(le.zip);
	SELF.fdid := nxto_cntr + autokey.did_adder('NXTO'); 
	self.city_name := map(zip_citys[1]='0' => '',
					  zip_citys[1]='1' => zip_citys[3..],
					  zip_citys[3..stringlib.StringFind(zip_citys,',',2)-1]);
	self.st := ZipLib.ZipToState2(le.zip);
	SELF := le; 
END;

DS_nxto_xpand := project(f_nextones, xpand_nexo(left, counter));

export key_nextones_fdid := index(DS_nxto_xpand,{fdid},{DS_nxto_xpand},
                                  '~thor_data400::key::nextones_fdids_' + doxie.Version_SuperKey);