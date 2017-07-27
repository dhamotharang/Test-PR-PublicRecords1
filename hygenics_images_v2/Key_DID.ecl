import doxie, data_services;

df 	:= File_Images;
ds 	:= dataset([],Layout_Key_did);
i 	:= INDEX(ds , {did,state,rtype,id,seq,num,date,imglength},{__filepos}, Data_Services.Data_location.Prefix('Images')+'criminal_images_v2::key::Matrix_Images_did_' + doxie.Version_SuperKey);

export Key_DID := i;