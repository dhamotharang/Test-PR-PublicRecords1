/*--SOAP--
<message name="BatchService">
	<part name="DPPAPurpose"             type="xsd:byte"/>
	<part name="GLBPurpose"              type="xsd:byte"/> 
  <part name="DataPermissionMask"      type="xsd:string"/>
  <part name="DataRestrictionMask"     type="xsd:string"/>
  <part name="ApplicationType"         type="xsd:string"/>
  <part name="IndustryClass"           type="xsd:string"/>
	<part name="RealTimePermissibleUse"  type="xsd:string" default="GOVERNMENT"/>
	<part name="ViewModelDebugs"         type="xsd:boolean"/>

	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/> 	
	<part name="batch_in"                type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="gateways"                type="tns:XmlDataSet" cols="70" rows="4"/>
</message>
*/
IMPORT AutoStandardI, BatchShare, Residency_Services, Suppress;	

EXPORT BatchService() := MACRO
		 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
    // *************************************************************************
   // *                      Force the order on the WsECL page                *
   // *************************************************************************
   #WEBSERVICE(FIELDS(
			'batch_in',
			'DPPAPurpose',
			'GLBPurpose',
			'DataPermissionMask',
			'DataRestrictionMask',
			'ApplicationType',
			'IndustryClass',
      'RealTimePermissibleUse',
			'gateways',
	    'ReturnDetailedRoyalties',
      'ViewModelDebugs'
		));

    #constant('PenaltThreshold',10);

	  // **************************************************************************************
	  //   Read parameters and XML input. 
		// **************************************************************************************		
    mod_rsbatch_params := Residency_Services.IParam.getBatchParams();
		
		ds_xml_in_raw := DATASET([], Residency_Services.Layouts.Batch_in) : STORED('batch_in', FEW);

		// **************************************************************************************
		//   Use common batch share macros to get input file ready for processing. 
		// **************************************************************************************				
		BatchShare.MAC_SequenceInput(ds_xml_in_raw, ds_xml_in_seq);
		BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_batch_in);

		// **************************************************************************************
		//    Call main attribute to fetch records. 
		// **************************************************************************************
		DEBUGMODEL := FALSE : STORED('ViewModelDebugs');
		ds_recs_full    := Residency_Services.BatchRecords(ds_batch_in, mod_rsbatch_params,DEBUGMODEL);

		ds_recs_results := ds_recs_full.Records;
		
		// **************************************************************************************
		//    Restore original acctno and format to output layout.
		// **************************************************************************************						
		BatchShare.Mac_RestoreAcctno(ds_batch_in, ds_recs_results, ds_Results,,FALSE);
		Royalty.MAC_RestoreAcctno(ds_batch_in, ds_recs_full.Royalties, ds_Royalties); 
		// NOTE: ds_recs_full."Royalties" dataset (--^) built in Residency_Services.fn_getVehicles
						
		Results	:= SORT(ds_results, acctno);
		
    // Debug outputs, uncomment as needed
		// OUTPUT(ds_batch_in,     NAMED('ds_batch_in'));
		// OUTPUT(ds_recs_full,    NAMED('ds_recs_full'));
		// OUTPUT(ds_recs_results, NAMED('ds_recs_results'));
		// OUTPUT(ds_results,      NAMED('ds_results'));

    // Final 2 outputs
		OUTPUT(Results,      NAMED('Results'));
		OUTPUT(ds_Royalties, NAMED('RoyaltySet'));
		
ENDMACRO;	
