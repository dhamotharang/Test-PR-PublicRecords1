/*--SOAP--
<message name="WatercraftSearch" wuTimeout="300000">
  <part name="BDID" type="xsd:string"/>
  <part name="DID" type="xsd:string"/>
  <part name="WatercraftKey" type="xsd:string" />
  <part name="SequenceKey" type="xsd:string" />
  <part name="HullNumber" type="xsd:string" />
  <part name="VesselName" type="xsd:string" />
  <part name="MinVesselLength" type="xsd:unsignedInt" />
  <part name="MaxVesselLength" type="xsd:unsignedInt" />
  <part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="LastName" type = "xsd:string"/>
  <part name="AllowNicknames" type="xsd:boolean"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="CompanyName" type="xsd:string"/>
  <part name="FEIN" type="xsd:string"/>

  <part name="PrimName" type="xsd:string"/>
  <part name="PrimRange" type="xsd:string"/>

  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string" />
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="County" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
  <part name="Phone" type="xsd:string"/>
  <part name="NoDeepDive" type="xsd:boolean"/>
  <part name="RecordByDate" type="xsd:string"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="ApplicationType" type="xsd:string"/>
  <part name="PenaltThreshold" type="xsd:unsignedInt"/>
  <part name="StrictMatch" type="xsd:boolean"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/> <!-- [NONE, ALL, LAST4, FIRST5] -->
  <part name="IncludeNonRegulatedWatercraftSources" type="xsd:boolean" />
</message>
*/

IMPORT Text_Search, doxie, AutostandardI, WSInput;

EXPORT WatercraftSearchService := MACRO
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

  #CONSTANT('SearchGoodSSNOnly',TRUE)
  #CONSTANT('SearchIgnoresAddressOnly',TRUE)
  #CONSTANT('getBdidsbyExecutive',FALSE)

 WSInput.MAC_WatercraftSearchService();

  doxie.MAC_Header_Field_Declare ();
  gm := AutoStandardI.GlobalModule();
  
  params := MODULE(PROJECT(gm, WatercraftV2_Services.Interfaces.search_params, opt))
    STRING2 st_pass := '' : STORED('state');
    EXPORT STRING2 st := STD.STR.ToUpperCase(st_pass);
    EXPORT UNSIGNED2 pt := 10 : STORED('PenaltThreshold');
    EXPORT STRING30 wk := '' : STORED('WatercraftKey');
    STRING30 h_num := '' : STORED('HullNumber');
    EXPORT STRING30 hull_num := STD.STR.ToUpperCase (h_num);
    EXPORT STRING32 seqk := '' : STORED('sequenceKey');
    STRING50 v_name := '' : STORED('VesselName');
    EXPORT STRING50 vesl_nam := STD.STR.ToUpperCase(v_name);
    EXPORT UNSIGNED2 min_vesl_len := 0 : STORED('MinVesselLength');
    EXPORT UNSIGNED2 max_vesl_len := 0 : STORED('MaxVesselLength');
    EXPORT STRING6 ssn_mask := ssn_mask_val;
    EXPORT STRING14 DID := '' :STORED('DID');
    EXPORT STRING BDID := '' :STORED('BDID');
    EXPORT BOOLEAN include_non_regulated_sources := FALSE : STORED('IncludeNonRegulatedWatercraftSources');
  END;
  rsrt_stmts := WatercraftV2_services.WatercraftSearch(params);
  rsrt1 := rsrt_stmts.Records;
  Text_Search.MAC_Append_ExternalKey(rsrt1, rsrt2, l.watercraft_key + l.sequence_key + l.state_origin);
  doxie.MAC_Marshall_Results(rsrt2,rmar);
  OUTPUT(rmar, NAMED('Results'));
  
ENDMACRO;
