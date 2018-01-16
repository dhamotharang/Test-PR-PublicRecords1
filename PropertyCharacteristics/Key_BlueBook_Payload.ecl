import autokeyb2,doxie,Data_Services;

fakepf	:=	PropertyCharacteristics.File_Property_AutoKey;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',0,0,Data_Services.Data_location.Prefix()+'thor_data400::key::propertybluebook::qa::autokey::payload',plk,'');

export	Key_BlueBook_Payload	:=	plk;