﻿/*--SOAP--
<message name="BRM_Marketing_Attr_Batch_Services">
	<part name="Batch_In" type="tns:XmlDataSet" cols="100" rows="25"/>
	<part name="ScoreThreshold" type="xsd:integer"/>
	<part name="BIPAppendScoreThreshold" type="xsd:integer"/>
	<part name="BIPAppendWeightThreshold" type="xsd:integer"/>
	<part name="BIPAppendPrimForce" type="xsd:boolean"/>
	<part name="BIPAppendIncludeAuthRep" type="xsd:boolean"/>
	<part name="BIPAppendNoReAppend" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="GLBPurpose" type="xsd:integer"/>
	<part name="DPPAPurpose" type="xsd:integer"/>
	<part name="OverrideExperianRestriction" type="xsd:boolean"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="AllowedSources" type="xsd:string"/>
	<part name="AttributeVer1" type="xsd:string"/>
	<part name="AttributeVer2" type="xsd:string"/>
	<part name="LexIdSourceOptout" type="xsd:integer"/>
	<part name="_TransactionId" type="xsd:string"/>
	<part name="_BatchUID" type="xsd:string"/>
	<part name="_GCID" type="xsd:integer"/>
</message>
*/

IMPORT PublicRecords_KEL,Royalty,iesp,STD;
EXPORT BRM_Marketing_Attr_Batch_Services() := MACRO

		#OPTION('expandSelectCreateRow', TRUE);
		#WEBSERVICE(FIELDS(
		'Batch_In',
		'ScoreThreshold',
		'BIPAppendScoreThreshold',
		'BIPAppendWeightThreshold',
		'BIPAppendPrimForce',
		'BIPAppendIncludeAuthRep',
		'BIPAppendNoReAppend',
		'DataRestrictionMask',
		'DataPermissionMask',
		'GLBPurpose',
		'DPPAPurpose',
		'OverrideExperianRestriction',
		'IndustryClass',
		'AllowedSources',
		'AttributeVer1',
		'AttributeVer2',
		'LexIdSourceOptout',
   '_TransactionId',
   '_BatchUID',
   '_GCID'
  ));
	
	//  The following stored definations fix error of  "Duplicate definition of STORED('datarestrictionmask') with different type".
	STRING5 Default_Industry_Class := '';	
	#stored('IndustryClass',Default_Industry_Class);
	STRING100 Default_data_permission_mask := '';	
	#stored('DataPermissionMask',Default_data_permission_mask);
	UNSIGNED1 Default_GLB_Purpose := 0;
	#STORED('GLBPurpose', Default_GLB_Purpose);
	STRING100 Default_Data_Restriction_Mask := '';
	#STORED('DataRestrictionMask',Default_Data_Restriction_Mask);

	//batch input.		
	DATASET(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Batch_In_Layout) ds_input := DATASET([], BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Batch_In_Layout) : STORED('Batch_In');
	INTEGER Score_threshold := 80 : STORED('ScoreThreshold');
	STRING100 DataRestrictionMask := '' : STORED('DataRestrictionMask');
	STRING100 DataPermissionMask := '' : STORED('DataPermissionMask');
	UNSIGNED1 GLBA := 0 : STORED('GLBPurpose');
	UNSIGNED1 DPPA := 0 : STORED('DPPAPurpose');
	UNSIGNED BIPAppend_Score_Threshold := 75 : STORED('BIPAppendScoreThreshold');
	UNSIGNED BIPAppend_Weight_Threshold := 0 : STORED('BIPAppendWeightThreshold');
	BOOLEAN BIPAppend_PrimForce := FALSE : STORED('BIPAppendPrimForce');
	BOOLEAN BIPAppend_Include_AuthRep := FALSE : STORED('BIPAppendIncludeAuthRep');
	BOOLEAN BIPAppend_No_ReAppend := TRUE : STORED('BIPAppendNoReAppend');
	BOOLEAN Is_Marketing := TRUE;
	BOOLEAN is_FCRA := FALSE;
	BOOLEAN OverrideExperianRestriction := FALSE : STORED('OverrideExperianRestriction');
	STRING100 AllowedSources := '' : STORED('AllowedSources');	
	STRING5 Industry_Class := Default_Industry_Class : STORED('IndustryClass');
	//CCPA fields
	UNSIGNED1 _LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
	STRING _TransactionId := '' : STORED ('_TransactionId');
	STRING100 _BatchUID := '' : STORED('_BatchUID');
	UNSIGNED6 _GCID := 0 : STORED('_GCID');
	
	STRING AttributeVer1_in := ''  : STORED('AttributeVer1');
	STRING AttributeVer2_in := '' : STORED('AttributeVer2');
	
	STRING ModelName1_in := '' : STORED('ModelName1');
	STRING ModelName2_in := '' : STORED('ModelName2');
	STRING ModelName3_in := '' : STORED('ModelName3');
	STRING ModelName4_in := '' : STORED('ModelName4');
	STRING ModelName5_in := '' : STORED('ModelName5');

	BOOLEAN Allow_DNBDMI := STD.Str.Find( AllowedSources, Business_Risk_BIP.Constants.AllowDNBDMI, 1 ) > 0; // When TRUE this will unmask DNB DMI data - NO CUSTOMERS CAN USE THIS, FOR RESEARCH PURPOSES ONLY
	#STORED('AllowAll', Allow_DNBDMI); // If DNBDMI is allowed, set AllowAll to TRUE for Business Best test

	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := Score_threshold;
		EXPORT STRING100 Data_Restriction_Mask := DataRestrictionMask;
		EXPORT STRING100 Data_Permission_Mask := DataPermissionMask;
		EXPORT UNSIGNED GLBAPurpose := GLBA;
		EXPORT UNSIGNED DPPAPurpose := DPPA;
		EXPORT BOOLEAN isFCRA := is_FCRA;
		EXPORT STRING100 Allowed_Sources := AllowedSources;
		EXPORT STRING IndustryClass := Industry_Class; // When set to UTILI or DRMKT this restricts Utility data
		EXPORT BOOLEAN Override_Experian_Restriction := OverrideExperianRestriction;
		EXPORT DATA100 KEL_Permissions_Mask := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
			DataRestrictionMask, 
			DataPermissionMask, 
			GLBA, 
			DPPA, 
			FALSE,//isfcra
			TRUE, //ismarketing
			0, //Allow_DNBDMI
			FALSE,//OverrideExperianRestriction
			'',//PermissiblePurpose - For FCRA Products Only
			Industry_Class,
			PublicRecords_KEL.CFG_Compile);
		
		// BIP Append Options
		EXPORT UNSIGNED BIPAppendScoreThreshold := IF(BIPAppend_Score_Threshold = 0, 75, MIN(MAX(51,BIPAppend_Score_Threshold), 100)); // Score threshold must be between 51 and 100 -- default is 75.
		EXPORT UNSIGNED BIPAppendWeightThreshold := BIPAppend_Weight_Threshold;
		EXPORT BOOLEAN BIPAppendPrimForce := BIPAppend_PrimForce;
		EXPORT BOOLEAN BIPAppendReAppend := NOT BIPAppend_No_ReAppend;
		EXPORT BOOLEAN BIPAppendIncludeAuthRep := BIPAppend_Include_AuthRep;
		// CCPA Options
		EXPORT UNSIGNED1 LexIdSourceOptout := _LexIdSourceOptout;
		EXPORT STRING100 TransactionID := _TransactionId;                                
		EXPORT STRING100 BatchUID := _BatchUID;
		EXPORT UNSIGNED6 GlobalCompanyId := _GCID;				

		//default options in PublicRecords_KEL.Interface_Options have been changed to FALSE
		EXPORT BOOLEAN IncludeAircraft := TRUE;
		EXPORT BOOLEAN IncludeAddress := TRUE;
		EXPORT BOOLEAN IncludeBankruptcy := TRUE;
		EXPORT BOOLEAN IncludeBusinessSele := TRUE;
		EXPORT BOOLEAN IncludeBusinessProx := TRUE;
		EXPORT BOOLEAN IncludeCriminalOffender := TRUE;
		EXPORT BOOLEAN IncludeEducation := TRUE;
		EXPORT BOOLEAN IncludeEmail := TRUE;
		EXPORT BOOLEAN IncludeLienJudgment := TRUE;
		EXPORT BOOLEAN IncludePerson := TRUE;
		EXPORT BOOLEAN IncludeProperty := TRUE;
		EXPORT BOOLEAN IncludePropertyEvent := TRUE;
		EXPORT BOOLEAN IncludeTradeline := TRUE;
		EXPORT BOOLEAN IncludeVehicle := TRUE;
		EXPORT BOOLEAN IncludeWatercraft := TRUE;
		EXPORT BOOLEAN IncludeUCC := TRUE;
    
  END;	
				
	//For now we have only one version of the attributes V1.There are 2 fields for attributes now just in case we will be having new version sooner.
	AttrsRequested := DATASET([ {STD.Str.ToUpperCase(AttributeVer1_in)},{STD.Str.ToUpperCase(AttributeVer2_in)} ],BRM_Marketing_Attributes.Layout_BRM_NonFCRA.AttributeGroupRec);
	allow_MA_attrs_only := EXISTS(AttrsRequested(AttributeGroup = STD.Str.ToUpperCase(BRM_Marketing_Attributes.Constants.Include_MA_attrs)));   
	
	BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Batch_Input getInput(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Batch_In_Layout le, UNSIGNED4 c) := TRANSFORM
	SELF.G_ProcBusUID := c; 
	SELF := le;
	END;
	
	batchin_with_UID := project(ds_input, getInput(LEFT, COUNTER));
	
	//minimum input requirement
	MinimumInputMet():= MACRO
	(((trim(CompanyName)<>'' OR trim(AlternateCompanyName)<>'') AND
							(trim(StreetAddressLine1)<>'' OR trim(StreetAddressLine2)<>'') AND
								((trim(Zip1)<>'') OR (trim(City1)<>'' AND trim(State1)<>''))) OR
								(trim(seleID) <>''))	
								
								ENDMACRO;

	valid_inputs := IF(allow_MA_attrs_only,batchin_with_UID(MinimumInputMet()));
						
	ResultSet := BRM_Marketing_Attributes.Fn_Get_All_BRM_Attrs(valid_inputs, Options);	
													
	FinalSet := join(batchin_with_UID,ResultSet, left.g_procbusUID = right.g_procbusUID,
													TRANSFORM(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Intermediate_Layout,
													self.AcctNo:= Left.AcctNo,
													self:=Left,self :=Right,self :=[]),left outer);
                                            			
 BRM_Marketing_Attributes.Layout_BRM_NonFCRA.BatchOutput xfm_to_Results(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Intermediate_Layout le) :=
		TRANSFORM
			model_result_1 := ROW( le.ModelResults[1], iesp.business_marketing.t_BRMModelHRI );
			model_result_2 := ROW( le.ModelResults[2], iesp.business_marketing.t_BRMModelHRI );
			model_result_3 := ROW( le.ModelResults[3], iesp.business_marketing.t_BRMModelHRI );
			model_result_4 := ROW( le.ModelResults[4], iesp.business_marketing.t_BRMModelHRI );
			model_result_5 := ROW( le.ModelResults[5], iesp.business_marketing.t_BRMModelHRI );
			
			SELF.Model_1_Name      := model_result_1.name; 
			SELF.Model_1_Score     := (STRING)model_result_1.Scores[1].Value;
			SELF.Model_1_RC1       := model_result_1.Scores[1].ScoreReasons[1].ReasonCode;
			SELF.Model_1_RC2       := model_result_1.Scores[1].ScoreReasons[2].ReasonCode;
			SELF.Model_1_RC3       := model_result_1.Scores[1].ScoreReasons[3].ReasonCode;
			SELF.Model_1_RC4       := model_result_1.Scores[1].ScoreReasons[4].ReasonCode;
			SELF.Model_1_RC5       := model_result_1.Scores[1].ScoreReasons[5].ReasonCode;
			SELF.Model_2_Name      := model_result_2.name;
			SELF.Model_2_Score     := (STRING)model_result_2.Scores[1].Value;
			SELF.Model_2_RC1       := model_result_2.Scores[1].ScoreReasons[1].ReasonCode;
			SELF.Model_2_RC2       := model_result_2.Scores[1].ScoreReasons[2].ReasonCode;
			SELF.Model_2_RC3       := model_result_2.Scores[1].ScoreReasons[3].ReasonCode;
			SELF.Model_2_RC4       := model_result_2.Scores[1].ScoreReasons[4].ReasonCode;
			SELF.Model_2_RC5       := model_result_2.Scores[1].ScoreReasons[5].ReasonCode;
			SELF.Model_3_Name      := model_result_2.name;
			SELF.Model_3_Score     := (STRING)model_result_3.Scores[1].Value;
			SELF.Model_3_RC1       := model_result_3.Scores[1].ScoreReasons[1].ReasonCode;
			SELF.Model_3_RC2       := model_result_3.Scores[1].ScoreReasons[2].ReasonCode;
			SELF.Model_3_RC3       := model_result_3.Scores[1].ScoreReasons[3].ReasonCode;
			SELF.Model_3_RC4       := model_result_3.Scores[1].ScoreReasons[4].ReasonCode;
			SELF.Model_3_RC5       := model_result_3.Scores[1].ScoreReasons[5].ReasonCode;
			SELF.Model_4_Name      := model_result_4.name;
			SELF.Model_4_Score     := (STRING)model_result_4.Scores[1].Value;
			SELF.Model_4_RC1       := model_result_4.Scores[1].ScoreReasons[1].ReasonCode;
			SELF.Model_4_RC2       := model_result_4.Scores[1].ScoreReasons[2].ReasonCode;
			SELF.Model_4_RC3       := model_result_4.Scores[1].ScoreReasons[3].ReasonCode;
			SELF.Model_4_RC4       := model_result_4.Scores[1].ScoreReasons[4].ReasonCode;
			SELF.Model_4_RC5       := model_result_4.Scores[1].ScoreReasons[5].ReasonCode;
			SELF.Model_5_Name      := model_result_4.name;
			SELF.Model_5_Score     := (STRING)model_result_5.Scores[1].Value;
			SELF.Model_5_RC1       := model_result_5.Scores[1].ScoreReasons[1].ReasonCode;
			SELF.Model_5_RC2       := model_result_5.Scores[1].ScoreReasons[2].ReasonCode;
			SELF.Model_5_RC3       := model_result_5.Scores[1].ScoreReasons[3].ReasonCode;
			SELF.Model_5_RC4       := model_result_5.Scores[1].ScoreReasons[4].ReasonCode;
			SELF.Model_5_RC5       := model_result_5.Scores[1].ScoreReasons[5].ReasonCode;
			SELF := le;	
			SELF := [];
			END;
	
	Final_Results := PROJECT(FinalSet, xfm_to_Results(LEFT));
	
//joining invalid inputs with the valid output	
	ds_batch_input_NOT_having_minimum_input := 
    PROJECT(
      batchin_with_UID( NOT MinimumInputMet() ),
      TRANSFORM( BRM_Marketing_Attributes.Layout_BRM_NonFCRA.BatchOutput,
        SELF.error_msg := 'minimum input criteria not met';
        SELF := LEFT;
					SELF:=[];
      )
    );
		Final_output := Dedup(sort((Final_Results +ds_batch_input_NOT_having_minimum_input),g_procbusuid,-error_msg),g_procbusuid);
	//error message when the attribute name is not supplied.	
		Results := IF(NOT allow_MA_attrs_only,Project(Final_output,transform(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.BatchOutput, 
																			SELF.error_msg := 'minimum input criteria not met';
																			SELF := LEFT;
																			self:=[])),Final_output);

	output(Results,named('Results'));

 //For Cortera Tradeline Royalty for B2B attributes.
 	ds_B2Battributes := 
			PROJECT(
				Results,
				TRANSFORM( { INTEGER G_ProcBusUID,STRING AcctNo, INTEGER B2BAccountCount},
					SELF.G_ProcBusUID := LEFT.G_ProcBusUID,
					SELF.AcctNo := LEFT.AcctNo,
					SELF.B2BAccountCount :=
					      If((  LEFT.BE_B2BActvCnt>0 OR 
						           LEFT.BE_B2BActvCarrCnt> 0 OR 
						           LEFT.BE_B2BActvFltCnt > 0 OR 
						           LEFT.BE_B2BActvMatCnt > 0 OR 
						           LEFT.BE_B2BActvOpsCnt > 0 OR 
						           LEFT.BE_B2BActvOthCnt > 0 OR 
						           LEFT.BE_B2BActvBalTot > 0 OR 
						           LEFT.BE_B2BActvCarrBalTot > 0 OR 
						           LEFT.BE_B2BActvFltBalTot > 0 OR 
						           LEFT.BE_B2BActvMatBalTot > 0 OR 
						           LEFT.BE_B2BActvOpsBalTot > 0 OR 
						           LEFT.BE_B2BActvOthBalTot > 0 OR
						           (INTEGER)LEFT.BE_B2BActvBalTotRnge >0 OR
						           (INTEGER)LEFT.BE_B2BActvCarrBalTotRnge >0 OR
						           (INTEGER)LEFT.BE_B2BActvFltBalTotRnge >0 OR
						           (INTEGER)LEFT.BE_B2BActvMatBalTotRnge >0 OR
						           (INTEGER)LEFT.BE_B2BActvOpsBalTotRnge >0 OR
						           (INTEGER)LEFT.BE_B2BActvOthBalTotRnge >0 OR
						           (INTEGER)LEFT.BE_B2BActvWorstPerfIndx >0 OR
						           (INTEGER)LEFT.BE_B2BWorstPerfIndx2Y >0)
			,1,0)));
 		Cortera_royalties := Royalty.RoyaltyCorteraTradeline.GetBatchRoyaltiesByAcctno(batchin_with_UID, ds_B2Battributes);
		OUTPUT(Cortera_royalties, NAMED('RoyaltySet'));
		
ENDMACRO;   
