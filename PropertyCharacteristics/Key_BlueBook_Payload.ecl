import autokeyb2,doxie,ut;

fakepf	:=	PropertyCharacteristics.File_Property_AutoKey;

autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',0,0,PropertyCharacteristics.Constants.CLUSTER+'key::propertybluebook::qa::autokey::payload',plk,'');

export	Key_BlueBook_Payload	:=	plk;