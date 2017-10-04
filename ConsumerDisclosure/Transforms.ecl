IMPORT iesp, ConsumerDisclosure;
EXPORT Transforms := MODULE

	//-----Aircraft------------
	iesp.fcradataservice.t_FcraDataServiceAircraftIdData xfAircraftId(
										ConsumerDisclosure.RawAircraft.aircraft_out air) := TRANSFORM
		SELF.MetaData := air.MetaData;
		SELF.RawData := air;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceAircraftDetailsData xfAircraftDetails(
											ConsumerDisclosure.RawAircraft.aircraft_details_out dtls) := TRANSFORM
		SELF.MetaData := dtls.MetaData;
		SELF.RawData := dtls;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceAircraftEngineData xfAircraftEngine(
											ConsumerDisclosure.RawAircraft.aircraft_engine_out eng) := TRANSFORM
		SELF.MetaData := eng.MetaData;
		SELF.RawData := eng;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServiceAircraftData xformAircraftData(ConsumerDisclosure.RawAircraft.FAA_out l) 
	:= TRANSFORM
		SELF.Aircraft := PROJECT(l.Aircraft, xfAircraftId(LEFT));
		SELF.AircraftDetails := PROJECT(l.AircraftDetails, xfAircraftDetails(LEFT));
		SELF.AircraftEngine := PROJECT(l.AircraftEngine, xfAircraftEngine(LEFT));
		SELF.GroupBy.mfr_mdl_code := l.mfr_mdl_code;
		SELF.GroupBy.eng_mfr_mdl := l.eng_mfr_mdl;
	END;

	//----------Bankruptcy-------------
	iesp.fcradataservice.t_FcraDataServiceBKSearchData xfBKsearch(
										ConsumerDisclosure.RawBankruptcy.Bankruptcy_party_out bks) := TRANSFORM
		SELF.MetaData := bks.MetaData;
		SELF.RawData := bks.RawData;
		SELF.WithdrawnStatusInfo := bks.WithdrawnStatusInfo;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceBKMainData xfBKmain(
											ConsumerDisclosure.RawBankruptcy.Bankruptcy_main_out bkl) := TRANSFORM
		SELF.MetaData := bkl.MetaData;
		SELF.RawData := bkl.RawData;
		SELF.CourtInfo := bkl.CourtInfo;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServiceBankruptcyData xformBKData(
																				ConsumerDisclosure.RawBankruptcy.Bankruptcy_out l) 
	:= TRANSFORM
		SELF.Main := PROJECT(l.Main, xfBKmain(LEFT));
		SELF.Search := PROJECT(l.Parties, xfBKsearch(LEFT));
		SELF.GroupBy.tmsid := l.tmsid;
	END;
	
//----------Marriage-Divorce-------------
	iesp.fcradataservice.t_FcraDataServiceMarriageDivMainData xfMDMain(
										ConsumerDisclosure.RawMarriageDivorce.MD_main_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceMarriageDivPartyData xfMDParty(
											ConsumerDisclosure.RawMarriageDivorce.MD_party_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServiceMarriageDivData xformMDData(
																				ConsumerDisclosure.RawMarriageDivorce.MD_out l) 
	:= TRANSFORM
		SELF.Main := PROJECT(l.Main, xfMDMain(LEFT));
		SELF.Search := PROJECT(l.Parties, xfMDParty(LEFT));
		SELF.GroupBy.record_id := l.record_id;
	END;
	
	//----------Pilot-------------
	iesp.fcradataservice.t_FcraDataServicePilotRegistrationData xfPilotReg(
										ConsumerDisclosure.RawPilot.Pilot_reg_out reg) := TRANSFORM
		SELF.MetaData := reg.MetaData;
		SELF.RawData := reg;
	END;
	
	iesp.fcradataservice.t_FcraDataServicePilotCertificateData xfPilotCert(
											ConsumerDisclosure.RawPilot.Pilot_cert_out cert) := TRANSFORM
		SELF.MetaData := cert.MetaData;
		SELF.RawData := cert;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServicePilotData xformPilotData(
																				ConsumerDisclosure.RawPilot.Pilot_out l) 
	:= TRANSFORM
		SELF.Certificate := PROJECT(l.Certificate, xfPilotCert(LEFT));
		SELF.Registration := PROJECT(l.Registration, xfPilotReg(LEFT));
		SELF.GroupBy.unique_id := l.unique_id;
	END;
	
//----------UCC-------------
	iesp.fcradataservice.t_FcraDataServiceUCCMainData xformUCCMain(
										ConsumerDisclosure.RawUCC.UCC_main_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceUCCPartyData xformUCCParty(
											ConsumerDisclosure.RawUCC.UCC_party_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServiceUCCData xformUCCData(
																				ConsumerDisclosure.RawUCC.UCC_out l) 
	:= TRANSFORM
		SELF.Main := PROJECT(l.UCCMain, xformUCCMain(LEFT));
		SELF.Party := PROJECT(l.UCCParty, xformUCCParty(LEFT));
		SELF.GroupBy.tmsid := l.tmsid;
	END;
	
	//----------Watercraft-------------
	iesp.fcradataservice.t_FcraDataServiceWatercraftOwnerData xfWatercraftOwners(
										ConsumerDisclosure.RawWatercraft.Watercraft_owners_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceWatercraftInfoData xfWatercraftInfo(
											ConsumerDisclosure.RawWatercraft.Watercraft_info_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceWatercraftCoastguardData xfCoastguard(
											ConsumerDisclosure.RawWatercraft.Coastguard_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServiceWatercraftData xformWatercraftData(
																				ConsumerDisclosure.RawWatercraft.Watercraft_out l) 
	:= TRANSFORM
		SELF.Owners := PROJECT(l.Owners, xfWatercraftOwners(LEFT));
		SELF.Details := PROJECT(l.Details, xfWatercraftInfo(LEFT));
		SELF.Coastguard := PROJECT(l.Coastguard, xfCoastguard(LEFT));
		SELF.GroupBy.state_origin := l.state_origin;
		SELF.GroupBy.watercraft_key := l.watercraft_key;
		SELF.GroupBy.sequence_key := l.sequence_key;
	END;
	
END;