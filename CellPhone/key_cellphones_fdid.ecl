import doxie, autokey, data_services;

f_cellphones := Cellphone.file_cellphones_base;

xl_cellphones := RECORD
	f_cellphones;
	unsigned6 fdid;
END;

xl_cellphones xpand_cellpho(f_cellphones le, integer cellpho_cntr) :=  TRANSFORM 
	SELF.fdid := cellpho_cntr + autokey.did_adder('NXTO'); 
	SELF := le; 
END;

DS_cellpho_xpand := project(f_cellphones, xpand_cellpho(left, counter));

export key_cellphones_fdid := index(DS_cellpho_xpand,{fdid},{DS_cellpho_xpand},
                                  data_services.data_location.prefix() + 'thor_data400::key::cellphones_fdids_' + doxie.Version_SuperKey);