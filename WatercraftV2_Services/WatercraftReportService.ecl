/*--SOAP--
<message name="WatercraftReportService">
    
  <part name="DID" type="xsd:string"/>
  <part name="BDID" type="xsd:string"/>
  <part name="HullNumber" type="xsd:string"/>
  <part name="VesselName" type="xsd:string"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="DataRestrictionMask" type='xsd:string'/>
  <part name="ApplicationType" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/> <!-- [NONE, ALL, LAST4, FIRST5] -->

  <part name="Watercraftkey" type="xsd:string"/>
  <part name="SequenceKey" type="xsd:string"/>
  <part name="State" type="xsd:string"/>

  <part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="AllowNicknames" type="xsd:boolean"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="CompanyName" type="xsd:string"/>
  <part name="FEIN" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  
  <part name="Zip" type="xsd:string"/>
  <part name="County" type="xsd:string"/>

  <part name="ZipRadius" type="xsd:unsignedInt"/>
  <part name="NoDeepDive" type="xsd:boolean"/>
  <part name="Summarize" type="xsd:boolean"/>

  <part name="IncludeNonRegulatedWatercraftSources" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns one watercraft Record.*/

EXPORT WatercraftReportService := MACRO
  
  gm := AutoStandardI.GlobalModule();
  params := MODULE(PROJECT(gm, WatercraftV2_Services.Interfaces.report_params, opt))
    EXPORT STRING30 wk := '' : STORED('Watercraftkey');
    STRING30 h_num := '' : STORED('HullNumber');
    EXPORT STRING30 hull_num := STD.STR.ToUpperCase(h_num);
    EXPORT STRING32 seqk := '' : STORED('SequenceKey');
    STRING2 st_pass := '' : STORED('State');
    EXPORT STRING2 st := STD.STR.ToUpperCase(st_pass);
    EXPORT STRING14 DID := '' : STORED('DID');
    EXPORT STRING BDID := '' : STORED('BDID');
    STRING ssn_mask_pass := 'NONE' : STORED('SSNMask');
    EXPORT STRING6 ssn_mask := STD.STR.ToUpperCase(ssn_mask_pass);
    STRING50 v_name := '' : STORED('VesselName');
    EXPORT STRING50 vesl_nam := STD.STR.ToUpperCase(v_name);
    EXPORT UNSIGNED2 pt := 10 : STORED('PenaltThreshold');
    EXPORT BOOLEAN summarize:= FALSE : STORED('Summarize');
    EXPORT BOOLEAN include_non_regulated_sources := FALSE : STORED('IncludeNonRegulatedWatercraftSources');
  END;
  
  report_recs := watercraftV2_Services.WatercraftReport(params);
  
  OUTPUT(report_recs.Records, NAMED('Results'));

ENDMACRO;
