IMPORT $, ConsumerDisclosure, doxie, FFD, iesp;

EXPORT ReportRecords(DATASET(doxie.layout_references) in_dids, $.IParams.IParam in_mod) :=
FUNCTION

  // person context/consumer statements
  in_pc_request := PROJECT(in_dids, transform(FFD.Layouts.DidBatch, self.acctno := (string) counter; self.did := left.did;));

  BOOLEAN FailOnSoapError := TRUE;
  pc_response := FFD.Functions.FetchPersonContextAsResponse(in_pc_request, in_mod.gateways,,,FailOnSoapError );
  pc_recs := PROJECT(pc_response.Records, FFD.Layouts.PersonContextBatch);
  slim_pc_recs := FFD.SlimPersonContext(pc_recs);
  consumer_statements := FFD.prepareConsumerStatements(pc_recs);

  in_uniqids := PROJECT(in_dids, doxie.layout_best);

  flag_file := FFD.Functions.GetFlagFileCombined(in_uniqids, pc_recs);

  pull_by_address := in_mod.IncludeAdvo OR in_mod.IncludeAVM or in_mod.IncludeProperties;

  header_data := $.RawHeader.GetData(in_dids, flag_file, slim_pc_recs, in_mod);
  address_data := IF(pull_by_address, $.RawHeader.GetAddressList(header_data));
  ssn_from_header_in := IF(in_mod.IncludeSSN, $.RawHeader.PickBestSSN(header_data));

  inquiry_recs := IF(in_mod.IncludeInquiries, $.RawInquiry.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  ssn_from_inquiry_in := IF(in_mod.IncludeSSNFromInquiries, $.RawInquiry.GetSSNList(inquiry_recs));

  ssn_data := ssn_from_header_in + ssn_from_inquiry_in;
  ssn_recs := IF(in_mod.IncludeSSN, $.RawSSN.GetData(ssn_data,  flag_file, slim_pc_recs, in_mod));

  header_recs := IF(in_mod.IncludeHeader, header_data);
  advo_recs := IF(in_mod.IncludeAdvo, $.RawAdvo.GetData(address_data, flag_file, slim_pc_recs, in_mod));
  avm_recs := IF(in_mod.IncludeAVM, $.RawAVM.GetAVMAddressData(address_data, flag_file, slim_pc_recs, in_mod));
  avm_median_recs := IF(in_mod.IncludeAVM, $.RawAVM.GetAVMMediansData(address_data, flag_file, slim_pc_recs, in_mod));
  property_recs := IF(in_mod.IncludeProperties, $.RawProperty.GetData(in_dids, address_data, flag_file, slim_pc_recs, in_mod));

  aircraft_recs := IF(in_mod.IncludeAircraft, $.RawAircraft.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  american_student_recs := IF(in_mod.IncludeStudent, $.RawStudent.GetASLData(in_dids, flag_file, slim_pc_recs, in_mod));
  alloy_media_student_recs := IF(in_mod.IncludeStudent, $.RawStudent.GetAlloyMSData(in_dids, flag_file, slim_pc_recs, in_mod));
  atf_recs := IF(in_mod.IncludeATF, $.RawATF.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  bk_recs := IF(in_mod.IncludeBankruptcy, $.RawBankruptcy.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  crim_recs := IF(in_mod.IncludeCriminal, $.RawCriminal.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  death_recs := IF(in_mod.IncludeDeath, $.RawDeathDID.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  email_recs := IF(in_mod.IncludeEmail, $.RawEmail.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  gong_recs := IF(in_mod.IncludeGong, $.RawGong.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  huntfish_recs := IF(in_mod.IncludeHuntingFishing, $.RawHuntingFishing.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  infutor_recs := IF(in_mod.IncludeInfutor, $.RawInfutor.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  liens_recs := IF(in_mod.IncludeLiens, $.RawLiens.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  marriage_recs := IF(in_mod.IncludeMarriageDivorce, $.RawMarriageDivorce.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  paw_recs := IF(in_mod.IncludePAW, $.RawPeopleAtWork.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  pilot_recs := IF(in_mod.IncludePilot, $.RawPilot.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  proflic_recs := IF(in_mod.IncludeProfLicense, $.RawProfLicense.GetV2Data(in_dids, flag_file, slim_pc_recs, in_mod));
  proflic_mari_recs := IF(in_mod.IncludeProfLicense, $.RawProfLicense.GetMariData(in_dids, flag_file, slim_pc_recs, in_mod));
  property_by_owner_recs := property_recs(isOwnedBySubject);
  property_by_residence_recs := property_recs(~isOwnedBySubject);
  thrive_recs := IF(in_mod.IncludeThrive, $.RawThrive.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  so_recs := IF(in_mod.IncludeOffenders, $.RawOffender.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
  watercraft_recs := IF(in_mod.IncludeWatercraft, $.RawWatercraft.GetData(in_dids, flag_file, slim_pc_recs, in_mod));

  optout_recs := IF(in_mod.IncludeOptOut, $.RawOptOut.GetData(in_dids));

  // ------- OUTPUT section ----------------
  iesp.fcradataservice.t_FcraDataServiceReport xformResult() := TRANSFORM
    SELF.Aircrafts := PROJECT(aircraft_recs, $.Transforms.xformAircraftData(LEFT));
    SELF.Advo := PROJECT(advo_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceAdvoData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.AlloyMediaStudent := PROJECT(alloy_media_student_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceAlloyMediaStudentData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.AmericanStudent := PROJECT(american_student_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceAmericanStudentData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.ATF := PROJECT(atf_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceATFData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.AVM := PROJECT(avm_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceAVMData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData, SELF.Snapshotdata:= LEFT.Snapshotdata));
    SELF.AVMMedians := PROJECT(avm_median_recs, $.Transforms.xformAVMMediansData(LEFT));
    SELF.Bankruptcy := PROJECT(bk_recs, $.Transforms.xformBKData(LEFT));
    SELF.Criminal := PROJECT(crim_recs, $.Transforms.xformCriminalData(LEFT));
    SELF.DeathDid := PROJECT(death_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceDeathDidData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.Email := PROJECT(email_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceEmailData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.Gong := PROJECT(gong_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceGongData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.HeaderData := PROJECT(header_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceHeaderData, SELF.RawData:= LEFT.RawData, SELF.MetaData.ComplianceFlags.isPropagatedCorrection:=LEFT.isPropagatedCorrection, SELF.MetaData:= LEFT.MetaData));
    SELF.HuntingFishing := PROJECT(huntfish_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceHuntFishData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.Infutor := PROJECT(infutor_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceInfutorData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.Inquiries := PROJECT(inquiry_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceInquiriesData, SELF.RawData:= LEFT.DisclosureData, SELF.MetaData:= LEFT.MetaData));
    SELF.Liens := PROJECT(liens_recs, $.Transforms.xformLiensData(LEFT));
    SELF.Marriage := PROJECT(marriage_recs, $.Transforms.xformMDData(LEFT));
    SELF.OptOut := PROJECT(optout_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceOptOutData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.PeopleAtWork := PROJECT(paw_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServicePAWData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.Pilot := PROJECT(pilot_recs, $.Transforms.xformPilotData(LEFT));
    SELF.ProfessionalLicense := PROJECT(proflic_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceProfLicenseData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.ProfLicenseMari := PROJECT(proflic_mari_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceProfLicenseMariData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.PropertyAssessment := PROJECT(SORT(property_by_owner_recs(EXISTS(Assessment)),-assessed_value_year), $.Transforms.xformPropertyAssessmentData(LEFT));
    SELF.PropertyDeed := PROJECT(SORT(property_by_owner_recs(EXISTS(Deed)),-contract_date), $.Transforms.xformPropertyDeedData(LEFT));
    // deprecated as of feb.2020
    // SELF.AssessmentByResidence := PROJECT(SORT(property_by_residence_recs(EXISTS(Assessment)),-assessed_value_year), $.Transforms.xformPropertyAssessmentData(LEFT));
    // SELF.DeedByResidence := PROJECT(SORT(property_by_residence_recs(EXISTS(Deed)),-contract_date), $.Transforms.xformPropertyDeedData(LEFT));
    SELF.SexOffenders := PROJECT(so_recs, $.Transforms.xformSexOffenderData(LEFT));
    SELF.SSN := PROJECT(ssn_recs(isHeaderSource), TRANSFORM(iesp.fcradataservice.t_FcraDataServiceSSNData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData, SELF.SourceData.death_sources := LEFT.death_sources));
    SELF.SSNFromInquiries := PROJECT(ssn_recs(isInquirySource), TRANSFORM(iesp.fcradataservice.t_FcraDataServiceSSNData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData, SELF.SourceData.death_sources := LEFT.death_sources));
    SELF.Thrive := PROJECT(thrive_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceThriveData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
    SELF.Watercraft := PROJECT(watercraft_recs, $.Transforms.xformWatercraftData(LEFT));
    SELF.PersonContext := PROJECT(pc_recs, iesp.fcradataservice.t_FcraDataServicePersonContextRecord); // --> maybe this should be the raw records as returned from person context instead?
    SELF:=[];
  END;

  res := ROW(xformResult());

  isResultFound := EXISTS(aircraft_recs) OR EXISTS(advo_recs) OR EXISTS(alloy_media_student_recs) OR EXISTS(american_student_recs) OR
    EXISTS(atf_recs) OR EXISTS(avm_recs) OR EXISTS(avm_median_recs) OR EXISTS(bk_recs) OR EXISTS(crim_recs) OR EXISTS(death_recs) OR
    EXISTS(email_recs) OR EXISTS(gong_recs) OR EXISTS(header_recs) OR EXISTS(huntfish_recs) OR EXISTS(infutor_recs) OR EXISTS(inquiry_recs) OR
    EXISTS(liens_recs) OR EXISTS(marriage_recs) OR EXISTS(optout_recs) OR EXISTS(paw_recs) OR EXISTS(pilot_recs) OR EXISTS(proflic_recs) OR
    EXISTS(proflic_mari_recs) OR EXISTS(property_by_owner_recs) OR EXISTS(property_by_residence_recs) OR EXISTS(so_recs) OR
    EXISTS(ssn_recs) OR EXISTS(thrive_recs) OR EXISTS(watercraft_recs) OR EXISTS(pc_recs);

  isPCSoapFail := pc_response._Header.Status = ConsumerDisclosure.Constants.StatusCodes.SOAPError;

  $.Layouts.ReportResponse xformResponse() := TRANSFORM
    StatusCode := MAP(isPCSoapFail => ConsumerDisclosure.Constants.StatusCodes.SOAPError,
                      isResultFound => ConsumerDisclosure.Constants.StatusCodes.ResultsFound,
                      ConsumerDisclosure.Constants.StatusCodes.NoResultsFound);
    SELF.Status := StatusCode;
    SELF.Message := ConsumerDisclosure.Constants.GetStatusMessage(StatusCode);
    SELF.Exceptions := IF(isPCSoapFail, pc_response._Header.Exceptions);
    SELF.Records := IF(~isPCSoapFail, res);
  END;
  out_resp := ROW(xformResponse());

  // ------- OUTPUT section ----------------

  IF(ConsumerDisclosure.Debug, OUTPUT(flag_file, named('flag_file')));
  IF(ConsumerDisclosure.Debug, OUTPUT(slim_pc_recs, named('slim_pc_recs')));
  IF(ConsumerDisclosure.Debug AND pull_by_address, OUTPUT(address_data, named('address_list')));
  IF(ConsumerDisclosure.Debug, OUTPUT(consumer_statements, named('consumer_statements')));

  RETURN out_resp;

END;
