/*--SOAP--
<message name="JudgmentsAndLiens_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="Phonetics"            type="xsd:boolean"/>
	<part name="Nicknames"            type="xsd:boolean"/>
	<part name="Match_Name"           type="xsd:boolean"/>
	<part name="Match_Street_Address" type="xsd:boolean"/>
	<part name="Match_City"           type="xsd:boolean"/>
	<part name="Match_State"          type="xsd:boolean"/>
	<part name="Match_Zip"            type="xsd:boolean"/>
	<part name="Match_SSN"            type="xsd:boolean"/>
		
	<part name="MaxResults"           type="xsd:unsignedInt"/>
	<part name="Max_Results_Per_Acct" type="xsd:byte"/>	
	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	
	<part name="Match_Attorneys"      type="xsd:boolean"/>
	<part name="Match_Creditors"      type="xsd:boolean"/>
	<part name="Match_Debtors"        type="xsd:boolean"/>
	<part name="PenaltThreshold"      type="xsd:unsignedInt"/>
	<part name="NoDIDAppend"      		type="xsd:boolean"/>
	<part name="NoBDIDAppend"      	 	type="xsd:boolean"/>
	<part name="BIPFetchLevel"        type="xsd:string"/>

</message>
*/

IMPORT AutoStandardI, BatchServices, BatchShare, BIPV2, LiensV2_Services, STD;

EXPORT JudgmentsAndLiens_BatchService(useCannedRecs = 'false') := 
	MACRO
	 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
		#OPTION('optimizeProjects', TRUE);
		
		#CONSTANT('getBdidsbyExecutive',FALSE);
		#CONSTANT('SearchGoodSSNOnly',TRUE);
		#CONSTANT('SearchIgnoresAddressOnly',TRUE);
		#STORED('ScoreThreshold',10);

		// 1. Build party_type set.
		BOOLEAN match_attorneys  := FALSE : STORED('Match_Attorneys');
		BOOLEAN match_creditors  := FALSE : STORED('Match_Creditors');
		BOOLEAN match_debtors    := FALSE : STORED('Match_Debtors');
    STRING1 BIPFetchLevel_in := BIPV2.IDconstants.Fetch_Level_SELEID	 : STORED('BIPFetchLevel');
		

		// Return all records if either all the booleans are true, or all are false. The reason is 
		// because it's common to run a batch job without checking any parties and yet expect the 
		// system to return all results. Strictly a concession to human behavior.
		BOOLEAN all_or_none_are_checked := (match_attorneys AND match_creditors AND match_debtors) OR
		                                    NOT (match_attorneys OR match_creditors OR match_debtors);
		SET OF STRING1 attorney_type := IF( match_attorneys, ['A'], [] );
		SET OF STRING1 creditor_type := IF( match_creditors, ['C'], [] );
		SET OF STRING1 debtor_type   := IF( match_debtors,   ['D'], [] );
		SET OF STRING1 partyTypes    := IF( all_or_none_are_checked, 
		                                    ['A','C','D',''],
		                                    attorney_type + creditor_type + debtor_type
		                                   );
		BOOLEAN match_name     			:= FALSE : STORED('Match_Name');
		BOOLEAN match_addr  				:= FALSE : STORED('Match_Street_Address');     
		BOOLEAN match_city     			:= FALSE : STORED('Match_City');
		BOOLEAN match_state    			:= FALSE : STORED('Match_State');       
		BOOLEAN match_zip      			:= FALSE : STORED('Match_Zip');         
		BOOLEAN match_ssn      			:= FALSE : STORED('Match_SSN'); 			 
		// 2. Grab the input XML and throw into a dataset.	
		ds_xml_in_raw 	:= DATASET([], LiensV2_Services.Batch_Layouts.batch_in) : STORED('batch_in', FEW);
    ds_xml_in := IF( NOT useCannedRecs, 
										 ds_xml_in_raw, 
										 PROJECT(BatchServices._Sample_inBatchMaster('JUDGEMENTSLIENS'), LiensV2_Services.Batch_Layouts.batch_in)
									  );		
		gm := AutoStandardI.GlobalModule();								
		batch_params		:= BatchShare.IParam.getBatchParamsV2();
		jl_batch_params := MODULE(PROJECT(batch_params, LiensV2_Services.IParam.batch_params, OPT))
			EXPORT UNSIGNED8 MaxResults   					:= 10000  : STORED('MaxResults');
			EXPORT UNSIGNED8 maxResultsPerAcct 			:= 1000  : STORED('Max_Results_Per_Acct');
			EXPORT BOOLEAN no_did_append					 	:= FALSE : STORED('NoDIDAppend');
			EXPORT BOOLEAN no_bdid_append				 		:= FALSE : STORED('NoBDIDAppend');
			EXPORT UNSIGNED2 PenaltThreshold   			:= 10    : STORED('PenaltThreshold');
			EXPORT party_types 											:= partyTypes;
			EXPORT MatchName												:= match_name;
			EXPORT MatchStrAddr											:= match_addr;
			EXPORT MatchCity												:= match_city;
			EXPORT MatchState												:= match_state;
			EXPORT MatchZip													:= match_zip;
			EXPORT MatchSSN													:= match_ssn;
			EXPORT applicationType 									:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(gm,AutoStandardI.InterfaceTranslator.application_type_val.params));
      EXPORT STRING1 BIPFetchLevel            := STD.Str.ToUpperCase(BIPFetchLevel_in);
		END;
		
		BatchShare.MAC_SequenceInput(ds_xml_in, ds_batch_in);
		
		// Search for J&L records by party.
		ds_batch_out := LiensV2_Services.Batch_records(ds_batch_in, jl_batch_params);
		
		// Restore original acctno and format to output layout.	
		BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_batch_out, ds_batch_ready, false);	
		ds_JL_recs_flat := PROJECT(ds_batch_ready, LiensV2_Services.batch_make_flat(LEFT));		
		pre_result := SORT(ds_JL_recs_flat, acctno, penalt, -orig_filing_date, -release_Date, filing_jurisdiction, orig_filing_number);
		pre_resultSlim := UNGROUP(TOPN(GROUP(pre_result, acctno), jl_batch_params.MaxResultsPerAcct,acctno));
		
		ut.mac_TrimFields(pre_resultSlim, 'pre_resultSlim', result);
		
		OUTPUT(result, NAMED('Results'));
		
ENDMACRO;	
