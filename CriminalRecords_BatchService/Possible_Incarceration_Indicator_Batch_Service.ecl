/*--SOAP--
<message name="Possible_Incarceration_Indicator_Batch_Service" wuTimeout="300000">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="Match_Name" type="xsd:boolean"/>
	<part name="Match_City" type="xsd:boolean"/>
	<part name="Match_Street_Address" type="xsd:boolean"/>
	<part name="Match_State" type="xsd:boolean"/>
	<part name="Match_Zip" type="xsd:boolean"/>
	<part name="Match_SSN" type="xsd:boolean"/>
	<part name="Match_DOB" type="xsd:boolean"/>
	<part name="workHard" type="xsd:boolean"/>
	<part name="Run_Deep_Dive" type="xsd:boolean"/>
	<part name="Return_DOC_Name" type="xsd:boolean"/>
	<part name="Return_SSN" type="xsd:boolean"/>
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
	<part name="DPPAPurpose" type="xsd:unsignedInt"/>
	<part name="GLBPurpose" type="xsd:unsignedInt"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
</message>
*/
/*--INFO-- Possible Incarceration Indicator.*/


IMPORT AutoStandardI, BatchShare, CriminalRecords_BatchService,ut;

EXPORT Possible_Incarceration_Indicator_Batch_Service() := MACRO
	#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	gm := AutoStandardI.GlobalModule();
	BOOLEAN match_name     			:= FALSE : STORED('Match_Name');
	BOOLEAN match_addr  				:= FALSE : STORED('Match_Street_Address');     
	BOOLEAN match_city     			:= FALSE : STORED('Match_City');
	BOOLEAN match_state    			:= FALSE : STORED('Match_State');       
	BOOLEAN match_zip      			:= FALSE : STORED('Match_Zip');         
	BOOLEAN match_ssn      			:= FALSE : STORED('Match_SSN'); 
	BOOLEAN Match_DOB      := FALSE : STORED('Match_DOB'); 
	batch_params		:= BatchShare.IParam.getBatchParams();
	pii_batch_params := module(project(batch_params, CriminalRecords_BatchService.IParam.batch_params, opt))
		export applicationType 	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(gm,AutoStandardI.InterfaceTranslator.application_type_val.params));
		export MatchName												:= match_name;
		export MatchStrAddr											:= match_addr;
		export MatchCity												:= match_city;
		export MatchState												:= match_state;
		export MatchZip													:= match_zip;
		export MatchSSN													:= match_ssn;
		export MatchDOB      										:= match_DOB; 
	end;
		
	ds_xml_in := DATASET([], CriminalRecords_BatchService.Layouts.batch_pii_in) : STORED('batch_in', FEW);
	
	// run input through some standard procedures
	BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
	BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);	
		
	ds_batch_out := CriminalRecords_BatchService.Possible_Incarceration_Indicator_Batch_Service_Records(pii_batch_params, ds_batch_in).Records;
	
	// Restore original acctno.	
	BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_batch_out, ds_batch_ready, false);	
	
	ut.mac_TrimFields(ds_batch_ready, 'ds_batch_ready', results);
	OUTPUT(results, NAMED('Results'));	
	
ENDMACRO;
