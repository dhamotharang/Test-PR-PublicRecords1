IMPORT ConsumerDisclosure, doxie, FCRA, FFD, iesp;

EXPORT ReportRecords(dataset(doxie.layout_references) in_dids, ConsumerDisclosure.IParams.IParam in_mod) := 
FUNCTION
	
	// person context/consumer statements
	in_pc := project(in_dids, transform(FFD.Layouts.DidBatch, self.acctno := (string) counter; self.did := left.did;));
	pc_recs := FFD.FetchPersonContext(in_pc, in_mod.gateways);
	slim_pc_recs := FFD.SlimPersonContext(pc_recs);
	consumer_statements := FFD.prepareConsumerStatements(pc_recs); 
		
	in_uniqids := PROJECT(in_dids, doxie.layout_best);
	
  flag_file := FFD.GetFlagFile(in_uniqids, pc_recs);
	
	pull_by_address := in_mod.IncludeAdvo or in_mod.IncludeAVM or in_mod.IncludeProperties;
	
	header_data := ConsumerDisclosure.RawHeader.GetData(in_dids, flag_file, slim_pc_recs, in_mod);
	address_data := if(pull_by_address, ConsumerDisclosure.RawHeader.GetAddressList(header_data));
	
	header_recs := if(in_mod.IncludeHeader, header_data);
	advo_recs := if(in_mod.IncludeAdvo, ConsumerDisclosure.RawAdvo.GetData(address_data, flag_file, slim_pc_recs, in_mod));

	aircraft_recs := if(in_mod.IncludeAircraft, ConsumerDisclosure.RawAircraft.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	american_student_recs := if(in_mod.IncludeStudent, ConsumerDisclosure.RawStudent.GetASLData(in_dids, flag_file, slim_pc_recs, in_mod));
	alloy_media_student_recs := if(in_mod.IncludeStudent, ConsumerDisclosure.RawStudent.GetAlloyMSData(in_dids, flag_file, slim_pc_recs, in_mod));
  atf_recs := if(in_mod.IncludeATF, ConsumerDisclosure.RawATF.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	bk_recs := if(in_mod.IncludeBankruptcy, ConsumerDisclosure.RawBankruptcy.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	crim_recs := if(in_mod.IncludeCriminal, ConsumerDisclosure.RawCriminal.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	death_recs := if(in_mod.IncludeDeath, ConsumerDisclosure.RawDeathDID.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	email_recs := if(in_mod.IncludeEmail, ConsumerDisclosure.RawEmail.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	gong_recs := if(in_mod.IncludeGong, ConsumerDisclosure.RawGong.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	huntfish_recs := if(in_mod.IncludeHuntingFishing, ConsumerDisclosure.RawHuntingFishing.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	infutor_recs := if(in_mod.IncludeInfutor, ConsumerDisclosure.RawInfutor.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	liens_recs := if(in_mod.IncludeLiens, ConsumerDisclosure.RawLiens.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	marriage_recs := if(in_mod.IncludeMarriageDivorce, ConsumerDisclosure.RawMarriageDivorce.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	paw_recs := if(in_mod.IncludePAW, ConsumerDisclosure.RawPeopleAtWork.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	pilot_recs := if(in_mod.IncludePilot, ConsumerDisclosure.RawPilot.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	proflic_recs := if(in_mod.IncludeProfLicense, ConsumerDisclosure.RawProfLicense.GetV2Data(in_dids, flag_file, slim_pc_recs, in_mod));
	proflic_mari_recs := if(in_mod.IncludeProfLicense, ConsumerDisclosure.RawProfLicense.GetMariData(in_dids, flag_file, slim_pc_recs, in_mod));
	property_recs := if(in_mod.IncludeProperties, ConsumerDisclosure.RawProperty.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	thrive_recs := if(in_mod.IncludeThrive, ConsumerDisclosure.RawThrive.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	so_recs := if(in_mod.IncludeOffenders, ConsumerDisclosure.RawOffender.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	ucc_recs := if(in_mod.IncludeUCC, ConsumerDisclosure.RawUCC.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	watercraft_recs := if(in_mod.IncludeWatercraft, ConsumerDisclosure.RawWatercraft.GetData(in_dids, flag_file, slim_pc_recs, in_mod));

	optout_recs := if(in_mod.IncludeOptOut, ConsumerDisclosure.RawOptOut.GetData(in_dids));

	// ------- OUTPUT section ----------------
	iesp.fcradataservice.t_FcraDataServiceReport xformResult() := TRANSFORM
		SELF.Aircrafts := PROJECT(aircraft_recs, ConsumerDisclosure.Transforms.xformAircraftData(LEFT));
		SELF.Advo := PROJECT(advo_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceAdvoData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.AlloyMediaStudent := PROJECT(alloy_media_student_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceAlloyMediaStudentData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.AmericanStudent := PROJECT(american_student_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceAmericanStudentData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.ATF := PROJECT(atf_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceATFData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.Bankruptcy := PROJECT(bk_recs, ConsumerDisclosure.Transforms.xformBKData(LEFT));
		SELF.Criminal := PROJECT(crim_recs, ConsumerDisclosure.Transforms.xformCriminalData(LEFT));
		SELF.DeathDid := PROJECT(death_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceDeathDidData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.Email := PROJECT(email_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceEmailData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.Gong := PROJECT(gong_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceGongData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.HeaderData := PROJECT(header_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceHeaderData, SELF.RawData:= LEFT.RawData, SELF.MetaData.ComplianceFlags.isPropagatedCorrection:=LEFT.isPropagatedCorrection, SELF.MetaData:= LEFT.MetaData));
		SELF.HuntingFishing := PROJECT(huntfish_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceHuntFishData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.Infutor := PROJECT(infutor_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceInfutorData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.Liens := PROJECT(liens_recs, ConsumerDisclosure.Transforms.xformLiensData(LEFT));
		SELF.Marriage := PROJECT(marriage_recs, ConsumerDisclosure.Transforms.xformMDData(LEFT));
		SELF.OptOut := PROJECT(optout_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceOptOutData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.PeopleAtWork := PROJECT(paw_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServicePAWData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.Pilot := PROJECT(pilot_recs, ConsumerDisclosure.Transforms.xformPilotData(LEFT));
		SELF.ProfessionalLicense := PROJECT(proflic_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceProfLicenseData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.ProfLicenseMari := PROJECT(proflic_mari_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceProfLicenseMariData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.PropertyAssessment := PROJECT(property_recs(EXISTS(Assessment)), ConsumerDisclosure.Transforms.xformPropertyAssessmentData(LEFT));
		SELF.PropertyDeed := PROJECT(property_recs(EXISTS(Deed)), ConsumerDisclosure.Transforms.xformPropertyDeedData(LEFT));
		SELF.Thrive := PROJECT(thrive_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceThriveData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.SexOffenders := PROJECT(so_recs, ConsumerDisclosure.Transforms.xformSexOffenderData(LEFT));
		SELF.UCC := PROJECT(ucc_recs, ConsumerDisclosure.Transforms.xformUCCData(LEFT));
		SELF.Watercraft := PROJECT(watercraft_recs, ConsumerDisclosure.Transforms.xformWatercraftData(LEFT));
		SELF.PersonContext := PROJECT(pc_recs, iesp.fcradataservice.t_FcraDataServicePersonContextRecord); // --> maybe this should be the raw records as returned from person context instead?
		SELF:=[];
	END;
	
	res := ROW(xformResult());

	// ------- OUTPUT section ----------------
	
  if($.Debug, OUTPUT(flag_file, named('flag_file')));
  if($.Debug, OUTPUT(slim_pc_recs, named('slim_pc_recs')));
  if($.Debug, OUTPUT(consumer_statements, named('consumer_statements')));

	RETURN res;
	
END;