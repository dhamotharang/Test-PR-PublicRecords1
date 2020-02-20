/*--SOAP--
<message name="ReportService">
  <part name="PublicProfileReportRequest" type="tns:XmlDataSet" cols="80" rows="40" />
</message>
*/
/*--INFO-- Header Summary: search by combinations of NAME,ADDRESS,SSN and DOB<br/>
 Person Report Summary: IncludeFootPrint 
*/

IMPORT iesp,address,AutoStandardI, std;

EXPORT ReportService := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
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

  // glbMod := AutoStandardI.GlobalModule(); // will need it for reading legacy settings
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
  rptByMod := MODULE (PROJECT (mod_access, PublicProfileServices.IParam.searchParams, OPT))
    export unsigned1 glb := (unsigned1) User.GLBPurpose;
    export unsigned1 dppa := (unsigned1) User.DLPurpose;
    export boolean show_minors := TRUE;

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
  END;

  hdrSum := PublicProfileServices.Records.HeaderSummary(rptByMod);
  perSum := IF(Options.IncludeFootPrint,
    PublicProfileServices.Records.PersonSummary(rptByMod),
    ROW([],iesp.public_profile_report.t_PublicProfileIndividual));

  iesp.public_profile_report.t_PublicProfileReportResponse initResponse() := TRANSFORM
    SELF._Header := iesp.ECL2ESP.GetHeaderRow();
    SELF.Messages := [];
    SELF.UserInput := ReportBy;
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
