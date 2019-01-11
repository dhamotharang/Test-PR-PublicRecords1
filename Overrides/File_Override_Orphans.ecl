IMPORT data_services;

EXPORT File_Override_Orphans := module

export orphan_rec := record
string20 datagroup;
string20 flag_file_ID;
string12 DID;
string100 recID;
end;

export orphan_file := dataset(data_services.foreign_prod + 'thor_data400::lookup::override::orphans', orphan_rec, flat);

end;
