import doxie,Data_Services;

df 	:= File_Images;
ds 	:= dataset([],Layout_Key_id);

i 	:= INDEX(ds , {state,rtype,id,seq,num,date,imglength},{__filepos}, Data_Services.Data_location.Prefix('Images')+'criminal_images::key::Matrix_Images_' + doxie.Version_SuperKey);

//i := INDEX(File_Images, images.Layout_key_id, '~criminal_images::key::Matrix_Images_' + doxie.Version_SuperKey);

export Key_Images := i;