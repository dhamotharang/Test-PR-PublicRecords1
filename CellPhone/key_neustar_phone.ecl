import doxie, data_services;


f_neustar := CellPhone.fileNeuStar;


export key_neustar_phone := index(f_neustar(trim(cellphone,left,right)<> '')
                                  ,{cellphone}
                                  ,{cellphone}
                                  ,data_services.data_location.prefix() + 'thor_data400::key::neustar_phone_qa');