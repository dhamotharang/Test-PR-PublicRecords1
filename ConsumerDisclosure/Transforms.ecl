﻿IMPORT iesp, ConsumerDisclosure;
EXPORT Transforms := MODULE

	//-----Aircraft------------
	iesp.fcradataservice.t_FcraDataServiceAircraftIdData xfAircraftId(
										ConsumerDisclosure.RawAircraft.layout_aircraft_out air) := TRANSFORM
		SELF.MetaData := air.MetaData;
		SELF.RawData := air;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceAircraftDetailsData xfAircraftDetails(
											ConsumerDisclosure.RawAircraft.layout_aircraft_details_out dtls) := TRANSFORM
		SELF.MetaData := dtls.MetaData;
		SELF.RawData := dtls;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceAircraftEngineData xfAircraftEngine(
											ConsumerDisclosure.RawAircraft.layout_aircraft_engine_out eng) := TRANSFORM
		SELF.MetaData := eng.MetaData;
		SELF.RawData := eng;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServiceAircraftData xformAircraftData(ConsumerDisclosure.RawAircraft.layout_FAA_out l) 
	:= TRANSFORM
		SELF.Aircraft := PROJECT(l.Aircraft, xfAircraftId(LEFT));
		SELF.AircraftDetails := PROJECT(l.AircraftDetails, xfAircraftDetails(LEFT));
		SELF.AircraftEngine := PROJECT(l.AircraftEngine, xfAircraftEngine(LEFT));
		SELF.GroupBy.mfr_mdl_code := l.mfr_mdl_code;
		SELF.GroupBy.eng_mfr_mdl := l.eng_mfr_mdl;
	END;

	//----------AVM Medians-------------
	EXPORT iesp.fcradataservice.t_FcraDataServiceAVMMediansData xformAVMMediansData(ConsumerDisclosure.RawAVM.layout_avm_medians_out l) 
	:= TRANSFORM
		SELF.AddressWithCalculatedAVMMedians := PROJECT(l.disclosure_medians, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceAVMMediansCalculatedData,SELF.CalculatedData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.AVMMediansHistory := PROJECT(l.raw_medians, TRANSFORM(iesp.fcradataservice.t_FcraDataServiceAVMMediansRawData,SELF.RawData:= LEFT, SELF.MetaData:= LEFT.MetaData));
		SELF.GroupBy.geolink := l.block_geolink;
	END;

	//----------Bankruptcy-------------
	iesp.fcradataservice.t_FcraDataServiceBKSearchData xfBKsearch(
										ConsumerDisclosure.RawBankruptcy.layout_Bankruptcy_party_out bks) := TRANSFORM
		SELF.MetaData := bks.MetaData;
		SELF.RawData := bks.RawData;
		SELF.WithdrawnStatusInfo := bks.WithdrawnStatusInfo;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceBKMainData xfBKmain(
											ConsumerDisclosure.RawBankruptcy.layout_Bankruptcy_main_out bkl) := TRANSFORM
		SELF.MetaData := bkl.MetaData;
		SELF.RawData := bkl.RawData;
		SELF.CourtInfo := bkl.CourtInfo;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServiceBankruptcyData xformBKData(
																				ConsumerDisclosure.RawBankruptcy.layout_Bankruptcy_out l) 
	:= TRANSFORM
		SELF.Main := PROJECT(l.Main, xfBKmain(LEFT));
		SELF.Search := PROJECT(l.Parties, xfBKsearch(LEFT));
		SELF.GroupBy.tmsid := l.tmsid;
	END;
	
//----------Criminal-------------
	iesp.fcradataservice.t_FcraDataServiceCriminalOffenderData xfOffenders(
										ConsumerDisclosure.RawCriminal.layout_offender_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceCriminalOffenseData xfOffenses(
											ConsumerDisclosure.RawCriminal.layout_offense_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceCriminalCourtOffenseData xfCourtOffenses(
											ConsumerDisclosure.RawCriminal.layout_court_offense_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceCriminalPunishmentData xfPunishment(
											ConsumerDisclosure.RawCriminal.layout_punishment_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServiceCriminalData xformCriminalData(
																				ConsumerDisclosure.RawCriminal.layout_criminal_rec_out l) 
	:= TRANSFORM
		SELF.Offenders := PROJECT(l.Offenders, xfOffenders(LEFT));
		SELF.OffendersPlus := PROJECT(l.OffenderPlus, xfOffenders(LEFT));
		SELF.Offenses := PROJECT(l.Offenses, xfOffenses(LEFT));
		SELF.CourtOffenses := PROJECT(l.CourtOffenses, xfCourtOffenses(LEFT));
		SELF.Punishment := PROJECT(l.Punishments, xfPunishment(LEFT));
		SELF.GroupBy.offender_key := l.offender_key;
	END;
	
//----------Liens-------------
	iesp.fcradataservice.t_FcraDataServiceLiensMainData xfLiensMain(
										ConsumerDisclosure.RawLiens.layout_liens_main_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceLiensPartyData xfLiensParty(
											ConsumerDisclosure.RawLiens.layout_liens_party_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServiceLiensData xformLiensData(
																				ConsumerDisclosure.RawLiens.layout_liens_out l) 
	:= TRANSFORM
		SELF.Main := PROJECT(l.Main, xfLiensMain(LEFT));
		SELF.Party := PROJECT(l.Parties, xfLiensParty(LEFT));
		SELF.GroupBy.tmsid := l.tmsid;
		SELF.GroupBy.rmsid := l.rmsid;
	END;
	
//----------Marriage-Divorce-------------
	iesp.fcradataservice.t_FcraDataServiceMarriageDivMainData xfMDMain(
										ConsumerDisclosure.RawMarriageDivorce.layout_MD_main_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceMarriageDivPartyData xfMDParty(
											ConsumerDisclosure.RawMarriageDivorce.layout_MD_party_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServiceMarriageDivData xformMDData(
																				ConsumerDisclosure.RawMarriageDivorce.layout_MD_out l) 
	:= TRANSFORM
		SELF.Main := PROJECT(l.Main, xfMDMain(LEFT));
		SELF.Search := PROJECT(l.Parties, xfMDParty(LEFT));
		SELF.GroupBy.record_id := l.record_id;
	END;
	
	//----------Pilot-------------
	iesp.fcradataservice.t_FcraDataServicePilotRegistrationData xfPilotReg(
										ConsumerDisclosure.RawPilot.layout_Pilot_reg_out reg) := TRANSFORM
		SELF.MetaData := reg.MetaData;
		SELF.RawData := reg;
	END;
	
	iesp.fcradataservice.t_FcraDataServicePilotCertificateData xfPilotCert(
											ConsumerDisclosure.RawPilot.layout_Pilot_cert_out cert) := TRANSFORM
		SELF.MetaData := cert.MetaData;
		SELF.RawData := cert;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServicePilotData xformPilotData(
																				ConsumerDisclosure.RawPilot.layout_Pilot_out l) 
	:= TRANSFORM
		SELF.Certificate := PROJECT(l.Certificate, xfPilotCert(LEFT));
		SELF.Registration := PROJECT(l.Registration, xfPilotReg(LEFT));
		SELF.GroupBy.unique_id := l.unique_id;
	END;
	
	//----------Property-------------
	iesp.fcradataservice.t_FcraDataServicePropertyAssessmentData xfPropAssessment(
										ConsumerDisclosure.RawProperty.layout_assessment_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec.RawData;
		SELF.AddlLegalDescription := rec.AddlLegalDescription;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServicePropertyAssessment xformPropertyAssessmentData(
																				ConsumerDisclosure.RawProperty.layout_property_out l) 
	:= TRANSFORM
		SELF.Assessment := PROJECT(l.Assessment, xfPropAssessment(LEFT));
		SELF.Search := PROJECT(l.Search, TRANSFORM(iesp.fcradataservice.t_FcraDataServicePropertySearchData,
																								SELF.MetaData := LEFT.MetaData,
																								SELF.RawData := LEFT));
		SELF.GroupBy.ln_fares_id := l.ln_fares_id;
	END;
	
	iesp.fcradataservice.t_FcraDataServicePropertyDeedData xfPropDeed(
											ConsumerDisclosure.RawProperty.layout_deed_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec.RawData;
		SELF.AdditionalNames := PROJECT(rec.AdditionalNames, iesp.fcradataservice_raw.t_FcraDataServiceRawPropertyAddlNames);
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServicePropertyDeed xformPropertyDeedData(
																				ConsumerDisclosure.RawProperty.layout_property_out l) 
	:= TRANSFORM
		SELF.Deed := PROJECT(l.Deed, xfPropDeed(LEFT));
		SELF.Search := PROJECT(l.Search, TRANSFORM(iesp.fcradataservice.t_FcraDataServicePropertySearchData,
																								SELF.MetaData := LEFT.MetaData,
																								SELF.RawData := LEFT));
		SELF.GroupBy.ln_fares_id := l.ln_fares_id;
	END;
	
//----------SexOffenders-------------
	iesp.fcradataservice.t_FcraDataServiceSOffenderMainData xformSOffenders(
										ConsumerDisclosure.RawOffender.layout_so_offender_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceSOffenseData xformSOffenses(
											ConsumerDisclosure.RawOffender.layout_so_offense_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServiceSOData xformSexOffenderData(
																				ConsumerDisclosure.RawOffender.layout_SO_out l) 
	:= TRANSFORM
		SELF.Main := PROJECT(l.Offenders, xformSOffenders(LEFT));
		SELF.Offenses := PROJECT(l.Offenses, xformSOffenses(LEFT));
		SELF.GroupBy.seisint_primary_key := l.seisint_primary_key;
	END;
	
//----------UCC-------------
	iesp.fcradataservice.t_FcraDataServiceUCCMainData xformUCCMain(
										ConsumerDisclosure.RawUCC.layout_UCC_main_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceUCCPartyData xformUCCParty(
											ConsumerDisclosure.RawUCC.layout_UCC_party_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServiceUCCData xformUCCData(
																				ConsumerDisclosure.RawUCC.layout_UCC_out l) 
	:= TRANSFORM
		SELF.Main := PROJECT(l.UCCMain, xformUCCMain(LEFT));
		SELF.Party := PROJECT(l.UCCParty, xformUCCParty(LEFT));
		SELF.GroupBy.tmsid := l.tmsid;
	END;
	
	//----------Watercraft-------------
	iesp.fcradataservice.t_FcraDataServiceWatercraftOwnerData xfWatercraftOwners(
										ConsumerDisclosure.RawWatercraft.layout_watercraft_owners_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceWatercraftInfoData xfWatercraftInfo(
											ConsumerDisclosure.RawWatercraft.layout_watercraft_info_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	iesp.fcradataservice.t_FcraDataServiceWatercraftCoastguardData xfCoastguard(
											ConsumerDisclosure.RawWatercraft.layout_coastguard_out rec) := TRANSFORM
		SELF.MetaData := rec.MetaData;
		SELF.RawData := rec;
	END;
	
	EXPORT iesp.fcradataservice.t_FcraDataServiceWatercraftData xformWatercraftData(
																				ConsumerDisclosure.RawWatercraft.layout_watercraft_out l) 
	:= TRANSFORM
		SELF.Owners := PROJECT(l.Owners, xfWatercraftOwners(LEFT));
		SELF.Details := PROJECT(l.Details, xfWatercraftInfo(LEFT));
		SELF.Coastguard := PROJECT(l.Coastguard, xfCoastguard(LEFT));
		SELF.GroupBy.state_origin := l.state_origin;
		SELF.GroupBy.watercraft_key := l.watercraft_key;
		SELF.GroupBy.sequence_key := l.sequence_key;
	END;
	
END;