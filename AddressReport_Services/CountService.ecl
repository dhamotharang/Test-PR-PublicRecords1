/*--SOAP--
<message name="CountService" wuTimeout="300000">
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <separator />
  <part name="DID" type="xsd:string" required="1" />
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/>
 
  <part name="AddressCountReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Searches for Address Report*/

import iesp, doxie, AutoStandardI;

EXPORT CountService := MACRO

//The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_AddrReport_CountService();
  
  rec_in := iesp.addresscount.t_AddressCountReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('AddressCountReportRequest', FEW);

  first_row := ds_in[1] : INDEPENDENT;
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  ReportBy := global (first_row.ReportBy);
  //***************************************************
  // iesp.ECL2ESP.SetInputAddress (ReportBy.Address);
  // Unfortunately I cannot use the standard ECL2ESP setIputAddress
  // because the input can be a single line or components and
  // I am using the clean address passing the single line address.
  //****************************************************
  AddressReport_Services.input.SetInputAddress (ReportBy.Address);

  tmp:=AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(tmp);

  tempmod := module (project (tmp, AddressReport_Services.input.params, OPT))
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
  end;

  recs := AddressReport_Services.CountService_Records (tempmod,FALSE);
  results_cnts:=recs.record_cnts;
  output(results_cnts, named('Results'));

ENDMACRO;
// CountService();
