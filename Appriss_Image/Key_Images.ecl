import doxie,Data_Services;

// i := INDEX(dataset([],{ string2 rtype,  string15 booking_sid,  
                        // unsigned2 seq,  unsigned2 num,  string8 date,  unsigned4 imglength,unsigned8 __filepos}), 
												// {string2 rtype,  string15 booking_sid,  
                        // unsigned2 seq,  unsigned2 num,  string8 date,  unsigned4 imglength,unsigned8 __filepos}, 
												// Data_Services.Data_location.Prefix('Appriss') + 'Appriss_images::key::Matrix_Images_'+doxie.Version_SuperKey);


i := INDEX(File_Images, Layout_key_booking_id,  Data_Services.Data_location.Prefix('Appriss') + 'Appriss_images::key::Matrix_Images_' + doxie.Version_SuperKey);

export Key_Images := i;