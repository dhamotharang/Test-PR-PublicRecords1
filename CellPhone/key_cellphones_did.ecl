import doxie, Cellphone, data_services;

f_cellphones := Cellphone.file_cellphones_base;

fcellphones_did := f_cellphones((unsigned)did<>0, (unsigned)CellPhone<>0);

export key_cellphones_did := index(fcellphones_did,
                                   {unsigned6 l_did := did},
                                   {fcellphones_did},
                                   data_services.data_location.prefix() + 'thor_data400::key::cellphones_did_'+doxie.Version_SuperKey);