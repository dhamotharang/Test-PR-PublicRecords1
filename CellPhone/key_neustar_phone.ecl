import doxie_files, doxie,ut;


f_neustar := CellPhone.fileNeuStar;


export key_neustar_phone := index(f_neustar(trim(cellphone,left,right)<> '')
                                  ,{cellphone}
								  ,{cellphone}
								  ,'~thor_data400::key::neustar_phone_qa');