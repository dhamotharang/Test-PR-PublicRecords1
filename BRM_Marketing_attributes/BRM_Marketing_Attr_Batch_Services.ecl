/*--SOAP--
<message name="BRM_Marketing_Attr_Batch_Services">
	<part name="Batch_In" type="tns:XmlDataSet" cols="100" rows="25"/>
	<part name="ScoreThreshold" type="xsd:integer"/>
	<part name="BIPAppendScoreThreshold" type="xsd:integer"/>
	<part name="BIPAppendWeightThreshold" type="xsd:integer"/>
	<part name="BIPAppendPrimForce" type="xsd:boolean"/>
	<part name="BIPAppendIncludeAuthRep" type="xsd:boolean"/>
	<part name="BIPAppendReAppend" type="xsd:boolean"/>
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

IMPORT PublicRecords_KEL, Royalty, iesp, STD, BRM_Marketing_attributes, Business_Risk_BIP;
EXPORT BRM_Marketing_Attr_Batch_Services() := MACRO

		#OPTION('expandSelectCreateRow', TRUE);
		#WEBSERVICE(FIELDS(
		'Batch_In',
		'ScoreThreshold',
		'BIPAppendScoreThreshold',
		'BIPAppendWeightThreshold',
		'BIPAppendPrimForce',
		'BIPAppendIncludeAuthRep',
		'BIPAppendReAppend',
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
	STRING100 Default_data_restriction_mask := Business_Risk_BIP.Constants.Default_DataRestrictionMask;	
	#STORED('DataRestrictionMask',Default_data_restriction_mask);
	STRING100 Default_data_permission_mask := Business_Risk_BIP.Constants.Default_DataPermissionMask;	
	#STORED('DataPermissionMask',Default_data_permission_mask);
	UNSIGNED1 Default_GLB_Purpose := Business_Risk_BIP.Constants.Default_GLBA;
	#STORED('GLBPurpose', Default_GLB_Purpose);
	// #STORED('DPPAPurpose',Business_Risk_BIP.Constants.Default_DPPA);

	//batch input.		
	DATASET(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Batch_In_Layout) ds_input := DATASET([], BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Batch_In_Layout) : STORED('Batch_In');
	INTEGER Score_threshold := 80 : STORED('ScoreThreshold');
	STRING100 DataRestrictionMask := Business_Risk_BIP.Constants.Default_DataRestrictionMask : STORED('DataRestrictionMask');
	STRING100 DataPermissionMask :=  Business_Risk_BIP.Constants.Default_DataPermissionMask : STORED('DataPermissionMask');
	UNSIGNED1 GLBA := Business_Risk_BIP.Constants.Default_GLBA : STORED('GLBPurpose');
	UNSIGNED1 DPPA := Business_Risk_BIP.Constants.Default_DPPA : STORED('DPPAPurpose');
	UNSIGNED BIPAppend_Score_Threshold := 75 : STORED('BIPAppendScoreThreshold');
	UNSIGNED BIPAppend_Weight_Threshold := 0 : STORED('BIPAppendWeightThreshold');
	BOOLEAN BIPAppend_PrimForce := FALSE : STORED('BIPAppendPrimForce');
	BOOLEAN BIPAppend_Include_AuthRep := FALSE : STORED('BIPAppendIncludeAuthRep');
	BOOLEAN BIPAppend_ReAppend := TRUE : STORED('BIPAppendReAppend');
	BOOLEAN Is_Marketing := TRUE;
	BOOLEAN is_FCRA := FALSE;
	BOOLEAN OverrideExperianRestriction := FALSE : STORED('OverrideExperianRestriction');
	STRING100 AllowedSources := Business_Risk_BIP.Constants.Default_AllowedSources : STORED('AllowedSources');
	STRING5	IndustryClass_In := Business_Risk_BIP.Constants.Default_IndustryClass : STORED('IndustryClass');
	Industry_Class := STD.Str.ToUpperCase(TRIM(IndustryClass_In, LEFT, RIGHT));
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
    #CONSTANT('IsFCRA', FALSE);
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := Score_threshold;
		EXPORT STRING100 Data_Restriction_Mask := DataRestrictionMask;
		EXPORT STRING100 Data_Permission_Mask := DataPermissionMask;
		EXPORT UNSIGNED GLBAPurpose := GLBA;
		EXPORT UNSIGNED DPPAPurpose := DPPA;
		EXPORT BOOLEAN isFCRA := is_FCRA;
        EXPORT BOOLEAN isMarketing := Is_Marketing;

		EXPORT STRING100 Allowed_Sources := AllowedSources;
		EXPORT STRING5 IndustryClass := Industry_Class; // When set to UTILI or DRMKT this restricts Utility data
		EXPORT BOOLEAN Override_Experian_Restriction := OverrideExperianRestriction;
		EXPORT DATA57 KEL_Permissions_Mask := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
			DataRestrictionMask, 
			DataPermissionMask, 
			GLBA, 
			DPPA, 
			FALSE,//isfcra
			Is_Marketing, //ismarketing
			0, //Allow_DNBDMI
			Override_Experian_Restriction,//OverrideExperianRestriction
			'',//PermissiblePurpose - For FCRA Products Only
			Industry_Class,
			PublicRecords_KEL.KEL_Queries_MAS_Shared.C_Compile);
		
		// BIP Append Options
   EXPORT UNSIGNED BIPAppendScoreThreshold := MAP(NOT BIPAppend_ReAppend => 0, // 
                                                BIPAppend_Score_Threshold = 0 => 75, 
                                                MIN(MAX(51,BIPAppend_Score_Threshold), 100));		
		EXPORT UNSIGNED BIPAppendWeightThreshold := BIPAppend_Weight_Threshold;
		EXPORT BOOLEAN BIPAppendPrimForce := BIPAppend_PrimForce;
		EXPORT BOOLEAN BIPAppendReAppend :=  BIPAppend_ReAppend;
		EXPORT BOOLEAN BIPAppendIncludeAuthRep := BIPAppend_Include_AuthRep;
		// CCPA Options
		EXPORT UNSIGNED1 LexIdSourceOptout := _LexIdSourceOptout;
		EXPORT STRING100 TransactionID := _TransactionId;                                
		EXPORT STRING100 BatchUID := _BatchUID;
		EXPORT UNSIGNED6 GlobalCompanyId := _GCID;				

	
  END;	
				
		//default setting for keys is false, turn on only what is needed for attributes		
		JoinFlags := BRM_Marketing_attributes.Join_Interface_Options(PublicRecords_KEL.Join_Interface_Options);
				
				
	//For now we have only one version of the attributes V1.There are 2 fields for attributes now just in case we will be having new version sooner.
	AttrsRequested := DATASET([ {STD.Str.ToUpperCase(AttributeVer1_in)},{STD.Str.ToUpperCase(AttributeVer2_in)} ],BRM_Marketing_Attributes.Layout_BRM_NonFCRA.AttributeGroupRec);
	allow_MA_attrs_only := EXISTS(AttrsRequested(AttributeGroup = STD.Str.ToUpperCase(BRM_Marketing_Attributes.Constants.Include_MA_attrs)));   
	
	BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Batch_Input getInput(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Batch_In_Layout le, UNSIGNED4 c) := TRANSFORM
	SELF.G_ProcBusUID := c;
  SELF.HistoryDateYYYYMM := le.HistoryDateYYYYMM ;
	SELF.HistoryDate := le.HistoryDate;
 	SELF.SeleID := le.SeleID;
// if we are not using bipappend(sele provided) then clear out the rest of the BII
  SELF.AcctNo := IF(BIPAppend_ReAppend, le.AcctNo , '');	
	SELF.CompanyName := IF(BIPAppend_ReAppend, le.CompanyName , '');
	SELF.AlternateCompanyName := IF(BIPAppend_ReAppend, le.AlternateCompanyName , '');
	SELF.StreetAddressLine1 := IF(BIPAppend_ReAppend, le.StreetAddressLine1 , '');
	SELF.StreetAddressLine2 := IF(BIPAppend_ReAppend, le.StreetAddressLine2 , '');
	SELF.City1 := IF(BIPAppend_ReAppend, le.City1 , '');
	SELF.State1 := IF(BIPAppend_ReAppend, le.State1 , '');
	SELF.Zip1 := IF(BIPAppend_ReAppend, le.Zip1 , '');
	SELF.BusinessTIN := IF(BIPAppend_ReAppend, le.BusinessTIN , '');
	SELF.BusinessPhone := IF(BIPAppend_ReAppend, le.BusinessPhone , '');
	SELF.BusinessURL := IF(BIPAppend_ReAppend, le.BusinessURL , '');
	SELF.BusinessEmailAddress := IF(BIPAppend_ReAppend, le.BusinessEmailAddress , '');
	SELF.PowID := IF(BIPAppend_ReAppend, le.PowID , '');
	SELF.ProxID := IF(BIPAppend_ReAppend, le.ProxID , '');
	SELF.OrgID := IF(BIPAppend_ReAppend, le.OrgID , '');
	SELF.UltID := IF(BIPAppend_ReAppend, le.UltID , '');
	SELF.custom_input1 := IF(BIPAppend_ReAppend, le.custom_input1, '');
	SELF.custom_input2 := IF(BIPAppend_ReAppend, le.custom_input2, '');
	SELF.custom_input3 := IF(BIPAppend_ReAppend, le.custom_input3, '');
	SELF.custom_input4 := IF(BIPAppend_ReAppend, le.custom_input4, '');
	SELF.custom_input5 := IF(BIPAppend_ReAppend, le.custom_input5, '');

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
						
	ResultSet := BRM_Marketing_Attributes.Fn_Get_All_BRM_Attrs(valid_inputs, Options, JoinFlags);	
													
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
			
			SELF.Model_1_Name      := (STRING20)model_result_1.name; 
			SELF.Model_1_Score     := (STRING3)model_result_1.Scores[1].Value;
			SELF.Model_1_RC1       := (STRING5)model_result_1.Scores[1].ScoreReasons[1].ReasonCode;
			SELF.Model_1_RC2       := (STRING5)model_result_1.Scores[1].ScoreReasons[2].ReasonCode;
			SELF.Model_1_RC3       := (STRING5)model_result_1.Scores[1].ScoreReasons[3].ReasonCode;
			SELF.Model_1_RC4       := (STRING5)model_result_1.Scores[1].ScoreReasons[4].ReasonCode;
			SELF.Model_1_RC5       := (STRING5)model_result_1.Scores[1].ScoreReasons[5].ReasonCode;
			SELF.Model_2_Name      := (STRING20)model_result_2.name;
			SELF.Model_2_Score     := (STRING3)model_result_2.Scores[1].Value;
			SELF.Model_2_RC1       := (STRING5)model_result_2.Scores[1].ScoreReasons[1].ReasonCode;
			SELF.Model_2_RC2       := (STRING5)model_result_2.Scores[1].ScoreReasons[2].ReasonCode;
			SELF.Model_2_RC3       := (STRING5)model_result_2.Scores[1].ScoreReasons[3].ReasonCode;
			SELF.Model_2_RC4       := (STRING5)model_result_2.Scores[1].ScoreReasons[4].ReasonCode;
			SELF.Model_2_RC5       := (STRING5)model_result_2.Scores[1].ScoreReasons[5].ReasonCode;
			SELF.Model_3_Name      := (STRING20)model_result_2.name;
			SELF.Model_3_Score     := (STRING3)model_result_3.Scores[1].Value;
			SELF.Model_3_RC1       := (STRING5)model_result_3.Scores[1].ScoreReasons[1].ReasonCode;
			SELF.Model_3_RC2       := (STRING5)model_result_3.Scores[1].ScoreReasons[2].ReasonCode;
			SELF.Model_3_RC3       := (STRING5)model_result_3.Scores[1].ScoreReasons[3].ReasonCode;
			SELF.Model_3_RC4       := (STRING5)model_result_3.Scores[1].ScoreReasons[4].ReasonCode;
			SELF.Model_3_RC5       := (STRING5)model_result_3.Scores[1].ScoreReasons[5].ReasonCode;
			SELF.Model_4_Name      := (STRING20)model_result_4.name;
			SELF.Model_4_Score     := (STRING3)model_result_4.Scores[1].Value;
			SELF.Model_4_RC1       := (STRING5)model_result_4.Scores[1].ScoreReasons[1].ReasonCode;
			SELF.Model_4_RC2       := (STRING5)model_result_4.Scores[1].ScoreReasons[2].ReasonCode;
			SELF.Model_4_RC3       := (STRING5)model_result_4.Scores[1].ScoreReasons[3].ReasonCode;
			SELF.Model_4_RC4       := (STRING5)model_result_4.Scores[1].ScoreReasons[4].ReasonCode;
			SELF.Model_4_RC5       := (STRING5)model_result_4.Scores[1].ScoreReasons[5].ReasonCode;
			SELF.Model_5_Name      := (STRING20)model_result_4.name;
			SELF.Model_5_Score     := (STRING3)model_result_5.Scores[1].Value;
			SELF.Model_5_RC1       := (STRING5)model_result_5.Scores[1].ScoreReasons[1].ReasonCode;
			SELF.Model_5_RC2       := (STRING5)model_result_5.Scores[1].ScoreReasons[2].ReasonCode;
			SELF.Model_5_RC3       := (STRING5)model_result_5.Scores[1].ScoreReasons[3].ReasonCode;
			SELF.Model_5_RC4       := (STRING5)model_result_5.Scores[1].ScoreReasons[4].ReasonCode;
			SELF.Model_5_RC5       := (STRING5)model_result_5.Scores[1].ScoreReasons[5].ReasonCode;
			SELF := le;	
			SELF := [];
			END;
	
	Final_Results := PROJECT(FinalSet, xfm_to_Results(LEFT));
	
//joining invalid inputs with the valid output	
 	ds_batch_input_NOT_having_minimum_input := 
       PROJECT(
         batchin_with_UID( NOT MinimumInputMet() ),
         TRANSFORM( BRM_Marketing_Attributes.Layout_BRM_NonFCRA.BatchOutput,
           SELF.g_procbusuid := LEFT.g_procbusuid;
           SELF.acctno := LEFT.acctno;
           SELF.historydateyyyymm := LEFT.historydateyyyymm;
           SELF.historydate := LEFT.historydate;
           SELF.companyname := LEFT.companyname;
           SELF.alternatecompanyname := LEFT.alternatecompanyname;
           SELF.streetaddressline1 := LEFT.streetaddressline1;
           SELF.streetaddressline2 := LEFT.streetaddressline2;
           SELF.city1 := LEFT.city1;
           SELF.state1 := LEFT.state1;
           SELF.zip1 := LEFT.zip1;
           SELF.businesstin := LEFT.businesstin;
           SELF.businessphone := LEFT.businessphone;
           SELF.businessurl := LEFT.businessurl;
           SELF.businessemailaddress := LEFT.businessemailaddress;
           SELF.powid := (STRING)LEFT.powid;
           SELF.proxid := (STRING)LEFT.proxid;
           SELF.seleid := (STRING)LEFT.seleid;
           SELF.orgid := (STRING)LEFT.orgid;
           SELF.ultid := (STRING)LEFT.ultid;
           SELF.custom_input1 := LEFT.custom_input1;
           SELF.custom_input2 := LEFT.custom_input2;	
           SELF.custom_input3 := LEFT.custom_input3;
           SELF.custom_input4 := LEFT.custom_input4;
           SELF.custom_input5 := LEFT.custom_input5;
           SELF.error_msg := 'minimum input criteria not met';
           SELF := LEFT;
           SELF := [];
         )
       );

		Final_output := Dedup(sort((Final_Results +ds_batch_input_NOT_having_minimum_input),g_procbusuid,-error_msg),g_procbusuid);
	//error message when the attribute name is not supplied.	
		Results := IF(NOT allow_MA_attrs_only,Project(Final_output,transform(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.BatchOutput, 
																			SELF.g_procbusuid := LEFT.g_procbusuid;
                                      SELF.acctno := LEFT.acctno;
                                      SELF.historydateyyyymm := LEFT.historydateyyyymm;
                                      SELF.historydate := LEFT.historydate;
                                      SELF.companyname := LEFT.companyname;
                                      SELF.alternatecompanyname := LEFT.alternatecompanyname;
                                      SELF.streetaddressline1 := LEFT.streetaddressline1;
                                      SELF.streetaddressline2 := LEFT.streetaddressline2;
                                      SELF.city1 := LEFT.city1;
                                      SELF.state1 := LEFT.state1;
                                      SELF.zip1 := LEFT.zip1;
                                      SELF.businesstin := LEFT.businesstin;
                                      SELF.businessphone := LEFT.businessphone;
                                      SELF.businessurl := LEFT.businessurl;
                                      SELF.businessemailaddress := LEFT.businessemailaddress;
                                      SELF.powid := LEFT.powid;
                                      SELF.proxid := LEFT.proxid;
                                      SELF.seleid := LEFT.seleid;
                                      SELF.orgid := LEFT.orgid;
                                      SELF.ultid := LEFT.ultid;
                                      SELF.custom_input1 := LEFT.custom_input1;
                                      SELF.custom_input2 := LEFT.custom_input2;	
                                      SELF.custom_input3 := LEFT.custom_input3;
                                      SELF.custom_input4 := LEFT.custom_input4;
                                      SELF.custom_input5 := LEFT.custom_input5;
                                      SELF.error_msg := 'minimum input criteria not met';
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
					      If((  (INTEGER)LEFT.BE_B2BActvCnt>0 OR 
						           (INTEGER)LEFT.BE_B2BActvCarrCnt> 0 OR 
						           (INTEGER)LEFT.BE_B2BActvFltCnt > 0 OR 
						           (INTEGER)LEFT.BE_B2BActvMatCnt > 0 OR 
						           (INTEGER)LEFT.BE_B2BActvOpsCnt > 0 OR 
						           (INTEGER)LEFT.BE_B2BActvOthCnt > 0 OR 
						           (INTEGER)LEFT.BE_B2BActvBalTot > 0 OR 
						           (INTEGER)LEFT.BE_B2BActvCarrBalTot > 0 OR 
						           (INTEGER)LEFT.BE_B2BActvFltBalTot > 0 OR 
						           (INTEGER)LEFT.BE_B2BActvMatBalTot > 0 OR 
						           (INTEGER)LEFT.BE_B2BActvOpsBalTot > 0 OR 
						           (INTEGER)LEFT.BE_B2BActvOthBalTot > 0 OR
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
