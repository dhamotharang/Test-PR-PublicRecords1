IMPORT ConsumerDisclosure, doxie, FCRA, FFD, iesp;

EXPORT ReportRecords(dataset(doxie.layout_references) in_dids, ConsumerDisclosure.IParams.IParam in_mod) := 
FUNCTION
	
	boolean inc_all := in_mod.IncludeAll;	
	boolean inc_atf := inc_all or in_mod.IncludeATF;
	boolean inc_bk := inc_all or in_mod.IncludeBankruptcy;
	boolean inc_death := inc_all or in_mod.IncludeDeath;
	boolean inc_gong := inc_all or in_mod.IncludeGong;
	
	// person context/consumer statements
	in_pc := project(in_dids, transform(FFD.Layouts.DidBatch, self.acctno := (string) counter; self.did := left.did;));
	pc_recs := FFD.FetchPersonContext(in_pc, in_mod.gateways);
	slim_pc_recs := FFD.SlimPersonContext(pc_recs);
	consumer_statements := FFD.prepareConsumerStatements(pc_recs); 
		
	in_uniqids := PROJECT(in_dids, doxie.layout_best);
	
	// Do we need best records? 
	//best_recs := doxie.best_records(in_dids, IsFCRA := TRUE);

	// In cases when best recs is not returned for LexId, 
	// For ex, in case when all header records are suppressed
	//best_recs_for_flag_file := IF(EXISTS(best_recs), best_recs, in_uniqids);
  
	// FCRA overrides flag file - maybe use just input LexId?  
	// Do we need to support SSN for override flags ?
  flag_file := FFD.GetFlagFile(in_uniqids, pc_recs);
	
  atf_recs := if(inc_atf, ConsumerDisclosure.RawATF.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	bk_recs := if(inc_bk, ConsumerDisclosure.RawBankruptcy.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	death_recs := if(inc_death, ConsumerDisclosure.RawDeathDID.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	gong_recs := if(inc_gong, ConsumerDisclosure.RawGong.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	huntfish_recs := if(inc_all or in_mod.IncludeHuntingFishing, ConsumerDisclosure.RawHuntingFishing.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	paw_recs := if(inc_all or in_mod.IncludePAW, ConsumerDisclosure.RawPeopleAtWork.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	pilot_recs := if(inc_all or in_mod.IncludePilot, ConsumerDisclosure.RawPilot.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	aircraft_recs := if(inc_all or in_mod.IncludeAircraft, ConsumerDisclosure.RawAircraft.GetData(in_dids, flag_file, slim_pc_recs, in_mod));
	american_student_recs := if(inc_all or in_mod.IncludeStudent, ConsumerDisclosure.RawStudent.GetASLData(in_dids, flag_file, slim_pc_recs, in_mod));
	alloy_media_student_recs := if(inc_all or in_mod.IncludeStudent, ConsumerDisclosure.RawStudent.GetAlloyMSData(in_dids, flag_file, slim_pc_recs, in_mod));

	// ------- OUTPUT section ----------------
	iesp.fcradataservice.t_FcraDataServiceReport xformResult() := TRANSFORM
		SELF.Aircrafts := PROJECT(aircraft_recs, ConsumerDisclosure.Transforms.xformAircraftData(LEFT));
		SELF.AlloyMediaStudent := PROJECT(alloy_media_student_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceAlloyMediaStudentData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.AmericanStudent := PROJECT(american_student_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceAmericanStudentData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.ATF := PROJECT(atf_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceATFData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.Bankruptcy := PROJECT(bk_recs, ConsumerDisclosure.Transforms.xformBKData(LEFT));
		SELF.DeathDid := PROJECT(death_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceDeathDidData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.Gong := PROJECT(gong_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceGongData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.HuntingFishing := PROJECT(huntfish_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceHuntFishData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.PeopleAtWork := PROJECT(paw_recs, TRANSFORM(iesp.fcradataservice.t_FcraDataServicePAWData, SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.Pilot := PROJECT(pilot_recs, ConsumerDisclosure.Transforms.xformPilotData(LEFT));
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