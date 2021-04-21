// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO--
    Searches for Address Report.
*/

import AutoStandardI, PersonReports, iesp, doxie, AddressReport_Services, STD;
EXPORT ReportService := MACRO

//The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_AddrReport_ReportService();

  #constant('nodeepdive',true);
  #constant('SelectIndividually', true);
  #constant('IncludePriorProperties', true);
  #constant('UseCurrentlyOwnedProperty', true);
  #constant('IncludeDetails', true);
  #constant ('IncludeNonDMVSources', true);
  #constant ('IncludeNonRegulatedVehicleSources', true);
  #CONSTANT('TwoPartySearch', FALSE);

  include_def := module
    export boolean include_businesses := true;
    export boolean include_CensusData := true;
    export boolean Include_ResidentialPhones := true;
    export boolean Include_BusinessPhones := true;
    export boolean include_bankruptcy := true;
    export boolean include_Properties := true;
    export boolean include_Neighbors := true;
    export boolean include_LiensJudgments := true;
    export boolean include_MotorVehicles := true;
    export boolean include_DriversLicenses := true;
    export boolean include_CriminalRecords := true;
    export boolean include_SexualOffenses := true;
    export boolean include_HuntingFishingLicenses := true;
    export boolean include_WeaponPermits := true;
  end;
 boolean OverrideInclude := false : stored ('OverrideInclude');

  // reads "volatile" [includes] from XML, if any, and stores them for subsequent reading
  SetInputSearchOptions (iesp.addressreportreq.t_AddressReportOption tag) := FUNCTION
			#stored ('IncludeProperties', global(tag).IncludeProperties);
			#stored ('IncludeDriversLicenses', global(tag).IncludeDriversLicenses);
			#stored ('IncludeMotorVehicles', global(tag).IncludeMotorVehicles);
			#stored ('IncludeBusinesses', global(tag).IncludeBusinesses);
			#stored ('IncludeNeighbors', global(tag).IncludeNeighbors);
			#stored ('IncludeBankruptcies', global(tag).IncludeBankruptcies);
			#stored ('IncludeResidentialPhones', global(tag).IncludeResidentialPhones);
			#stored ('IncludeBusinessPhones', global(tag).IncludeBusinessPhones);
			#stored ('IncludeCensusData', global(tag).IncludeCensusData);
			#stored ('IncludeLiensJudgments', global(tag).IncludeLiensJudgments);
			#stored ('IncludeCriminalRecords', global(tag).IncludeCriminalRecords);
			#stored ('IncludeSexualOffenses', global(tag).IncludeSexualOffenses);
			#stored ('IncludeHuntingFishingLicenses', global(tag).IncludeHuntingFishings);
			#stored ('IncludeWeaponPermits', global(tag).IncludeConcealedWeapons);

			#stored ('MaxDriversLicenses', global(tag).MaxDriversLicenses);
			#stored ('MaxProperties', global(tag).MaxProperties);
			#stored ('MaxMotorVehicles', global(tag).MaxMotorVehicles);
			#stored ('MaxBusinesses', global(tag).MaxBusinesses);
			#stored ('NeighborCount', global(tag).NeighborCount);
			#stored ('MaxNeighbors', global(tag).MaxNeighbors);
			#stored ('MaxBankruptcies', global(tag).MaxBankruptcies);
			#stored ('MaxResidentialPhones', global(tag).MaxResidentialPhones);
			#stored ('MaxBusinessPhones', global(tag).MaxBusinessPhones);
			#stored ('MaxResidents', global(tag).MaxResidents);
			#stored ('MaxLiens', global(tag).MaxLiens);
			#stored ('MaxCriminalRecords', global(tag).MaxCriminalRecords);
			#stored ('MaxSexualOffenses', global(tag).MaxSexualOffenses);
			#stored ('MaxHuntingAndFishingLicenses', global(tag).MaxHuntingFishings);
			#stored ('MaxWeaponPermits', global(tag).MaxConcealedWeapons);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;

  //Due to a dependency to BPS report and to changes done during Project July on the ESP side
  //ESP had to split the request and the response for this service in order to be able to keep generating the layout
  //instead of manually making the changes
  //This should not become the norm
  rec_in := iesp.addressreportreq.t_AddressReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('AddressReportRequest', FEW);

  first_raw := ds_in[1] : INDEPENDENT;
  iesp.ECL2ESP.SetInputBaseRequest (first_raw);
  ReportBy := global (first_raw.ReportBy);

  //***************************************************//
  // iesp.ECL2ESP.SetInputAddress (ReportBy.Address);
  // Unfortunately I cannot use the standard ECL2ESP setIputAddress
  // because the input can be a single line or components and
  // I am using the clean address passing the single line address.
  //****************************************************//
  AddressReport_Services.input.SetInputAddress (ReportBy.Address);
  SetInputSearchOptions (first_raw.Options);
  boolean location_report := first_raw.Options.LocationReportOnly : STORED('LocationReportOnly');
  boolean use_new_business_header := first_raw.Options.useNewBusinessHeader : STORED('useNewBusinessHeader');
  string1 bus_report_fetch_level := 'S' : stored('BusinessReportFetchLevel');
  boolean includeAssignmentsAndReleases := first_raw.Options.IncludeAssignmentsAndReleases : STORED('IncludeAssignmentsAndReleases');

  include_stored := PersonReports.GlobalIncludes ();

  tmp := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(tmp);

  tempmod := module (project (tmp, AddressReport_Services.input._addressreport, opt))
      doxie.compliance.MAC_CopyModAccessValues(mod_access);
      export boolean include_driverslicenses := include_stored.include_driverslicenses;
      export boolean include_businesses := include_stored.include_businesses;
      export boolean include_CensusData := include_stored.include_CensusData;
      export boolean Include_ResidentialPhones := include_stored.Include_ResidentialPhones;
      export boolean Include_BusinessPhones := include_stored.Include_BusinessPhones;
      export boolean include_bankruptcy := include_stored.include_bankruptcy;
      export boolean include_Properties := include_stored.include_Properties;
      export boolean include_Neighbors := include_stored.include_Neighbors;
      export boolean include_LiensJudgments := include_stored.include_LiensJudgments;
      export boolean include_MotorVehicles := include_stored.include_MotorVehicles;
      export boolean include_CriminalRecords := include_stored.include_crimrecords;
      export boolean include_SexualOffenses := include_stored.include_sexualoffences;
      export boolean include_HuntingFishingLicenses := include_stored.include_huntingfishing;
      export boolean include_WeaponPermits := include_stored.include_weaponpermits;
      export boolean locationReport := location_report;
      export boolean useNewBusinessHeader := use_new_business_header;
      export string1 BusinessReportFetchLevel := STD.Str.ToUpperCase(bus_report_fetch_level);
  end;

	Relationship.IParams.storeParams(first_raw.Options.RelationshipOption);
	addr_mod := Relationship.IParams.getParams(tempmod,AddressReport_Services.input._addressreport);

  recs := AddressReport_Services.ReportService_Records (addr_mod, FALSE,includeAssignmentsAndReleases);
  results_recs := project(recs, transform(iesp.addressreport.t_AddressReportResponse, self := left.ReportResponse));
  output(results_recs, named ('Results'));

  //Royalties for Location Report
  if(tempmod.locationReport, output(recs.royalties, NAMED('RoyaltySet')));

ENDMACRO;
// ReportService();
