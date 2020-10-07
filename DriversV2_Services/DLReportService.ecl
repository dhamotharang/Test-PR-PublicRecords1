/*--SOAP--
<message name="DLReportService">

  <!-- DL Keys -->
  <part name="DLSeq" type="xsd:string"/>
  <part name="DID" type="xsd:string"/>
  <part name="DriversLicense" type="xsd:string"/>

  <!-- DL Tuning -->
  <part name="PenaltThreshold" type="xsd:unsignedInt"/>
  
  <!-- Privacy -->
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>

  <!-- Breadth -->
  <part name="IncludeEverything" type="xsd:boolean"/>
  <part name="IncludeAccidents" type="xsd:boolean"/>
  <part name="IncludeConvictions" type="xsd:boolean"/>
  <part name="IncludeDRInfo" type="xsd:boolean"/>
  <part name="IncludeFRAInsurance" type="xsd:boolean"/>
  <part name="IncludeSuspensions" type="xsd:boolean"/>
  <part name="IncludeNonDMVSources" type="xsd:boolean"/>
  
  <!-- Record management -->
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
    
</message>
*/
/*--INFO-- Lookup DL Records via simple keys, then display in wide_view with Conviction Point extensions. */

EXPORT DLReportService() := MACRO

  //The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_DLReportService();
                      
  // compute results
  raw := Driversv2_Services.DLCPReportService_records;

  // standard record counts & limits
  doxie.MAC_Header_Field_Declare()
  doxie.MAC_Marshall_Results(raw,cooked)

  // display results (if permitted)
  i := DriversV2_Services.input;
  MAP(
    i.dl_seq = 0 AND i.did = 0 AND i.dl_num = ''
    => FAIL(301, doxie.ErrorCodes(301)),
      
    ~dppa_ok
    => FAIL(2, doxie.ErrorCodes(2)),
    
    OUTPUT(cooked, NAMED('Results'))
  )

ENDMACRO;
