/*--SOAP--
<message name="HeaderFileAdvanceAddressSearch">
  <part name="did" type="xsd:string"/>
  <part name="RandR" type="xsd:boolean"/>
	<part name="DPPAPurpose" type="xsd:unsignedInt"/>
	<part name="GLBPurpose" type="xsd:unsignedInt"/>
  <part name="IncludeHRI" type="xsd:boolean"/>
  <part name="MaxHriPer" type="xsd:unsignedInt"/> 
	<part name="ProbationOverride" type="xsd:boolean"/>
	<part name="LNBranded" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
  <part name="KeepOldSsns" type="xsd:boolean"/>
  <part name="ReturnAlsoFound" type = "xsd:boolean"/>
</message>
*/
/*--INFO-- This service searches the header file for addresses. */
/*
	Given this person at this address, 
	find every person that ever lived at any of the person's addresses,
	or using the RandR switch, find every person that lived at the same time 
	with the person at any of the persons addresses. 
	
	Inputs
		did_value. The root person for the search. 
		RandR. Do we limit the results to same time?
	  DPPAPurpose. 
		GLBPurpose.
		IncludeHRI.
		MaxHRIPer.
		ProbationOverride. Use sources on probation?
		LNBranded. Switch for specific behavior for dayton apps
*/
export HeaderFileAdvancedAddressSearch := MACRO
  #CONSTANT('UsingKeepSSNs',true);
  // v-- Added for RQ-13563 to purposely force off the use of FDN keys
  #CONSTANT('IncludeFraudDefenseNetwork',FALSE);

	MatchingRecs := Header_Services.Fetch_Header_File_Advanced_Address;
  OUTPUT(MatchingRecs, NAMED('MatchingRecs'));
ENDMACRO;