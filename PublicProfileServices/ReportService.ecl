/*--SOAP--
<message name="ReportService">
	<part name="PublicProfileReportRequest" type="tns:XmlDataSet" cols="80" rows="40" />
</message>
*/
/*--INFO-- Header Summary: search by combinations of NAME,ADDRESS,SSN and DOB<br/>
 Person Report Summary: IncludeFootPrint 
*/
/*--HELP-- 
<pre>
&lt;PublicProfileReportRequest&gt;
 &lt;Row&gt;
  &lt;User&gt;
   &lt;GLBPurpose&gt;1&lt;/GLBPurpose&gt;
   &lt;DLPurpose&gt;1&lt;/DLPurpose&gt;
   &lt;DataRestrictionMask&gt;0&lt;/DataRestrictionMask&gt;
   &lt;ApplicationType&gt;0&lt;/ApplicationType&gt;
  &lt;/User&gt;
  &lt;ReportBy&gt;
   &lt;UniqueID&gt;&lt;/UniqueID&gt;
   &lt;Name&gt;
    &lt;Full&gt;&lt;/Full&gt;
    &lt;First&gt;&lt;/First&gt;
    &lt;Middle&gt;&lt;/Middle&gt;
    &lt;Last&gt;&lt;/Last&gt;
   &lt;/Name&gt;
   &lt;Address&gt;
    &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
    &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
    &lt;StreetName&gt;&lt;/StreetName&gt;
    &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
    &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
    &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
    &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
    &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
    &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
    &lt;City&gt;&lt;/City&gt;
    &lt;State&gt;&lt;/State&gt;
    &lt;Zip5&gt;&lt;/Zip5&gt;
   &lt;/Address&gt;
   &lt;DOB&gt;
    &lt;Year&gt;&lt;/Year&gt;
    &lt;Month&gt;&lt;/Month&gt;
    &lt;Day&gt;&lt;/Day&gt;
   &lt;/DOB&gt;
   &lt;SSN&gt;&lt;/SSN&gt;
  &lt;/ReportBy&gt;
  &lt;Options&gt;
   &lt;IncludeSSN&gt;TRUE&lt;/IncludeSSN>
   &lt;IncludeNameSSN&gt;TRUE&lt;/IncludeNameSSN&gt;
   &lt;IncludeNameDOB&gt;TRUE&lt;/IncludeNameDOB&gt;
   &lt;IncludeAddress&gt;TRUE&lt;/IncludeAddress&gt;
   &lt;IncludeNameAddress&gt;TRUE&lt;/IncludeNameAddress&gt;
   &lt;IncludeCombination&gt;TRUE&lt;/IncludeCombination&gt;
   &lt;IncludeFootPrint&gt;TRUE&lt;/IncludeFootPrint&gt;
   &lt;UseTestData&gt;FALSE&lt;/UseTestData&gt;
  &lt;/Options&gt;
 &lt;/Row&gt;
&lt;/PublicProfileReportRequest&gt;
</pre>
*/

IMPORT iesp,address,PersonReports,AutoStandardI, std;

EXPORT ReportService := MACRO
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
	#onwarning(4207, ignore);
	
	#CONSTANT('IncludeMinors',TRUE);
	#CONSTANT('IncludeNonDMVSources',TRUE);
  // v-- Added for RQ-13563 to purposely force off the use of FDN keys
  #CONSTANT('IncludeFraudDefenseNetwork',FALSE);

	// get XML input 
	rec_in := iesp.public_profile_report.t_PublicProfileReportRequest;
	ds_in := DATASET([],rec_in) : STORED('PublicProfileReportRequest',FEW);
	request := ds_in[1] : INDEPENDENT;

	// set compliance from iesp XML input
	User := GLOBAL(request.User);
	iesp.ECL2ESP.SetInputUser(User);
	iesp.ECL2ESP.SetInputBaseRequest(request);

	// set XML input
	ReportBy := GLOBAL(request.ReportBy);
	Options  := GLOBAL(request.Options);

	// full name
	BOOLEAN isFullName := ReportBy.Name.Full!='' AND ReportBy.Name.Last='';
	cln := address.CleanNameFields(address.CleanPerson73(ReportBy.Name.Full));

	// parsed address
	BOOLEAN isParsedAddress := ReportBy.Address.StreetName!='' AND ReportBy.Address.StreetAddress1='';
  STRING200 parsedAddress := Address.Addr1FromComponents(ReportBy.Address.StreetNumber,
		ReportBy.Address.StreetPreDirection,ReportBy.Address.StreetName,ReportBy.Address.StreetSuffix,
		ReportBy.Address.StreetPostDirection,ReportBy.Address.UnitDesignation,ReportBy.Address.UnitNumber);
	STRING200 fullAddress := TRIM(ReportBy.Address.StreetAddress1)+' '+ReportBy.Address.StreetAddress2;

	//TODO: verify that we need to set glb, dppa (can set "allow..." as an alternative)
	perm_mod := module (PersonReports.input.permissions)
		// export boolean AllowAll := false;
		// export boolean AllowGLB := false;
		// export boolean AllowDPPA := false;
		export unsigned1 glbpurpose := (unsigned1) User.GLBPurpose;
		export unsigned1 dppapurpose := (unsigned1) User.DLPurpose;
		export boolean IncludeMinors := true;
	end;

  glbMod := AutoStandardI.GlobalModule(); // will need it for reading legacy settings
	rptByMod := MODULE(PublicProfileServices.IParam.searchParams)
		EXPORT STRING12  UniqueID := ReportBy.UniqueID;
		EXPORT STRING30  FirstName  := IF(isFullName,cln.fname,stringlib.StringToUpperCase(ReportBy.Name.First));
		EXPORT STRING30  MiddleName := IF(isFullName,cln.mname,stringlib.StringToUpperCase(ReportBy.Name.Middle));
		EXPORT STRING30  LastName   := IF(isFullName,cln.lname,stringlib.StringToUpperCase(ReportBy.Name.Last));
		EXPORT STRING11  SSN := ReportBy.SSN;
		EXPORT UNSIGNED8 DOB := (INTEGER)iesp.ECL2ESP.t_DateToString8(ReportBy.DOB);
		EXPORT STRING200 Addr  := IF(isParsedAddress,parsedAddress,fullAddress);
		EXPORT STRING25  City  := ReportBy.Address.City;
		EXPORT STRING2   State := ReportBy.Address.State;
		EXPORT STRING6   Zip   := ReportBy.Address.Zip5;
		EXPORT BOOLEAN   IncludeSSN := Options.IncludeSSN;
		EXPORT BOOLEAN   IncludeNameSSN := Options.IncludeNameSSN;
		EXPORT BOOLEAN   IncludeNameDOB := Options.IncludeNameDOB;
		EXPORT BOOLEAN   IncludeAddress := Options.IncludeAddress;
		EXPORT BOOLEAN   IncludeNameAddress := Options.IncludeNameAddress;
		EXPORT BOOLEAN   IncludeCombination := Options.IncludeCombination;
		EXPORT BOOLEAN   UseTestData := Options.UseTestData;

    export unsigned1 glbpurpose := AutoStandardI.PermissionI_Tools.val(perm_mod).glb.stored_value;
    export unsigned1 dppapurpose := AutoStandardI.PermissionI_Tools.val (perm_mod).dppa.stored_value;
    // legacy: can be provided outside of ESDL input
    export string6 ssn_mask := AutoStandardI.InterfaceTranslator.ssn_mask_value.val (project (glbMod, AutoStandardI.InterfaceTranslator.ssn_mask_value.params));
		export boolean mask_dl := User.DLMask;
		export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(glbMod,AutoStandardI.InterfaceTranslator.application_type_val.params));
	END;

	rptBy := ReportBy;
	hdrSum := PublicProfileServices.Records.HeaderSummary(rptByMod);
	perSum := IF(Options.IncludeFootPrint,
		PublicProfileServices.Records.PersonSummary(rptByMod),
		ROW([],iesp.public_profile_report.t_PublicProfileIndividual));

	iesp.public_profile_report.t_PublicProfileReportResponse initResponse() := TRANSFORM
		SELF._Header := iesp.ECL2ESP.GetHeaderRow();
		SELF.Messages := [];
		SELF.UserInput := rptBy;
		SELF.RunDate := iesp.ECL2ESP.toDate((INTEGER)Std.Date.Today());
		SELF.SSNResults := GLOBAL(hdrSum.SSNResults);
		SELF.NameSSNResults := GLOBAL(hdrSum.NameSSNResults);
		SELF.NameDOBResults := GLOBAL(hdrSum.NameDOBResults);
		SELF.AddressResults := GLOBAL(hdrSum.AddressResults);
		SELF.NameAddressResults := GLOBAL(hdrSum.NameAddressResults);
		SELF.CombinationResults := GLOBAL(hdrSum.CombinationResults);
		SELF.Individual := GLOBAL(perSum);
	END;

	//For Demo
	demoData := PublicProfileServices.TestData_ReportBy.DemoData(rptByMod);

	iesp.public_profile_report.t_PublicProfileReportResponse DemoResponse(PublicProfileServices.layouts.myDemoRec l) := TRANSFORM
		SELF._Header := iesp.ECL2ESP.GetHeaderRow();
		SELF.Messages := [];
		SELF.UserInput := Project(l,PublicProfileServices.TestData_ReportBy.xformRptBy(left));
		SELF.RunDate := iesp.ECL2ESP.toDate((INTEGER)Std.Date.Today());
		SELF.SSNResults := PublicProfileServices.TestData_HeaderSummary.getSSNResults(l);
		SELF.NameSSNResults := PublicProfileServices.TestData_HeaderSummary.getNameSSNResults(l);
		SELF.NameDOBResults := PublicProfileServices.TestData_HeaderSummary.getNameDOBResults(l);
		SELF.AddressResults := PublicProfileServices.TestData_HeaderSummary.getAddressResultsResults(l);
		SELF.NameAddressResults := PublicProfileServices.TestData_HeaderSummary.getNameAddressResultsResults(l);
		SELF.CombinationResults := PublicProfileServices.TestData_HeaderSummary.getCombinationResultsResults(l);
		SELF.Individual := [];
		SELF := [];
	END;

	DemoResults := Project(demoData,DemoResponse(left));
	
	Results := if(Options.UseTestData,DemoResults,DATASET([initResponse()]));

	OUTPUT(Results,NAMED('Results'));

ENDMACRO;
// PublicProfileServices.ReportService();
/*
<PublicProfileReportRequest>
	<Row>
		<User>
			<GLBPurpose></GLBPurpose>
			<DLPurpose></DLPurpose>
			<DataRestrictionMask></DataRestrictionMask>
			<SSNMask></SSNMask>
		</User>
		<ReportBy>
			<UniqueID></UniqueID>
			<Name>
        <Full></Full>
				<First></First>
				<Middle></Middle>
				<Last></Last>
			</Name>
			<Address>
        <StreetNumber></StreetNumber>
        <StreetPreDirection></StreetPreDirection>
        <StreetName></StreetName>
        <StreetPostDirection></StreetPostDirection>
        <StreetSuffix></StreetSuffix>
        <UnitDesignation></UnitDesignation>
        <UnitNumber></UnitNumber>
				<StreetAddress1></StreetAddress1>
				<StreetAddress2></StreetAddress2>
				<City></City>
				<State></State>
				<Zip5></Zip5>
			</Address>
			<Dob>
				<Year></Year>
				<Month></Month>
				<Day></Day>
			</Dob>
			<Ssn></Ssn>
		</ReportBy>
		<Options>
      <IncludeSSN></IncludeSSN>
      <IncludeNameSSN></IncludeNameSSN>
      <IncludeNameDOB></IncludeNameDOB>
      <IncludeAddress></IncludeAddress>
      <IncludeNameAddress></IncludeNameAddress>
      <IncludeCombination></IncludeCombination>
			<IncludeFootPrint></IncludeFootPrint>
		</Options>
	</Row>
</PublicProfileReportRequest>
*/