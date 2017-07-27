import doxie, data_services;

df 	:= File_Images;
ds 	:= dataset([],Layout_Key_did);
i 	:= INDEX(ds , {did,state,rtype,id,seq,num,date,imglength},{__filepos}, Data_Services.Data_location.Prefix('Images')+'criminal_images::key::Matrix_Images_did_' + doxie.Version_SuperKey);

//i := INDEX(hygenics_images.File_Images, hygenics_images.Layout_key_did, '~criminal_images::key::Matrix_Images_did_'+doxie.Version_SuperKey);

export Key_DID := i;