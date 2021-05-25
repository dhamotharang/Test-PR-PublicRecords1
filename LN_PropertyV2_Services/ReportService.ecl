/*--SOAP--
<message name="ReportService">

  <!-- Property Keys -->
  <part name="DID"								type="xsd:string"/>
  <part name="BDID"								type="xsd:string"/>
  <part name="FaresID"						type="xsd:string"/>
  <part name="ParcelID"						type="xsd:string"/>

  <!-- Property Tuning -->
  <part name="PenaltThreshold"		type="xsd:unsignedInt"/>
  <part name="LookupType"					type="xsd:string"/>
  <part name="AllPropRecords"			type="xsd:boolean"/>
  <part name="AllParcelRecords"		type="xsd:boolean"/>

  <!-- Data Restrictions -->
  <part name="LnBranded"					type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="ApplicationType"     	type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
  <part name="AllowAll"						type="xsd:boolean"/>

  <!-- Privacy -->
  <part name="SSNMask"						type="xsd:string"/>

  <!-- Record management -->
  <part name="MaxResults"					type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime"	type="xsd:unsignedInt"/>
  <part name="SkipRecords"				type="xsd:unsignedInt"/>

</message>
*/
/*--INFO-- Search for Property Records via simple keys. */
import LN_PropertyV2_Services, doxie;

export ReportService() := macro

  // compute results
  #CONSTANT('usePropMarshall', true);
  
  //This boolean is used in Property Report and Search Services to show Deeds, Assessments and A&R data when LooupType is blank or S
  boolean includeBlackKnight := Ln_PropertyV2_Services.consts.LOOKUP_TYPE.IsIncludeAllDeedTypes(Ln_PropertyV2_Services.input.lookupVal);
  
  
  raw := LN_PropertyV2_Services.ReportService_records(false,,,includeBlackKnight).Records;

  // standard record counts & limits
  doxie.MAC_Header_Field_Declare()

  // doxie.MAC_Marshall_Results(raw,cooked)
  LN_PropertyV2_Services.Marshall.MAC_Marshall_Results(raw,cooked);

  // display results
  output(cooked, named('Results'))

endmacro;
