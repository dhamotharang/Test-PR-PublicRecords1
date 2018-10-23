/*--SOAP--
<message name="HeaderFileNeighborSearchService">
  <part name="did" type="xsd:string"/>
	<part name="Addr" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<part name="NeighborsPerAddress" type="xsd:unsignedInt"/>
	<part name="NeighborsPerNA" type="xsd:unsignedInt"/>
	<part name="NeighborRecency" type="xsd:unsignedInt"/>
	<part name="DPPAPurpose" type="xsd:unsignedInt"/>
	<part name="GLBPurpose" type="xsd:unsignedInt"/>
  <part name="IncludeHRI" type="xsd:boolean"/>
  <part name="MaxHriPer" type="xsd:unsignedInt"/> 
	<part name="ProbationOverride" type="xsd:boolean"/>
	<part name="LNBranded" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
  <part name="KeepOldSsns" type="xsd:boolean"/>
  <part name="UsingKeepSsns" type="xsd:boolean"/>	
  <part name="ReturnAlsoFound" type = "xsd:boolean"/>
</message>
*/
/*--INFO-- This service searches the header file for neighbors. */
/*
	Given this person at this address, 
	find that person's neighbors.
	
	Inputs
		Did. The root person for the search
		Address components. Address to find neighbors for.
		NeighborsPerAddress. Count of neighbor addresses to find for the input address. (default=3)
			This is not the count of neighbor names to return. 
		NeighborsPerNA. Count of neighbors to find for each neighbor address. (default=3)
		NeighborRecency. Number of months within which a neighbor is considered "current". (default=3, max=12)
	  DPPAPurpose. 
		GLBPurpose.
		IncludeHRI.
		MaxHRIPer.
		ProbationOverride. Use sources on probation?
		LNBranded. Switch for specific behavior for dayton apps
*/
export HeaderFileNeighborSearchService := MACRO
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
  // v-- Added for RQ-13563 to purposely force off the use of FDN keys
  #CONSTANT('IncludeFraudDefenseNetwork',FALSE);

	MatchingRecs := Header_Services.Fetch_Header_File_Neighbor;
  OUTPUT(MatchingRecs, NAMED('MatchingRecs'));
ENDMACRO;