import doxie,Data_Services;

df 	:= File_Images;
ds 	:= dataset([],Layout_Key_id);

i 	:= INDEX(ds , {state,rtype,id,seq,num,date,imglength},{__filepos}, Data_Services.Data_location.Prefix('Images')+'images_v2::key::Matrix_Images_' + doxie.Version_SuperKey);
//i 	:= INDEX(ds , {state,rtype,id,seq,num,date,imglength},{__filepos}, '~images_v2::key::Matrix_Images_' + doxie.Version_SuperKey);

//i := INDEX(File_Images, Layout_key_id, '~images::key::Matrix_Images_' + doxie.Version_SuperKey);

export Key_Images := i;