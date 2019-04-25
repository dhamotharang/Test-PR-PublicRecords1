//************************************************************************************************************************************//
//IID Key files for Key Validation purposes
//************************************************************************************************************************************//
EXPORT IIDKeyFiles := MODULE
	Import InstantID_Archiving,KeyValidation,doxie, Data_Services,ut, ADVFiles,Autokey;

	//Attribute that refers to Report key file
	export keyFileReport := InstantID_Archiving.Key_Report;	

	//Attribute that refers to Report1 key file
	export keyFileReport1 := InstantID_Archiving.Key_Report1;

	//Attribute that refers to Report2 key file
	export keyFileReport2 := InstantID_Archiving.Key_Report2;

	//Attribute that refers to Report3 key file
	export keyFileReport3 := InstantID_Archiving.Key_Report3;

	//Attribute that refers to Report4 key file
	export keyFileReport4 := InstantID_Archiving.Key_Report4;

	//Attribute that refers to Report5 key file
	export keyFileReport5 := InstantID_Archiving.Key_Report5;

	//Attribute that refers to Report6 key file
	export keyFileReport6 := InstantID_Archiving.Key_Report6;

	//Attribute that refers to Verification key file
  export keyFileVerification := InstantID_Archiving.Key_Verification;

	//Attribute that refers to Risk key file
	export keyFileRisk := InstantID_Archiving.Key_Risk;

	//Attribute that refers to Model key file
	export keyFileModel := InstantID_Archiving.Key_Model;

	//Attribute that refers to ModelRisk key file
	export keyFileModelRisk := InstantID_Archiving.Key_ModelRisk;

	//Attribute that refers to DateAdded key file
	export keyFileDateAdded	:= InstantID_Archiving.Key_DateAdded;		

	//Attribute that refers to RiskIndex key file
	export keyFile_ModelIndex	:= InstantID_Archiving.Key_RiskIndex;	

	//Attribute that refers to Redflags key file
	export keyFile_RedFlags	:= InstantID_Archiving.Key_RedFlags;

	//Attribute that refers to Payload key file
	export keyFile_Payload	:= InstantID_Archiving.Key_Payload;	

	//Attribute that refers to AutokeyPayload key file
	keyFile_AutoKeyPayload_1	:= InstantID_Archiving.Key_AutokeyPayload;

	keyFile_AutoPayload_name := KeyValidation.applyNormalize(keyFile_AutoKeyPayload_1,['lname','fname'],['if(c=1, l.lname,l.lname2)','if(c=1, l.fname,l.fname2)'],
																														['qa_defined_empty'],2);

	export keyFile_AutoKeyPayload := KeyValidation.applyNormalize(keyFile_AutoPayload_name,['zip5','st','prim_name','prim_range','sec_range'],['if(c=1, l.zip5,l.zip52)',
																													'if(c=1, l.st,l.st2)','if(c=1, ut.stripOrdinal(l.prim_name),ut.stripOrdinal(l.prim_name2))',
																													'if(c=1, TRIM(ut.CleanPrimRange(l.prim_range),left), TRIM(ut.CleanPrimRange(l.prim_range2),left))',
																													'if(c=1, l.sec_range,l.sec_range2)'],['qa_defined_empty'],2);

	//Attribute that refers to Address Autokey key file																									
	export keyFile_AutoKeyAddress := Autokey.Key_Address(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::key::instantid_archiving::autokey::qa::');

	//Attribute that refers to CityStName Autokey key file
	export keyFile_AutoKeycitystname := Autokey.Key_CityStName(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::key::instantid_archiving::autokey::qa::');

	//Attribute that refers to Name Autokey key file
	export keyFile_AutoKeyname := Autokey.Key_Name(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::key::instantid_archiving::autokey::qa::');

	//Attribute that refers to SSN2 Autokey key file
	export keyFile_AutoKeySSN2 := Autokey.Key_SSN2(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::key::instantid_archiving::autokey::qa::');

	//Attribute that refers to StName Autokey key file
	export keyFile_AutoKeyStName := Autokey.Key_StName(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::key::instantid_archiving::autokey::qa::');

	//Attribute that refers to Zip Autokey key file
	export keyFile_AutoKeyZip := Autokey.Key_Zip(Data_Services.Data_location.Prefix('INSTANTIDARCHIVING')+'thor_data400::key::instantid_archiving::autokey::qa::');
	
END;