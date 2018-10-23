/*--SOAP--
<message name="UCCLiens_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="Phonetics"            type="xsd:boolean"/>
	<part name="Nicknames"            type="xsd:boolean"/>
	
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
		
	<part name="MaxResults"           type="xsd:unsignedInt"/>
	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="filing_status"        type="xsd:string"/>
	<part name="min_date"             type="xsd:string"/>
	<part name="max_date"             type="xsd:string"/>
	<part name="filing_jurisdiction"  type="xsd:string"/>
	<part name="debtor_zip"           type="xsd:string"/>
	<part name="collateral"           type="xsd:string"/>
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>
	<part name="Return_Current_Only"  type="xsd:boolean" default="false"/>
	<part name="Run_Deep_Dive"        type="xsd:boolean" default="false"/>
	<part name="PenaltThreshold"      type="xsd:unsignedInt"/>
	<part name="BIPFetchLevel" 				type="xsd:string"/>
</message>
*/

IMPORT BatchServices, ut, BIPV2;

EXPORT UCCLiens_BatchService(useCannedRecs = 'false') := 
	MACRO
	
	 
	 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
		#OPTION('optimizeProjects', TRUE);
		
		#CONSTANT('getBdidsbyExecutive',FALSE);
		#CONSTANT('usehigherlimit',TRUE);

		#STORED('IncludeMultipleSecured', TRUE);
		#STORED('ReturnRolledDebtors', TRUE);
		
		STRING1 BIPFetchLevel		:= BIPV2.IDconstants.Fetch_Level_SELEID : STORED('BIPFetchLevel');
		

		// Configure additional search criteria.
		filters := MODULE(BatchServices.Interfaces.UCCV2.i_Query_Filters) END;
		
		BOOLEAN has_addl_search_filters := TRIM(filters.min_date,LEFT,RIGHT)           != BatchServices.Constants.UCCLiens.SEARCH_MIN_DATE OR
		                                   TRIM(filters.max_date,LEFT,RIGHT)           != BatchServices.Constants.UCCLiens.SEARCH_MAX_DATE OR
                                       TRIM(filters.filing_status_desc,LEFT,RIGHT) != '.*' OR																			 
		                                   TRIM(filters.filing_jurisdiction,LEFT,RIGHT)!= '.*' OR
		                                   TRIM(filters.debtor_zip,LEFT,RIGHT)         != '.*' OR
		                                   TRIM(filters.collateral,LEFT,RIGHT)         != '.*'; 
    
		BOOLEAN return_current_only := FALSE : Stored('Return_Current_Only');		
		
		// Grab the input XML and throw into a dataset.	
		ds_xml_in_raw 	:= DATASET([], BatchServices.Layouts.ucc.batch_in) : STORED('batch_in', FEW);
    ds_xml_in := IF( NOT useCannedRecs, 
										 PROJECT(ds_xml_in_raw,TRANSFORM(BatchServices.Layouts.ucc.batch_in,
																											SELF.max_results := if((UNSIGNED8)LEFT.max_results > 0, LEFT.max_results,BatchServices.Constants.UCCLiens.BATCH_MAX_RESULTS),
																											SELF := LEFT)),
										 PROJECT(BatchServices._Sample_inBatchMaster('BUSINESS'), BatchServices.Layouts.ucc.batch_in)
									  );		
		
		ut.MAC_Sequence_Records(ds_xml_in, seq, ds_xml_in_seq)
		
		OUTPUT( BatchServices.UCCLiens_BatchService_Records(ds_xml_in_seq, filters, has_addl_search_filters, useCannedRecs,return_current_only,STD.Str.touppercase(BIPFetchLevel)), NAMED('Results') 
		);		
				
	ENDMACRO;	
