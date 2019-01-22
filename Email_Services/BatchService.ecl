﻿/*--SOAP--
<message name="BatchService">
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="DataPermissionMask" type="xsd:string"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="ApplicationType" type="xsd:string"/>
  <part name="IndustryClass" type="xsd:string"/>
  <part name="DOBMask" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="Max_Results_Per_Acct" type="xsd:unsignedInt"/>  
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="PenaltThreshold" type="xsd:unsignedInt"/>
  <part name="ReturnDetailedRoyalties" type="xsd:boolean"/>
  <part name="Run_Deep_Dive" type="xsd:boolean"/>
  <part name="IncludeHistoricData" type="xsd:boolean"/>
  <part name="CheckEmailDeliverable" type="xsd:boolean"/>
  <part name="EmailQualityRulesMask" type="xsd:string"/>
  <part name="IntendedPurpose" type="xsd:string"/>
  <part name="SearchType" type="xsd:string"/>  
</message>
*/


EXPORT BatchService(useCannedRecs = 'false') := MACRO

IMPORT AutoheaderV2, AutoKeyI, BatchShare, Email_Services, Royalty;

  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #WEBSERVICE(FIELDS('DPPAPurpose', 
                     'GLBPurpose', 
                     'DataPermissionMask',
                     'DataRestrictionMask',
                     'ApplicationType', 
                     'IndustryClass' , 
                     'DOBMask',
                     'SSNMask',  
                     'batch_in', 
                     'MaxResults', 
                     'Max_Results_Per_Acct', 
                     'ReturnDetailedRoyalties', 
                     'PenaltThreshold',
                     'Run_Deep_Dive',
                     'IncludeHistoricData', 
                     'EmailQualityRulesMask', 
                     'IntendedPurpose', 
                     'SearchType',
                     'CheckEmailDeliverable',
                     'Gateways'
                     ));
  
  ds_xml_in := DATASET([], Email_Services.Layouts.batch_email_input) : STORED('batch_in', FEW);
  batch_params := Email_Services.IParams.getBatchParams();
  
  IF(~Email_Services.Constants.SearchType.isValidSearchType(batch_params.SearchType), 
        FAIL(AutoKeyI.errorcodes._codes.INVALID_INPUT, AutoKeyI.errorcodes._msgs(AutoKeyI.errorcodes._codes.INVALID_INPUT)));

  BatchShare.MAC_SequenceInput(ds_xml_in, ds_batch_in);

  batch_recs := Email_Services.Batch_Records(ds_batch_in, batch_params, useCannedRecs);

  BatchShare.MAC_RestoreAcctno(ds_batch_in,batch_recs.Records, ds_output,,false);
  Royalty.MAC_RestoreAcctno(ds_batch_in, batch_recs.Royalties, royalties);
  

  OUTPUT( ds_output, NAMED('Results'));
  OUTPUT( royalties, NAMED('RoyaltySet'));
ENDMACRO;