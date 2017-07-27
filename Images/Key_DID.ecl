import doxie,Data_Services;

df 	:= File_Images;
ds 	:= dataset([],Layout_Key_did);
i 	:= INDEX(ds , {did,state,rtype,id,seq,num,date,imglength},{__filepos}, Data_Services.Data_location.Prefix('Images')+'images::key::Matrix_Images_did_' + doxie.Version_SuperKey);

//i := INDEX(File_Images, Layout_key_did, '~images::key::Matrix_Images_did_'+doxie.Version_SuperKey);

export Key_DID := i;