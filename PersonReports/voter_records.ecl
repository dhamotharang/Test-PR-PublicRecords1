
IMPORT $, iesp, doxie, VotersV2_Services, ut;

EXPORT voter_records (
  dataset (doxie.layout_references) dids,
  $.IParam.voters in_params = MODULE ($.IParam.voters) END,
  boolean IsFCRA = false
) := MODULE

	shared iesp.voter.t_VoterRecord xform_v1(VotersV2_Services.layouts.LegacyOutput L) := transform
		self.name.first := l.fname,
		self.name.middle := l.mname,
		self.name.last := l.lname,
		self.name.suffix :=l.name_suffix,
		self.name.full := '',
		self.name.prefix := '';
		self.MaidenName := l.maiden_name,
    self.address := iesp.ECL2ESP.SetAddress (
			l.prim_name, l.prim_range, l.predir, l.postdir, l.suffix, l.unit_desig, l.sec_range,
			l.city_name, l.st, l.zip, l.zip4, l.county, ''),
		self.registrationid := l.vendor_id,
		self.statecode := l.source_state,
		self.statename := l.source_state_mapped,
		self.occupation := l.occupation,
		self.sex := l.gender_mapped,
		self.ssn := l.best_ssn,
		self.uniqueid := l.did,
		self.race := l.race_mapped,
		self.dob.year :=(unsigned2) l.dob[1..4],
		self.dob.month :=(unsigned1) l.dob[5..6],
		self.dob.day :=(unsigned1) l.dob[7..8],
		self.politicalparty := l.poliparty_mapped,
		self.status := l.active_status_mapped,
		self.lastdatevote.year :=(unsigned2) l.lastdayvote[1..4],
		self.lastdatevote.month :=(unsigned1) l.lastdayvote[5..6],
		self.lastdatevote.day :=(unsigned1) l.lastdayvote[7..8],
		self.registrationdate.year :=(unsigned2) l.regdate[1..4],
		self.registrationdate.month :=(unsigned1) l.regdate[5..6],
		self.registrationdate.day :=(unsigned1) l.regdate[7..8],
	end;

	shared iesp.voter.t_VotingHistory getVotingHistories(VotersV2_Services.layouts.HistoryByYear L) := transform
		self.VotedYear := l.voted_year,
		self.Primary := l.primary,
		self.Special1 := l.special_1,
		self.Special2 := l.special_2,
		self.General := l.general,
		self.PresidentialPrimary := l.pres,
		self.Other := l.other
	end;
	
	shared iesp.share.t_Address SetTranslatedAddress (VotersV2_Services.layouts.AddressTranslated a) := 
    iesp.ECL2ESP.SetAddress (
			a.prim_name, a.prim_range, a.predir, a.postdir, a.addr_suffix, a.unit_desig, a.sec_range,
			a.p_city_name, a.st, a.zip5, a.zip4, a.county, '');

	shared iesp.voter.t_VoterReport2Record xform_v2(VotersV2_Services.layouts.SourceOutput L) := transform
		self.voterrecordid := (String)l.vtid,
		self.uniqueid := l.did,
		self.ssn := l.ssn,
		self.name.prefix := l.name.title,
		self.name.first := l.name.fname,
		self.name.middle := l.name.mname,
		self.name.last := l.name.lname,
		self.name.suffix :=l.name.name_suffix,
		self.name.full := '',
		self.dob.year :=(unsigned2) l.dob[1..4],
		self.dob.month :=(unsigned1) l.dob[5..6],
		self.dob.day :=(unsigned1) l.dob[7..8],
		self.occupation := l.occupation,
		self.race := l.race_exp,
		self.gender := l.gender_exp,
		self.registrationdate.year :=(unsigned2) l.regdate[1..4],
		self.registrationdate.month :=(unsigned1) l.regdate[5..6],
		self.registrationdate.day :=(unsigned1) l.regdate[7..8],
		self.lastvotedate.year :=(unsigned2) l.lastdatevote[1..4],
		self.lastvotedate.month :=(unsigned1) l.lastdatevote[5..6],
		self.lastvotedate.day :=(unsigned1) l.lastdatevote[7..8],
		self.politicalparty := l.politicalparty_exp,
		self.voterstatus := l.voter_status_exp,
		self.activeorinactive := l.active_status_exp,
		self.activeorinactiveflag := l.active_status,
		self.registratestate := l.source_state,
		self.RegistrateStateName := l.source_state_exp,
    self.residentaddress := SetTranslatedAddress (l.res),
    self.mailingaddress := SetTranslatedAddress (l.mail),
		self.maidenname := l.maiden_prior,
		self.agecategory := (integer)l.ageCat,
		self.agerange := l.ageCat_exp,
		self.homephone := l.phone,
		self.WorkPhone := l.work_phone,
		self.HeadHouseHold := l.headHousehold,
		self.PlaceOfBirth := l.place_of_birth,
		self.VoterDistrictInfo.TownCode := l.TownCode,
		self.VoterDistrictInfo.DistrictCode := l.distcode,
		self.VoterDistrictInfo.CountyCode := l.CountyCode,
		self.VoterDistrictInfo.SchoolCode := l.SchoolCode,
		self.VoterDistrictInfo.PrecinctType := l.CityInOut,
		self.VoterDistrictInfo.SpecialDistrict1 := l.spec_dist1,
		self.VoterDistrictInfo.SpecialDistrict2 := l.spec_dist2,
		self.VoterDistrictInfo.Precinct1 := l.Precinct1,
		self.VoterDistrictInfo.Precinct2 := l.Precinct2,
		self.VoterDistrictInfo.Precinct3 := l.Precinct3,
		self.VoterDistrictInfo.VillagePrecinct := l.VillagePrecinct,
		self.VoterDistrictInfo.SchoolPrecinct := l.SchoolPrecinct,
		self.VoterDistrictInfo.Ward := l.Ward,
		self.VoterDistrictInfo.PrecinctCityOrTown := l.Precinct_CityTown,
		self.VoterDistrictInfo.AdvisoryNeigborCommissioner := l.ANCSMDinDC,
		self.VoterDistrictInfo.CityConcilDistrict := l.CityCouncilDist,
		self.VoterDistrictInfo.CountCommonDistric := l.CountyCommDist,
		self.VoterDistrictInfo.StateHouseInfo := l.StateHouse,
		self.VoterDistrictInfo.StateSenateInfo := l.StateSenate,
		self.VoterDistrictInfo.USHouseOfRepresentativesInfo := l.USHouse,
		self.VoterDistrictInfo.ElementarySchoolDistrict := l.ElemSchoolDist,
		self.VoterDistrictInfo.SchoolDistrict := l.SchoolDist,
		self.VoterDistrictInfo.CommunityCollegeDistrict := l.CommCollDist,
		self.VoterDistrictInfo.Municipal := l.Municipal,
		self.VoterDistrictInfo.VillageDistrict := l.VillageDist,
		self.VoterDistrictInfo.PoliceJurisdiction := l.PoliceJury,
		self.VoterDistrictInfo.PoliceDistrict := l.PoliceDist,
		self.VoterDistrictInfo.PublicServiceCommission := l.PublicServComm,
		self.VoterDistrictInfo.RescureSquad := l.Rescue,
		self.VoterDistrictInfo.FireDepartment := l.Fire,
		self.VoterDistrictInfo.SanitaryDepartment := l.Sanitary,
		self.VoterDistrictInfo.SewerDistrict := l.SewerDist,
		self.VoterDistrictInfo.WaterDistrict := l.WaterDist,
		self.VoterDistrictInfo.MosquitoDistrict := l.MosquitoDist,
		self.VoterDistrictInfo.TaxationDistrict := l.TaxDist,
		self.VoterDistrictInfo.SupremeCourt := l.SupremeCourt,
		self.VoterDistrictInfo.JusticeOfPeace := l.JusticeofPeace,
		self.VoterDistrictInfo.JudicialDistrict := l.JudicialDist,
		self.VoterDistrictInfo.SuperiorCourtDistrict := l.SuperiorCtDist,
		self.VoterDistrictInfo.CourtOfAppeals := l.AppealsCt,
		self.VoterDistrictInfo.CongressionalDistrict := l.CongressionalDist,
		self.VotingHistories := choosen(project(sort(l.History,record,-voted_year),getVotingHistories(left)),ut.limits.VOTERS_HISTORY_MAX),
		self.AlsoFound := false;
	end;

  EXPORT voters := project (VotersV2_Services.raw.MOXIE_VIEW.by_did (dids, in_params.ssn_mask, IsFCRA), xform_v1(Left));

  EXPORT voters_v2 := project (VotersV2_Services.raw.Source_View.by_did (dids, in_params.ssn_mask, IsFCRA, in_params.application_type), xform_v2(Left));

END;

