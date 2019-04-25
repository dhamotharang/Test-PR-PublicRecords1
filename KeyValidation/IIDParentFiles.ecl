//************************************************************************************************************************************//
//IID Parent files used for key validation purposes
//************************************************************************************************************************************//
EXPORT IIDParentFiles := MODULE

Import InstantID_Archiving,KeyValidation,doxie, Data_Services,ut, ADVFiles,Autokey;

	//Attribute that refers to Report parent 
	EXPORT parentFileKeyReport := InstantID_Archiving.files_report.reportFile;

	//Attribute that refers to Report1 parent 
	EXPORT parentFileKeyReport1 := InstantID_Archiving.files_report.reportFile1;

	//Attribute that refers to Report2 parent 
	EXPORT parentFileKeyReport2 := InstantID_Archiving.files_report.reportFile2;

	//Attribute that refers to Report3 parent 
	EXPORT parentFileKeyReport3 := InstantID_Archiving.files_report.reportFile3;

	//Attribute that refers to Report4 parent 
	EXPORT parentFileKeyReport4 := InstantID_Archiving.files_report.reportFile4;

	//Attribute that refers to Report5 parent 
  EXPORT parentFileKeyReport5 := InstantID_Archiving.files_report.reportFile5;
	
	//Attribute that refers to Report6 parent 
	EXPORT parentFileKeyReport6 := InstantID_Archiving.files_report.reportFile6;	

	//Attribute that refers to Verification parent 
	InstantIDi_Verification_base := InstantID_Archiving.Files.InstantIDi_Verification_base;																
																
	EXPORT parentFileKeyVerification := PROJECT(InstantIDi_Verification_base,
																			 TRANSFORM({STRING25 product := 'INSTANTID INTERNATIONAL', InstantID_Archiving.Layouts.Verification}, 
																										SELF.date_added := stringlib.stringfilter(LEFT.date_added, ' 0123456789');
																										SELF := LEFT));

	//Attribute that refers to Risk parent  
	{STRING25 product, InstantID_Archiving.Layouts.Risk} 
	trInFIleRisk(InstantID_Archiving.Layouts.Risk L, STRING product) := TRANSFORM
		SELF.product := product;
		SELF.date_added := stringlib.stringfilter(L.date_added, ' 0123456789');
		SELF := L;
	END;


	InstantID_Risk_base	 := InstantID_Archiving.Files.InstantID_Risk_base;
	
	InstantIDi_Risk_base := InstantID_Archiving.Files.InstantIDi_Risk_base;

	FlexID_Risk_base     := InstantID_Archiving.Files.FlexID_Risk_base;

	InpFile1_InstantID_Risk_base := PROJECT(InstantID_Risk_base, trInFIleRisk(LEFT, 'INSTANTID')); 

	InpFile2_InstantID_Risk_base := PROJECT(InstantIDi_Risk_base, trInFIleRisk(LEFT, 'INSTANTID INTERNATIONAL')); 

	InpFile3_InstantID_Risk_base := PROJECT(FlexID_Risk_base, trInFIleRisk(LEFT, 'FLEXID'));

	InpFile4_InstantID_Risk_base := PROJECT(InstantID_Archiving.Files_Batch.InstantID_Risk, trInFIleRisk(LEFT, 'INSTANTID')); 

	InpFile5_InstantID_Risk_base := PROJECT(InstantID_Archiving.Files_Batch.FlexID_Risk, trInFIleRisk(LEFT, 'FLEXID')); 

	EXPORT parentFileKeyRisk := InpFile1_InstantID_Risk_base + InpFile2_InstantID_Risk_base + InpFile3_InstantID_Risk_base + InpFile4_InstantID_Risk_base + InpFile5_InstantID_Risk_base;

	//Attribute that refers to Model parent 
	{STRING25 product, InstantID_Archiving.Layouts.Model}
  trInFIleModel(InstantID_Archiving.Layouts.Model L, STRING product) := TRANSFORM
		SELF.product := product;
		SELF.date_added := stringlib.stringfilter(L.date_added, ' 0123456789');
		SELF := L;
	END;

	InstantID_Model_base := InstantID_Archiving.Files.InstantID_Model_base;
	
	FlexID_Model_base	   := InstantID_Archiving.Files.FlexID_Model_base;														

	InpFile1_Model := PROJECT(InstantID_Model_base, trInFIleModel(LEFT, 'INSTANTID')); 

	InpFile2_Model := PROJECT(FlexID_Model_base, trInFIleModel(LEFT, 'FLEXID')); 

	InpFile3_Model := PROJECT(InstantID_Archiving.Files_Batch.InstantID_Model, trInFIleModel(LEFT, 'INSTANTID')); 

	InpFile4_Model := PROJECT(InstantID_Archiving.Files_Batch.FlexID_Model, trInFIleModel(LEFT, 'FLEXID')); 

	EXPORT parentFileKeyModel := InpFile1_Model + InpFile2_Model + InpFile3_Model + InpFile4_Model;
	

	//Attribute that refers to Modelrisk parent 
{STRING25 product, InstantID_Archiving.Layouts.ModelRisk}
  trInFIleModelRisk(InstantID_Archiving.Layouts.ModelRisk L, STRING product) := TRANSFORM
		SELF.product := product;
		SELF.date_added := stringlib.stringfilter(L.date_added, ' 0123456789');
		SELF := L;
	END;


	InstantID_ModelRisk_base   := InstantID_Archiving.Files.InstantID_ModelRisk_base;
	
	FlexID_ModelRisk_base	     := InstantID_Archiving.Files.FlexID_ModelRisk_base;

	InpFile1_ModelRisk := PROJECT(InstantID_ModelRisk_base, trInFIleModelRisk(LEFT, 'INSTANTID')); 

	InpFile2_ModelRisk := PROJECT(FlexID_ModelRisk_base, trInFIleModelRisk(LEFT, 'FLEXID')); 

	InpFile3_ModelRisk := PROJECT(InstantID_Archiving.Files_Batch.InstantID_Modelrisk, trInFIleModelRisk(LEFT, 'INSTANTID')); 

	InpFile4_ModelRisk := PROJECT(InstantID_Archiving.Files_Batch.FlexID_Modelrisk, trInFIleModelRisk(LEFT, 'FLEXID')); 

	EXPORT parentFileKeyModelRisk := InpFile1_ModelRisk + InpFile2_ModelRisk + InpFile3_ModelRisk + InpFile4_ModelRisk;
	

	//Attribute that refers to DateAdded parent 	
{STRING8 date_added, STRING30 product, STRING25 transaction_id, STRING20 company_id, STRING40 country}
   trInFIle_DateAdded(InstantID_Archiving.Layout_Base L) := TRANSFORM
		 SELF.product := L.product;
		 SELF.date_added := STRINGLIB.STRINGFILTER(L.date_added, '0123456789')[..8];
		 SELF := L;
	 END;
																
	EXPORT parentFileKey_DateAdded := PROJECT(InstantID_Archiving.Files_Base.Delta + InstantID_Archiving.Files_Base_Batch.key_files, trInFIle_DateAdded(LEFT)); 


	//Attribute that refers to RiskIndex parent 
	{STRING25 product, InstantID_Archiving.Layouts.ModelIndex}
  trInFIle_ModelIndex(InstantID_Archiving.Layouts.ModelIndex L, STRING product) := TRANSFORM
		SELF.product := product;
		SELF.date_added := stringlib.stringfilter(L.date_added, ' 0123456789');
		SELF := L;
	END;

	InstantID_ModelIndex_base  := InstantID_Archiving.Files.InstantID_ModelIndex_base;
	
	EXPORT parentFileKey_ModelIndex := PROJECT(InstantID_ModelIndex_base + InstantID_Archiving.Files_Batch.InstantID_ModelIndex, trInFile_ModelIndex(LEFT, 'INSTANTID')); 
	

	//Attribute that refers to Redflags parent 
	InstantID_RedFlags_base    := InstantID_Archiving.Files.InstantID_RedFlags_base;																
																
	EXPORT parentFileKey_RedFlags := PROJECT(InstantID_RedFlags_base + InstantID_Archiving.Files_Batch.InstantID_RedFlags, 
		TRANSFORM({STRING25 product := 'INSTANTID', InstantID_Archiving.Layouts.RedFlags}, 
			SELF.date_added := stringlib.stringfilter(LEFT.date_added, ' 0123456789');
			SELF := LEFT));

	//Attribute that refers to payload parent 
	EXPORT parentKeyFile_Payload := InstantID_Archiving.Files_Base.Delta +  InstantID_Archiving.Files_Base_Batch.key_files;

	//Attribute that refers to payload autokey parent 	
		pBase_AutoKeyPayload := InstantID_Archiving.Files_Base.Delta + InstantID_Archiving.Files_Base_Batch.key_files;
	
	parentKeyFile_AutoKeyPayload_1 := PROJECT(pBase_AutoKeyPayload, 
	TRANSFORM({InstantID_Archiving.Layout_Base, unsigned6 did := 0, unsigned6 bdid := 0},
			SELF.bdid := LEFT.transaction_id_key;
			SELF.did :=LEFT.transaction_id_key;
			SELF := LEFT));

	//Normalizing parent and key autokey files to produce combinations of lname, fname, zip5, st, prim_name, prim_range, sec_range fields.	
	parentKeyFile_AutoKeyPayload_name := KeyValidation.applyNormalize(parentKeyFile_AutoKeyPayload_1,['lname','fname'],['if(c=1, l.lname,l.lname2)','if(c=1, l.fname,l.fname2)'],
																																		['qa_defined_empty'],2);
	
	EXPORT parentKeyFile_AutoKeyPayload := KeyValidation.applyNormalize(parentKeyFile_AutoKeyPayload_name,['zip5','st','prim_name','prim_range','sec_range'],['if(c=1, l.zip5,l.zip52)',
																																'if(c=1, l.st,l.st2)','if(c=1, ut.stripOrdinal(l.prim_name),ut.stripOrdinal(l.prim_name2))',
																																'if(c=1, TRIM(ut.CleanPrimRange(l.prim_range),left), TRIM(ut.CleanPrimRange(l.prim_range2),left))',
																																'if(c=1, l.sec_range,l.sec_range2)'],['qa_defined_empty'],2);
																																
																																

	//Attribute that refers to autokey payload key parent 
	keyFile_AutoKeyPayload_1	:= InstantID_Archiving.Key_AutokeyPayload;

	keyFile_AutoPayload_name := KeyValidation.applyNormalize(keyFile_AutoKeyPayload_1,['lname','fname'],['if(c=1, l.lname,l.lname2)','if(c=1, l.fname,l.fname2)'],
																														['qa_defined_empty'],2);

	EXPORT keyFile_AutoKeyPayload := KeyValidation.applyNormalize(keyFile_AutoPayload_name,['zip5','st','prim_name','prim_range','sec_range'],['if(c=1, l.zip5,l.zip52)',
																													'if(c=1, l.st,l.st2)','if(c=1, ut.stripOrdinal(l.prim_name),ut.stripOrdinal(l.prim_name2))',
																													'if(c=1, TRIM(ut.CleanPrimRange(l.prim_range),left), TRIM(ut.CleanPrimRange(l.prim_range2),left))',
																													'if(c=1, l.sec_range,l.sec_range2)'],['qa_defined_empty'],2);																																
	
	

END;