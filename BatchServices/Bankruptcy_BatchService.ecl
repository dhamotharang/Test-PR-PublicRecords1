/*--SOAP--
<message name="Bankruptcy_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="Phonetics"            type="xsd:boolean"/>
	<part name="Nicknames"            type="xsd:boolean"/>
	<part name="SSNMask"			  type="xsd:string"/>	
	
	<part name="Match_Name"           type="xsd:boolean"/>
	<part name="Match_Comp_Name"      type="xsd:boolean"/>
	<part name="Match_Street_Address" type="xsd:boolean"/>
	<part name="Match_City"           type="xsd:boolean"/>
	<part name="Match_State"          type="xsd:boolean"/>
	<part name="Match_Zip"            type="xsd:boolean"/>
	<part name="Match_Phone"          type="xsd:boolean"/>
	<part name="Match_SSN"            type="xsd:boolean"/>
	<part name="Match_FEIN"           type="xsd:boolean"/>
	<part name="Match_DOB"            type="xsd:boolean"/>

	<part name="IsDeepDive" 		  type="xsd:boolean"/>
	<part name="MatchCode_ADL_Append" type="xsd:boolean"/>
	
    <part name="PenaltThreshold"	  type="xsd:unsignedInt"/>  
	<part name="MaxResults"           type="xsd:unsignedInt"/>
	<part name="Max_Results_Per_Acct" type="xsd:byte"/>	
	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	
	<part name="Match_Attorneys"      type="xsd:boolean"/>
	<part name="Match_Creditors"      type="xsd:boolean"/>
	<part name="Match_Debtors"        type="xsd:boolean"/>
	
	<part name="MatchCode_Includes"	  type="xsd:string"/>
	<part name="Chapter_Includes"	  type="xsd:string"/>
	<part name="DCode_Includes"  	  type="xsd:string"/>
	
	<part name="DaysBack"		 	  type="xsd:unsignedInt"/>	
	<part name="DID_Score_Threshold"  type="xsd:unsignedInt"/>
	<part name="BDID_Score_Threshold" type="xsd:unsignedInt"/>
	<part name="BIPFetchLevel" type="xsd:string"/>
	<part name="BIPSkipMatch" type="xsd:boolean"/>

	<part name="UseNameSSNLast4"			type="xsd:boolean"/>
</message>
*/

IMPORT BatchServices, Autokey_Batch, doxie;

export Bankruptcy_BatchService(useCannedRecs = 'false') := 
	MACRO
	 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
		#OPTION('optimizeProjects', TRUE);
		
		// Imitate in part the constants and stored variables found in the bankruptcy search service.
		#constant('SearchIgnoresAddressOnly',true)
		#stored('ScoreThreshold',10)
		#stored('PenaltThreshold',20)
		
		#constant('DisplayMatchedParty',true)
		#constant('isFCRA', false)	
		//#constant('noDeepDive', true)
		INTEGER max_results_per_acct := 100   : STORED('Max_Results_Per_Acct');		
		
		BOOLEAN isFCRA 					:= false	: STORED('IsFCRA');
		BOOLEAN isDeepDive 				:= false	: STORED('IsDeepDive');
		STRING7 in_ssn_mask				:= 'NONE'	: STORED('SSNMask');
		
		// 1. Build party_type set.
		BOOLEAN match_attorneys      	:= FALSE 	: STORED('Match_Attorneys');
		BOOLEAN match_creditors      	:= FALSE 	: STORED('Match_Creditors');
		BOOLEAN match_debtors        	:= TRUE 	: STORED('Match_Debtors');
		
		boolean use_namessnlast4			:= true 	: stored('UseNameSSNLast4');
		
		STRING1 BIPFetchLevel		:= 'S'	 : STORED('BIPFetchLevel');
		BOOLEAN BIPSkipMatch		:= true  : STORED('BIPSkipMatch');
		
		// Return all records if either all the booleans are true, or all are false. The reason is 
		// because it's common to run a batch job without checking any parties and yet expect the 
		// system to return all results. Strictly a concession to human behavior.
		BOOLEAN all_or_none_are_checked := (match_attorneys AND match_creditors AND match_debtors) OR
		                                    NOT (match_attorneys OR match_creditors OR match_debtors);
		
		SET OF STRING1 attorney_type := IF( match_attorneys, ['A'], [] );
		SET OF STRING1 creditor_type := IF( match_creditors, ['C'], [] );
		SET OF STRING1 debtor_type   := IF( match_debtors,   ['D'], [] );
		
		SET OF STRING1 party_types   := IF( all_or_none_are_checked, 
		                                    ['A','C','D',''],
		                                    attorney_type + creditor_type + debtor_type
		                                   );
										   
		ds_batch_in := IF( NOT useCannedRecs, 
		                   BatchServices.file_Bankruptcy_Batch_in(forceSeq := FALSE),
											 PROJECT(BatchServices._Sample_inBatchMaster('BANKRUPTCY'), TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_in,SELF := LEFT, SELF :=[]))
                      );	
											
		// Search for Bk records by party.		
		Pre_result := BatchServices.Bankruptcy_BatchService_Records.search(ds_batch_in, party_types, isFCRA, isDeepDive, in_ssn_mask, use_namessnlast4, BIPFetchLevel, BIPSkipMatch);
		
		ut.mac_TrimFields(Pre_result, 'Pre_result', result);
		
		OUTPUT(result, NAMED('Results'));	
	
	
	ENDMACRO;
	
// BatchServices.Bankruptcy_BatchService();