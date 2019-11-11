/*--SOAP--
<message name="BatchServices.AppendDid_BatchService">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="Appends" type="xsd:string"/>
  <part name="Verify" type="xsd:string"/>
  <part name="Fuzzies" type="xsd:string"/>
  <part name="Deduped" type="xsd:boolean"/>
  <part name="AppendThreshold" type="xsd:string"/>
  <part name="PatriotProcess" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="IncludeMinors" type="xsd:boolean"/>
  <part name="ApplicationType" type="xsd:string"/>
  <part name="xADLVersion" type="xsd:integer"/>
  <part name="IncludeRanking" type="xsd:boolean"/>
  <part name="DoPartialSuppression" type="xsd:boolean"/>
  <part name="Max_Results_Per_Acct" type="xsd:integer"/>
</message>
*/
/*--INFO-- This service returns dids based upon a set of personal data.*/

import doxie, AutoStandardI, batchShare, BatchServices, STD;

export AppendDid_BatchService := macro
string120 append_l := ''       : stored('Appends');
string120 verify_l := ''       : stored('Verify');
string120 fuzzy_l := ''       : stored('Fuzzies');
boolean   dedup_results := true   : stored('Deduped');
string3   thresh_val := ''         : stored('AppendThreshold');
boolean   patriotproc := false     : stored('PatriotProcess');
unsigned1 soap_xadl_version_value := 0 : stored('xADLVersion');
unsigned8 MaxResultsPerAcct       := 1       : stored('Max_Results_Per_Acct');
boolean IncludeRanking            := false   : stored('IncludeRanking');
boolean DoPartialSuppression            := false   : stored('DoPartialSuppression');

mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

// Bug: 53541=> for this service, we are using the nonblank key to ensure the largest
// majority of first and last names are populated during record retreival
UseNonBlankKey := TRUE;

appends := std.str.ToUpperCase(append_l);
verify := std.str.ToUpperCase(verify_l);
thresh_num := (unsigned2)thresh_val;
fuzzy := std.str.ToUpperCase(fuzzy_l);

ds_batchIn := dataset([],BatchServices.AppendDid_BatchService_Layouts.layout_did_InbatchWithAcctnoWithDID) : stored('batch_in');

BatchShare.MAC_ProcessInput(ds_batchIn,ds_batchInProcessed);

ds_batchResults := BatchServices.AppendDID_BatchService_Records(ds_batchInProcessed, 
  mod_access,
  appends,
  verify,
  fuzzy,
  dedup_results,
  thresh_num,
  patriotproc,
  useNonBlankKey,
  soap_xadl_version_value,
  MaxResultsPerAcct,
  IncludeRanking,
  DoPartialSuppression);
                         
BatchShare.MAC_RestoreAcctno(ds_batchInProcessed,ds_batchResults,results);
          
output(results, named('Results'));

endmacro;
