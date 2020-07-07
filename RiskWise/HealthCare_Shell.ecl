import liensv2, risk_indicators, doxie_files, sexoffender;
import ingenix_natlprof, Prof_LicenseV2, models, GSA, Business_Risk, Relationship, std;

EXPORT HealthCare_Shell(dataset(Risk_Indicators.Layout_Provider_Scoring.Clam_Plus) clam ) := FUNCTION
	NULL := -999999999;
  
  ptype := enum(
    Individual    = 1,
    Relative      = 2,
    Business      = 3,
    CorpAffil     = 4,
    Rel_CorpAffil = 5
  );

	string strMin( string le, string ri ) := map(
		trim(le) IN ['', '0', (STRING)NULL] => ri,
		trim(ri) IN ['', '0', (STRING)NULL] => le,
		(string)MIN((REAL8)le, (REAL8)ri)
	);
	
  max_bdid_count := 6;
  max_corpaffil_count := 6;
  max_relatives_count := 25;
	
  keyLayout := RECORD
    UNSIGNED6 seq := 0;
    UNSIGNED6 DID := 0;
    DATASET({UNSIGNED6 relativesDID}) relativesDID  {MAXCOUNT(max_relatives_count)} := DATASET([], {UNSIGNED6 relativesDID});
    DATASET({UNSIGNED6 bdid}) bdids  {MAXCOUNT(max_bdid_count)} := DATASET([], {UNSIGNED6 bdid});
    DATASET({UNSIGNED6 bdids_corpaffil}) bdids_corpaffil  {MAXCOUNT(max_corpaffil_count)} := DATASET([], {UNSIGNED6 bdids_corpaffil});
    DATASET({UNSIGNED6 relativesbdids_corpaffil}) relativesbdids_corpaffil  {MAXCOUNT(max_corpaffil_count)} := DATASET([], {UNSIGNED6 relativesbdids_corpaffil});
  END;


  Layout_HealthCare_Shell_Plus := record
    Risk_Indicators.Layouts.Layout_HealthCare_Shell;
    Risk_Indicators.Layout_Boca_Shell clam;
		
		ptype provider_type;
		
		integer sysdate := 0;
		STRING9 input_ssn := '';
		
    string50 tmsid := '';
    string50 rmsid := '';
    string60 offender_key := '';
		sexoffender.Key_SexOffender_DID().seisint_primary_key;
		
		// medical/professional license fields
		unsigned6 ProviderId := 0;
		string2 Data_Source := '';
		string30 Source := '';
		string  Lic_State := '';
		string4 IssueDate_Year := '';
		string4 ExpirationDate_Year := '';
		string4 LastRenewalDate_Year := '';
		string1 Expired_Flag := '';
		unsigned2 Exp_Lic_Count := 0;
		unsigned2 Lic_Count := 0;

		// criminal
		string datasource := '';
		string Sentence := '';
		boolean guilty := false;
		string offense_desc_1 := '';
		string offense_desc_2 := '';
		string offense_desc_3 := '';
		integer4 stc_date := 0;

    keyLayout - seq;
  END;
  
  // Get Relatives DID Data based on DID's 
clamids_dedp := dedup(sort(clam(did<>0),did), did);
justDids := PROJECT(clamids_dedp, 
			TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.DID));
//relatives not associates
rellyids := Relationship.proc_GetRelationshipNeutral(justDids, topNCount:=100,
							RelativeFlag:=TRUE,AssociateFlag:=TRUE,doAtMost:=TRUE, MaxCount:= 1000).result;   //All Relationships in new Format; limit set to 100 on key join
withRelativesTemp := JOIN(clam, rellyids, LEFT.DID <> 0 AND LEFT.DID = RIGHT.did1 AND RIGHT.did2 <> 0, 
											TRANSFORM({DATASET({UNSIGNED6 relativesDID}) relativesDID, 
											RECORDOF(LEFT)}, SELF.relativesDID := DATASET([{RIGHT.did2}], 
											{UNSIGNED6 relativesDID}); SELF := LEFT), LEFT OUTER);

withRelativesTemp rollRelatives(withRelativesTemp le, withRelativesTemp ri) := TRANSFORM
	leftkept := le.relativesDID (relativesDID <> ri.relativesDID[1].relativesDID);
	SELF.relativesDID := CHOOSEN(SORT(leftkept + ri.relativesDID, relativesDID), max_relatives_count);
	SELF := le;
END;
withRelatives := ROLLUP(withRelativesTemp, LEFT.seq = RIGHT.seq, rollRelatives(LEFT, RIGHT));

// Get BDID Corporate Affiliations Data based on DID's (Business_Risk.Key_Bus_Cont_DID_2_BDID)
withCorpAffilTemp := JOIN(clam, Business_Risk.Key_Bus_Cont_DID_2_BDID, LEFT.did <> 0 AND LEFT.DID = RIGHT.DID AND RIGHT.bdid <> 0,
											TRANSFORM({DATASET({UNSIGNED6 bdids_corpaffil}) bdids_corpaffil, RECORDOF(LEFT)}, SELF.bdids_corpaffil := DATASET([{RIGHT.bdid}], {UNSIGNED6 bdids_corpaffil}); SELF := LEFT), LEFT OUTER, KEEP(max_corpaffil_count), LIMIT(1000, SKIP));
withCorpAffilTemp rollCorpAffil(withCorpAffilTemp le, withCorpAffilTemp ri) := TRANSFORM
	leftkept := le.bdids_corpaffil (bdids_corpaffil <> ri.bdids_corpaffil[1].bdids_corpaffil);
	SELF.bdids_corpaffil := CHOOSEN(SORT(leftkept + ri.bdids_corpaffil, bdids_corpaffil), max_corpaffil_count);
	SELF := le;
END;
withCorpAffil := ROLLUP(withCorpAffilTemp, LEFT.seq = RIGHT.seq, rollCorpAffil(LEFT, RIGHT));

// Get Relatives BDID Corporate Affiliations Data based on Relatives DID's (Business_Risk.Key_Bus_Cont_DID_2_BDID)
withRelativeCorpAffilTemp := JOIN(withRelatives, Business_Risk.Key_Bus_Cont_DID_2_BDID, RIGHT.DID IN SET(LEFT.relativesDID, relativesDID) AND RIGHT.bdid <> 0,
											TRANSFORM({DATASET({UNSIGNED6 relativesbdids_corpaffil}) relativesbdids_corpaffil, RECORDOF(LEFT)}, SELF.relativesbdids_corpaffil := DATASET([{RIGHT.bdid}], {UNSIGNED6 relativesbdids_corpaffil}); SELF := LEFT), LEFT OUTER, KEEP(max_corpaffil_count), LIMIT(1000, SKIP));
withRelativeCorpAffilTemp rollRelativeCorpAffil(withRelativeCorpAffilTemp le, withRelativeCorpAffilTemp ri) := TRANSFORM
	leftkept := le.relativesbdids_corpaffil (relativesbdids_corpaffil <> ri.relativesbdids_corpaffil[1].relativesbdids_corpaffil);
	SELF.relativesbdids_corpaffil := CHOOSEN(SORT(leftkept + ri.relativesbdids_corpaffil, relativesbdids_corpaffil), max_corpaffil_count);
	SELF := le;
END;
withRelativeCorpAffil := ROLLUP(withRelativeCorpAffilTemp, LEFT.seq = RIGHT.seq, rollRelativeCorpAffil(LEFT, RIGHT));

withEverything := JOIN(withCorpAffil, withRelativeCorpAffil, LEFT.seq = RIGHT.seq, TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT) - RECORDOF(LEFT)}, SELF := LEFT; SELF := RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost));

// Strip it down to just the DID/BDID fields we care about
inputKey := PROJECT(withEverything, TRANSFORM(keyLayout,
																											SELF.seq := LEFT.seq;
																											SELF.DID := LEFT.DID;
																											SELF.relativesDID := LEFT.RelativesDID;
																											SELF.bdids := LEFT.bdids;
																											SELF.bdids_corpaffil := LEFT.bdids_corpaffil;
																											SELF.relativesbdids_corpaffil := LEFT.relativesbdids_corpaffil));

Layout_HealthCare_Shell_Plus joinBackToClam(clam le, keyLayout ri) := TRANSFORM
  SELF.sysdate := models.common.sas_date( if(le.historydate IN [999999, 0], (STRING8)Std.Date.Today(), (string)le.historydate+'01'));
	SELF.input_ssn := TRIM(le.shell_input.ssn);
	
  SELF.clam := le;
  SELF := ri;
  SELF := [];
END;
healthcare_in := JOIN(clam, inputKey, LEFT.seq = RIGHT.seq, joinBackToClam(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));

	// med license
	Layout_HealthCare_Shell_Plus getProviderIds( healthcare_in le, doxie_files.key_provider_did ri ) := TRANSFORM
		self.seq := le.seq;
		self.providerid := ri.providerid;
    self.provider_type := ptype.Individual;
    SELF := le;
		self := [];
	END;
	gotProviderIds := join(healthcare_in, doxie_files.key_provider_did, left.did != 0 and keyed(left.did=right.l_did), getProviderIds(left,right), keep(100), atmost(riskwise.max_atmost) );
  
  Layout_HealthCare_Shell_Plus_MedLic := RECORD
    Layout_HealthCare_Shell_Plus;
    UNSIGNED2 Same_State_Count := 0;
    UNSIGNED2 Same_State_Count_Expired := 0;
    STRING expiration_date := '';
    REAL8 sas_ExpDate := 0.0;
    REAL8 mth_expiration_date := 0.0;
  END;
	Layout_HealthCare_Shell_Plus_MedLic getMedLic( Layout_HealthCare_Shell_Plus le, ingenix_natlprof.key_license_providerid ri ) := TRANSFORM
		self.seq := le.seq;
		self.Data_Source := 'ML';
		self.Source := 'ML-DID';

		self.IssueDate_Year       := trim(ri.effective_date)[1..4];
		self.ExpirationDate_Year  := trim(ri.termination_date)[1..4];
		self.LastRenewalDate_Year := '';
		self.Lic_State            := ri.licensestate;
		self.MedLicProfLic_hit    := true;
    sysdate := models.common.sas_date( if(le.clam.historydate IN [999999, 0], (STRING8)Std.Date.Today(), (string)le.clam.historydate+'01'));
		sas_ExpDate := models.Common.sas_date(trim(ri.termination_date));
		mth_expiration_date := ROUNDUP((sysdate-sas_ExpDate)/30.5);
		Expired_Flag := map(
			sas_ExpDate = NULL        => 'U',
			mth_expiration_date > 0   => 'Y',
                                   'N'
		);
    SELF.expiration_date := ri.termination_date;
    SELF.sas_ExpDate := sas_ExpDate;
    SELF.mth_expiration_date := mth_expiration_date;
		self.Expired_Flag := Expired_Flag;
		self.Exp_Lic_Count := IF(TRIM(Expired_Flag) IN ['Y'], 1, 0);
    SELF.Lic_Count := 1; // IF(TRIM(Expired_Flag) IN ['U'], 0, 1); // Don't count it if we don't know if it's expired or not
    
    sameState := TRIM(le.clam.shell_input.st) <> '' AND StringLib.StringToUpperCase(TRIM(le.clam.shell_input.st)) = StringLib.StringToUpperCase(TRIM(ri.licensestate));
    
    SELF.MedLicProfLic_Same_State := sameState;
    SELF.MedLicProfLic_Same_State_Exp := sameState AND Expired_Flag IN ['Y'];
    
    SELF.Same_State_Count := IF(sameState, 1, 0);
    SELF.Same_State_Count_Expired := IF(sameState AND Expired_Flag IN ['Y'], 1, 0);
    
    SELF.provider_type := ptype.Individual;
    SELF := le;
		self := [];
	END;
	gotMedLic := join( gotProviderIds, ingenix_natlprof.key_license_providerid, left.providerid != 0 AND keyed(left.providerid=right.l_providerid), getMedLic(left,right), keep(100), atmost(riskwise.max_atmost) );


	key_pl_did := Prof_LicenseV2.Key_Proflic_Did();
	Layout_HealthCare_Shell_Plus_MedLic getProfLicDid( healthcare_in le, key_pl_did ri ) := TRANSFORM
		self.seq := le.seq;
		self.Data_Source := 'PL';
		self.Source := 'PL-DID';

		self.IssueDate_Year       := trim(ri.issue_date)[1..4];
		self.ExpirationDate_Year  := trim(ri.expiration_date)[1..4];
		self.LastRenewalDate_Year := trim(ri.last_renewal_date)[1..4];
		self.Lic_State            := trim(ri.st);
		self.MedLicProfLic_hit    := true;
    sysdate := models.common.sas_date( if(le.clam.historydate IN [999999, 0], (STRING8)Std.Date.Today(), (string)le.clam.historydate+'01'));
		sas_ExpDate := models.Common.sas_date(trim(ri.expiration_date));
		mth_expiration_date := ROUNDUP((sysdate-sas_ExpDate)/30.5);
		Expired_Flag := map(
			sas_ExpDate = NULL        => 'U',
			mth_expiration_date > 0   => 'Y',
                                   'N'
		);
    SELF.expiration_date := ri.expiration_date;
    SELF.sas_ExpDate := sas_ExpDate;
    SELF.mth_expiration_date := mth_expiration_date;
		self.Expired_Flag := Expired_Flag;
		self.Exp_Lic_Count := IF(TRIM(Expired_Flag) IN ['Y'], 1, 0);
    SELF.Lic_Count := 1; // IF(TRIM(Expired_Flag) IN ['U'], 0, 1); // Don't count it if we don't know if it's expired or not
    
    sameState := TRIM(le.clam.shell_input.st) <> '' AND StringLib.StringToUpperCase(TRIM(le.clam.shell_input.st)) = StringLib.StringToUpperCase(TRIM(ri.st));
    
    SELF.MedLicProfLic_Same_State :=  sameState;
    SELF.MedLicProfLic_Same_State_Exp := sameState AND Expired_Flag IN ['Y'];
    SELF.Same_State_Count := IF(sameState, 1, 0);
    SELF.Same_State_Count_Expired := IF(sameState AND Expired_Flag IN ['Y'], 1, 0);
		
    SELF.provider_type := ptype.Individual;
		SELF := le;
		self := [];
	END;
	gotProfLicDid := join( healthcare_in, key_pl_did, left.did != 0 and keyed(left.did=right.did), getProfLicDid(left,right), keep(100), atmost(riskwise.max_atmost) );

	key_pl_bdid := Prof_LicenseV2.Key_Proflic_bDid();
	Layout_HealthCare_Shell_Plus_MedLic getProfLicBdid( healthcare_in le, key_pl_bdid ri ) := TRANSFORM
		self.seq := le.seq;
		self.Data_Source := 'PL';
		self.Source := 'PL-BDID';
		
		self.provider_type := ptype.Business;

		self.IssueDate_Year       := trim(ri.issue_date)[1..4];
		self.ExpirationDate_Year  := trim(ri.expiration_date)[1..4];
		self.LastRenewalDate_Year := trim(ri.last_renewal_date)[1..4];
		self.Lic_State            := trim(ri.st);
		self.MedLicProfLic_hit    := true;
    sysdate := models.common.sas_date( if(le.clam.historydate IN [999999, 0], (STRING8)Std.Date.Today(), (string)le.clam.historydate+'01'));
		sas_ExpDate := models.Common.sas_date(trim(ri.expiration_date));
		mth_expiration_date := ROUNDUP((sysdate-sas_ExpDate)/30.5);
		Expired_Flag := map(
			sas_ExpDate = NULL        => 'U',
			mth_expiration_date > 0   => 'Y',
                                   'N'
		);
    SELF.expiration_date := ri.expiration_date;
    SELF.sas_ExpDate := sas_ExpDate;
    SELF.mth_expiration_date := mth_expiration_date;
		self.Expired_Flag := Expired_Flag;
		self.Exp_Lic_Count := IF(TRIM(Expired_Flag) IN ['Y'], 1, 0);
    SELF.Lic_Count := 1; // IF(TRIM(Expired_Flag) IN ['U'], 0, 1); // Don't count it if we don't know if it's expired or not
    
    // sameState := IF(le.providerID = 0, FALSE, TRIM(le.clam.shell_input.st) <> '' AND StringLib.StringToUpperCase(TRIM(le.clam.shell_input.st)) = StringLib.StringToUpperCase(TRIM(ri.st)));
    sameState := TRIM(le.clam.shell_input.st) <> '' AND StringLib.StringToUpperCase(TRIM(le.clam.shell_input.st)) = StringLib.StringToUpperCase(TRIM(ri.st));
    
    SELF.MedLicProfLic_Same_State :=  sameState;
    SELF.MedLicProfLic_Same_State_Exp := sameState AND Expired_Flag IN ['Y'];
    
    SELF.Same_State_Count := IF(sameState, 1, 0);
    SELF.Same_State_Count_Expired := IF(sameState AND Expired_Flag IN ['Y'], 1, 0);
    
    SELF := le;
		self := [];
	END;
	gotProfLicBdid := join(healthcare_in, key_pl_bdid, COUNT(left.bdids) > 0 and keyed(right.bd in set(left.bdids (bdid != 0), bdid)),
		getProfLicBdid(left,right), keep(riskwise.max_atmost), atmost(riskwise.max_atmost * 2) );

  combinedMLPLRecs := gotMedLic + gotProfLicDid + gotProfLicBdid;
	allMLPLRecs := sort(combinedMLPLRecs, seq, providerid, MedLicProfLic_Same_State);
	Layout_HealthCare_Shell_Plus_MedLic rollMLPL( Layout_HealthCare_Shell_Plus_MedLic le, Layout_HealthCare_Shell_Plus_MedLic ri ) := TRANSFORM
    sameProvider := le.ProviderID = ri.ProviderID;
		self.Exp_Lic_Count := le.Exp_Lic_Count + ri.Exp_Lic_Count; // IF(NOT sameProvider, ri.Exp_Lic_Count, 0);
		self.Lic_Count := le.Lic_Count + 1; // IF(NOT sameProvider, 1, 0);
    
    SELF.ProviderID := ri.ProviderID;
    
		leftIssue := IF((INTEGER)le.IssueDate_Year <= 0, 0, (INTEGER)le.IssueDate_Year);
		rightIssue := IF((INTEGER)ri.IssueDate_Year <= 0, 0, (INTEGER)ri.IssueDate_Year);
		self.IssueDate_Year := MAP(leftIssue = 0 AND rightIssue > 0                             => (STRING)rightIssue, // Don't use the 0 value if we have a year
                               rightIssue = 0 AND leftIssue > 0                             => (STRING)leftIssue, // Don't use the 0 value if we have a year
                               leftIssue > 0 AND rightIssue > 0 AND leftIssue > rightIssue  => (STRING)rightIssue, // Right year is older
                                                                                               (STRING)leftIssue); // Left year is equal to right or older
                                          
    leftExpire := IF((INTEGER)le.ExpirationDate_Year <= 0, 0, (INTEGER)le.ExpirationDate_Year);
		rightExpire := IF((INTEGER)ri.ExpirationDate_Year <= 0, 0, (INTEGER)ri.ExpirationDate_Year);
		self.ExpirationDate_Year := MAP(leftExpire = 0 AND rightExpire > 0                         => (STRING)rightExpire, // Don't use the 0 value if we have a year
                               rightExpire = 0 AND leftExpire > 0                              => (STRING)leftExpire, // Don't use the 0 value if we have a year
                               leftExpire > 0 AND rightExpire > 0 AND leftExpire > rightExpire => (STRING)rightExpire, // Right year is older
                                                                                                  (STRING)leftExpire); // Left year is equal to right or older
                                          
    leftRenewal := IF((INTEGER)le.LastRenewalDate_Year <= 0, 0, (INTEGER)le.LastRenewalDate_Year);
		rightRenewal := IF((INTEGER)ri.LastRenewalDate_Year <= 0, 0, (INTEGER)ri.LastRenewalDate_Year);
		self.LastRenewalDate_Year := MAP(leftRenewal = 0 AND rightRenewal > 0                           => (STRING)rightRenewal, // Don't use the 0 value if we have a year
                               rightRenewal = 0 AND leftRenewal > 0                                 => (STRING)leftRenewal, // Don't use the 0 value if we have a year
                               leftRenewal > 0 AND rightRenewal > 0 AND leftRenewal > rightRenewal  => (STRING)rightRenewal, // Right year is older
                                                                                                       (STRING)leftRenewal); // Left year is equal to right or older
    
    SELF.MedLicProfLic_Same_State := IF(le.MedLicProfLic_Same_State = FALSE, ri.MedLicProfLic_Same_State, le.MedLicProfLic_Same_State);
    SELF.MedLicProfLic_Same_State_Exp := IF(le.MedLicProfLic_Same_State_Exp = FALSE, ri.MedLicProfLic_Same_State_Exp, le.MedLicProfLic_Same_State_Exp);
    
    SELF.Same_State_Count := le.Same_State_Count + ri.Same_State_Count;
    SELF.Same_State_Count_Expired := le.Same_State_Count_Expired + ri.Same_State_Count_Expired;

		self := le;
	END;
	rolledMLPL := rollup( allMLPLRecs, LEFT.seq = RIGHT.seq, rollMLPL(LEFT, RIGHT));
	
	Layout_HealthCare_Shell_Plus finishMLPL( Layout_HealthCare_Shell_Plus_MedLic le ) := TRANSFORM
    sysdate := models.common.sas_date( if(le.clam.historydate IN [999999, 0], (STRING8)Std.Date.Today(), (string)le.clam.historydate+'01'));
		RenewalExpirationYearMin := strMin(le.ExpirationDate_Year, le.LastRenewalDate_Year);
		Overall_Year_Min := IF(le.IssueDate_Year = (STRING)NULL OR RenewalExpirationYearMin = (STRING)NULL, (STRING)NULL, strMin(le.IssueDate_Year, RenewalExpirationYearMin));
    Overall_Year_Min_sas := (integer)models.common.sas_date(Overall_Year_Min);
		mth_Overall_Year_Min := IF(sysdate = NULL OR Overall_Year_Min_sas = NULL, NULL, ROUNDUP((sysdate - Overall_Year_Min_sas)/30.5));

		self.Overall_Year_Min := if(TRIM(Overall_Year_Min) IN ['', (STRING)NULL], 9999, (integer)IF(Overall_Year_Min = '0', '9999', Overall_Year_Min));
		self.Time_On_PS       := if(TRIM(Overall_Year_Min) IN ['', (STRING)NULL] OR mth_Overall_Year_Min = NULL, 0, (integer)(mth_Overall_Year_Min / 12));
    
    expiredLic := le.Exp_Lic_Count = le.Lic_Count;
    SELF.MedLicProfLic_Exp := expiredLic; // All licenses are expired
    SELF.MedLicProfLic_Same_State_Exp := le.Same_State_Count = le.Same_State_Count_Expired AND le.Same_State_Count <> 0; // Can't be expired if there is no count

		self := le;
	END;
	finalMLPL := project( rolledMLPL, finishMLPL(left) );


  // sex offender
  key_soffender := sexoffender.Key_SexOffender_DID(false);
  key_soffense  := SexOffender.key_sexoffender_offenses(false);
	Layout_Healthcare_Shell_Plus_SexOff := RECORD
		Layout_Healthcare_Shell_Plus;
		INTEGER8 sex_conviction_dt := 0;
		INTEGER8 mth_sex_conviction_dt := 0;
		STRING25 offense_description := '';
	END;
  Layout_Healthcare_Shell_Plus getSexOffender_SPK( healthcare_in le, key_soffender ri ) := TRANSFORM
    self.seq := le.seq;
    self.provider_type := ptype.Individual;
    self.seisint_primary_key := ri.seisint_primary_key;
    
    SELF := le;
    self := [];
  END;
  gotSexOffender_SPK := join(healthcare_in, key_soffender, left.did != 0 and keyed(left.did=right.did), getSexOffender_SPK(left,right), KEEP(100), ATMOST(RiskWise.max_atmost));

  Layout_Healthcare_Shell_Plus_SexOff getSexOffender( gotSexOffender_SPK le, key_soffense ri ) := TRANSFORM
    self.seq := le.seq;
    self.provider_type := le.provider_type;
		self.SexOffender_Hit := true;
		sysdate := models.common.sas_date( if(le.clam.historydate IN [999999, 0], (STRING8)Std.Date.Today(), (string)le.clam.historydate+'01'));
		sex_conviction_dt := models.common.sas_date(ri.conviction_date);
		mth_sex_conviction_dt := IF(sysdate = NULL OR sex_conviction_dt = NULL, NULL, ROUNDUP((sysdate - sex_conviction_dt)/30.5));

		Sex_Offense_Count_Unk := trim(ri.offense_description) = '' or sex_conviction_dt = NULL;
		Sex_Offense_Count_24  := not Sex_Offense_Count_Unk and trim(ri.offense_description)!='' and mth_sex_conviction_dt <= 24;
		Sex_Offense_Count_60  := not Sex_Offense_Count_24 AND not Sex_Offense_Count_Unk and trim(ri.offense_description)!='' and mth_sex_conviction_dt <= 60;
		Sex_Offense_Count_61  := not Sex_Offense_Count_60 AND not Sex_Offense_Count_Unk AND not Sex_Offense_Count_24 and trim(ri.offense_description)!='' and mth_sex_conviction_dt > 60;

		self.Sex_Offense_Count_Unk := (unsigned2)Sex_Offense_Count_Unk;
		self.Sex_Offense_Count_24  := (unsigned2)Sex_Offense_Count_24;
		self.Sex_Offense_Count_60  := (unsigned2)Sex_Offense_Count_60;
		self.Sex_Offense_Count_61  := (unsigned2)Sex_Offense_Count_61;
		
		SELF.sex_conviction_dt := sex_conviction_dt;
		SELF.mth_sex_conviction_dt := mth_sex_conviction_dt;
		SELF.offense_description := TRIM(ri.offense_description);
		
    SELF := le;
    self := [];
  END;
  gotSexOffenderTemp := join(gotSexOffender_SPK, key_soffense, keyed(left.seisint_primary_key=right.sspk), getSexOffender(left,right), KEEP(100), ATMOST(RiskWise.max_atmost));
	gotSexOffender := PROJECT(gotSexOffenderTemp, TRANSFORM(Layout_Healthcare_Shell_Plus, SELF := LEFT));

  Layout_Healthcare_Shell_Plus rollSexOffender( Layout_Healthcare_Shell_Plus le, Layout_Healthcare_Shell_Plus ri ) := TRANSFORM
		self.Sex_Offense_Count_Unk := le.Sex_Offense_Count_Unk + ri.Sex_Offense_Count_Unk;
		self.Sex_Offense_Count_24  := le.Sex_Offense_Count_24  + ri.Sex_Offense_Count_24;
		self.Sex_Offense_Count_60  := le.Sex_Offense_Count_60  + ri.Sex_Offense_Count_60;
		self.Sex_Offense_Count_61  := le.Sex_Offense_Count_61  + ri.Sex_Offense_Count_61;

		self := le;
	END;
	rolledSexOffender := rollup(gotSexOffender, left.seq=right.seq, rollSexOffender(left,right));


  // liens
  Layout_HealthCare_Shell_Plus getLiensByDid( healthcare_in le, liensv2.key_liens_DID ri ) := TRANSFORM
    self.seq := le.seq;
    self.provider_type := ptype.Individual;
    self.tmsid := ri.tmsid;
    self.rmsid := ri.rmsid;
    
    SELF := le;
    self := [];
  END;
  gotTMSIDRMSID := DEDUP(SORT(join(healthcare_in, liensv2.key_liens_DID, left.did != 0 and keyed(left.did=right.did), getLiensByDid(LEFT,RIGHT), KEEP(100), ATMOST(RiskWise.max_atmost)), seq, provider_type, tmsid, rmsid), ALL);

	// per pete & kathy, we should only keep liens when we either [a] don't have an SSN on input or [b] can match that input ssn to the ssn on the lien. mismatches get thrown away.
	gotLiensFilteredSSNs := GROUP(DEDUP(SORT(join(gotTMSIDRMSID, LiensV2.key_liens_party_ID, keyed(left.tmsid=right.tmsid) and keyed(left.rmsid=right.rmsid) and (TRIM(left.input_ssn) = '' or left.input_ssn = right.ssn), transform(left), keep(1), ATMOST(RiskWise.max_atmost)), seq, provider_type, tmsid, rmsid), seq, provider_type, tmsid, rmsid), seq);

  Layout_HealthCare_Shell_Plus_Liens := RECORD
    Layout_HealthCare_Shell_Plus;
		STRING25 Filing_Type1Temp := '';
		STRING25 Filing_Type2Temp := '';
    STRING25 Filing_Type1 := '';
    STRING25 Filing_Type2 := '';
    STRING25 Judgment_Category1 := '';
    STRING25 Judgment_Category2 := '';
		STRING8 orig_filing_date := '';
		STRING8 filing_date := '';
		REAL8 filing_date1Temp := 0.0;
		REAL8 filing_date2Temp := 0.0;
    REAL8 filing_date1 := 0.0;
    REAL8 filing_date2 := 0.0;
    REAL8 mth_filing_date1 := 0.0;
    REAL8 mth_filing_date2 := 0.0;
    BOOLEAN Judgment_ND_Flag1 := FALSE;
    BOOLEAN Judgment_ND_Flag2 := FALSE;
    BOOLEAN Judgment_61_Flag1 := FALSE;
    BOOLEAN Judgment_61_Flag2 := FALSE;
    BOOLEAN Judgment_60_Flag1 := FALSE;
    BOOLEAN Judgment_60_Flag2 := FALSE;
    BOOLEAN Judgment_24_Flag1 := FALSE;
    BOOLEAN Judgment_24_Flag2 := FALSE;
  END;
  Layout_HealthCare_Shell_Plus_Liens getLiens( gotLiensFilteredSSNs le, LiensV2.key_liens_main_ID ri ) := TRANSFORM
    self.seq := le.seq;
		self.provider_type := le.provider_type;


		// Filing_Type := trim(StringLib.StringToUpperCase(ri.filing_status[1].filing_status_desc));
		Filing_Type1Temp := trim(StringLib.StringToUpperCase(ri.orig_filing_type));
		Filing_Type2Temp := trim(StringLib.StringToUpperCase(ri.filing_type_desc));
		Filing_Type1 := IF(Filing_Type1Temp = '', Filing_Type2Temp, Filing_Type1Temp);
		Filing_Type2 := IF(Filing_Type2Temp = '', Filing_Type1Temp, Filing_Type2Temp);
		
		Judgment_Category1 := map(
			Models.Common.Contains(Filing_Type1, 'CHILD')       and Models.Common.Contains(Filing_Type1, 'SUPPORT') => 'CHILD SUPPORT',
			Models.Common.Contains(Filing_Type1, 'TAX')                                                            	=> 'TAX LIEN/WARRANT',
			Models.Common.Contains(Filing_Type1, 'CIVIL')                                                          	=> 'CIVIL JUDGMENT',
			Models.Common.Contains(Filing_Type1, 'FORECLOSURE')                                                    	=> 'FORECLOSURE',
			Models.Common.Contains(Filing_Type1, 'FORCIBLE')    and Models.Common.Contains(Filing_Type1, 'ENTRY')   => 'FORCIBLE ENTRY',
			Models.Common.Contains(Filing_Type1, 'SMALL')       and Models.Common.Contains(Filing_Type1, 'CLAIMS')  => 'SMALL CLAIMS',
			Models.Common.Contains(Filing_Type1, 'LANDLORD')    and Models.Common.Contains(Filing_Type1, 'TENANT')  => 'LANDLORD/TENANT',
			Models.Common.Contains(Filing_Type1, 'LIS')         and Models.Common.Contains(Filing_Type1, 'PENDENS') => 'LAWSUIT PENDING',
			Models.Common.Contains(Filing_Type1, 'LIEN')                                                          	=> 'LIEN-OTHER',
			Models.Common.Contains(Filing_Type1, 'JUDGMENT')                                                       	=> 'JUDGMENT-OTHER',
			Filing_Type1 = ''                                                                                      	=> 'Blank',
																																																									'OTHER'
		);
		Judgment_Category2Temp := map(
			Models.Common.Contains(Filing_Type2, 'CHILD')       and Models.Common.Contains(Filing_Type2, 'SUPPORT') => 'CHILD SUPPORT',
			Models.Common.Contains(Filing_Type2, 'TAX')                                                            	=> 'TAX LIEN/WARRANT',
			Models.Common.Contains(Filing_Type2, 'CIVIL')                                                          	=> 'CIVIL JUDGMENT',
			Models.Common.Contains(Filing_Type2, 'FORECLOSURE')                                                    	=> 'FORECLOSURE',
			Models.Common.Contains(Filing_Type2, 'FORCIBLE')    and Models.Common.Contains(Filing_Type2, 'ENTRY')   => 'FORCIBLE ENTRY',
			Models.Common.Contains(Filing_Type2, 'SMALL')       and Models.Common.Contains(Filing_Type2, 'CLAIMS')  => 'SMALL CLAIMS',
			Models.Common.Contains(Filing_Type2, 'LANDLORD')    and Models.Common.Contains(Filing_Type2, 'TENANT')  => 'LANDLORD/TENANT',
			Models.Common.Contains(Filing_Type2, 'LIS')         and Models.Common.Contains(Filing_Type2, 'PENDENS') => 'LAWSUIT PENDING',
			Models.Common.Contains(Filing_Type2, 'LIEN')                                                          	=> 'LIEN-OTHER',
			Models.Common.Contains(Filing_Type2, 'JUDGMENT')                                                       	=> 'JUDGMENT-OTHER',
			Filing_Type2 = ''                                                                                      	=> 'Blank',
																																																									'OTHER'
		);
		Judgment_Category2 := IF(Judgment_Category1 = Judgment_Category2Temp, 'Blank', Judgment_Category2Temp); // Don't double count when the same text is in both spots
		
		filing_date1Temp := models.common.sas_date(trim(ri.orig_filing_date));
		filing_date2Temp := models.common.sas_date(trim(ri.filing_date));
		
		filing_date1 := IF(filing_date1Temp = NULL, filing_date2Temp, filing_date1Temp);
		filing_date2 := IF(filing_date2Temp = NULL, filing_date1Temp, filing_date2Temp);

    sysdate := models.common.sas_date( if(le.clam.historydate IN [999999, 0], (STRING8)Std.Date.Today(), (string)le.clam.historydate+'01'));
		
		mth_filing_date1 := if(sysdate = NULL OR filing_date1 = null, null, ROUNDUP((sysdate - filing_date1)/30.5));
		mth_filing_date2 := if(sysdate = NULL OR filing_date2 = null, null, ROUNDUP((sysdate - filing_date2)/30.5));
		
		
		Judgment_61_Flag1 := mth_filing_date1 >= 60;
		Judgment_60_Flag1 := mth_filing_date1 < 60 and mth_filing_date1 >= 25;
		Judgment_24_Flag1 := mth_filing_date1 >= 0 and mth_filing_date1 < 25;
		Judgment_ND_Flag1 := mth_filing_date1 = NULL;
		
		Judgment_61_Flag2 := mth_filing_date2 >= 60;
		Judgment_60_Flag2 := mth_filing_date2 < 60 and mth_filing_date2 >= 25;
		Judgment_24_Flag2 := mth_filing_date2 >= 0 and mth_filing_date2 < 25;
		Judgment_ND_Flag2 := mth_filing_date2 = NULL;
    
		self.Liens.Liens_Hit                         := true;

		self.Liens.JGMT_Child_Support_Count_24       := (unsigned2)(Judgment_24_Flag1 and Judgment_Category1 = 'CHILD SUPPORT'     ) + (unsigned2)(Judgment_24_Flag2 and Judgment_Category2 = 'CHILD SUPPORT'     );
		self.Liens.JGMT_Civil_Judgment_Count_24      := (unsigned2)(Judgment_24_Flag1 and Judgment_Category1 = 'CIVIL JUDGMENT'    ) + (unsigned2)(Judgment_24_Flag2 and Judgment_Category2 = 'CIVIL JUDGMENT'    );
		self.Liens.JGMT_Forcible_Entry_Count_24      := (unsigned2)(Judgment_24_Flag1 and Judgment_Category1 = 'FORCIBLE ENTRY'    ) + (unsigned2)(Judgment_24_Flag2 and Judgment_Category2 = 'FORCIBLE ENTRY'    );
		self.Liens.JGMT_Foreclosure_Count_24         := (unsigned2)(Judgment_24_Flag1 and Judgment_Category1 = 'FORECLOSURE'       ) + (unsigned2)(Judgment_24_Flag2 and Judgment_Category2 = 'FORECLOSURE'       );
		self.Liens.JGMT_Judgment_Other_Count_24      := (unsigned2)(Judgment_24_Flag1 and Judgment_Category1 = 'JUDGMENT-OTHER'    ) + (unsigned2)(Judgment_24_Flag2 and Judgment_Category2 = 'JUDGMENT-OTHER'    );
		self.Liens.JGMT_Landlord_Tenant_Count_24     := (unsigned2)(Judgment_24_Flag1 and Judgment_Category1 = 'LANDLORD/TENANT'   ) + (unsigned2)(Judgment_24_Flag2 and Judgment_Category2 = 'LANDLORD/TENANT'   );
		self.Liens.JGMT_Lawsuit_Pending_Count_24     := (unsigned2)(Judgment_24_Flag1 and Judgment_Category1 = 'LAWSUIT PENDING'   ) + (unsigned2)(Judgment_24_Flag2 and Judgment_Category2 = 'LAWSUIT PENDING'   );
		self.Liens.JGMT_Lien_Other_Count_24          := (unsigned2)(Judgment_24_Flag1 and Judgment_Category1 = 'LIEN-OTHER'        ) + (unsigned2)(Judgment_24_Flag2 and Judgment_Category2 = 'LIEN-OTHER'        );
		self.Liens.JGMT_Small_Claims_Count_24        := (unsigned2)(Judgment_24_Flag1 and Judgment_Category1 = 'SMALL CLAIMS'      ) + (unsigned2)(Judgment_24_Flag2 and Judgment_Category2 = 'SMALL CLAIMS'      );
		self.Liens.JGMT_Tax_Lien_Count_24            := (unsigned2)(Judgment_24_Flag1 and Judgment_Category1 = 'TAX LIEN/WARRANT'  ) + (unsigned2)(Judgment_24_Flag2 and Judgment_Category2 = 'TAX LIEN/WARRANT'  );
		self.Liens.JGMT_Other_Count_24               := (unsigned2)(Judgment_24_Flag1 and Judgment_Category1 = 'OTHER'             ) + (unsigned2)(Judgment_24_Flag2 and Judgment_Category2 = 'OTHER'             );

		self.Liens.JGMT_Child_Support_Count_60       := (unsigned2)(Judgment_60_Flag1 and Judgment_Category1 = 'CHILD SUPPORT'     ) + (unsigned2)(Judgment_60_Flag2 and Judgment_Category2 = 'CHILD SUPPORT'     );
		self.Liens.JGMT_Civil_Judgment_Count_60      := (unsigned2)(Judgment_60_Flag1 and Judgment_Category1 = 'CIVIL JUDGMENT'    ) + (unsigned2)(Judgment_60_Flag2 and Judgment_Category2 = 'CIVIL JUDGMENT'    );
		self.Liens.JGMT_Forcible_Entry_Count_60      := (unsigned2)(Judgment_60_Flag1 and Judgment_Category1 = 'FORCIBLE ENTRY'    ) + (unsigned2)(Judgment_60_Flag2 and Judgment_Category2 = 'FORCIBLE ENTRY'    );
		self.Liens.JGMT_Foreclosure_Count_60         := (unsigned2)(Judgment_60_Flag1 and Judgment_Category1 = 'FORECLOSURE'       ) + (unsigned2)(Judgment_60_Flag2 and Judgment_Category2 = 'FORECLOSURE'       );
		self.Liens.JGMT_Judgment_Other_Count_60      := (unsigned2)(Judgment_60_Flag1 and Judgment_Category1 = 'JUDGMENT-OTHER'    ) + (unsigned2)(Judgment_60_Flag2 and Judgment_Category2 = 'JUDGMENT-OTHER'    );
		self.Liens.JGMT_Landlord_Tenant_Count_60     := (unsigned2)(Judgment_60_Flag1 and Judgment_Category1 = 'LANDLORD/TENANT'   ) + (unsigned2)(Judgment_60_Flag2 and Judgment_Category2 = 'LANDLORD/TENANT'   );
		self.Liens.JGMT_Lawsuit_Pending_Count_60     := (unsigned2)(Judgment_60_Flag1 and Judgment_Category1 = 'LAWSUIT PENDING'   ) + (unsigned2)(Judgment_60_Flag2 and Judgment_Category2 = 'LAWSUIT PENDING'   );
		self.Liens.JGMT_Lien_Other_Count_60          := (unsigned2)(Judgment_60_Flag1 and Judgment_Category1 = 'LIEN-OTHER'        ) + (unsigned2)(Judgment_60_Flag2 and Judgment_Category2 = 'LIEN-OTHER'        );
		self.Liens.JGMT_Small_Claims_Count_60        := (unsigned2)(Judgment_60_Flag1 and Judgment_Category1 = 'SMALL CLAIMS'      ) + (unsigned2)(Judgment_60_Flag2 and Judgment_Category2 = 'SMALL CLAIMS'      );
		self.Liens.JGMT_Tax_Lien_Count_60            := (unsigned2)(Judgment_60_Flag1 and Judgment_Category1 = 'TAX LIEN/WARRANT'  ) + (unsigned2)(Judgment_60_Flag2 and Judgment_Category2 = 'TAX LIEN/WARRANT'  );
		self.Liens.JGMT_Other_Count_60               := (unsigned2)(Judgment_60_Flag1 and Judgment_Category1 = 'OTHER'             ) + (unsigned2)(Judgment_60_Flag2 and Judgment_Category2 = 'OTHER'             );

		self.Liens.JGMT_Child_Support_Count_61       := (unsigned2)(Judgment_61_Flag1 and Judgment_Category1 = 'CHILD SUPPORT'     ) + (unsigned2)(Judgment_61_Flag2 and Judgment_Category2 = 'CHILD SUPPORT'     );
		self.Liens.JGMT_Civil_Judgment_Count_61      := (unsigned2)(Judgment_61_Flag1 and Judgment_Category1 = 'CIVIL JUDGMENT'    ) + (unsigned2)(Judgment_61_Flag2 and Judgment_Category2 = 'CIVIL JUDGMENT'    );
		self.Liens.JGMT_Forcible_Entry_Count_61      := (unsigned2)(Judgment_61_Flag1 and Judgment_Category1 = 'FORCIBLE ENTRY'    ) + (unsigned2)(Judgment_61_Flag2 and Judgment_Category2 = 'FORCIBLE ENTRY'    );
		self.Liens.JGMT_Foreclosure_Count_61         := (unsigned2)(Judgment_61_Flag1 and Judgment_Category1 = 'FORECLOSURE'       ) + (unsigned2)(Judgment_61_Flag2 and Judgment_Category2 = 'FORECLOSURE'       );
		self.Liens.JGMT_Judgment_Other_Count_61      := (unsigned2)(Judgment_61_Flag1 and Judgment_Category1 = 'JUDGMENT-OTHER'    ) + (unsigned2)(Judgment_61_Flag2 and Judgment_Category2 = 'JUDGMENT-OTHER'    );
		self.Liens.JGMT_Landlord_Tenant_Count_61     := (unsigned2)(Judgment_61_Flag1 and Judgment_Category1 = 'LANDLORD/TENANT'   ) + (unsigned2)(Judgment_61_Flag2 and Judgment_Category2 = 'LANDLORD/TENANT'   );
		self.Liens.JGMT_Lawsuit_Pending_Count_61     := (unsigned2)(Judgment_61_Flag1 and Judgment_Category1 = 'LAWSUIT PENDING'   ) + (unsigned2)(Judgment_61_Flag2 and Judgment_Category2 = 'LAWSUIT PENDING'   );
		self.Liens.JGMT_Lien_Other_Count_61          := (unsigned2)(Judgment_61_Flag1 and Judgment_Category1 = 'LIEN-OTHER'        ) + (unsigned2)(Judgment_61_Flag2 and Judgment_Category2 = 'LIEN-OTHER'        );
		self.Liens.JGMT_Small_Claims_Count_61        := (unsigned2)(Judgment_61_Flag1 and Judgment_Category1 = 'SMALL CLAIMS'      ) + (unsigned2)(Judgment_61_Flag2 and Judgment_Category2 = 'SMALL CLAIMS'      );
		self.Liens.JGMT_Tax_Lien_Count_61            := (unsigned2)(Judgment_61_Flag1 and Judgment_Category1 = 'TAX LIEN/WARRANT'  ) + (unsigned2)(Judgment_61_Flag2 and Judgment_Category2 = 'TAX LIEN/WARRANT'  );
		self.Liens.JGMT_Other_Count_61               := (unsigned2)(Judgment_61_Flag1 and Judgment_Category1 = 'OTHER'             ) + (unsigned2)(Judgment_61_Flag2 and Judgment_Category2 = 'OTHER'             );

		self.Liens.JGMT_Child_Support_Count_ND       := (unsigned2)(Judgment_ND_Flag1 and Judgment_Category1 = 'CHILD SUPPORT'     ) + (unsigned2)(Judgment_ND_Flag2 and Judgment_Category2 = 'CHILD SUPPORT'     );
		self.Liens.JGMT_Civil_Judgment_Count_ND      := (unsigned2)(Judgment_ND_Flag1 and Judgment_Category1 = 'CIVIL JUDGMENT'    ) + (unsigned2)(Judgment_ND_Flag2 and Judgment_Category2 = 'CIVIL JUDGMENT'    );
		self.Liens.JGMT_Forcible_Entry_Count_ND      := (unsigned2)(Judgment_ND_Flag1 and Judgment_Category1 = 'FORCIBLE ENTRY'    ) + (unsigned2)(Judgment_ND_Flag2 and Judgment_Category2 = 'FORCIBLE ENTRY'    );
		self.Liens.JGMT_Foreclosure_Count_ND         := (unsigned2)(Judgment_ND_Flag1 and Judgment_Category1 = 'FORECLOSURE'       ) + (unsigned2)(Judgment_ND_Flag2 and Judgment_Category2 = 'FORECLOSURE'       );
		self.Liens.JGMT_Judgment_Other_Count_ND      := (unsigned2)(Judgment_ND_Flag1 and Judgment_Category1 = 'JUDGMENT-OTHER'    ) + (unsigned2)(Judgment_ND_Flag2 and Judgment_Category2 = 'JUDGMENT-OTHER'    );
		self.Liens.JGMT_Landlord_Tenant_Count_ND     := (unsigned2)(Judgment_ND_Flag1 and Judgment_Category1 = 'LANDLORD/TENANT'   ) + (unsigned2)(Judgment_ND_Flag2 and Judgment_Category2 = 'LANDLORD/TENANT'   );
		self.Liens.JGMT_Lawsuit_Pending_Count_ND     := (unsigned2)(Judgment_ND_Flag1 and Judgment_Category1 = 'LAWSUIT PENDING'   ) + (unsigned2)(Judgment_ND_Flag2 and Judgment_Category2 = 'LAWSUIT PENDING'   );
		self.Liens.JGMT_Lien_Other_Count_ND          := (unsigned2)(Judgment_ND_Flag1 and Judgment_Category1 = 'LIEN-OTHER'        ) + (unsigned2)(Judgment_ND_Flag2 and Judgment_Category2 = 'LIEN-OTHER'        );
		self.Liens.JGMT_Small_Claims_Count_ND        := (unsigned2)(Judgment_ND_Flag1 and Judgment_Category1 = 'SMALL CLAIMS'      ) + (unsigned2)(Judgment_ND_Flag2 and Judgment_Category2 = 'SMALL CLAIMS'      );
		self.Liens.JGMT_Tax_Lien_Count_ND            := (unsigned2)(Judgment_ND_Flag1 and Judgment_Category1 = 'TAX LIEN/WARRANT'  ) + (unsigned2)(Judgment_ND_Flag2 and Judgment_Category2 = 'TAX LIEN/WARRANT'  );
		self.Liens.JGMT_Other_Count_ND               := (unsigned2)(Judgment_ND_Flag1 and Judgment_Category1 = 'OTHER'             ) + (unsigned2)(Judgment_ND_Flag2 and Judgment_Category2 = 'OTHER'             );

		self.Liens.JGMT_Sum := (UNSIGNED2)(Judgment_Category1 in ['CHILD SUPPORT', 'CIVIL JUDGMENT', 'FORCIBLE ENTRY', 'FORECLOSURE', 'JUDGMENT-OTHER', 'LANDLORD/TENANT', 'LAWSUIT PENDING', 'LIEN-OTHER', 'SMALL CLAIMS', 'TAX LIEN/WARRANT', 'OTHER']) + (UNSIGNED2)(Judgment_Category2 in ['CHILD SUPPORT', 'CIVIL JUDGMENT', 'FORCIBLE ENTRY', 'FORECLOSURE', 'JUDGMENT-OTHER', 'LANDLORD/TENANT', 'LAWSUIT PENDING', 'LIEN-OTHER', 'SMALL CLAIMS', 'TAX LIEN/WARRANT', 'OTHER']);

    SELF.Liens.JGMT_Flag_Count := 1;
    SELF.Liens.JGMT_Eviction_Flag_Count := IF(TRIM(ri.eviction) = 'Y', 1, 0);
		
		SELF.orig_filing_date := TRIM(ri.orig_filing_date);
		SELF.filing_date := TRIM(ri.filing_date);

    SELF.Filing_Type1Temp := Filing_Type1Temp;
    SELF.Filing_Type2Temp := Filing_Type2Temp;
    SELF.Filing_Type1 := Filing_Type1;
    SELF.Filing_Type2 := Filing_Type2;
    SELF.Judgment_Category1 := Judgment_Category1;
    SELF.Judgment_Category2 := Judgment_Category2;
    SELF.filing_date1Temp := filing_date1Temp;
    SELF.filing_date2Temp := filing_date2Temp;
    SELF.filing_date1 := filing_date1;
    SELF.filing_date2 := filing_date2;
		SELF.mth_filing_date1 := mth_filing_date1;
    SELF.mth_filing_date2 := mth_filing_date2;
    SELF.Judgment_ND_Flag1 := Judgment_ND_Flag1;
    SELF.Judgment_ND_Flag2 := Judgment_ND_Flag2;
    SELF.Judgment_61_Flag1 := Judgment_61_Flag1;
    SELF.Judgment_61_Flag2 := Judgment_61_Flag2;
    SELF.Judgment_60_Flag1 := Judgment_60_Flag1;
    SELF.Judgment_60_Flag2 := Judgment_60_Flag2;
    SELF.Judgment_24_Flag1 := Judgment_24_Flag1;
    SELF.Judgment_24_Flag2 := Judgment_24_Flag2;

    SELF := le;
    self := [];
  END;
	// Per Pete we want to dedup on TMSID/Orig_Filing_Date.  I am sorting by RMSID as well to help make this dedup deterministic.  The second DEDUP/SORT is to eliminate junk data.
  gotLiensTemp := DEDUP(SORT(JOIN(gotLiensFilteredSSNs, LiensV2.key_liens_main_ID, keyed(left.tmsid = right.tmsid) and keyed(left.rmsid = right.rmsid), getLiens(left,right), KEEP(100), ATMOST(RiskWise.max_atmost)), seq, provider_type, tmsid, rmsid, orig_filing_date), seq, provider_type, tmsid, orig_filing_date);
  // If there is a duplicate, write over the orig_filing_date to save it, if there is no duplicate keep the blank date.
	gotLiensTemp2 := JOIN(gotLiensTemp (TRIM(orig_filing_date) = ''), gotLiensTemp (TRIM(orig_filing_date) <> ''), LEFT.seq = RIGHT.seq AND LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid, TRANSFORM(RECORDOF(LEFT), SELF.orig_filing_date := '--------'; SELF := LEFT), LEFT ONLY, ATMOST(RiskWise.max_atmost));
	gotLiensCombo := gotLiensTemp + gotLiensTemp2;
	gotLiens := UNGROUP(PROJECT(DEDUP(SORT(gotLiensCombo (TRIM(orig_filing_date) <> ''), seq, provider_type, tmsid, rmsid, -(Judgment_Category1 <> 'Blank'), -(Judgment_Category2 = 'Blank')), seq, provider_type, tmsid, /*rmsid,*/ orig_filing_date) , TRANSFORM(Layout_HealthCare_Shell_Plus, SELF := LEFT)));
  
  Layout_HealthCare_Shell_Plus rollLiens( Layout_HealthCare_Shell_Plus le, Layout_HealthCare_Shell_Plus ri ) := TRANSFORM
		self.Liens.Liens_Hit                        := true;
		self.Liens.JGMT_Child_Support_Count_24      := le.Liens.JGMT_Child_Support_Count_24    + ri.Liens.JGMT_Child_Support_Count_24;
		self.Liens.JGMT_Civil_Judgment_Count_24     := le.Liens.JGMT_Civil_Judgment_Count_24   + ri.Liens.JGMT_Civil_Judgment_Count_24;
		self.Liens.JGMT_Forcible_Entry_Count_24     := le.Liens.JGMT_Forcible_Entry_Count_24   + ri.Liens.JGMT_Forcible_Entry_Count_24;
		self.Liens.JGMT_Foreclosure_Count_24        := le.Liens.JGMT_Foreclosure_Count_24      + ri.Liens.JGMT_Foreclosure_Count_24;
		self.Liens.JGMT_Judgment_Other_Count_24     := le.Liens.JGMT_Judgment_Other_Count_24   + ri.Liens.JGMT_Judgment_Other_Count_24;
		self.Liens.JGMT_Landlord_Tenant_Count_24    := le.Liens.JGMT_Landlord_Tenant_Count_24  + ri.Liens.JGMT_Landlord_Tenant_Count_24;
		self.Liens.JGMT_Lawsuit_Pending_Count_24    := le.Liens.JGMT_Lawsuit_Pending_Count_24  + ri.Liens.JGMT_Lawsuit_Pending_Count_24;
		self.Liens.JGMT_Lien_Other_Count_24         := le.Liens.JGMT_Lien_Other_Count_24       + ri.Liens.JGMT_Lien_Other_Count_24;
		self.Liens.JGMT_Small_Claims_Count_24       := le.Liens.JGMT_Small_Claims_Count_24     + ri.Liens.JGMT_Small_Claims_Count_24;
		self.Liens.JGMT_Tax_Lien_Count_24           := le.Liens.JGMT_Tax_Lien_Count_24         + ri.Liens.JGMT_Tax_Lien_Count_24;
		self.Liens.JGMT_Other_Count_24              := le.Liens.JGMT_Other_Count_24            + ri.Liens.JGMT_Other_Count_24;

		self.Liens.JGMT_Child_Support_Count_60      := le.Liens.JGMT_Child_Support_Count_60    + ri.Liens.JGMT_Child_Support_Count_60;
		self.Liens.JGMT_Civil_Judgment_Count_60     := le.Liens.JGMT_Civil_Judgment_Count_60   + ri.Liens.JGMT_Civil_Judgment_Count_60;
		self.Liens.JGMT_Forcible_Entry_Count_60     := le.Liens.JGMT_Forcible_Entry_Count_60   + ri.Liens.JGMT_Forcible_Entry_Count_60;
		self.Liens.JGMT_Foreclosure_Count_60        := le.Liens.JGMT_Foreclosure_Count_60      + ri.Liens.JGMT_Foreclosure_Count_60;
		self.Liens.JGMT_Judgment_Other_Count_60     := le.Liens.JGMT_Judgment_Other_Count_60   + ri.Liens.JGMT_Judgment_Other_Count_60;
		self.Liens.JGMT_Landlord_Tenant_Count_60    := le.Liens.JGMT_Landlord_Tenant_Count_60  + ri.Liens.JGMT_Landlord_Tenant_Count_60;
		self.Liens.JGMT_Lawsuit_Pending_Count_60    := le.Liens.JGMT_Lawsuit_Pending_Count_60  + ri.Liens.JGMT_Lawsuit_Pending_Count_60;
		self.Liens.JGMT_Lien_Other_Count_60         := le.Liens.JGMT_Lien_Other_Count_60       + ri.Liens.JGMT_Lien_Other_Count_60;
		self.Liens.JGMT_Small_Claims_Count_60       := le.Liens.JGMT_Small_Claims_Count_60     + ri.Liens.JGMT_Small_Claims_Count_60;
		self.Liens.JGMT_Tax_Lien_Count_60           := le.Liens.JGMT_Tax_Lien_Count_60         + ri.Liens.JGMT_Tax_Lien_Count_60;
		self.Liens.JGMT_Other_Count_60              := le.Liens.JGMT_Other_Count_60            + ri.Liens.JGMT_Other_Count_60;

		self.Liens.JGMT_Child_Support_Count_61      := le.Liens.JGMT_Child_Support_Count_61    + ri.Liens.JGMT_Child_Support_Count_61;
		self.Liens.JGMT_Civil_Judgment_Count_61     := le.Liens.JGMT_Civil_Judgment_Count_61   + ri.Liens.JGMT_Civil_Judgment_Count_61;
		self.Liens.JGMT_Forcible_Entry_Count_61     := le.Liens.JGMT_Forcible_Entry_Count_61   + ri.Liens.JGMT_Forcible_Entry_Count_61;
		self.Liens.JGMT_Foreclosure_Count_61        := le.Liens.JGMT_Foreclosure_Count_61      + ri.Liens.JGMT_Foreclosure_Count_61;
		self.Liens.JGMT_Judgment_Other_Count_61     := le.Liens.JGMT_Judgment_Other_Count_61   + ri.Liens.JGMT_Judgment_Other_Count_61;
		self.Liens.JGMT_Landlord_Tenant_Count_61    := le.Liens.JGMT_Landlord_Tenant_Count_61  + ri.Liens.JGMT_Landlord_Tenant_Count_61;
		self.Liens.JGMT_Lawsuit_Pending_Count_61    := le.Liens.JGMT_Lawsuit_Pending_Count_61  + ri.Liens.JGMT_Lawsuit_Pending_Count_61;
		self.Liens.JGMT_Lien_Other_Count_61         := le.Liens.JGMT_Lien_Other_Count_61       + ri.Liens.JGMT_Lien_Other_Count_61;
		self.Liens.JGMT_Small_Claims_Count_61       := le.Liens.JGMT_Small_Claims_Count_61     + ri.Liens.JGMT_Small_Claims_Count_61;
		self.Liens.JGMT_Tax_Lien_Count_61           := le.Liens.JGMT_Tax_Lien_Count_61         + ri.Liens.JGMT_Tax_Lien_Count_61;
		self.Liens.JGMT_Other_Count_61              := le.Liens.JGMT_Other_Count_61            + ri.Liens.JGMT_Other_Count_61;

		self.Liens.JGMT_Child_Support_Count_ND      := le.Liens.JGMT_Child_Support_Count_ND    + ri.Liens.JGMT_Child_Support_Count_ND;
		self.Liens.JGMT_Civil_Judgment_Count_ND     := le.Liens.JGMT_Civil_Judgment_Count_ND   + ri.Liens.JGMT_Civil_Judgment_Count_ND;
		self.Liens.JGMT_Forcible_Entry_Count_ND     := le.Liens.JGMT_Forcible_Entry_Count_ND   + ri.Liens.JGMT_Forcible_Entry_Count_ND;
		self.Liens.JGMT_Foreclosure_Count_ND        := le.Liens.JGMT_Foreclosure_Count_ND      + ri.Liens.JGMT_Foreclosure_Count_ND;
		self.Liens.JGMT_Judgment_Other_Count_ND     := le.Liens.JGMT_Judgment_Other_Count_ND   + ri.Liens.JGMT_Judgment_Other_Count_ND;
		self.Liens.JGMT_Landlord_Tenant_Count_ND    := le.Liens.JGMT_Landlord_Tenant_Count_ND  + ri.Liens.JGMT_Landlord_Tenant_Count_ND;
		self.Liens.JGMT_Lawsuit_Pending_Count_ND    := le.Liens.JGMT_Lawsuit_Pending_Count_ND  + ri.Liens.JGMT_Lawsuit_Pending_Count_ND;
		self.Liens.JGMT_Lien_Other_Count_ND         := le.Liens.JGMT_Lien_Other_Count_ND       + ri.Liens.JGMT_Lien_Other_Count_ND;
		self.Liens.JGMT_Small_Claims_Count_ND       := le.Liens.JGMT_Small_Claims_Count_ND     + ri.Liens.JGMT_Small_Claims_Count_ND;
		self.Liens.JGMT_Tax_Lien_Count_ND           := le.Liens.JGMT_Tax_Lien_Count_ND         + ri.Liens.JGMT_Tax_Lien_Count_ND;
		self.Liens.JGMT_Other_Count_ND              := le.Liens.JGMT_Other_Count_ND            + ri.Liens.JGMT_Other_Count_ND;

		self.Liens.JGMT_Flag_Count                  := le.Liens.JGMT_Flag_Count                + ri.Liens.JGMT_Flag_Count;
		self.Liens.JGMT_Eviction_Flag_Count         := le.Liens.JGMT_Eviction_Flag_Count       + ri.Liens.JGMT_Eviction_Flag_Count;

		self.Liens.JGMT_Sum                         := le.Liens.JGMT_Sum                       + ri.Liens.JGMT_Sum;

		self := le;
	END;
	rolledLiens := rollup( gotLiens, left.seq=right.seq, rollLiens(left,right) );


	// discipline/sanctions
	key_ingenix_did := doxie_files.key_sanctions_did;
	key_ingenix_bdid := Ingenix_NatlProf.Key_sanctions_bdid;
	key_sanctions := doxie_files.key_sanctions_sancid;
	
	sanctionsID := RECORD
		Layout_HealthCare_Shell_Plus;
		UNSIGNED6 SancID := 0;
	END;
	
	didSancID := JOIN(healthcare_in, key_ingenix_did, LEFT.clam.did != 0 AND KEYED(LEFT.did = RIGHT.l_did), 
												TRANSFORM(sanctionsID, SELF.DID := RIGHT.l_did; SELF.SancID := (UNSIGNED6)RIGHT.sanc_id; SELF.provider_type := ptype.Individual; SELF := LEFT), KEEP(100), ATMOST(RiskWise.max_atmost));
                        
  didRelativeSancID := JOIN(healthcare_in, key_ingenix_did, COUNT(LEFT.relativesDID) > 0 AND RIGHT.l_did IN SET(LEFT.relativesDID (relativesDID <> 0), relativesDID),
																TRANSFORM(sanctionsID, SELF.sancid := (UNSIGNED6)RIGHT.sanc_id; SELF.provider_type := ptype.Relative; SELF := LEFT), KEEP(100), ATMOST(RiskWise.max_atmost));
												
	bdidSancID := JOIN(healthcare_in, key_ingenix_bdid, COUNT(LEFT.bdids) > 0 AND KEYED(RIGHT.bdid IN SET(LEFT.bdids (bdid <> 0), bdid)),
												TRANSFORM(sanctionsID, SELF.SancID := (UNSIGNED6)RIGHT.sanc_id; SELF.provider_type := ptype.Business; SELF := LEFT), KEEP(100), ATMOST(RiskWise.max_atmost));
			
  corpaffilSancID := JOIN(healthcare_in, key_ingenix_bdid, COUNT(LEFT.bdids_corpaffil) > 0 AND RIGHT.bdid IN SET(LEFT.bdids_corpaffil (bdids_corpaffil <> 0), bdids_corpaffil),
                        TRANSFORM(sanctionsID, SELF.SancID := (UNSIGNED6)RIGHT.sanc_id; SELF.provider_type := ptype.CorpAffil; SELF := LEFT), KEEP(100), ATMOST(RiskWise.max_atmost));
  
  Layout_Healthcare_Shell_Plus_Temp := RECORD
    Layout_Healthcare_Shell_Plus;
    STRING8 sanc_sancdte_form := '';
    STRING8 sanc_reindte_form := '';
    REAL8 sanc_sancdte_ymd := 0.0;
    REAL8 sanc_reindte_ymd := 0.0;
    REAL8 mth_sanc_sancdte_ymd := 0.0;
    REAL8 mth_sanc_reindte_ymd := 0.0;
    string sanc_type := '';
    BOOLEAN Sanction_Black_Flag := FALSE;
    BOOLEAN out_of_state_flag := FALSE;
  END;
	Layout_Healthcare_Shell_Plus_Temp getSanctions(sanctionsID le, key_sanctions ri) := TRANSFORM
		self.seq := le.seq;
		self.provider_type := le.provider_type;
		
    sanc_sancdte_ymd := models.common.sas_date( ri.sanc_sancdte_form );
    sanc_reindte_ymd := models.common.sas_date( ri.sanc_reindte_form );
    sysdate := models.common.sas_date( if(le.clam.historydate IN [999999, 0], (STRING8)Std.Date.Today(), (string)le.clam.historydate+'01'));
		
		mth_sanc_sancdte_ymd := if(sysdate = NULL OR sanc_sancdte_ymd = NULL, NULL, ROUNDUP((sysdate-sanc_sancdte_ymd)/30.5));
		mth_sanc_reindte_ymd := if(sysdate = NULL OR sanc_reindte_ymd = NULL, NULL, ROUNDUP((sysdate-sanc_reindte_ymd)/30.5));

		sanc_type := StringLib.StringToUpperCase(trim(ri.SANC_TYPE));

		sanc_reindte_pop := trim(ri.sanc_reindte_form) <> '' AND sanc_reindte_ymd <> NULL;
		sanc_OIG_LEIE :=
			sanc_type = 'DEBARRED/EXCLUDED'
				and StringLib.StringToUpperCase(trim(ri.SANC_BRDTYPE)) = 'FEDERAL BOARDS'
				and StringLib.StringToUpperCase(trim(ri.SANC_SANCST)) = 'DC'
		;
		sanc_GSA_EPLS :=
			sanc_type in ['EXCLUDED', 'EXCLUDED/DELETED']
				and StringLib.StringToUpperCase(trim(ri.SANC_BRDTYPE)) = 'FEDERAL BOARDS'
				and StringLib.StringToUpperCase(trim(ri.SANC_SANCST)) = 'DC'
		;
    
    Sanction_Types := ['ACCUSATION', 'CANCELLED', 'CEASE AND DESIST', 'CONSENT ORDER', 'DEBARRED/EXCLUDED', 'DEBARRED/SUSPENDED', 'EXCLUDED', 'EXCLUDED/DELETED', 'FINE', 'LETTER OF CONCERN', 'LICENSURE DENIED', 'LIMITED LICENSE', 'MODIFICATION OF PREVIOUS ORDER', 'NONE GIVEN', 'OTHER', 'PROBATION', 'REPRIMAND', 'RETIRED', 'REVOCATION', 'REVOKE', 'SURRENDER', 'SUSPENSION', 'TERMINATION', 'VOLUNTARY EXCLUSION', 'VOLUNTARY SURRENDER', 'EXCLUSION', 'STATEMENT OF CHARGES', ''];

		Sanction_Black_Flag := sanc_type in ['CANCELLED', 'DEBARRED/EXCLUDED', 'DEBARRED/SUSPENDED', 'EXCLUDED', 'EXCLUDED/DELETED', 'LICENSURE DENIED', 'REVOCATION', 'SURRENDER', 'SUSPENSION', 'TERMINATION', 'VOLUNTARY EXCLUSION', 'VOLUNTARY SURRENDER', 'EXCLUSION']; 

		input_state_OK := StringLib.StringToUpperCase(trim(le.clam.shell_input.st)) in
			[
				'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FL', 'GA', 'HI',
				'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN',
				'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH',
				'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA',
				'WV', 'WI', 'WY'
			];

		out_of_state_flag := input_state_OK
			and StringLib.StringToUpperCase(trim(le.clam.shell_input.st)) != StringLib.StringToUpperCase(trim(ri.sanc_sancst))
			and trim(ri.sanc_sancst) != '';
    
    SELF.Sanctions.sanc_OIG_LEIE := (UNSIGNED)sanc_OIG_LEIE;
    SELF.Sanctions.sanc_GSA_EPLS := sanc_GSA_EPLS;
    SELF.Sanctions.Sanction_Black_Flag := Sanction_Black_Flag;
    SELF.Sanctions.out_of_state_flag := out_of_state_flag;
    
    sanc_GSA := sanc_GSA_EPLS;
    check1 := NOT sanc_GSA_EPLS AND sanc_OIG_LEIE = FALSE AND out_of_state_flag = TRUE AND Sanction_Black_Flag = TRUE;
    check2 := (sanc_reindte_pop = FALSE OR (sanc_reindte_pop = TRUE AND mth_sanc_reindte_ymd <= 0));
    check3 := sanc_reindte_pop = TRUE AND mth_sanc_reindte_ymd > 0;
    sanc_os_current := check1 AND check2;
    sanc_os_NoDate := check1 AND NOT check2 AND check3 AND mth_sanc_sancdte_ymd < 0;
    sanc_os_24 := check1 AND NOT check2 AND check3 AND mth_sanc_sancdte_ymd >= 0 AND mth_sanc_sancdte_ymd <= 24;
    sanc_os_60 := check1 AND NOT check2 AND check3 AND mth_sanc_sancdte_ymd > 24 AND mth_sanc_sancdte_ymd <= 60;
    sanc_os_61 := check1 AND NOT check2 AND check3 AND mth_sanc_sancdte_ymd > 60;
    
    check4 := Sanction_Black_Flag = TRUE AND (sanc_reindte_pop = FALSE OR (sanc_reindte_pop = TRUE AND mth_sanc_reindte_ymd <= 0));
    check5 := Sanction_Black_Flag = TRUE AND sanc_reindte_pop = TRUE AND mth_sanc_reindte_ymd > 0;
    sanc_current := NOT check1 AND check4;
    sanc_NoDate_1 := NOT check1 AND NOT check4 AND check5 AND mth_sanc_sancdte_ymd = NULL;
    sanc_24_1 := NOT check1 AND NOT check4 AND check5 AND mth_sanc_sancdte_ymd >= 0 AND mth_sanc_sancdte_ymd <= 24;
    sanc_60_1 := NOT check1 AND NOT check4 AND check5 AND mth_sanc_sancdte_ymd > 24 AND mth_sanc_sancdte_ymd <= 60;
    sanc_61_1 := NOT check1 AND NOT check4 AND check5 AND mth_sanc_sancdte_ymd > 60;
    sanc_NoDate_2 := NOT check1 AND NOT check4 AND NOT check5 AND mth_sanc_sancdte_ymd = NULL;
    sanc_24_2 := NOT check1 AND NOT check4 AND NOT check5 AND mth_sanc_sancdte_ymd >= 0 AND mth_sanc_sancdte_ymd <= 24;
    sanc_60_2 := NOT check1 AND NOT check4 AND NOT check5 AND mth_sanc_sancdte_ymd > 24 AND mth_sanc_sancdte_ymd <= 60;
    sanc_61_2 := NOT check1 AND NOT check4 AND NOT check5 AND mth_sanc_sancdte_ymd > 60;
		sanc_NoDate := sanc_NoDate_1 OR sanc_NoDate_2;
    sanc_24 := sanc_24_1 OR sanc_24_2;
    sanc_60 := sanc_60_1 OR sanc_60_2;
    sanc_61 := sanc_61_1 OR sanc_61_2;
    
    sanction_os_black := sanc_os_current OR sanc_os_24 OR sanc_os_60 OR sanc_os_61;
    
    self.sanctions.sanc_os_current      := (INTEGER)sanc_os_current;
		self.sanctions.sanc_os_NoDate       := (INTEGER)sanc_os_NoDate;
		self.sanctions.sanc_os_24           := (INTEGER)sanc_os_24;
		self.sanctions.sanc_os_60           := (INTEGER)sanc_os_60;
		self.sanctions.sanc_os_61           := (INTEGER)sanc_os_61;
		self.sanctions.sanc_current         := (INTEGER)sanc_current;
		self.sanctions.sanc_NoDate          := (INTEGER)sanc_NoDate;
		self.sanctions.sanc_24              := (INTEGER)sanc_24;
		self.sanctions.sanc_60              := (INTEGER)sanc_60;
		self.sanctions.sanc_61              := (INTEGER)sanc_61;
    
		self.sanctions.Sanctions_Hit        := TRUE;
		self.sanctions.sanc_f01_current     := (integer)(sanc_current and sanc_type = 'ACCUSATION'                     );
		self.sanctions.sanc_f02_current     := (integer)(sanc_current and sanc_type = 'CANCELLED'                      );
		self.sanctions.sanc_f03_current     := (integer)(sanc_current and sanc_type = 'CEASE AND DESIST'               );
		self.sanctions.sanc_f04_current     := (integer)(sanc_current and sanc_type = 'CONSENT ORDER'                  );
		self.sanctions.sanc_f05_current     := (integer)(sanc_current and sanc_type = 'DEBARRED/EXCLUDED'              );
		self.sanctions.sanc_f06_current     := (integer)(sanc_current and sanc_type = 'DEBARRED/SUSPENDED'             );
		self.sanctions.sanc_f07_current     := (integer)(sanc_current and sanc_type = 'EXCLUDED'                       );
		self.sanctions.sanc_f08_current     := (integer)(sanc_current and sanc_type = 'EXCLUDED/DELETED'               );
		self.sanctions.sanc_f09_current     := (integer)(sanc_current and sanc_type = 'FINE'                           );
		self.sanctions.sanc_f10_current     := (integer)(sanc_current and sanc_type = 'LETTER OF CONCERN'              );
		self.sanctions.sanc_f11_current     := (integer)(sanc_current and sanc_type = 'LICENSURE DENIED'               );
		self.sanctions.sanc_f12_current     := (integer)(sanc_current and sanc_type = 'LIMITED LICENSE'                );
		self.sanctions.sanc_f13_current     := (integer)(sanc_current and sanc_type = 'MODIFICATION OF PREVIOUS ORDER' );
		self.sanctions.sanc_f14_current     := (integer)(sanc_current and sanc_type = 'NONE GIVEN'                     );
		self.sanctions.sanc_f15_current     := (integer)(sanc_current and sanc_type = 'OTHER'                          );
		self.sanctions.sanc_f16_current     := (integer)(sanc_current and sanc_type = 'PROBATION'                      );
		self.sanctions.sanc_f17_current     := (integer)(sanc_current and sanc_type = 'REPRIMAND'                      );
		self.sanctions.sanc_f18_current     := (integer)(sanc_current and sanc_type = 'RETIRED'                        );
		self.sanctions.sanc_f19_current     := (integer)(sanc_current and sanc_type IN ['REVOCATION', 'REVOKE']        );
		self.sanctions.sanc_f20_current     := (integer)(sanc_current and sanc_type = 'SURRENDER'                      );
		self.sanctions.sanc_f21_current     := (integer)(sanc_current and sanc_type = 'SUSPENSION'                     );
		self.sanctions.sanc_f22_current     := (integer)(sanc_current and sanc_type = 'TERMINATION'                    );
		self.sanctions.sanc_f23_current     := (integer)(sanc_current and sanc_type = 'VOLUNTARY EXCLUSION'            );
		self.sanctions.sanc_f24_current     := (integer)(sanc_current and sanc_type = 'VOLUNTARY SURRENDER'            );
		self.sanctions.sanc_f25_current     := (integer)(sanc_current and sanc_type = 'EXCLUSION'                      );
		self.sanctions.sanc_f26_current     := (integer)(sanc_current and sanc_type = 'STATEMENT OF CHARGES'           );
		self.sanctions.sanc_blank_current   := (integer)(sanc_current and sanc_type = ''                               );
		self.sanctions.sanc_unknown_current := (integer)(sanc_current AND sanc_type NOT IN Sanction_Types);

		self.sanctions.sanc_f01_24     := (integer)(sanc_24 and sanc_type = 'ACCUSATION'                     );
		self.sanctions.sanc_f02_24     := (integer)(sanc_24 and sanc_type = 'CANCELLED'                      );
		self.sanctions.sanc_f03_24     := (integer)(sanc_24 and sanc_type = 'CEASE AND DESIST'               );
		self.sanctions.sanc_f04_24     := (integer)(sanc_24 and sanc_type = 'CONSENT ORDER'                  );
		self.sanctions.sanc_f05_24     := (integer)(sanc_24 and sanc_type = 'DEBARRED/EXCLUDED'              );
		self.sanctions.sanc_f06_24     := (integer)(sanc_24 and sanc_type = 'DEBARRED/SUSPENDED'             );
		self.sanctions.sanc_f07_24     := (integer)(sanc_24 and sanc_type = 'EXCLUDED'                       );
		self.sanctions.sanc_f08_24     := (integer)(sanc_24 and sanc_type = 'EXCLUDED/DELETED'               );
		self.sanctions.sanc_f09_24     := (integer)(sanc_24 and sanc_type = 'FINE'                           );
		self.sanctions.sanc_f10_24     := (integer)(sanc_24 and sanc_type = 'LETTER OF CONCERN'              );
		self.sanctions.sanc_f11_24     := (integer)(sanc_24 and sanc_type = 'LICENSURE DENIED'               );
		self.sanctions.sanc_f12_24     := (integer)(sanc_24 and sanc_type = 'LIMITED LICENSE'                );
		self.sanctions.sanc_f13_24     := (integer)(sanc_24 and sanc_type = 'MODIFICATION OF PREVIOUS ORDER' );
		self.sanctions.sanc_f14_24     := (integer)(sanc_24 and sanc_type = 'NONE GIVEN'                     );
		self.sanctions.sanc_f15_24     := (integer)(sanc_24 and sanc_type = 'OTHER'                          );
		self.sanctions.sanc_f16_24     := (integer)(sanc_24 and sanc_type = 'PROBATION'                      );
		self.sanctions.sanc_f17_24     := (integer)(sanc_24 and sanc_type = 'REPRIMAND'                      );
		self.sanctions.sanc_f18_24     := (integer)(sanc_24 and sanc_type = 'RETIRED'                        );
		self.sanctions.sanc_f19_24     := (integer)(sanc_24 and sanc_type in ['REVOCATION','REVOKE']         );
		self.sanctions.sanc_f20_24     := (integer)(sanc_24 and sanc_type = 'SURRENDER'                      );
		self.sanctions.sanc_f21_24     := (integer)(sanc_24 and sanc_type = 'SUSPENSION'                     );
		self.sanctions.sanc_f22_24     := (integer)(sanc_24 and sanc_type = 'TERMINATION'                    );
		self.sanctions.sanc_f23_24     := (integer)(sanc_24 and sanc_type = 'VOLUNTARY EXCLUSION'            );
		self.sanctions.sanc_f24_24     := (integer)(sanc_24 and sanc_type = 'VOLUNTARY SURRENDER'            );
		self.sanctions.sanc_f25_24     := (integer)(sanc_24 and sanc_type = 'EXCLUSION'                      );
		self.sanctions.sanc_f26_24     := (integer)(sanc_24 and sanc_type = 'STATEMENT OF CHARGES'           );
		self.sanctions.sanc_blank_24   := (integer)(sanc_24 and sanc_type = ''                               );
		self.sanctions.sanc_unknown_24 := (integer)(sanc_24 AND sanc_type NOT IN Sanction_Types);

		self.sanctions.sanc_f01_60     := (integer)(sanc_60 and sanc_type = 'ACCUSATION'                     );
		self.sanctions.sanc_f02_60     := (integer)(sanc_60 and sanc_type = 'CANCELLED'                      );
		self.sanctions.sanc_f03_60     := (integer)(sanc_60 and sanc_type = 'CEASE AND DESIST'               );
		self.sanctions.sanc_f04_60     := (integer)(sanc_60 and sanc_type = 'CONSENT ORDER'                  );
		self.sanctions.sanc_f05_60     := (integer)(sanc_60 and sanc_type = 'DEBARRED/EXCLUDED'              );
		self.sanctions.sanc_f06_60     := (integer)(sanc_60 and sanc_type = 'DEBARRED/SUSPENDED'             );
		self.sanctions.sanc_f07_60     := (integer)(sanc_60 and sanc_type = 'EXCLUDED'                       );
		self.sanctions.sanc_f08_60     := (integer)(sanc_60 and sanc_type = 'EXCLUDED/DELETED'               );
		self.sanctions.sanc_f09_60     := (integer)(sanc_60 and sanc_type = 'FINE'                           );
		self.sanctions.sanc_f10_60     := (integer)(sanc_60 and sanc_type = 'LETTER OF CONCERN'              );
		self.sanctions.sanc_f11_60     := (integer)(sanc_60 and sanc_type = 'LICENSURE DENIED'               );
		self.sanctions.sanc_f12_60     := (integer)(sanc_60 and sanc_type = 'LIMITED LICENSE'                );
		self.sanctions.sanc_f13_60     := (integer)(sanc_60 and sanc_type = 'MODIFICATION OF PREVIOUS ORDER' );
		self.sanctions.sanc_f14_60     := (integer)(sanc_60 and sanc_type = 'NONE GIVEN'                     );
		self.sanctions.sanc_f15_60     := (integer)(sanc_60 and sanc_type = 'OTHER'                          );
		self.sanctions.sanc_f16_60     := (integer)(sanc_60 and sanc_type = 'PROBATION'                      );
		self.sanctions.sanc_f17_60     := (integer)(sanc_60 and sanc_type = 'REPRIMAND'                      );
		self.sanctions.sanc_f18_60     := (integer)(sanc_60 and sanc_type = 'RETIRED'                        );
		self.sanctions.sanc_f19_60     := (integer)(sanc_60 and sanc_type in ['REVOCATION', 'REVOKE']        );
		self.sanctions.sanc_f20_60     := (integer)(sanc_60 and sanc_type = 'SURRENDER'                      );
		self.sanctions.sanc_f21_60     := (integer)(sanc_60 and sanc_type = 'SUSPENSION'                     );
		self.sanctions.sanc_f22_60     := (integer)(sanc_60 and sanc_type = 'TERMINATION'                    );
		self.sanctions.sanc_f23_60     := (integer)(sanc_60 and sanc_type = 'VOLUNTARY EXCLUSION'            );
		self.sanctions.sanc_f24_60     := (integer)(sanc_60 and sanc_type = 'VOLUNTARY SURRENDER'            );
		self.sanctions.sanc_f25_60     := (integer)(sanc_60 and sanc_type = 'EXCLUSION'                      );
		self.sanctions.sanc_f26_60     := (integer)(sanc_60 and sanc_type = 'STATEMENT OF CHARGES'           );
		self.sanctions.sanc_blank_60   := (integer)(sanc_60 and sanc_type = ''                               );
		self.sanctions.sanc_unknown_60 := (integer)(sanc_60 AND sanc_type NOT IN Sanction_Types);

		self.sanctions.sanc_f01_61     := (integer)(sanc_61 and sanc_type = 'ACCUSATION'                     );
		self.sanctions.sanc_f02_61     := (integer)(sanc_61 and sanc_type = 'CANCELLED'                      );
		self.sanctions.sanc_f03_61     := (integer)(sanc_61 and sanc_type = 'CEASE AND DESIST'               );
		self.sanctions.sanc_f04_61     := (integer)(sanc_61 and sanc_type = 'CONSENT ORDER'                  );
		self.sanctions.sanc_f05_61     := (integer)(sanc_61 and sanc_type = 'DEBARRED/EXCLUDED'              );
		self.sanctions.sanc_f06_61     := (integer)(sanc_61 and sanc_type = 'DEBARRED/SUSPENDED'             );
		self.sanctions.sanc_f07_61     := (integer)(sanc_61 and sanc_type = 'EXCLUDED'                       );
		self.sanctions.sanc_f08_61     := (integer)(sanc_61 and sanc_type = 'EXCLUDED/DELETED'               );
		self.sanctions.sanc_f09_61     := (integer)(sanc_61 and sanc_type = 'FINE'                           );
		self.sanctions.sanc_f10_61     := (integer)(sanc_61 and sanc_type = 'LETTER OF CONCERN'              );
		self.sanctions.sanc_f11_61     := (integer)(sanc_61 and sanc_type = 'LICENSURE DENIED'               );
		self.sanctions.sanc_f12_61     := (integer)(sanc_61 and sanc_type = 'LIMITED LICENSE'                );
		self.sanctions.sanc_f13_61     := (integer)(sanc_61 and sanc_type = 'MODIFICATION OF PREVIOUS ORDER' );
		self.sanctions.sanc_f14_61     := (integer)(sanc_61 and sanc_type = 'NONE GIVEN'                     );
		self.sanctions.sanc_f15_61     := (integer)(sanc_61 and sanc_type = 'OTHER'                          );
		self.sanctions.sanc_f16_61     := (integer)(sanc_61 and sanc_type = 'PROBATION'                      );
		self.sanctions.sanc_f17_61     := (integer)(sanc_61 and sanc_type = 'REPRIMAND'                      );
		self.sanctions.sanc_f18_61     := (integer)(sanc_61 and sanc_type = 'RETIRED'                        );
		self.sanctions.sanc_f19_61     := (integer)(sanc_61 and sanc_type in ['REVOCATION','REVOKE']         );
		self.sanctions.sanc_f20_61     := (integer)(sanc_61 and sanc_type = 'SURRENDER'                      );
		self.sanctions.sanc_f21_61     := (integer)(sanc_61 and sanc_type = 'SUSPENSION'                     );
		self.sanctions.sanc_f22_61     := (integer)(sanc_61 and sanc_type = 'TERMINATION'                    );
		self.sanctions.sanc_f23_61     := (integer)(sanc_61 and sanc_type = 'VOLUNTARY EXCLUSION'            );
		self.sanctions.sanc_f24_61     := (integer)(sanc_61 and sanc_type = 'VOLUNTARY SURRENDER'            );
		self.sanctions.sanc_f25_61     := (integer)(sanc_61 and sanc_type = 'EXCLUSION'                      );
		self.sanctions.sanc_f26_61     := (integer)(sanc_61 and sanc_type = 'STATEMENT OF CHARGES'           );
		self.sanctions.sanc_blank_61   := (integer)(sanc_61 and sanc_type = ''                               );
		self.sanctions.sanc_unknown_61 := (integer)(sanc_61 AND sanc_type NOT IN Sanction_Types);

    SELF.sanc_sancdte_form := ri.sanc_sancdte_form;
    SELF.sanc_reindte_form := ri.sanc_reindte_form;
    SELF.sanc_sancdte_ymd := sanc_sancdte_ymd;
    SELF.sanc_reindte_ymd := sanc_reindte_ymd;
    SELF.mth_sanc_sancdte_ymd := mth_sanc_sancdte_ymd;
    SELF.mth_sanc_reindte_ymd := mth_sanc_reindte_ymd;
    SELF.Sanction_Black_Flag := Sanction_Black_Flag;
    SELF.out_of_state_flag := out_of_state_flag;
    SELF.sanc_type := sanc_type;

    SELF := le;
		self := [];
	end;
  sancDid := JOIN(didSancID, key_sanctions, LEFT.sancid != 0 AND KEYED(LEFT.sancid = RIGHT.l_sancid), getSanctions(left, right), KEEP(100), ATMOST(RiskWise.max_atmost));
  sancDidRelative := JOIN(didRelativeSancID, key_sanctions, LEFT.sancid != 0 AND KEYED(LEFT.sancid = RIGHT.l_sancid), getSanctions(left, right), KEEP(100), ATMOST(RiskWise.max_atmost));
  sancBDID := JOIN(bdidSancID, key_sanctions, LEFT.sancid != 0 AND KEYED(LEFT.sancid = RIGHT.l_sancid), getSanctions(left, right), KEEP(100), ATMOST(RiskWise.max_atmost));
  sancBDIDCorpAffil := JOIN(corpaffilSancID, key_sanctions, LEFT.sancid != 0 AND KEYED(LEFT.sancid = RIGHT.l_sancid), getSanctions(left, right), KEEP(100), ATMOST(RiskWise.max_atmost));
	gotSanctionsTemp := sancDid + sancDidRelative + sancBDID + sancBDIDCorpAffil;
  gotSanctions := SORT(PROJECT(gotSanctionsTemp, TRANSFORM(Layout_Healthcare_Shell_Plus, SELF := LEFT)), seq, provider_type);

	Layout_Healthcare_Shell_Plus rollSanctions( Layout_Healthcare_Shell_Plus le, Layout_Healthcare_Shell_Plus ri ) := TRANSFORM
    self.sanctions.sanc_os_current      := le.sanctions.sanc_os_current + ri.sanctions.sanc_os_current;
		self.sanctions.sanc_os_NoDate       := le.sanctions.sanc_os_NoDate + ri.sanctions.sanc_os_NoDate;
		self.sanctions.sanc_os_24           := le.sanctions.sanc_os_24 + ri.sanctions.sanc_os_24;
		self.sanctions.sanc_os_60           := le.sanctions.sanc_os_60 + ri.sanctions.sanc_os_60;
		self.sanctions.sanc_os_61           := le.sanctions.sanc_os_61 + ri.sanctions.sanc_os_61;
		self.sanctions.sanc_current         := le.sanctions.sanc_current + ri.sanctions.sanc_current;
		self.sanctions.sanc_NoDate          := le.sanctions.sanc_NoDate + ri.sanctions.sanc_NoDate;
		self.sanctions.sanc_24              := le.sanctions.sanc_24 + ri.sanctions.sanc_24;
		self.sanctions.sanc_60              := le.sanctions.sanc_60 + ri.sanctions.sanc_60;
		self.sanctions.sanc_61              := le.sanctions.sanc_61 + ri.sanctions.sanc_61;
    SELF.Sanctions.sanc_OIG_LEIE        := le.sanctions.sanc_OIG_LEIE + ri.sanctions.sanc_OIG_LEIE;
    SELF.Sanctions.sanc_GSA_EPLS        := le.sanctions.sanc_GSA_EPLS OR ri.sanctions.sanc_GSA_EPLS;
    SELF.Sanctions.Sanction_Black_Flag  := le.sanctions.Sanction_Black_Flag OR ri.sanctions.Sanction_Black_Flag;
    SELF.Sanctions.out_of_state_flag    := le.sanctions.out_of_state_flag OR ri.sanctions.out_of_state_flag;

		self.sanctions.Sanctions_Hit         := le.sanctions.Sanctions_Hit OR ri.sanctions.Sanctions_Hit;
		self.sanctions.sanc_f01_current      := le.sanctions.sanc_f01_current + ri.sanctions.sanc_f01_current;
		self.sanctions.sanc_f02_current      := le.sanctions.sanc_f02_current + ri.sanctions.sanc_f02_current;
		self.sanctions.sanc_f03_current      := le.sanctions.sanc_f03_current + ri.sanctions.sanc_f03_current;
		self.sanctions.sanc_f04_current      := le.sanctions.sanc_f04_current + ri.sanctions.sanc_f04_current;
		self.sanctions.sanc_f05_current      := le.sanctions.sanc_f05_current + ri.sanctions.sanc_f05_current;
		self.sanctions.sanc_f06_current      := le.sanctions.sanc_f06_current + ri.sanctions.sanc_f06_current;
		self.sanctions.sanc_f07_current      := le.sanctions.sanc_f07_current + ri.sanctions.sanc_f07_current;
		self.sanctions.sanc_f08_current      := le.sanctions.sanc_f08_current + ri.sanctions.sanc_f08_current;
		self.sanctions.sanc_f09_current      := le.sanctions.sanc_f09_current + ri.sanctions.sanc_f09_current;
		self.sanctions.sanc_f10_current      := le.sanctions.sanc_f10_current + ri.sanctions.sanc_f10_current;
		self.sanctions.sanc_f11_current      := le.sanctions.sanc_f11_current + ri.sanctions.sanc_f11_current;
		self.sanctions.sanc_f12_current      := le.sanctions.sanc_f12_current + ri.sanctions.sanc_f12_current;
		self.sanctions.sanc_f13_current      := le.sanctions.sanc_f13_current + ri.sanctions.sanc_f13_current;
		self.sanctions.sanc_f14_current      := le.sanctions.sanc_f14_current + ri.sanctions.sanc_f14_current;
		self.sanctions.sanc_f15_current      := le.sanctions.sanc_f15_current + ri.sanctions.sanc_f15_current;
		self.sanctions.sanc_f16_current      := le.sanctions.sanc_f16_current + ri.sanctions.sanc_f16_current;
		self.sanctions.sanc_f17_current      := le.sanctions.sanc_f17_current + ri.sanctions.sanc_f17_current;
		self.sanctions.sanc_f18_current      := le.sanctions.sanc_f18_current + ri.sanctions.sanc_f18_current;
		self.sanctions.sanc_f19_current      := le.sanctions.sanc_f19_current + ri.sanctions.sanc_f19_current;
		self.sanctions.sanc_f20_current      := le.sanctions.sanc_f20_current + ri.sanctions.sanc_f20_current;
		self.sanctions.sanc_f21_current      := le.sanctions.sanc_f21_current + ri.sanctions.sanc_f21_current;
		self.sanctions.sanc_f22_current      := le.sanctions.sanc_f22_current + ri.sanctions.sanc_f22_current;
		self.sanctions.sanc_f23_current      := le.sanctions.sanc_f23_current + ri.sanctions.sanc_f23_current;
		self.sanctions.sanc_f24_current      := le.sanctions.sanc_f24_current + ri.sanctions.sanc_f24_current;
		self.sanctions.sanc_f25_current      := le.sanctions.sanc_f25_current + ri.sanctions.sanc_f25_current;
		self.sanctions.sanc_f26_current      := le.sanctions.sanc_f26_current + ri.sanctions.sanc_f26_current;
		self.sanctions.sanc_blank_current    := le.sanctions.sanc_blank_current + ri.sanctions.sanc_blank_current;
		self.sanctions.sanc_unknown_current  := le.sanctions.sanc_unknown_current + ri.sanctions.sanc_unknown_current;

		self.sanctions.sanc_f01_24           := le.sanctions.sanc_f01_24 + ri.sanctions.sanc_f01_24;
		self.sanctions.sanc_f02_24           := le.sanctions.sanc_f02_24 + ri.sanctions.sanc_f02_24;
		self.sanctions.sanc_f03_24           := le.sanctions.sanc_f03_24 + ri.sanctions.sanc_f03_24;
		self.sanctions.sanc_f04_24           := le.sanctions.sanc_f04_24 + ri.sanctions.sanc_f04_24;
		self.sanctions.sanc_f05_24           := le.sanctions.sanc_f05_24 + ri.sanctions.sanc_f05_24;
		self.sanctions.sanc_f06_24           := le.sanctions.sanc_f06_24 + ri.sanctions.sanc_f06_24;
		self.sanctions.sanc_f07_24           := le.sanctions.sanc_f07_24 + ri.sanctions.sanc_f07_24;
		self.sanctions.sanc_f08_24           := le.sanctions.sanc_f08_24 + ri.sanctions.sanc_f08_24;
		self.sanctions.sanc_f09_24           := le.sanctions.sanc_f09_24 + ri.sanctions.sanc_f09_24;
		self.sanctions.sanc_f10_24           := le.sanctions.sanc_f10_24 + ri.sanctions.sanc_f10_24;
		self.sanctions.sanc_f11_24           := le.sanctions.sanc_f11_24 + ri.sanctions.sanc_f11_24;
		self.sanctions.sanc_f12_24           := le.sanctions.sanc_f12_24 + ri.sanctions.sanc_f12_24;
		self.sanctions.sanc_f13_24           := le.sanctions.sanc_f13_24 + ri.sanctions.sanc_f13_24;
		self.sanctions.sanc_f14_24           := le.sanctions.sanc_f14_24 + ri.sanctions.sanc_f14_24;
		self.sanctions.sanc_f15_24           := le.sanctions.sanc_f15_24 + ri.sanctions.sanc_f15_24;
		self.sanctions.sanc_f16_24           := le.sanctions.sanc_f16_24 + ri.sanctions.sanc_f16_24;
		self.sanctions.sanc_f17_24           := le.sanctions.sanc_f17_24 + ri.sanctions.sanc_f17_24;
		self.sanctions.sanc_f18_24           := le.sanctions.sanc_f18_24 + ri.sanctions.sanc_f18_24;
		self.sanctions.sanc_f19_24           := le.sanctions.sanc_f19_24 + ri.sanctions.sanc_f19_24;
		self.sanctions.sanc_f20_24           := le.sanctions.sanc_f20_24 + ri.sanctions.sanc_f20_24;
		self.sanctions.sanc_f21_24           := le.sanctions.sanc_f21_24 + ri.sanctions.sanc_f21_24;
		self.sanctions.sanc_f22_24           := le.sanctions.sanc_f22_24 + ri.sanctions.sanc_f22_24;
		self.sanctions.sanc_f23_24           := le.sanctions.sanc_f23_24 + ri.sanctions.sanc_f23_24;
		self.sanctions.sanc_f24_24           := le.sanctions.sanc_f24_24 + ri.sanctions.sanc_f24_24;
		self.sanctions.sanc_f25_24           := le.sanctions.sanc_f25_24 + ri.sanctions.sanc_f25_24;
		self.sanctions.sanc_f26_24           := le.sanctions.sanc_f26_24 + ri.sanctions.sanc_f26_24;
		self.sanctions.sanc_blank_24         := le.sanctions.sanc_blank_24 + ri.sanctions.sanc_blank_24;
		self.sanctions.sanc_unknown_24       := le.sanctions.sanc_unknown_24 + ri.sanctions.sanc_unknown_24;

		self.sanctions.sanc_f01_60           := le.sanctions.sanc_f01_60 + ri.sanctions.sanc_f01_60;
		self.sanctions.sanc_f02_60           := le.sanctions.sanc_f02_60 + ri.sanctions.sanc_f02_60;
		self.sanctions.sanc_f03_60           := le.sanctions.sanc_f03_60 + ri.sanctions.sanc_f03_60;
		self.sanctions.sanc_f04_60           := le.sanctions.sanc_f04_60 + ri.sanctions.sanc_f04_60;
		self.sanctions.sanc_f05_60           := le.sanctions.sanc_f05_60 + ri.sanctions.sanc_f05_60;
		self.sanctions.sanc_f06_60           := le.sanctions.sanc_f06_60 + ri.sanctions.sanc_f06_60;
		self.sanctions.sanc_f07_60           := le.sanctions.sanc_f07_60 + ri.sanctions.sanc_f07_60;
		self.sanctions.sanc_f08_60           := le.sanctions.sanc_f08_60 + ri.sanctions.sanc_f08_60;
		self.sanctions.sanc_f09_60           := le.sanctions.sanc_f09_60 + ri.sanctions.sanc_f09_60;
		self.sanctions.sanc_f10_60           := le.sanctions.sanc_f10_60 + ri.sanctions.sanc_f10_60;
		self.sanctions.sanc_f11_60           := le.sanctions.sanc_f11_60 + ri.sanctions.sanc_f11_60;
		self.sanctions.sanc_f12_60           := le.sanctions.sanc_f12_60 + ri.sanctions.sanc_f12_60;
		self.sanctions.sanc_f13_60           := le.sanctions.sanc_f13_60 + ri.sanctions.sanc_f13_60;
		self.sanctions.sanc_f14_60           := le.sanctions.sanc_f14_60 + ri.sanctions.sanc_f14_60;
		self.sanctions.sanc_f15_60           := le.sanctions.sanc_f15_60 + ri.sanctions.sanc_f15_60;
		self.sanctions.sanc_f16_60           := le.sanctions.sanc_f16_60 + ri.sanctions.sanc_f16_60;
		self.sanctions.sanc_f17_60           := le.sanctions.sanc_f17_60 + ri.sanctions.sanc_f17_60;
		self.sanctions.sanc_f18_60           := le.sanctions.sanc_f18_60 + ri.sanctions.sanc_f18_60;
		self.sanctions.sanc_f19_60           := le.sanctions.sanc_f19_60 + ri.sanctions.sanc_f19_60;
		self.sanctions.sanc_f20_60           := le.sanctions.sanc_f20_60 + ri.sanctions.sanc_f20_60;
		self.sanctions.sanc_f21_60           := le.sanctions.sanc_f21_60 + ri.sanctions.sanc_f21_60;
		self.sanctions.sanc_f22_60           := le.sanctions.sanc_f22_60 + ri.sanctions.sanc_f22_60;
		self.sanctions.sanc_f23_60           := le.sanctions.sanc_f23_60 + ri.sanctions.sanc_f23_60;
		self.sanctions.sanc_f24_60           := le.sanctions.sanc_f24_60 + ri.sanctions.sanc_f24_60;
		self.sanctions.sanc_f25_60           := le.sanctions.sanc_f25_60 + ri.sanctions.sanc_f25_60;
		self.sanctions.sanc_f26_60           := le.sanctions.sanc_f26_60 + ri.sanctions.sanc_f26_60;
		self.sanctions.sanc_blank_60         := le.sanctions.sanc_blank_60 + ri.sanctions.sanc_blank_60;
		self.sanctions.sanc_unknown_60       := le.sanctions.sanc_unknown_60 + ri.sanctions.sanc_unknown_60;

		self.sanctions.sanc_f01_61           := le.sanctions.sanc_f01_61 + ri.sanctions.sanc_f01_61;
		self.sanctions.sanc_f02_61           := le.sanctions.sanc_f02_61 + ri.sanctions.sanc_f02_61;
		self.sanctions.sanc_f03_61           := le.sanctions.sanc_f03_61 + ri.sanctions.sanc_f03_61;
		self.sanctions.sanc_f04_61           := le.sanctions.sanc_f04_61 + ri.sanctions.sanc_f04_61;
		self.sanctions.sanc_f05_61           := le.sanctions.sanc_f05_61 + ri.sanctions.sanc_f05_61;
		self.sanctions.sanc_f06_61           := le.sanctions.sanc_f06_61 + ri.sanctions.sanc_f06_61;
		self.sanctions.sanc_f07_61           := le.sanctions.sanc_f07_61 + ri.sanctions.sanc_f07_61;
		self.sanctions.sanc_f08_61           := le.sanctions.sanc_f08_61 + ri.sanctions.sanc_f08_61;
		self.sanctions.sanc_f09_61           := le.sanctions.sanc_f09_61 + ri.sanctions.sanc_f09_61;
		self.sanctions.sanc_f10_61           := le.sanctions.sanc_f10_61 + ri.sanctions.sanc_f10_61;
		self.sanctions.sanc_f11_61           := le.sanctions.sanc_f11_61 + ri.sanctions.sanc_f11_61;
		self.sanctions.sanc_f12_61           := le.sanctions.sanc_f12_61 + ri.sanctions.sanc_f12_61;
		self.sanctions.sanc_f13_61           := le.sanctions.sanc_f13_61 + ri.sanctions.sanc_f13_61;
		self.sanctions.sanc_f14_61           := le.sanctions.sanc_f14_61 + ri.sanctions.sanc_f14_61;
		self.sanctions.sanc_f15_61           := le.sanctions.sanc_f15_61 + ri.sanctions.sanc_f15_61;
		self.sanctions.sanc_f16_61           := le.sanctions.sanc_f16_61 + ri.sanctions.sanc_f16_61;
		self.sanctions.sanc_f17_61           := le.sanctions.sanc_f17_61 + ri.sanctions.sanc_f17_61;
		self.sanctions.sanc_f18_61           := le.sanctions.sanc_f18_61 + ri.sanctions.sanc_f18_61;
		self.sanctions.sanc_f19_61           := le.sanctions.sanc_f19_61 + ri.sanctions.sanc_f19_61;
		self.sanctions.sanc_f20_61           := le.sanctions.sanc_f20_61 + ri.sanctions.sanc_f20_61;
		self.sanctions.sanc_f21_61           := le.sanctions.sanc_f21_61 + ri.sanctions.sanc_f21_61;
		self.sanctions.sanc_f22_61           := le.sanctions.sanc_f22_61 + ri.sanctions.sanc_f22_61;
		self.sanctions.sanc_f23_61           := le.sanctions.sanc_f23_61 + ri.sanctions.sanc_f23_61;
		self.sanctions.sanc_f24_61           := le.sanctions.sanc_f24_61 + ri.sanctions.sanc_f24_61;
		self.sanctions.sanc_f25_61           := le.sanctions.sanc_f25_61 + ri.sanctions.sanc_f25_61;
		self.sanctions.sanc_f26_61           := le.sanctions.sanc_f26_61 + ri.sanctions.sanc_f26_61;
		self.sanctions.sanc_blank_61         := le.sanctions.sanc_blank_61 + ri.sanctions.sanc_blank_61;
		self.sanctions.sanc_unknown_61       := le.sanctions.sanc_unknown_61 + ri.sanctions.sanc_unknown_61;

		self := le;
	end;
	rolledSanctions := ROLLUP(gotSanctions, left.seq = right.seq and left.provider_type = right.provider_type, rollSanctions(left,right) );

	Layout_Healthcare_Shell_Plus cleanupSanctions( Layout_Healthcare_Shell_Plus le ) := TRANSFORM
		emptyRow := row( [], Layout_Healthcare_Shell_Plus.Sanctions );
		self.Sanctions     := if(le.provider_type IN [ptype.Individual, ptype.Business], le.sanctions, emptyRow);
		self.RAN_Sanctions := if(le.provider_type = ptype.Relative,   le.sanctions, emptyRow);
		self.Bus_Sanctions := if(le.provider_type = ptype.CorpAffil,   le.sanctions, emptyRow);
		self := le;
	END;
	cleanedSanctions := project(rolledSanctions, cleanupSanctions(left));

	Layout_Healthcare_Shell_Plus finishSanctions(Layout_Healthcare_Shell_Plus le, Layout_Healthcare_Shell_Plus ri) := TRANSFORM
		self.sanctions     := if(ri.provider_type IN [ptype.Individual, ptype.Business], ri.sanctions, le.sanctions);
		self.ran_sanctions := if(ri.provider_type = ptype.Relative, ri.ran_sanctions, le.ran_sanctions);
		self.bus_sanctions := if(ri.provider_type = ptype.CorpAffil, ri.bus_sanctions, le.bus_sanctions);
		
		self := le;
	END;
	final_sanctions := rollup(cleanedSanctions, left.seq = right.seq, finishSanctions(left, right));

	// provider
	gsa_did  := GSA.Key_GSA_DID;
	gsa_bdid := GSA.Key_GSA_BDID;
	Layout_Healthcare_Shell_Plus_GSATemp := RECORD
		Layout_Healthcare_Shell_Plus;
		STRING25 ExclusionType := '';
		STRING8 TerminationDate := '';
		INTEGER ActionDt := 0;
		INTEGER TermDt := 0;
		REAL8 mth_action_dt := 0.0;
		REAL8 mth_term_dt := 0.0;
	END;
	Layout_Healthcare_Shell_Plus_GSATemp getProviderDID(healthcare_in le, gsa_did ri, ptype provider_type_in) := TRANSFORM
		self.seq         := le.seq;
		self.provider_type := provider_type_in;
		
		ExclusionType := trim(ri.cttype);
		TerminationDate := trim(ri.TermDate);

		Action_DT := models.common.sas_date(ri.ActionDate);
		Term_DT   := models.common.sas_date(TerminationDate);
    sysdate := models.common.sas_date( if(le.clam.historydate IN [999999, 0], (STRING8)Std.Date.Today(), (string)le.clam.historydate+'01'));
		
		mth_Action_DT := if(sysdate = NULL OR action_dt = NULL, NULL, ROUNDUP((sysdate-Action_DT)/30.5));
		// If the term date is indefinite then this should always be a current record
		mth_Term_DT   := if(StringLib.StringToUpperCase(TRIM(ri.termdateindefinite)) = 'Y', 0, if(sysdate = NULL OR Term_DT = NULL, NULL, ROUNDUP((sysdate-Term_DT)/30.5)));
		
		SELF.ExclusionType := ExclusionType;
		SELF.TerminationDate := TerminationDate;
		SELF.ActionDt := Action_DT;
		SELF.TermDt := Term_DT;
		SELF.mth_action_dt := mth_Action_DT;
		SELF.mth_term_dt := mth_Term_DT;
		SELF.sysdate := sysdate;


		GSA_Provider_Old_Flag     := mth_action_dt > 0 AND ExclusionType in ['Procurement','NonProcurement','Reciprocal'] and mth_Term_DT  > 0;
		GSA_Provider_Current_Flag := mth_action_dt > 0 AND ExclusionType in ['Procurement','NonProcurement','Reciprocal'] and mth_Term_DT <= 0 AND mth_Term_DT <> NULL;

		self.Provider.Provider_Hit              := true;
		self.Provider.GSA_Provider_Old_Flag     := (unsigned2)GSA_Provider_Old_Flag;
		self.Provider.GSA_Provider_Current_Flag := (unsigned2)GSA_Provider_Current_Flag;
		
		self.Provider.GSA_Prov_Recip_24_Curr   := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='Reciprocal' and mth_Action_DT <= 24);
		self.Provider.GSA_Prov_Recip_60_Curr   := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='Reciprocal' and mth_Action_DT <= 60 AND mth_Action_DT > 24);
		self.Provider.GSA_Prov_Recip_61_Curr   := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='Reciprocal' and mth_Action_DT  > 60);
		self.Provider.GSA_Prov_Proc_24_Curr    := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='Procurement' and mth_Action_DT <= 24);
		self.Provider.GSA_Prov_Proc_60_Curr    := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='Procurement' and mth_Action_DT <= 60 AND mth_Action_DT > 24);
		self.Provider.GSA_Prov_Proc_61_Curr    := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='Procurement' and mth_Action_DT  > 60);
		self.Provider.GSA_Prov_NonProc_24_Curr := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='NonProcurement' and mth_Action_DT <= 24);
		self.Provider.GSA_Prov_NonProc_60_Curr := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='NonProcurement' and mth_Action_DT <= 60 AND mth_Action_DT > 24);
		self.Provider.GSA_Prov_NonProc_61_Curr := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='NonProcurement' and mth_Action_DT  > 60);

		self.Provider.GSA_Prov_Recip_24_Old   := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='Reciprocal' and mth_Action_DT <= 24);
		self.Provider.GSA_Prov_Recip_60_Old   := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='Reciprocal' and mth_Action_DT <= 60 AND mth_Action_DT > 24);
		self.Provider.GSA_Prov_Recip_61_Old   := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='Reciprocal' and mth_Action_DT  > 60);
		self.Provider.GSA_Prov_Proc_24_Old    := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='Procurement' and mth_Action_DT <= 24);
		self.Provider.GSA_Prov_Proc_60_Old    := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='Procurement' and mth_Action_DT <= 60 AND mth_Action_DT > 24);
		self.Provider.GSA_Prov_Proc_61_Old    := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='Procurement' and mth_Action_DT  > 60);
		self.Provider.GSA_Prov_NonProc_24_Old := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='NonProcurement' and mth_Action_DT <= 24);
		self.Provider.GSA_Prov_NonProc_60_Old := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='NonProcurement' and mth_Action_DT <= 60 AND mth_Action_DT > 24);
		self.Provider.GSA_Prov_NonProc_61_Old := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='NonProcurement' and mth_Action_DT  > 60);

    SELF := le;
		self := [];
	END;
  
  Layout_Healthcare_Shell_Plus_GSATemp getProviderBDID(healthcare_in le, gsa_bdid ri, ptype provider_type_in) := TRANSFORM
		self.seq         := le.seq;
		self.provider_type := provider_type_in;
		
		ExclusionType := trim(ri.cttype);
		TerminationDate := trim(ri.TermDate);

		Action_DT := models.common.sas_date(ri.ActionDate);
		Term_DT   := models.common.sas_date(TerminationDate);
    sysdate := models.common.sas_date( if(le.clam.historydate IN [999999, 0], (STRING8)Std.Date.Today(), (string)le.clam.historydate+'01'));
		
		mth_Action_DT := if(sysdate = NULL OR action_dt = NULL, null, ROUNDUP((sysdate-Action_DT)/30.5));
		// If the term date is indefinite then this should always be a current record
		mth_Term_DT   := if(StringLib.StringToUpperCase(TRIM(ri.termdateindefinite)) = 'Y', 0, if(sysdate = NULL OR Term_DT = NULL, NULL, ROUNDUP((sysdate-Term_DT)/30.5)));
		
		SELF.ExclusionType := ExclusionType;
		SELF.TerminationDate := TerminationDate;
		SELF.ActionDt := Action_DT;
		SELF.TermDt := Term_DT;
		SELF.mth_action_dt := mth_Action_DT;
		SELF.mth_term_dt := mth_Term_DT;
		SELF.sysdate := sysdate;


		GSA_Provider_Old_Flag     := mth_action_dt > 0 AND ExclusionType in ['Procurement','NonProcurement','Reciprocal'] and mth_Term_DT  > 0;
		GSA_Provider_Current_Flag := mth_action_dt > 0 AND ExclusionType in ['Procurement','NonProcurement','Reciprocal'] and mth_Term_DT <= 0 AND mth_term_dt <> NULL;

		self.Provider.Provider_Hit              := true;
		self.Provider.GSA_Provider_Old_Flag     := (unsigned2)GSA_Provider_Old_Flag;
		self.Provider.GSA_Provider_Current_Flag := (unsigned2)GSA_Provider_Current_Flag;
		
		self.Provider.GSA_Prov_Recip_24_Curr   := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='Reciprocal' and mth_Action_DT <= 24);
		self.Provider.GSA_Prov_Recip_60_Curr   := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='Reciprocal' and mth_Action_DT <= 60 AND mth_Action_DT > 24);
		self.Provider.GSA_Prov_Recip_61_Curr   := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='Reciprocal' and mth_Action_DT  > 60);
		self.Provider.GSA_Prov_Proc_24_Curr    := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='Procurement' and mth_Action_DT <= 24);
		self.Provider.GSA_Prov_Proc_60_Curr    := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='Procurement' and mth_Action_DT <= 60 AND mth_Action_DT > 24);
		self.Provider.GSA_Prov_Proc_61_Curr    := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='Procurement' and mth_Action_DT  > 60);
		self.Provider.GSA_Prov_NonProc_24_Curr := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='NonProcurement' and mth_Action_DT <= 24);
		self.Provider.GSA_Prov_NonProc_60_Curr := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='NonProcurement' and mth_Action_DT <= 60 AND mth_Action_DT > 24);
		self.Provider.GSA_Prov_NonProc_61_Curr := (unsigned2)(GSA_Provider_Current_Flag and mth_Action_DT != NULL and ExclusionType='NonProcurement' and mth_Action_DT  > 60);

		self.Provider.GSA_Prov_Recip_24_Old   := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='Reciprocal' and mth_Action_DT <= 24);
		self.Provider.GSA_Prov_Recip_60_Old   := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='Reciprocal' and mth_Action_DT <= 60 AND mth_Action_DT > 24);
		self.Provider.GSA_Prov_Recip_61_Old   := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='Reciprocal' and mth_Action_DT  > 60);
		self.Provider.GSA_Prov_Proc_24_Old    := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='Procurement' and mth_Action_DT <= 24);
		self.Provider.GSA_Prov_Proc_60_Old    := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='Procurement' and mth_Action_DT <= 60 AND mth_Action_DT > 24);
		self.Provider.GSA_Prov_Proc_61_Old    := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='Procurement' and mth_Action_DT  > 60);
		self.Provider.GSA_Prov_NonProc_24_Old := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='NonProcurement' and mth_Action_DT <= 24);
		self.Provider.GSA_Prov_NonProc_60_Old := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='NonProcurement' and mth_Action_DT <= 60 AND mth_Action_DT > 24);
		self.Provider.GSA_Prov_NonProc_61_Old := (unsigned2)(GSA_Provider_Old_Flag and mth_Action_DT != NULL and ExclusionType='NonProcurement' and mth_Action_DT  > 60);

    SELF := le;
		self := [];
	END;
  providerDID := JOIN(healthcare_in, gsa_did, LEFT.did != 0 AND KEYED(LEFT.did = RIGHT.did), getProviderDID(LEFT, RIGHT, ptype.Individual), KEEP(100), ATMOST(RiskWise.max_atmost));
  providerRelative := JOIN(healthcare_in, gsa_did, COUNT(LEFT.relativesDID) > 0 AND KEYED(RIGHT.did IN SET(LEFT.relativesDID (relativesDID <> 0), relativesDID)), getProviderDID(LEFT, RIGHT, ptype.Relative), KEEP(100), ATMOST(RiskWise.max_atmost));
  providerBDID := JOIN(healthcare_in, gsa_bdid, COUNT(LEFT.bdids) > 0 AND KEYED(RIGHT.bdid IN SET(LEFT.bdids (bdid <> 0), bdid)), getProviderBDID(LEFT, RIGHT, ptype.Business), KEEP(100), ATMOST(RiskWise.max_atmost));
  providerCorpAffil := JOIN(healthcare_in, gsa_bdid, COUNT(LEFT.bdids_corpaffil) > 0 AND KEYED(RIGHT.bdid IN SET(LEFT.bdids_corpaffil (bdids_corpaffil <> 0), bdids_corpaffil)), getProviderBDID(LEFT, RIGHT, ptype.CorpAffil), KEEP(100), ATMOST(RiskWise.max_atmost));
  providerRelativeCorpAffil := JOIN(healthcare_in, gsa_bdid, COUNT(LEFT.relativesbdids_corpaffil) > 0 AND KEYED(RIGHT.bdid IN SET(LEFT.relativesbdids_corpaffil (relativesbdids_corpaffil <> 0), relativesbdids_corpaffil)), getProviderBDID(LEFT, RIGHT, ptype.Rel_CorpAffil), KEEP(100), ATMOST(RiskWise.max_atmost));
	gotProvider := PROJECT(providerDID + providerRelative + providerBDID + providerCorpAffil + providerRelativeCorpAffil, TRANSFORM(Layout_Healthcare_Shell_Plus, SELF := LEFT));

	Layout_Healthcare_Shell_Plus rollProvider(Layout_Healthcare_Shell_Plus le, Layout_Healthcare_Shell_Plus ri) := TRANSFORM
		self.Provider.Provider_Hit              := true;
		self.Provider.GSA_Provider_Old_Flag     := le.Provider.GSA_Provider_Old_Flag     + ri.Provider.GSA_Provider_Old_Flag;
		self.Provider.GSA_Provider_Current_Flag := le.Provider.GSA_Provider_Current_Flag + ri.Provider.GSA_Provider_Current_Flag;

		self.Provider.GSA_Prov_Recip_24_Curr    := le.Provider.GSA_Prov_Recip_24_Curr   + ri.Provider.GSA_Prov_Recip_24_Curr;
		self.Provider.GSA_Prov_Recip_60_Curr    := le.Provider.GSA_Prov_Recip_60_Curr   + ri.Provider.GSA_Prov_Recip_60_Curr;
		self.Provider.GSA_Prov_Recip_61_Curr    := le.Provider.GSA_Prov_Recip_61_Curr   + ri.Provider.GSA_Prov_Recip_61_Curr;
		self.Provider.GSA_Prov_Proc_24_Curr     := le.Provider.GSA_Prov_Proc_24_Curr    + ri.Provider.GSA_Prov_Proc_24_Curr;
		self.Provider.GSA_Prov_Proc_60_Curr     := le.Provider.GSA_Prov_Proc_60_Curr    + ri.Provider.GSA_Prov_Proc_60_Curr;
		self.Provider.GSA_Prov_Proc_61_Curr     := le.Provider.GSA_Prov_Proc_61_Curr    + ri.Provider.GSA_Prov_Proc_61_Curr;
		self.Provider.GSA_Prov_NonProc_24_Curr  := le.Provider.GSA_Prov_NonProc_24_Curr + ri.Provider.GSA_Prov_NonProc_24_Curr;
		self.Provider.GSA_Prov_NonProc_60_Curr  := le.Provider.GSA_Prov_NonProc_60_Curr + ri.Provider.GSA_Prov_NonProc_60_Curr;
		self.Provider.GSA_Prov_NonProc_61_Curr  := le.Provider.GSA_Prov_NonProc_61_Curr + ri.Provider.GSA_Prov_NonProc_61_Curr;

		self.Provider.GSA_Prov_Recip_24_Old     := le.Provider.GSA_Prov_Recip_24_Old   + ri.Provider.GSA_Prov_Recip_24_Old;
		self.Provider.GSA_Prov_Recip_60_Old     := le.Provider.GSA_Prov_Recip_60_Old   + ri.Provider.GSA_Prov_Recip_60_Old;
		self.Provider.GSA_Prov_Recip_61_Old     := le.Provider.GSA_Prov_Recip_61_Old   + ri.Provider.GSA_Prov_Recip_61_Old;
		self.Provider.GSA_Prov_Proc_24_Old      := le.Provider.GSA_Prov_Proc_24_Old    + ri.Provider.GSA_Prov_Proc_24_Old;
		self.Provider.GSA_Prov_Proc_60_Old      := le.Provider.GSA_Prov_Proc_60_Old    + ri.Provider.GSA_Prov_Proc_60_Old;
		self.Provider.GSA_Prov_Proc_61_Old      := le.Provider.GSA_Prov_Proc_61_Old    + ri.Provider.GSA_Prov_Proc_61_Old;
		self.Provider.GSA_Prov_NonProc_24_Old   := le.Provider.GSA_Prov_NonProc_24_Old + ri.Provider.GSA_Prov_NonProc_24_Old;
		self.Provider.GSA_Prov_NonProc_60_Old   := le.Provider.GSA_Prov_NonProc_60_Old + ri.Provider.GSA_Prov_NonProc_60_Old;
		self.Provider.GSA_Prov_NonProc_61_Old   := le.Provider.GSA_Prov_NonProc_61_Old + ri.Provider.GSA_Prov_NonProc_61_Old;

		self := le;
	END;
	rolledProvider := rollup(gotProvider, left.seq=right.seq and left.provider_type = right.provider_type, rollProvider(left,right));

	Layout_Healthcare_Shell_Plus cleanupProvider(Layout_Healthcare_Shell_Plus le) := TRANSFORM
		emptyRow := row( [], Layout_Healthcare_Shell_Plus.provider );
		self.provider               := if(le.provider_type = ptype.Individual, le.provider, emptyRow);
		self.ran_provider           := if(le.provider_type = ptype.Relative, le.provider, emptyRow);
		self.bus_provider           := if(le.provider_type = ptype.Business, le.provider, emptyRow);
		self.corpaffil_provider     := if(le.provider_type = ptype.CorpAffil, le.provider, emptyRow);
		self.RAN_CorpAffil_Provider := if(le.provider_type = ptype.Rel_CorpAffil, le.provider, emptyRow);
		self := le;
	END;
	cleanedProvider := project(rolledProvider, cleanupProvider(left));
	
	Layout_Healthcare_Shell_Plus finishProvider( Layout_Healthcare_Shell_Plus le, Layout_Healthcare_Shell_Plus ri ) := TRANSFORM
		self.provider               := if( ri.provider_type=ptype.Individual, ri.provider,               le.provider               );
		self.ran_provider           := if( ri.provider_type=ptype.Relative,   ri.ran_provider,           le.ran_provider           );
		self.bus_provider           := if( ri.provider_type=ptype.Business,   ri.bus_provider,           le.bus_provider           );
		self.corpaffil_provider     := if( ri.provider_type=ptype.CorpAffil,  ri.corpaffil_provider,     le.corpaffil_provider     );
		self.ran_corpaffil_provider := if( ri.provider_type=ptype.CorpAffil,  ri.ran_corpaffil_provider, le.ran_corpaffil_provider );
		self := le;
	END;
	final_provider := rollup( cleanedProvider, left.seq=right.seq, finishProvider(left,right) );

  // criminal
	key_offenders := doxie_files.Key_Offenders();
	key_offenses := doxie_files.Key_Offenses();
	key_court_offenses := doxie_files.Key_Court_Offenses(false);
	key_incarceration := doxie_files.Key_Punishment();
  Layout_Healthcare_Shell_Plus getOffender(healthcare_in le, key_offenders ri, ptype provider_type_in) := TRANSFORM
    self.seq := le.seq;
		self.provider_type := provider_type_in;
    self.offender_key := ri.offender_key;
		self.datasource   := trim(ri.datasource);
		
		self.source := (STRING)ri.sdid;

    SELF := le;
    self := [];
  END;

	// Criminal Court records go to doxie_files.Key_Court_Offenses; Department of Corrections go to doxie_files.Key_Offenses
  offenderDID := DEDUP(SORT(JOIN(healthcare_in, key_offenders, left.did != 0 and keyed(left.did=right.sdid) and TRIM(StringLib.StringToUpperCase(RIGHT.datasource)) != 'ARREST LOG', getOffender(left, right, ptype.Individual), KEEP(3000), ATMOST(3000)), seq, provider_type, offender_key, source), seq, provider_type, offender_key, source);
  offenderRelativeDID := DEDUP(SORT(JOIN(healthcare_in, key_offenders, COUNT(LEFT.relativesDID) > 0 AND KEYED(RIGHT.sdid IN SET(LEFT.relativesDID (relativesDID <> 0), relativesDID)) and TRIM(StringLib.StringToUpperCase(RIGHT.datasource)) != 'ARREST LOG', getOffender(left, right, ptype.Relative), KEEP(3000), ATMOST(3000)), seq, provider_type, offender_key, source), seq, provider_type, offender_key, source);
  
  Layout_HealthCare_Shell_Plus_Crim := RECORD
    Layout_HealthCare_Shell_Plus;
		// Offense Key
		string8		process_date;
		string2		vendor;
		string30	county_of_origin;
		string20	source_file;
		string1		data_type;
		string2		record_type := '';
		string2		orig_state;
		string50	offense_key;
		string8		off_date:='';
		string8		arr_date:='';
		string35	case_num:='';
		string3		total_num_of_offenses:='';
		string3		num_of_counts:='';
		string20	off_code:='';
		string31	chg:='';
		string1		chg_typ_flg:='';
		string4 	off_of_record;
		string75	off_desc_1:='';
		string50	off_desc_2:='';
		string2		add_off_cd:='';
		string30	add_off_desc:='';
		string1		off_typ:='';
		string5		off_lev:='';
		string8		arr_disp_date:='';
		string3		arr_disp_cd:='';
		string50	arr_disp_desc_1:='';
		string50	arr_disp_desc_2:='';
		string50	arr_disp_desc_3:='';
		string5		court_cd:='';
		string40	court_desc:='';
		string40	ct_dist:='';
		string1		ct_fnl_plea_cd:='';
		string30	ct_fnl_plea:='';
		string8		ct_off_code:='';
		string17	ct_chg:='';
		string1		ct_chg_typ_flg:='';
		string50	ct_off_desc_1:='';
		string50	ct_off_desc_2:='';
		string1		ct_addl_desc_cd:='';
		string2		ct_off_lev:='';
		string8		ct_disp_dt:='';
		string4		ct_disp_cd:='';
		string50	ct_disp_desc_1:='';
		string50	ct_disp_desc_2:='';
		string2		cty_conv_cd:='';
		string30	cty_conv:='';
		string1		adj_wthd:='';
		string8		stc_dt:='';
		string3		stc_cd:='';
		string3		stc_comp:='';
		string50	stc_desc_1:='';
		string50	stc_desc_2:='';
		string50	stc_desc_3:='';
		string50	stc_desc_4:='';
		string15	stc_lgth:='';
		string50	stc_lgth_desc:='';
		string8		inc_adm_dt:='';
		string10	min_term:='';
		string35	min_term_desc:='';
		string10	max_term:='';
		string35	max_term_desc:='';
		string50  Parole:='';
		String50  Probation:='';
		String40  OffenseTown:='';
		String8   Convict_dt:=''; 
		string40  Court_County:='';
		string60 	fcra_offense_key:='';
		string1 	fcra_conviction_flag:='';
		string1 	fcra_traffic_flag:='';
		string8 	fcra_date:='';
		string1 	fcra_date_type:='';
		string8 	conviction_override_date:='';
		string1 	conviction_override_date_type:='';
		string2 	offense_score:='';
		STRING100	court_disp_desc_1 := '';
		STRING100	court_disp_desc_2 := '';
		unsigned8	offense_persistent_id := 0;
		STRING100 sent_agency_rec_cust := '';
		STRING100 court_final_plea := '';
		STRING10 sent_addl_prov_code := '';
		STRING25 offense_town := '';
		STRING10 sent_probation := '';
		STRING10 sent_court_fine := '';
		STRING10 sent_court_cost := '';
		STRING8 sent_date := '';
		
		STRING2 state_origin := '';
		STRING4 off_comp := '';
		STRING1 off_delete_flag := '';
		STRING10 le_agency_cd := '';
		STRING50 le_agency_desc := '';
		STRING35 le_agency_case_number := '';
		STRING35 traffic_ticket_number := '';
		STRING25 traffic_dl_no := '';
		STRING2 traffic_dl_st := '';
		STRING20 arr_off_code := '';
		STRING75 arr_off_desc_1 := '';
		STRING50 arr_off_desc_2 := '';
		STRING5 arr_off_type_cd := '';
		STRING30 arr_off_type_desc := '';
		STRING5 arr_off_lev := '';
		STRING20 arr_statute := '';
		STRING70 arr_statute_desc := '';
		STRING5 arr_disp_code := '';
		STRING10 pros_refer_cd := '';
		STRING50 pros_refer := '';
		STRING10 pros_assgn_cd := '';
		STRING50 pros_assgn := '';
		STRING1 pros_chg_rej := '';
		STRING20 pros_off_code := '';
		STRING75 pros_off_desc_1 := '';
		STRING50 pros_off_desc_2 := '';
		STRING5 pros_off_type_cd := '';
		STRING30 pros_off_type_desc := '';
		STRING5 pros_off_lev := '';
		STRING30 pros_act_filed := '';
		STRING35 court_case_number := '';
		STRING1 court_appeal_flag := '';
		STRING20 court_off_code := '';
		STRING75 court_off_desc_1 := '';
		STRING50 court_off_desc_2 := '';
		STRING5 court_off_type_cd := '';
		STRING30 court_off_type_desc := '';
		STRING5 court_off_lev := '';
		STRING20 court_statute := '';
		STRING50 court_additional_statutes := '';
		STRING70 court_statute_desc := '';
		STRING8 court_disp_date := '';
		STRING5 court_disp_code := '';
		STRING50 sent_jail := '';
		STRING50 sent_susp_time := '';
		STRING9 sent_susp_court_fine := '';
		STRING40 sent_addl_prov_desc_1 := '';
		STRING40 sent_addl_prov_desc_2 := '';
		STRING2 sent_consec := '';
		STRING10 sent_agency_rec_cust_ori := '';
		STRING8 appeal_date := '';
		STRING40 appeal_off_disp := '';
		STRING40 appeal_final_decision := '';
		STRING12 restitution := '';
		STRING30 community_service := '';
		STRING30 addl_sent_dates := '';
		STRING60 probation_desc2 := '';
		STRING8 court_dt := '';
		STRING35 arr_off_lev_mapped := '';
		STRING35 court_off_lev_mapped := '';
		
    STRING100 offense := '';
    STRING100 offense_category1 := '';
    STRING100 offense_category2 := '';
    STRING100 offense_category3 := '';
    BOOLEAN minor_offense1 := FALSE;
    BOOLEAN minor_offense2 := FALSE;
    BOOLEAN minor_offense3 := FALSE;
    REAL8 mth_stc_date := 0.0;
    BOOLEAN Dont_Count1 := FALSE;
    BOOLEAN Dont_Count2 := FALSE;
    BOOLEAN Dont_Count3 := FALSE;
    BOOLEAN Crim_Offense_121_Flag1 := FALSE;
    BOOLEAN Crim_Offense_121_Flag2 := FALSE;
    BOOLEAN Crim_Offense_121_Flag3 := FALSE;
    BOOLEAN Crim_Offense_61_Flag1 := FALSE;
    BOOLEAN Crim_Offense_61_Flag2 := FALSE;
    BOOLEAN Crim_Offense_61_Flag3 := FALSE;
    BOOLEAN Crim_Offense_60_Flag1 := FALSE;
    BOOLEAN Crim_Offense_60_Flag2 := FALSE;
    BOOLEAN Crim_Offense_60_Flag3 := FALSE;
    BOOLEAN Crim_Offense_24_Flag1 := FALSE;
    BOOLEAN Crim_Offense_24_Flag2 := FALSE;
    BOOLEAN Crim_Offense_24_Flag3 := FALSE;
  END;
  
  Layout_Healthcare_Shell_Plus_Crim getOffenses(Layout_Healthcare_Shell_Plus le, key_offenses ri) := TRANSFORM
    self.seq := le.seq;
		self.provider_type := le.provider_type;

		disp := StringLib.StringToUpperCase(ri.ct_disp_desc_1);
		self.Sentence := disp;
		
		self.guilty :=
			   ( Models.Common.contains( disp, 'GUILT' )   and not Models.Common.contains( disp, ' NOT ' ) )
			or ( Models.Common.contains( disp, 'CONVICT' ) and not Models.Common.contains( disp, ' NOT ' ) )
		;
		self.offense_desc_1 := StringLib.StringToUpperCase(trim(ri.off_desc_1));
		self.offense_desc_2 := StringLib.StringToUpperCase(trim(ri.off_desc_2));
		self.offense_desc_3 := StringLib.StringToUpperCase(trim(ri.add_off_desc));
		self.stc_date       := (integer4)(ri.stc_dt);
    
		SELF := ri;
		SELF := le;
		self := [];
	END;

  Layout_Healthcare_Shell_Plus_Crim getCourtOffenses(Layout_Healthcare_Shell_Plus le, key_court_offenses ri) := TRANSFORM
    self.seq := le.seq;
		self.provider_type := le.provider_type;
		
		disp := StringLib.StringToUpperCase(ri.court_disp_desc_1);

		self.Sentence := disp;
		guilty := (Models.Common.contains(disp, 'GUILT') and not Models.Common.contains(disp, ' NOT '))
							or (Models.Common.contains(disp, 'CONVICT') and not Models.Common.contains(disp, ' NOT '));
		self.guilty := guilty;
			   
    
    offense_desc_1 := StringLib.StringToUpperCase(trim(ri.court_off_desc_1));
    offense_desc_2 := StringLib.StringToUpperCase(trim(ri.court_statute_desc));
    offense_desc_3 := StringLib.StringToUpperCase(trim(ri.sent_addl_prov_desc_1));
		self.offense_desc_1 := offense_desc_1;
		self.offense_desc_2 := offense_desc_2;
		self.offense_desc_3 := '';

		self.stc_date := IF((integer4) ri.sent_date > 0, (integer4)ri.sent_date, (integer4) ri.court_disp_date);
		// self.stc_date := IF(le.provider_type = ptype.Individual /* OR guilty */, IF((integer4) ri.sent_date > 0, (integer4)ri.sent_date, (integer4) ri.court_disp_date), -1);
    
		SELF := ri;
    SELF := le;
    self := [];
	END;
  offenderOffensesDID := join(offenderDID, key_offenses, keyed(left.offender_key=right.ok), getOffenses(left,right), KEEP(4000), ATMOST(5000));
	offenderOffensesRel := join(offenderRelativeDID, key_offenses, keyed(left.offender_key=right.ok), getOffenses(left,right), KEEP(4000), ATMOST(5000));
	offenderOffenses := offenderOffensesDID + offenderOffensesRel;
  
	offenderCourtOffensesDID := join(offenderDID, Key_Court_Offenses, keyed(left.offender_key=right.ofk), getCourtOffenses(left,right), KEEP(4000), ATMOST(5000));
	offenderCourtOffensesRel := join(offenderRelativeDID, Key_Court_Offenses, keyed(left.offender_key=right.ofk), getCourtOffenses(left,right), KEEP(4000), ATMOST(5000));
	offenderCourtOffenses := offenderCourtOffensesDID + offenderCourtOffensesRel;
	// Basically want to do a DEDUP RECORD, but with so many fields in the Healthcare Shell it is more efficient to list the criminal fields explicitly.
	gotOffensesSort := SORT((offenderOffenses + offenderCourtOffenses), 	seq, provider_type, offender_key, -stc_date, -guilty, offense_desc_1, offense_desc_2, offense_desc_3, process_date, vendor, county_of_origin, source_file, data_type, record_type, orig_state, offense_key, off_date, arr_date, case_num, total_num_of_offenses, num_of_counts, off_code, chg, chg_typ_flg, off_of_record, off_desc_1, off_desc_2, add_off_cd, add_off_desc, off_typ, off_lev, arr_disp_date, arr_disp_cd, arr_disp_desc_1, arr_disp_desc_2, arr_disp_desc_3, court_cd, court_desc, ct_dist, ct_fnl_plea_cd, ct_fnl_plea, ct_off_code, ct_chg, ct_chg_typ_flg, ct_off_desc_1, ct_off_desc_2, ct_addl_desc_cd, ct_off_lev, ct_disp_dt, ct_disp_cd, ct_disp_desc_1, ct_disp_desc_2, cty_conv_cd, cty_conv, adj_wthd, stc_dt, stc_cd, stc_comp, stc_desc_1, stc_desc_2, stc_desc_3, stc_desc_4, stc_lgth, stc_lgth_desc, inc_adm_dt, min_term, min_term_desc, max_term, max_term_desc, Parole, Probation, OffenseTown, Convict_dt, Court_County, fcra_offense_key, fcra_conviction_flag, fcra_traffic_flag, fcra_date, fcra_date_type, conviction_override_date, conviction_override_date_type, offense_score, court_disp_desc_1, court_disp_desc_2, offense_persistent_id, source, sent_agency_rec_cust, sent_probation, sent_court_fine, sent_court_cost, sent_date, sent_addl_prov_code, offense_town, state_origin, off_comp, off_delete_flag, le_agency_cd, le_agency_desc, le_agency_case_number, traffic_ticket_number, traffic_dl_no, traffic_dl_st, arr_off_code, arr_off_desc_1, arr_off_desc_2, arr_off_type_cd, arr_off_type_desc, arr_off_lev, arr_statute, arr_statute_desc, arr_disp_code, pros_refer_cd, pros_refer, pros_assgn_cd, pros_assgn, pros_chg_rej, pros_off_code, pros_off_desc_1, pros_off_desc_2, pros_off_type_cd, pros_off_type_desc, pros_off_lev, pros_act_filed, court_case_number, court_appeal_flag, court_off_code, court_off_desc_1, court_off_desc_2, court_off_type_cd, court_off_type_desc, court_off_lev, court_statute, court_additional_statutes, court_statute_desc, court_disp_date, court_disp_code, sent_jail, sent_susp_time, sent_susp_court_fine, sent_addl_prov_desc_1, sent_addl_prov_desc_2, sent_consec, sent_agency_rec_cust_ori, appeal_date, appeal_off_disp, appeal_final_decision, restitution, community_service, addl_sent_dates, probation_desc2, court_dt, arr_off_lev_mapped, court_off_lev_mapped, court_final_plea);
	gotOffenses := DEDUP(gotOffensesSort,																	seq, provider_type, offender_key,  stc_date,  guilty, offense_desc_1, offense_desc_2, offense_desc_3, process_date, vendor, county_of_origin, source_file, data_type, record_type, orig_state, offense_key, off_date, arr_date, case_num, total_num_of_offenses, num_of_counts, off_code, chg, chg_typ_flg, off_of_record, off_desc_1, off_desc_2, add_off_cd, add_off_desc, off_typ, off_lev, arr_disp_date, arr_disp_cd, arr_disp_desc_1, arr_disp_desc_2, arr_disp_desc_3, court_cd, court_desc, ct_dist, ct_fnl_plea_cd, ct_fnl_plea, ct_off_code, ct_chg, ct_chg_typ_flg, ct_off_desc_1, ct_off_desc_2, ct_addl_desc_cd, ct_off_lev, ct_disp_dt, ct_disp_cd, ct_disp_desc_1, ct_disp_desc_2, cty_conv_cd, cty_conv, adj_wthd, stc_dt, stc_cd, stc_comp, stc_desc_1, stc_desc_2, stc_desc_3, stc_desc_4, stc_lgth, stc_lgth_desc, inc_adm_dt, min_term, min_term_desc, max_term, max_term_desc, Parole, Probation, OffenseTown, Convict_dt, Court_County, fcra_offense_key, fcra_conviction_flag, fcra_traffic_flag, fcra_date, fcra_date_type, conviction_override_date, conviction_override_date_type, offense_score, court_disp_desc_1, court_disp_desc_2, offense_persistent_id, source, sent_agency_rec_cust, sent_probation, sent_court_fine, sent_court_cost, sent_date, sent_addl_prov_code, offense_town, state_origin, off_comp, off_delete_flag, le_agency_cd, le_agency_desc, le_agency_case_number, traffic_ticket_number, traffic_dl_no, traffic_dl_st, arr_off_code, arr_off_desc_1, arr_off_desc_2, arr_off_type_cd, arr_off_type_desc, arr_off_lev, arr_statute, arr_statute_desc, arr_disp_code, pros_refer_cd, pros_refer, pros_assgn_cd, pros_assgn, pros_chg_rej, pros_off_code, pros_off_desc_1, pros_off_desc_2, pros_off_type_cd, pros_off_type_desc, pros_off_lev, pros_act_filed, court_case_number, court_appeal_flag, court_off_code, court_off_desc_1, court_off_desc_2, court_off_type_cd, court_off_type_desc, court_off_lev, court_statute, court_additional_statutes, court_statute_desc, court_disp_date, court_disp_code, sent_jail, sent_susp_time, sent_susp_court_fine, sent_addl_prov_desc_1, sent_addl_prov_desc_2, sent_consec, sent_agency_rec_cust_ori, appeal_date, appeal_off_disp, appeal_final_decision, restitution, community_service, addl_sent_dates, probation_desc2, court_dt, arr_off_lev_mapped, court_off_lev_mapped, court_final_plea);
  
  STRING25 getOffense (STRING offense) := MAP(
			Models.Common.Contains( offense ,'FELONY')                                                => 'FELONY',
			Models.Common.Contains( offense ,'MURDER')                                                => 'MURDER',
			Models.Common.Contains( offense ,'ASSAULT')                                               => 'ASSAULT',
			Models.Common.Contains( offense ,'ASSLT')                                                 => 'ASSAULT',
			Models.Common.Contains( offense ,'ASLT')                                                  => 'ASSAULT',
			Models.Common.Contains( offense ,'BATTERY')                                               => 'ASSAULT',
			Models.Common.Contains( offense ,'ROBBERY')                                               => 'ROBBERY',
			Models.Common.Contains( offense ,'ROBB')                                                  => 'ROBBERY',

			Models.Common.Contains( offense ,'BURGLARY')                                              => 'BURGLARY',
			Models.Common.Contains( offense ,'BURG')                                                  => 'BURGLARY',
			Models.Common.Contains( offense ,'THEFT')                                                 => 'THEFT',
			Models.Common.Contains( offense ,'FRAUD')                                                 => 'FRAUD',

			Models.Common.Contains( offense ,'SHOPLIFT')                                              => 'BURGLARY',
			Models.Common.Contains( offense ,'LARC')                                                  => 'BURGLARY',
			Models.Common.Contains( offense ,'REC' )
				and Models.Common.Contains( offense ,'STOLEN')                                          => 'BURGLARY',
			Models.Common.Contains( offense ,'CRIM' )
				and Models.Common.Contains( offense ,'MISC')                                            => 'BURGLARY',

			Models.Common.Contains( offense ,'FORG')                                                  => 'FORGERY',
			Models.Common.Contains( offense ,'CAPIAS')                                                => 'ARREST',
			Models.Common.Contains( offense ,'ARREST')                                                => 'ARREST',
			Models.Common.Contains( offense ,'BOOKED')                                                => 'ARREST',
			Models.Common.Contains( offense ,'CHILD' )
				and Models.Common.Contains( offense ,'ABUS')                                            => 'CHILD ABUSE',
			Models.Common.Contains( offense ,'SEX')                                                   => 'SEX CRIME',
			Models.Common.Contains( offense ,'LEWD')                                                  => 'SEX CRIME',
			Models.Common.Contains( offense ,'PROST')                                                 => 'SEX CRIME',
			Models.Common.Contains( offense ,'MISDEMEANOR')                                           => 'MISDEMEANOR',
			Models.Common.Contains( offense ,'DRIV')
				and Models.Common.Contains( offense ,'SUSP')                                            => 'DWLS',
			Models.Common.Contains( offense ,'DRIV')
				and Models.Common.Contains( offense ,'REVOKE')                                          => 'DWLS',
			Models.Common.Contains( offense ,'DR')
				and Models.Common.Contains( offense ,'LIC')
				and Models.Common.Contains( offense ,'REVOC')                                           => 'DWLS',
			Models.Common.Contains( offense ,'DWLS')                                                  => 'DWLS',
			Models.Common.Contains( offense ,'DWLR')                                                  => 'DWLS',
			Models.Common.Contains( offense ,'DRIV')
							and Models.Common.Contains( offense ,'INTOX')                                     => 'DUI',
			Models.Common.Contains( offense ,'IMPAIRED')                                              => 'DUI',
			Models.Common.Contains( offense ,'INTOXICATED')                                           => 'DUI',
			Models.Common.Contains( offense ,'INFLUENCE')                                             => 'DUI',
			Models.Common.Contains( offense ,'DUI')                                                   => 'DUI',
			Models.Common.Contains( offense ,'D.U.I.')                                                => 'DUI',
			Models.Common.Contains( offense ,'DWI')                                                   => 'DUI',
			Models.Common.Contains( offense ,'DRUGS')                                                 => 'CONTROLLED SUBSTANCE',
			Models.Common.Contains( offense ,'DRUG')                                                  => 'CONTROLLED SUBSTANCE',
			Models.Common.Contains( offense ,'COCAINE')                                               => 'CONTROLLED SUBSTANCE',
			Models.Common.Contains( offense ,'MARIJUANA')                                             => 'CONTROLLED SUBSTANCE',
			Models.Common.Contains( offense ,'MARIHUANA')                                             => 'CONTROLLED SUBSTANCE',
			Models.Common.Contains( offense ,'POSS')                                                  => 'CONTROLLED SUBSTANCE',
			Models.Common.Contains( offense ,'SUBSTANCE')                                             => 'CONTROLLED SUBSTANCE',
			Models.Common.Contains( offense ,'CANNABIS')                                              => 'CONTROLLED SUBSTANCE',
			Models.Common.Contains( offense ,'WEAPON')                                                => 'WEAPON',
			Models.Common.Contains( offense ,'FIREARM')                                               => 'WEAPON',
			Models.Common.Contains( offense ,'HARASS')                                                => 'HARASSMENT',
			Models.Common.Contains( offense ,'STALK')                                                 => 'HARASSMENT',
			Models.Common.Contains( offense ,'TERROR')                                                => 'HARASSMENT',
			Models.Common.Contains( offense ,'THREAT')                                                => 'HARASSMENT',
			Models.Common.Contains( offense ,'PROP')
				and Models.Common.Contains( offense ,'DAMAGE')                                          => 'PROPERTY DAMAGE',
      /* Miscellaneous Red */
			Models.Common.Contains( offense ,'LAUND')                                                 => 'RED-MISC',           /* Money Laundering          */
			Models.Common.Contains( offense ,'CONSP')                                                 => 'RED-MISC',           /* Consipiracy               */
			Models.Common.Contains( offense ,'KITING')                                                => 'RED-MISC',           /* Check Kiting              */
			Models.Common.Contains( offense ,'ELDER')                                                 => 'RED-MISC',           /* Elder Abuse               */
			Models.Common.Contains( offense ,'ABUSE')
				and Models.Common.Contains( offense ,'DISAB')                                           => 'RED-MISC',           /* Abuse of Disabled Persons */
			Models.Common.Contains( offense ,'TRAFFIC')                                               => 'TRAFFIC',
			Models.Common.Contains( offense ,'INFRACTION')                                            => 'TRAFFIC',
			trim(offense[1..3]) in ['SP','RD','RD-','RD/','SP.','SPD','R/D']                          => 'TRAFFIC',
			offense[1..4] = 'R.D.'                                                                    => 'TRAFFIC',
			offense[1] in [ '1', '2', '3', '4', '5', '6', '7', '8', '9' ]
				and Models.Common.Contains( offense ,'/')
				and Models.Common.Contains( offense ,'SP')                                              => 'TRAFFIC',
			Models.Common.Contains( offense ,'SPEED')                                                 => 'TRAFFIC',
			Models.Common.Contains( offense ,'BELT')                                                  => 'TRAFFIC',
			Models.Common.Contains( offense ,'RECKLESS')                                              => 'TRAFFIC',
			Models.Common.Contains( offense ,'HIGHWAY')                                               => 'TRAFFIC',
			Models.Common.Contains( offense ,'VEHICLE')                                               => 'TRAFFIC',
			Models.Common.Contains( offense ,'VIOLATION')                                             => 'TRAFFIC',
			Models.Common.Contains( offense ,'IMPROP')                                                => 'TRAFFIC',
			Models.Common.Contains( offense ,'PASS')                                                  => 'TRAFFIC',
			Models.Common.Contains( offense ,'CARELESS')
				and Models.Common.Contains( offense ,'DRIV')                                            => 'TRAFFIC',
			Models.Common.Contains( offense ,'FOLLOW')
				and Models.Common.Contains( offense ,'CLOSE')                                           => 'TRAFFIC',
			Models.Common.Contains( offense ,'EXP')
				and Models.Common.Contains( offense ,'REG')                                             => 'TRAFFIC',
			Models.Common.Contains( offense ,'FAIL')
				and Models.Common.Contains( offense ,'STOP')                                            => 'TRAFFIC',
			Models.Common.Contains( offense ,'FAIL')
				and Models.Common.Contains( offense ,'YIELD')                                           => 'TRAFFIC',
			Models.Common.Contains( offense ,'DISORD')                                                => 'DISORDERLY',
			Models.Common.Contains( offense ,'PARKING')                                               => 'PARKING',
			Models.Common.Contains( offense ,'PARK')
				and Models.Common.Contains( offense ,'VIOL')                                            => 'PARKING',
			Models.Common.Contains( offense ,'TCATS')                                                 => 'PARKING',
			Models.Common.Contains( offense ,'CHECK')                                                 => 'BAD CHECK',
			Models.Common.Contains( offense ,'TRES')                                                  => 'TRESPASSING',
			Models.Common.Contains( offense ,'BREAK')
				and Models.Common.Contains( offense ,'ENTER')                                           => 'BREAK-ENTER',
			Models.Common.Contains( offense ,'ALC')                                                   => 'ALCOHOL',
			Models.Common.Contains( offense ,'CONSUM')                                                => 'ALCOHOL',
			Models.Common.Contains( offense ,'CARRY')
				and Models.Common.Contains( offense ,'OPEN')                                            => 'ALCOHOL',
			Models.Common.Contains( offense ,'CONTAIN')
				and Models.Common.Contains( offense ,'OPEN')                                            => 'ALCOHOL',
			Models.Common.Contains( offense ,'PUBLIC')
				and Models.Common.Contains( offense ,'INTOX')                                           => 'ALCOHOL',
			Models.Common.Contains( offense ,'FLEE')                                                  => 'RESIST ARREST',
			Models.Common.Contains( offense ,'RESIST')                                                => 'RESIST ARREST',
      offense = ''                                                                              => 'Blank',
			// 'OTHER'
			''
		);

   
  Layout_Healthcare_Shell_Plus_Crim countOffenses(Layout_HealthCare_Shell_Plus_Crim le) := TRANSFORM
		self.seq := le.seq;
		self.provider_type := le.provider_type;
    
    sysdate := models.common.sas_date( if(le.clam.historydate IN [999999, 0], (STRING8)Std.Date.Today(), (string)le.clam.historydate+'01'));
		sasStc_Date := IF(le.stc_date <> -1, Models.common.sas_date((STRING)le.stc_date), NULL);
		mth_stc_date := if(sysdate = NULL OR sasStc_Date = NULL, NULL, ROUNDUP((sysdate - sasStc_Date) / 30.5));
		
		offense_category1 := getOffense(TRIM(le.offense_desc_1));
    offense_category2 := getOffense(TRIM(le.offense_desc_2));
    offense_category3 := getOffense(TRIM(le.offense_desc_3));

    minor_offenses := ['OTHER','TRAFFIC','PARKING','MISDEMEANOR','PROPERTY DAMAGE','DISORDERLY','TRESPASSING','ALCOHOL','RESIST ARREST','BAD CHECK'];

		minor_offense1 := offense_category1 in minor_offenses;
		minor_offense2 := offense_category2 in minor_offenses;
		minor_offense3 := offense_category3 in minor_offenses;
    
    datasource_dont_count := (StringLib.StringToUpperCase(TRIM(le.datasource)) = 'ARREST LOG') OR
                  (StringLib.StringToUpperCase(TRIM(le.datasource)) = 'CRIMINAL COURT' AND NOT le.guilty) OR
                  (StringLib.StringToUpperCase(TRIM(le.datasource)) = '');
    
		Dont_Count1 := datasource_dont_count OR
                  (StringLib.StringToUpperCase(offense_category1) in ['ARREST','BLANK']) OR
                  (mth_stc_date = NULL) OR
                  (mth_stc_date >= 121 AND minor_offense1);
    Dont_Count2 := datasource_dont_count OR
                  (StringLib.StringToUpperCase(offense_category2) in ['ARREST','BLANK']) OR
                  (mth_stc_date = NULL) OR
                  (mth_stc_date >= 121 AND minor_offense2);
    Dont_Count3 := datasource_dont_count OR
                  (StringLib.StringToUpperCase(offense_category3) in ['ARREST','BLANK']) OR
                  (mth_stc_date = NULL) OR
                  (mth_stc_date >= 121 AND minor_offense3);
		
		Crim_Offense_121_flag1 := not Dont_Count1 and mth_stc_date >= 121;                       /* 10+   Years                   */
		Crim_Offense_121_flag2 := not Dont_Count2 and mth_stc_date >= 121;                       /* 10+   Years                   */
		Crim_Offense_121_flag3 := not Dont_Count3 and mth_stc_date >= 121;                       /* 10+   Years                   */
		Crim_Offense_61_flag1  := not Dont_Count1 and mth_stc_date >= 61 and mth_stc_date < 121; /* 5+    Years                   */
		Crim_Offense_61_flag2  := not Dont_Count2 and mth_stc_date >= 61 and mth_stc_date < 121; /* 5+    Years                   */
		Crim_Offense_61_flag3  := not Dont_Count3 and mth_stc_date >= 61 and mth_stc_date < 121; /* 5+    Years                   */
		Crim_Offense_60_flag1  := not Dont_Count1 and mth_stc_date >= 25 and mth_stc_date <  61; /* 3 - 5 Years                   */
		Crim_Offense_60_flag2  := not Dont_Count2 and mth_stc_date >= 25 and mth_stc_date <  61; /* 3 - 5 Years                   */
		Crim_Offense_60_flag3  := not Dont_Count3 and mth_stc_date >= 25 and mth_stc_date <  61; /* 3 - 5 Years                   */
		Crim_Offense_24_flag1  := not Dont_Count1                        and mth_stc_date <  25; /* 0 - 2 Years                   */
		Crim_Offense_24_flag2  := not Dont_Count2                        and mth_stc_date <  25; /* 0 - 2 Years                   */
		Crim_Offense_24_flag3  := not Dont_Count3                        and mth_stc_date <  25; /* 0 - 2 Years                   */

    SELF.offense_category1 := offense_category1;
    SELF.offense_category2 := offense_category2;
    SELF.offense_category3 := offense_category3;
    SELF.minor_offense1 := minor_offense1;
    SELF.minor_offense2 := minor_offense2;
    SELF.minor_offense3 := minor_offense3;
    
    SELF.mth_stc_date := mth_stc_date;
    
    SELF.Dont_Count1 := Dont_Count1;
    SELF.Dont_Count2 := Dont_Count2;
    SELF.Dont_Count3 := Dont_Count3;
    
    SELF.Crim_Offense_121_Flag1 := Crim_Offense_121_Flag1;
    SELF.Crim_Offense_121_Flag2 := Crim_Offense_121_Flag2;
    SELF.Crim_Offense_121_Flag3 := Crim_Offense_121_Flag3;
    SELF.Crim_Offense_61_Flag1 := Crim_Offense_61_Flag1;
    SELF.Crim_Offense_61_Flag2 := Crim_Offense_61_Flag2;
    SELF.Crim_Offense_61_Flag3 := Crim_Offense_61_Flag3;
    SELF.Crim_Offense_60_Flag1 := Crim_Offense_60_Flag1;
    SELF.Crim_Offense_60_Flag2 := Crim_Offense_60_Flag2;
    SELF.Crim_Offense_60_Flag3 := Crim_Offense_60_Flag3;
    SELF.Crim_Offense_24_Flag1 := Crim_Offense_24_Flag1;
    SELF.Crim_Offense_24_Flag2 := Crim_Offense_24_Flag2;
    SELF.Crim_Offense_24_Flag3 := Crim_Offense_24_Flag3;
	
		wc1 := Crim_Offense_121_flag1 or Crim_Offense_61_flag1 or Crim_Offense_60_flag1 or Crim_Offense_24_flag1;
		wc2 := Crim_Offense_121_flag2 or Crim_Offense_61_flag2 or Crim_Offense_60_flag2 or Crim_Offense_24_flag2;
		wc3 := Crim_Offense_121_flag3 or Crim_Offense_61_flag3 or Crim_Offense_60_flag3 or Crim_Offense_24_flag3;
    
		self.criminal.Crim_Flag             := IF(le.stc_date <> -1, TRUE, FALSE); // We have a criminal hit
    self.criminal.Crim_Flag_Cnt         := IF(le.stc_date <> -1, 1, 0); // + (UNSIGNED2)(offense_category2 <> 'Blank') + (UNSIGNED2)(offense_category3 <> 'Blank');
		self.criminal.WC_Count              := (UNSIGNED2)wc1 + (UNSIGNED2)wc2 + (UNSIGNED2)wc3;
		self.criminal.WC_Misdemeanor_Count  := (UNSIGNED2)(wc1 and offense_category1 = 'MISDEMEANOR') + (UNSIGNED2)(wc2 and offense_category2 = 'MISDEMEANOR') + (UNSIGNED2)(wc3 and offense_category3 = 'MISDEMEANOR');
		self.criminal.WC_Felony_Count       := (UNSIGNED2)(wc1 and offense_category1 = 'FELONY') + (UNSIGNED2)(wc2 and offense_category2 = 'FELONY') + (UNSIGNED2)(wc3 and offense_category3 = 'FELONY');
		self.criminal.WC_SexCrime_Count     := (UNSIGNED2)(wc1 and offense_category1 = 'SEX CRIME') + (UNSIGNED2)(wc2 and offense_category2 = 'SEX CRIME') + (UNSIGNED2)(wc3 and offense_category3 = 'SEX CRIME');




		self.criminal.Felony_Count_24               := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'FELONY') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'FELONY') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'FELONY');
		self.criminal.Murder_Count_24               := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'MURDER') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'MURDER') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'MURDER');
		self.criminal.Assault_Count_24              := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'ASSAULT') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'ASSAULT') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'ASSAULT');
		self.criminal.Robbery_Count_24              := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'ROBBERY') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'ROBBERY') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'ROBBERY');
		self.criminal.Burg_Count_24                 := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'BURGLARY') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'BURGLARY') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'BURGLARY');
		self.criminal.Theft_Count_24                := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'THEFT') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'THEFT') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'THEFT');
		self.criminal.Fraud_Count_24                := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'FRAUD') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'FRAUD') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'FRAUD');
		self.criminal.Forgery_Count_24              := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'FORGERY') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'FORGERY') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'FORGERY');
		self.criminal.Arrest_Count_24               := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'ARREST') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'ARREST') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'ARREST');
		self.criminal.Child_Abuse_Count_24          := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'CHILD ABUSE') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'CHILD ABUSE') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'CHILD ABUSE');
		self.criminal.Sex_Crime_Count_24            := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'SEX CRIME') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'SEX CRIME') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'SEX CRIME');
		self.criminal.Misdemeanor_Count_24          := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'MISDEMEANOR') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'MISDEMEANOR') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'MISDEMEANOR');
		self.criminal.DWLS_Count_24                 := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'DWLS') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'DWLS') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'DWLS');
		self.criminal.DUI_Count_24                  := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'DUI') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'DUI') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'DUI');
		self.criminal.Cont_Subst_Count_24           := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'CONTROLLED SUBSTANCE') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'CONTROLLED SUBSTANCE') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'CONTROLLED SUBSTANCE');
		self.criminal.Weapon_Count_24               := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'WEAPON') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'WEAPON') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'WEAPON');
		self.criminal.Harassment_Count_24           := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'HARASSMENT') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'HARASSMENT') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'HARASSMENT');
		self.criminal.Prop_Dmg_Count_24             := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'PROPERTY DAMAGE') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'PROPERTY DAMAGE') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'PROPERTY DAMAGE');
		self.criminal.Traffic_Count_24              := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'TRAFFIC') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'TRAFFIC') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'TRAFFIC');
		self.criminal.Disorderly_Count_24           := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'DISORDERLY') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'DISORDERLY') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'DISORDERLY');
		self.criminal.Parking_Count_24              := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'PARKING') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'PARKING') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'PARKING');
		self.criminal.Bad_Check_Count_24            := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'BAD CHECK') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'BAD CHECK') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'BAD CHECK');
		self.criminal.Trespassing_Count_24          := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'TRESPASSING') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'TRESPASSING') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'TRESPASSING');
		self.criminal.Break_Enter_Count_24          := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'BREAK-ENTER') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'BREAK-ENTER') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'BREAK-ENTER');
		self.criminal.Alcohol_Count_24              := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'ALCOHOL') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'ALCOHOL') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'ALCOHOL');
		self.criminal.Res_Arrest_Count_24           := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'RESIST ARREST') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'RESIST ARREST') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'RESIST ARREST');
		self.criminal.Other_Count_24                := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'OTHER') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'OTHER') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'OTHER');
		self.criminal.Red_Misc_Count_24             := (UNSIGNED2)(Crim_Offense_24_flag1 and offense_category1 = 'RED-MISC') + (UNSIGNED2)(Crim_Offense_24_flag2 and offense_category2 = 'RED-MISC') + (UNSIGNED2)(Crim_Offense_24_flag3 and offense_category3 = 'RED-MISC');

		self.criminal.Felony_Count_60               := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'FELONY') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'FELONY') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'FELONY');
		self.criminal.Murder_Count_60               := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'MURDER') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'MURDER') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'MURDER');
		self.criminal.Assault_Count_60              := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'ASSAULT') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'ASSAULT') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'ASSAULT');
		self.criminal.Robbery_Count_60              := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'ROBBERY') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'ROBBERY') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'ROBBERY');
		self.criminal.Burg_Count_60                 := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'BURGLARY') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'BURGLARY') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'BURGLARY');
		self.criminal.Theft_Count_60                := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'THEFT') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'THEFT') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'THEFT');
		self.criminal.Fraud_Count_60                := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'FRAUD') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'FRAUD') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'FRAUD');
		self.criminal.Forgery_Count_60              := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'FORGERY') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'FORGERY') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'FORGERY');
		self.criminal.Arrest_Count_60               := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'ARREST') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'ARREST') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'ARREST');
		self.criminal.Child_Abuse_Count_60          := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'CHILD ABUSE') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'CHILD ABUSE') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'CHILD ABUSE');
		self.criminal.Sex_Crime_Count_60            := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'SEX CRIME') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'SEX CRIME') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'SEX CRIME');
		self.criminal.Misdemeanor_Count_60          := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'MISDEMEANOR') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'MISDEMEANOR') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'MISDEMEANOR');
		self.criminal.DWLS_Count_60                 := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'DWLS') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'DWLS') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'DWLS');
		self.criminal.DUI_Count_60                  := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'DUI') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'DUI') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'DUI');
		self.criminal.Cont_Subst_Count_60           := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'CONTROLLED SUBSTANCE') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'CONTROLLED SUBSTANCE') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'CONTROLLED SUBSTANCE');
		self.criminal.Weapon_Count_60               := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'WEAPON') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'WEAPON') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'WEAPON');
		self.criminal.Harassment_Count_60           := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'HARASSMENT') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'HARASSMENT') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'HARASSMENT');
		self.criminal.Prop_Dmg_Count_60             := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'PROPERTY DAMAGE') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'PROPERTY DAMAGE') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'PROPERTY DAMAGE');
		self.criminal.Traffic_Count_60              := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'TRAFFIC') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'TRAFFIC') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'TRAFFIC');
		self.criminal.Disorderly_Count_60           := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'DISORDERLY') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'DISORDERLY') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'DISORDERLY');
		self.criminal.Parking_Count_60              := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'PARKING') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'PARKING') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'PARKING');
		self.criminal.Bad_Check_Count_60            := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'BAD CHECK') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'BAD CHECK') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'BAD CHECK');
		self.criminal.Trespassing_Count_60          := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'TRESPASSING') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'TRESPASSING') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'TRESPASSING');
		self.criminal.Break_Enter_Count_60          := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'BREAK-ENTER') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'BREAK-ENTER') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'BREAK-ENTER');
		self.criminal.Alcohol_Count_60              := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'ALCOHOL') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'ALCOHOL') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'ALCOHOL');
		self.criminal.Res_Arrest_Count_60           := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'RESIST ARREST') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'RESIST ARREST') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'RESIST ARREST');
		self.criminal.Other_Count_60                := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'OTHER') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'OTHER') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'OTHER');
		self.criminal.Red_Misc_Count_60             := (UNSIGNED2)(Crim_Offense_60_flag1 and offense_category1 = 'RED-MISC') + (UNSIGNED2)(Crim_Offense_60_flag2 and offense_category2 = 'RED-MISC') + (UNSIGNED2)(Crim_Offense_60_flag3 and offense_category3 = 'RED-MISC');

		self.criminal.Felony_Count_61               := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'FELONY') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'FELONY') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'FELONY');
		self.criminal.Murder_Count_61               := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'MURDER') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'MURDER') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'MURDER');
		self.criminal.Assault_Count_61              := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'ASSAULT') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'ASSAULT') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'ASSAULT');
		self.criminal.Robbery_Count_61              := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'ROBBERY') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'ROBBERY') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'ROBBERY');
		self.criminal.Burg_Count_61                 := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'BURGLARY') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'BURGLARY') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'BURGLARY');
		self.criminal.Theft_Count_61                := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'THEFT') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'THEFT') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'THEFT');
		self.criminal.Fraud_Count_61                := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'FRAUD') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'FRAUD') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'FRAUD');
		self.criminal.Forgery_Count_61              := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'FORGERY') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'FORGERY') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'FORGERY');
		self.criminal.Arrest_Count_61               := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'ARREST') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'ARREST') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'ARREST');
		self.criminal.Child_Abuse_Count_61          := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'CHILD ABUSE') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'CHILD ABUSE') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'CHILD ABUSE');
		self.criminal.Sex_Crime_Count_61            := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'SEX CRIME') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'SEX CRIME') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'SEX CRIME');
		self.criminal.Misdemeanor_Count_61          := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'MISDEMEANOR') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'MISDEMEANOR') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'MISDEMEANOR');
		self.criminal.DWLS_Count_61                 := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'DWLS') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'DWLS') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'DWLS');
		self.criminal.DUI_Count_61                  := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'DUI') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'DUI') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'DUI');
		self.criminal.Cont_Subst_Count_61           := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'CONTROLLED SUBSTANCE') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'CONTROLLED SUBSTANCE') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'CONTROLLED SUBSTANCE');
		self.criminal.Weapon_Count_61               := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'WEAPON') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'WEAPON') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'WEAPON');
		self.criminal.Harassment_Count_61           := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'HARASSMENT') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'HARASSMENT') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'HARASSMENT');
		self.criminal.Prop_Dmg_Count_61             := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'PROPERTY DAMAGE') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'PROPERTY DAMAGE') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'PROPERTY DAMAGE');
		self.criminal.Traffic_Count_61              := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'TRAFFIC') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'TRAFFIC') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'TRAFFIC');
		self.criminal.Disorderly_Count_61           := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'DISORDERLY') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'DISORDERLY') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'DISORDERLY');
		self.criminal.Parking_Count_61              := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'PARKING') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'PARKING') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'PARKING');
		self.criminal.Bad_Check_Count_61            := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'BAD CHECK') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'BAD CHECK') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'BAD CHECK');
		self.criminal.Trespassing_Count_61          := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'TRESPASSING') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'TRESPASSING') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'TRESPASSING');
		self.criminal.Break_Enter_Count_61          := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'BREAK-ENTER') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'BREAK-ENTER') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'BREAK-ENTER');
		self.criminal.Alcohol_Count_61              := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'ALCOHOL') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'ALCOHOL') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'ALCOHOL');
		self.criminal.Res_Arrest_Count_61           := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'RESIST ARREST') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'RESIST ARREST') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'RESIST ARREST');
		self.criminal.Other_Count_61                := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'OTHER') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'OTHER') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'OTHER');
		self.criminal.Red_Misc_Count_61             := (UNSIGNED2)(Crim_Offense_61_flag1 and offense_category1 = 'RED-MISC') + (UNSIGNED2)(Crim_Offense_61_flag2 and offense_category2 = 'RED-MISC') + (UNSIGNED2)(Crim_Offense_61_flag3 and offense_category3 = 'RED-MISC');

		self.criminal.Felony_Count_121               := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'FELONY') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'FELONY') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'FELONY');
		self.criminal.Murder_Count_121               := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'MURDER') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'MURDER') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'MURDER');
		self.criminal.Assault_Count_121              := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'ASSAULT') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'ASSAULT') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'ASSAULT');
		self.criminal.Robbery_Count_121              := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'ROBBERY') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'ROBBERY') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'ROBBERY');
		self.criminal.Burg_Count_121                 := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'BURGLARY') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'BURGLARY') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'BURGLARY');
		self.criminal.Theft_Count_121                := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'THEFT') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'THEFT') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'THEFT');
		self.criminal.Fraud_Count_121                := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'FRAUD') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'FRAUD') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'FRAUD');
		self.criminal.Forgery_Count_121              := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'FORGERY') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'FORGERY') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'FORGERY');
		self.criminal.Arrest_Count_121               := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'ARREST') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'ARREST') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'ARREST');
		self.criminal.Child_Abuse_Count_121          := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'CHILD ABUSE') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'CHILD ABUSE') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'CHILD ABUSE');
		self.criminal.Sex_Crime_Count_121            := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'SEX CRIME') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'SEX CRIME') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'SEX CRIME');
		self.criminal.Misdemeanor_Count_121          := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'MISDEMEANOR') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'MISDEMEANOR') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'MISDEMEANOR');
		self.criminal.DWLS_Count_121                 := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'DWLS') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'DWLS') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'DWLS');
		self.criminal.DUI_Count_121                  := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'DUI') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'DUI') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'DUI');
		self.criminal.Cont_Subst_Count_121           := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'CONTROLLED SUBSTANCE') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'CONTROLLED SUBSTANCE') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'CONTROLLED SUBSTANCE');
		self.criminal.Weapon_Count_121               := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'WEAPON') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'WEAPON') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'WEAPON');
		self.criminal.Harassment_Count_121           := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'HARASSMENT') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'HARASSMENT') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'HARASSMENT');
		self.criminal.Prop_Dmg_Count_121             := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'PROPERTY DAMAGE') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'PROPERTY DAMAGE') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'PROPERTY DAMAGE');
		self.criminal.Traffic_Count_121              := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'TRAFFIC') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'TRAFFIC') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'TRAFFIC');
		self.criminal.Disorderly_Count_121           := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'DISORDERLY') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'DISORDERLY') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'DISORDERLY');
		self.criminal.Parking_Count_121              := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'PARKING') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'PARKING') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'PARKING');
		self.criminal.Bad_Check_Count_121            := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'BAD CHECK') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'BAD CHECK') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'BAD CHECK');
		self.criminal.Trespassing_Count_121          := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'TRESPASSING') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'TRESPASSING') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'TRESPASSING');
		self.criminal.Break_Enter_Count_121          := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'BREAK-ENTER') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'BREAK-ENTER') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'BREAK-ENTER');
		self.criminal.Alcohol_Count_121              := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'ALCOHOL') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'ALCOHOL') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'ALCOHOL');
		self.criminal.Res_Arrest_Count_121           := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'RESIST ARREST') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'RESIST ARREST') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'RESIST ARREST');
		self.criminal.Other_Count_121                := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'OTHER') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'OTHER') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'OTHER');
		self.criminal.Red_Misc_Count_121             := (UNSIGNED2)(Crim_Offense_121_flag1 and offense_category1 = 'RED-MISC') + (UNSIGNED2)(Crim_Offense_121_flag2 and offense_category2 = 'RED-MISC') + (UNSIGNED2)(Crim_Offense_121_flag3 and offense_category3 = 'RED-MISC');

    SELF := le;
    self := [];
  END;
  countedOffensesTemp := SORT(PROJECT(gotOffenses, countOffenses(left)), seq, provider_type, offender_key, dont_count1, dont_count2, dont_count3, offense_category1, offense_category2, offense_category3, mth_stc_date);
  countedOffenses := PROJECT(countedOffensesTemp, TRANSFORM(Layout_HealthCare_Shell_Plus, SELF := LEFT));
  
  Layout_Healthcare_Shell_Plus rollOffenses( Layout_Healthcare_Shell_Plus le, Layout_Healthcare_Shell_Plus ri ) := TRANSFORM
		self.seq := le.seq;
		self.provider_type := le.provider_type;

		self.criminal.Crim_Flag                     := true;
    self.Criminal.Crim_Flag_Cnt                 := le.Criminal.Crim_Flag_Cnt                 + ri.Criminal.Crim_Flag_Cnt;
		self.criminal.WC_Count                      := le.criminal.WC_Count                      + ri.criminal.WC_Count;
		self.criminal.WC_Misdemeanor_Count          := le.criminal.WC_Misdemeanor_Count          + ri.criminal.WC_Misdemeanor_Count;
		self.criminal.WC_Felony_Count               := le.criminal.WC_Felony_Count               + ri.criminal.WC_Felony_Count;
		self.criminal.WC_SexCrime_Count             := le.criminal.WC_SexCrime_Count             + ri.criminal.WC_SexCrime_Count;

		self.criminal.Felony_Count_24               := le.criminal.Felony_Count_24               + ri.criminal.Felony_Count_24;
		self.criminal.Murder_Count_24               := le.criminal.Murder_Count_24               + ri.criminal.Murder_Count_24;
		self.criminal.Assault_Count_24              := le.criminal.Assault_Count_24              + ri.criminal.Assault_Count_24;
		self.criminal.Robbery_Count_24              := le.criminal.Robbery_Count_24              + ri.criminal.Robbery_Count_24;
		self.criminal.Burg_Count_24                 := le.criminal.Burg_Count_24                 + ri.criminal.Burg_Count_24;
		self.criminal.Theft_Count_24                := le.criminal.Theft_Count_24                + ri.criminal.Theft_Count_24;
		self.criminal.Fraud_Count_24                := le.criminal.Fraud_Count_24                + ri.criminal.Fraud_Count_24;
		self.criminal.Forgery_Count_24              := le.criminal.Forgery_Count_24              + ri.criminal.Forgery_Count_24;
		self.criminal.Arrest_Count_24               := le.criminal.Arrest_Count_24               + ri.criminal.Arrest_Count_24;
		self.criminal.Child_Abuse_Count_24          := le.criminal.Child_Abuse_Count_24          + ri.criminal.Child_Abuse_Count_24;
		self.criminal.Sex_Crime_Count_24            := le.criminal.Sex_Crime_Count_24            + ri.criminal.Sex_Crime_Count_24;
		self.criminal.Misdemeanor_Count_24          := le.criminal.Misdemeanor_Count_24          + ri.criminal.Misdemeanor_Count_24;
		self.criminal.DWLS_Count_24                 := le.criminal.DWLS_Count_24                 + ri.criminal.DWLS_Count_24;
		self.criminal.DUI_Count_24                  := le.criminal.DUI_Count_24                  + ri.criminal.DUI_Count_24;
		self.criminal.Cont_Subst_Count_24           := le.criminal.Cont_Subst_Count_24           + ri.criminal.Cont_Subst_Count_24;
		self.criminal.Weapon_Count_24               := le.criminal.Weapon_Count_24               + ri.criminal.Weapon_Count_24;
		self.criminal.Harassment_Count_24           := le.criminal.Harassment_Count_24           + ri.criminal.Harassment_Count_24;
		self.criminal.Prop_Dmg_Count_24             := le.criminal.Prop_Dmg_Count_24             + ri.criminal.Prop_Dmg_Count_24;
		self.criminal.Traffic_Count_24              := le.criminal.Traffic_Count_24              + ri.criminal.Traffic_Count_24;
		self.criminal.Disorderly_Count_24           := le.criminal.Disorderly_Count_24           + ri.criminal.Disorderly_Count_24;
		self.criminal.Parking_Count_24              := le.criminal.Parking_Count_24              + ri.criminal.Parking_Count_24;
		self.criminal.Bad_Check_Count_24            := le.criminal.Bad_Check_Count_24            + ri.criminal.Bad_Check_Count_24;
		self.criminal.Trespassing_Count_24          := le.criminal.Trespassing_Count_24          + ri.criminal.Trespassing_Count_24;
		self.criminal.Break_Enter_Count_24          := le.criminal.Break_Enter_Count_24          + ri.criminal.Break_Enter_Count_24;
		self.criminal.Alcohol_Count_24              := le.criminal.Alcohol_Count_24              + ri.criminal.Alcohol_Count_24;
		self.criminal.Res_Arrest_Count_24           := le.criminal.Res_Arrest_Count_24           + ri.criminal.Res_Arrest_Count_24;
		self.criminal.Other_Count_24                := le.criminal.Other_Count_24                + ri.criminal.Other_Count_24;
		self.criminal.Red_Misc_Count_24             := le.criminal.Red_Misc_Count_24             + ri.criminal.Red_Misc_Count_24;

		self.criminal.Felony_Count_60               := le.criminal.Felony_Count_60               + ri.criminal.Felony_Count_60;
		self.criminal.Murder_Count_60               := le.criminal.Murder_Count_60               + ri.criminal.Murder_Count_60;
		self.criminal.Assault_Count_60              := le.criminal.Assault_Count_60              + ri.criminal.Assault_Count_60;
		self.criminal.Robbery_Count_60              := le.criminal.Robbery_Count_60              + ri.criminal.Robbery_Count_60;
		self.criminal.Burg_Count_60                 := le.criminal.Burg_Count_60                 + ri.criminal.Burg_Count_60;
		self.criminal.Theft_Count_60                := le.criminal.Theft_Count_60                + ri.criminal.Theft_Count_60;
		self.criminal.Fraud_Count_60                := le.criminal.Fraud_Count_60                + ri.criminal.Fraud_Count_60;
		self.criminal.Forgery_Count_60              := le.criminal.Forgery_Count_60              + ri.criminal.Forgery_Count_60;
		self.criminal.Arrest_Count_60               := le.criminal.Arrest_Count_60               + ri.criminal.Arrest_Count_60;
		self.criminal.Child_Abuse_Count_60          := le.criminal.Child_Abuse_Count_60          + ri.criminal.Child_Abuse_Count_60;
		self.criminal.Sex_Crime_Count_60            := le.criminal.Sex_Crime_Count_60            + ri.criminal.Sex_Crime_Count_60;
		self.criminal.Misdemeanor_Count_60          := le.criminal.Misdemeanor_Count_60          + ri.criminal.Misdemeanor_Count_60;
		self.criminal.DWLS_Count_60                 := le.criminal.DWLS_Count_60                 + ri.criminal.DWLS_Count_60;
		self.criminal.DUI_Count_60                  := le.criminal.DUI_Count_60                  + ri.criminal.DUI_Count_60;
		self.criminal.Cont_Subst_Count_60           := le.criminal.Cont_Subst_Count_60           + ri.criminal.Cont_Subst_Count_60;
		self.criminal.Weapon_Count_60               := le.criminal.Weapon_Count_60               + ri.criminal.Weapon_Count_60;
		self.criminal.Harassment_Count_60           := le.criminal.Harassment_Count_60           + ri.criminal.Harassment_Count_60;
		self.criminal.Prop_Dmg_Count_60             := le.criminal.Prop_Dmg_Count_60             + ri.criminal.Prop_Dmg_Count_60;
		self.criminal.Traffic_Count_60              := le.criminal.Traffic_Count_60              + ri.criminal.Traffic_Count_60;
		self.criminal.Disorderly_Count_60           := le.criminal.Disorderly_Count_60           + ri.criminal.Disorderly_Count_60;
		self.criminal.Parking_Count_60              := le.criminal.Parking_Count_60              + ri.criminal.Parking_Count_60;
		self.criminal.Bad_Check_Count_60            := le.criminal.Bad_Check_Count_60            + ri.criminal.Bad_Check_Count_60;
		self.criminal.Trespassing_Count_60          := le.criminal.Trespassing_Count_60          + ri.criminal.Trespassing_Count_60;
		self.criminal.Break_Enter_Count_60          := le.criminal.Break_Enter_Count_60          + ri.criminal.Break_Enter_Count_60;
		self.criminal.Alcohol_Count_60              := le.criminal.Alcohol_Count_60              + ri.criminal.Alcohol_Count_60;
		self.criminal.Res_Arrest_Count_60           := le.criminal.Res_Arrest_Count_60           + ri.criminal.Res_Arrest_Count_60;
		self.criminal.Other_Count_60                := le.criminal.Other_Count_60                + ri.criminal.Other_Count_60;
		self.criminal.Red_Misc_Count_60             := le.criminal.Red_Misc_Count_60             + ri.criminal.Red_Misc_Count_60;

		self.criminal.Felony_Count_61               := le.criminal.Felony_Count_61               + ri.criminal.Felony_Count_61;
		self.criminal.Murder_Count_61               := le.criminal.Murder_Count_61               + ri.criminal.Murder_Count_61;
		self.criminal.Assault_Count_61              := le.criminal.Assault_Count_61              + ri.criminal.Assault_Count_61;
		self.criminal.Robbery_Count_61              := le.criminal.Robbery_Count_61              + ri.criminal.Robbery_Count_61;
		self.criminal.Burg_Count_61                 := le.criminal.Burg_Count_61                 + ri.criminal.Burg_Count_61;
		self.criminal.Theft_Count_61                := le.criminal.Theft_Count_61                + ri.criminal.Theft_Count_61;
		self.criminal.Fraud_Count_61                := le.criminal.Fraud_Count_61                + ri.criminal.Fraud_Count_61;
		self.criminal.Forgery_Count_61              := le.criminal.Forgery_Count_61              + ri.criminal.Forgery_Count_61;
		self.criminal.Arrest_Count_61               := le.criminal.Arrest_Count_61               + ri.criminal.Arrest_Count_61;
		self.criminal.Child_Abuse_Count_61          := le.criminal.Child_Abuse_Count_61          + ri.criminal.Child_Abuse_Count_61;
		self.criminal.Sex_Crime_Count_61            := le.criminal.Sex_Crime_Count_61            + ri.criminal.Sex_Crime_Count_61;
		self.criminal.Misdemeanor_Count_61          := le.criminal.Misdemeanor_Count_61          + ri.criminal.Misdemeanor_Count_61;
		self.criminal.DWLS_Count_61                 := le.criminal.DWLS_Count_61                 + ri.criminal.DWLS_Count_61;
		self.criminal.DUI_Count_61                  := le.criminal.DUI_Count_61                  + ri.criminal.DUI_Count_61;
		self.criminal.Cont_Subst_Count_61           := le.criminal.Cont_Subst_Count_61           + ri.criminal.Cont_Subst_Count_61;
		self.criminal.Weapon_Count_61               := le.criminal.Weapon_Count_61               + ri.criminal.Weapon_Count_61;
		self.criminal.Harassment_Count_61           := le.criminal.Harassment_Count_61           + ri.criminal.Harassment_Count_61;
		self.criminal.Prop_Dmg_Count_61             := le.criminal.Prop_Dmg_Count_61             + ri.criminal.Prop_Dmg_Count_61;
		self.criminal.Traffic_Count_61              := le.criminal.Traffic_Count_61              + ri.criminal.Traffic_Count_61;
		self.criminal.Disorderly_Count_61           := le.criminal.Disorderly_Count_61           + ri.criminal.Disorderly_Count_61;
		self.criminal.Parking_Count_61              := le.criminal.Parking_Count_61              + ri.criminal.Parking_Count_61;
		self.criminal.Bad_Check_Count_61            := le.criminal.Bad_Check_Count_61            + ri.criminal.Bad_Check_Count_61;
		self.criminal.Trespassing_Count_61          := le.criminal.Trespassing_Count_61          + ri.criminal.Trespassing_Count_61;
		self.criminal.Break_Enter_Count_61          := le.criminal.Break_Enter_Count_61          + ri.criminal.Break_Enter_Count_61;
		self.criminal.Alcohol_Count_61              := le.criminal.Alcohol_Count_61              + ri.criminal.Alcohol_Count_61;
		self.criminal.Res_Arrest_Count_61           := le.criminal.Res_Arrest_Count_61           + ri.criminal.Res_Arrest_Count_61;
		self.criminal.Other_Count_61                := le.criminal.Other_Count_61                + ri.criminal.Other_Count_61;
		self.criminal.Red_Misc_Count_61             := le.criminal.Red_Misc_Count_61             + ri.criminal.Red_Misc_Count_61;

		self.criminal.Felony_Count_121              := le.criminal.Felony_Count_121              + ri.criminal.Felony_Count_121;
		self.criminal.Murder_Count_121              := le.criminal.Murder_Count_121              + ri.criminal.Murder_Count_121;
		self.criminal.Assault_Count_121             := le.criminal.Assault_Count_121             + ri.criminal.Assault_Count_121;
		self.criminal.Robbery_Count_121             := le.criminal.Robbery_Count_121             + ri.criminal.Robbery_Count_121;
		self.criminal.Burg_Count_121                := le.criminal.Burg_Count_121                + ri.criminal.Burg_Count_121;
		self.criminal.Theft_Count_121               := le.criminal.Theft_Count_121               + ri.criminal.Theft_Count_121;
		self.criminal.Fraud_Count_121               := le.criminal.Fraud_Count_121               + ri.criminal.Fraud_Count_121;
		self.criminal.Forgery_Count_121             := le.criminal.Forgery_Count_121             + ri.criminal.Forgery_Count_121;
		self.criminal.Arrest_Count_121              := le.criminal.Arrest_Count_121              + ri.criminal.Arrest_Count_121;
		self.criminal.Child_Abuse_Count_121         := le.criminal.Child_Abuse_Count_121         + ri.criminal.Child_Abuse_Count_121;
		self.criminal.Sex_Crime_Count_121           := le.criminal.Sex_Crime_Count_121           + ri.criminal.Sex_Crime_Count_121;
		self.criminal.Misdemeanor_Count_121         := le.criminal.Misdemeanor_Count_121         + ri.criminal.Misdemeanor_Count_121;
		self.criminal.DWLS_Count_121                := le.criminal.DWLS_Count_121                + ri.criminal.DWLS_Count_121;
		self.criminal.DUI_Count_121                 := le.criminal.DUI_Count_121                 + ri.criminal.DUI_Count_121;
		self.criminal.Cont_Subst_Count_121          := le.criminal.Cont_Subst_Count_121          + ri.criminal.Cont_Subst_Count_121;
		self.criminal.Weapon_Count_121              := le.criminal.Weapon_Count_121              + ri.criminal.Weapon_Count_121;
		self.criminal.Harassment_Count_121          := le.criminal.Harassment_Count_121          + ri.criminal.Harassment_Count_121;
		self.criminal.Prop_Dmg_Count_121            := le.criminal.Prop_Dmg_Count_121            + ri.criminal.Prop_Dmg_Count_121;
		self.criminal.Traffic_Count_121             := le.criminal.Traffic_Count_121             + ri.criminal.Traffic_Count_121;
		self.criminal.Disorderly_Count_121          := le.criminal.Disorderly_Count_121          + ri.criminal.Disorderly_Count_121;
		self.criminal.Parking_Count_121             := le.criminal.Parking_Count_121             + ri.criminal.Parking_Count_121;
		self.criminal.Bad_Check_Count_121           := le.criminal.Bad_Check_Count_121           + ri.criminal.Bad_Check_Count_121;
		self.criminal.Trespassing_Count_121         := le.criminal.Trespassing_Count_121         + ri.criminal.Trespassing_Count_121;
		self.criminal.Break_Enter_Count_121         := le.criminal.Break_Enter_Count_121         + ri.criminal.Break_Enter_Count_121;
		self.criminal.Alcohol_Count_121             := le.criminal.Alcohol_Count_121             + ri.criminal.Alcohol_Count_121;
		self.criminal.Res_Arrest_Count_121          := le.criminal.Res_Arrest_Count_121          + ri.criminal.Res_Arrest_Count_121;
		self.criminal.Other_Count_121               := le.criminal.Other_Count_121               + ri.criminal.Other_Count_121;
		self.criminal.Red_Misc_Count_121            := le.criminal.Red_Misc_Count_121            + ri.criminal.Red_Misc_Count_121;

    SELF.offense_desc_1 := IF(TRIM(le.offense_desc_1) <> '', le.offense_desc_1, ri.offense_desc_1);
    SELF.offense_desc_2 := IF(TRIM(le.offense_desc_2) <> '', le.offense_desc_2, ri.offense_desc_2);
    SELF.offense_desc_3 := IF(TRIM(le.offense_desc_3) <> '', le.offense_desc_3, ri.offense_desc_3);

    SELF := le;
		self := [];
  END;
	rolledOffenses := rollup(countedOffenses, left.seq = right.seq and left.provider_type =  right.provider_type, rollOffenses(left,right));
	
	Layout_Healthcare_Shell_Plus cleanupOffenses( Layout_Healthcare_Shell_Plus le ) := TRANSFORM
		emptyRow := row([], Layout_Healthcare_Shell_Plus.criminal );
		self.criminal := if(le.provider_type = ptype.Individual, le.criminal, emptyRow);
		self.ran_criminal := if(le.provider_type = ptype.Relative, le.criminal, emptyRow);
		self := le;
	END;
	cleanedOffenses := project(rolledOffenses, cleanupOffenses(left));
	
	Layout_Healthcare_Shell_Plus finishOffenses(Layout_Healthcare_Shell_Plus le, Layout_Healthcare_Shell_Plus ri) := TRANSFORM
		self.criminal := if(ri.provider_type = ptype.Individual, ri.criminal, le.criminal);
		self.ran_criminal := if(ri.provider_type = ptype.Relative, ri.ran_criminal, le.ran_criminal);
		self := le;
	END;
	final_Offenses := rollup(cleanedOffenses, left.seq = right.seq, finishOffenses(left,right));

  // possible incarceration. -- instead, use the macro. see Risk_Indicators.Collection_Shell_MOD
  // this code taken from CriminalRecords_BatchService.Possible_Incarceration_Indicator_Batch_Service_Records:
    // Constants
    STRING PI_PATTERN := '^(Active|Population|Inmate|Incarcerated|IN +CUSTODY|UNDER +CUSTODY|IN, +ADMISSION)|LIFE';
    STRING PI_SENT_PATTERN := '^(LIFE|LIFE [WITHOUT|W/O]* PAROLE)$';
    UNSIGNED1 COND_OUT := 0;
    UNSIGNED1 COND_IN := 1;
    UNSIGNED1 COND_UNKNOWN := 2;
    UNSIGNED4 currentDt := (UNSIGNED4) StringLib.getDateYYYYMMDD();

    trimBoth(STRING input) := TRIM(input, LEFT, RIGHT);

    BOOLEAN isProbablyNotIncarcerated(STRING statStr, STRING sentStr, SET OF UNSIGNED4 relDates) := FUNCTION
      dateRule(UNSIGNED4 relDt, UNSIGNED4 curDt) := MAP(relDt >= curDt => COND_IN,
                                                        relDt = 0 => COND_UNKNOWN,
                                                        COND_OUT);
      statusRule(STRING inmStat, STRING sentDesc) := MAP(REGEXFIND(PI_PATTERN, inmStat, NOCASE) => COND_IN,
                                        LENGTH(inmStat) = 0 and REGEXFIND(PI_SENT_PATTERN, sentDesc, NOCASE) => COND_IN,
                                        LENGTH(inmStat) = 0 => COND_UNKNOWN,
                                        COND_OUT);

      UNSIGNED1 statRule := statusRule(trimBoth(statStr), trimBoth(sentStr));
      UNSIGNED1 dateRule1 := dateRule((UNSIGNED4) relDates[1], currentDt);
      UNSIGNED1 dateRule2 := dateRule((UNSIGNED4) relDates[2], currentDt);
      UNSIGNED1 dateRule3 := dateRule((UNSIGNED4) relDates[3], currentDt);
      BOOLEAN dtsNotIn := (dateRule2 <> COND_IN AND dateRule3 <> COND_IN) OR dateRule1 = COND_OUT OR dateRule3 = COND_OUT; 
      BOOLEAN dtInOrOut := dateRule1 <> COND_UNKNOWN OR dateRule2 <> COND_UNKNOWN OR dateRule3 <> COND_UNKNOWN;

      RETURN (statRule <> COND_IN OR dtInOrOut) AND (statRule = COND_OUT OR dtsNotIn);
    END;
  //

  // incarceration
  Layout_Healthcare_Shell_Plus getIncarceration(Layout_Healthcare_Shell_Plus le, key_incarceration ri) := TRANSFORM
    self.seq := le.seq;
    self.PossibleIncarceration := ~isProbablyNotIncarcerated(ri.cur_stat_inm_desc, ri.sent_length_desc, [(UNSIGNED4) ri.act_rel_dt, (UNSIGNED4) ri.sch_rel_dt, (UNSIGNED4) ri.ctl_rel_dt]);
		SELF := le;
    self := [];
  END;
  // gotIncarcerationTemp := join(gotOffender, key_incarceration, left.provider_type = ptype.Individual AND keyed(left.offender_key = right.ok), getIncarceration(left, right), KEEP(100), ATMOST(RiskWise.max_atmost));
  gotIncarcerationTemp := join(offenderDID, key_incarceration, left.provider_type = ptype.Individual AND keyed(left.offender_key = right.ok), getIncarceration(left, right), KEEP(100), ATMOST(RiskWise.max_atmost)) + join(offenderRelativeDID, key_incarceration, left.provider_type = ptype.Individual AND keyed(left.offender_key = right.ok), getIncarceration(left, right), KEEP(100), ATMOST(RiskWise.max_atmost));

  Layout_Healthcare_Shell_Plus rollIncarceration(Layout_Healthcare_Shell_Plus le, Layout_Healthcare_Shell_Plus ri) := TRANSFORM
    // If we already have an incarceration keep it, otherwise grab the next record
    SELF.PossibleIncarceration := IF(le.PossibleIncarceration = TRUE, SKIP, ri.PossibleIncarceration);
    SELF := le;
  END;
  // We might have more than 1 incarceration - roll-em-up.
  gotIncarceration := ROLLUP(gotIncarcerationTemp, LEFT.seq = RIGHT.seq, rollIncarceration(LEFT, RIGHT));

	// join 'em all together
	Risk_Indicators.Layouts.Layout_Healthcare_Shell join_license(clam le, finalMLPL ri) := TRANSFORM
		self.seq               := le.seq;
		self.Overall_Year_Min  := ri.Overall_Year_Min;
		self.Time_On_PS        := ri.Time_On_PS;
        
		self.MedLicProfLic_hit := ri.MedLicProfLic_hit;
    SELF.MedLicProfLic_None := ri.MedLicProfLic_None;
    SELF.MedLicProfLic_Exp := ri.MedLicProfLic_Exp;
    SELF.MedLicProfLic_Time := ri.MedLicProfLic_Time;
    SELF.MedLicProfLic_Same_State_Exp := ri.MedLicProfLic_Same_State_Exp;
    SELF.MedLicProfLic_Same_State := ri.MedLicProfLic_Same_State;
    
    SELF := le;
		self := [];
	END;
	withLicenses := join(clam, finalMLPL, left.seq = right.seq, join_license(left,right), left outer, KEEP(1), ATMOST(RiskWise.max_atmost));

	Risk_Indicators.Layouts.Layout_Healthcare_Shell join_so( Risk_Indicators.Layouts.Layout_Healthcare_Shell le, rolledSexOffender ri ) := TRANSFORM
		self.Sex_Offense_Count_Unk := ri.Sex_Offense_Count_Unk;
		self.Sex_Offense_Count_24  := ri.Sex_Offense_Count_24;
		self.Sex_Offense_Count_60  := ri.Sex_Offense_Count_60;
		self.Sex_Offense_Count_61  := ri.Sex_Offense_Count_61;
		self.SexOffender_Hit       := ri.SexOffender_Hit;

		self := le;
	END;
	withSexOffender := join( withLicenses, rolledSexOffender, left.seq=right.seq, join_so(left,right), left outer, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	Risk_Indicators.Layouts.Layout_Healthcare_Shell join_liens( Risk_Indicators.Layouts.Layout_Healthcare_Shell le, rolledSexOffender ri ) := TRANSFORM
		self.Liens := ri.Liens;
		self       := le;
	END;
	withLiens := join( withSexOffender, rolledLiens, left.seq=right.seq, join_liens(left,right), left outer, KEEP(1), ATMOST(RiskWise.max_atmost));

	Risk_Indicators.Layouts.Layout_Healthcare_Shell join_sanctions( withLiens le, final_sanctions ri ) := TRANSFORM
		self.sanctions     := ri.sanctions;
		self.ran_sanctions := ri.ran_sanctions;
		self.bus_sanctions := ri.bus_sanctions;

		self := le;
	END;
	withSanctions := join( withLiens, final_sanctions, left.seq=right.seq, join_sanctions(left,right), left outer, KEEP(1), ATMOST(RiskWise.max_atmost));

	Risk_Indicators.Layouts.Layout_Healthcare_Shell join_provider( withSanctions le, final_provider ri ) := TRANSFORM
		self.provider               := ri.provider;
		self.ran_provider           := ri.ran_provider;
		self.bus_provider           := ri.bus_provider;
		self.corpaffil_provider     := ri.corpaffil_provider;
		self.ran_corpaffil_provider := ri.ran_corpaffil_provider;

		self := le;
	END;
	withProvider := join( withSanctions, final_provider, left.seq=right.seq, join_provider(left,right), left outer, KEEP(1), ATMOST(RiskWise.max_atmost));

	Risk_Indicators.Layouts.Layout_Healthcare_Shell join_crim( withProvider le, final_Offenses ri ) := TRANSFORM
		self.criminal     := ri.criminal;
		self.ran_criminal := ri.ran_criminal;

		self := le;
	END;
	withCriminal := join( withProvider, final_Offenses, left.seq=right.seq, join_crim(left,right), left outer, KEEP(1), ATMOST(RiskWise.max_atmost));

	Risk_Indicators.Layouts.Layout_Healthcare_Shell join_incar( withCriminal le, gotIncarceration ri ) := TRANSFORM
		self.PossibleIncarceration     := ri.PossibleIncarceration;
    // If we don't have a hit and there is no discovered minimum year on any file - declare it a missing value and set to 9999
    SELF.overall_year_min := IF(le.MedLicProfLic_hit = FALSE, 0, le.overall_year_min);
    SELF.MedLicProfLic_None := NOT le.MedLicProfLic_hit; // If we don't have a Med Lic Prof Lic hit set to TRUE
    SELF.MedLicProfLic_Time := le.MedLicProfLic_hit;
    
		self := le;
	END;
	withIncarceration := join( withCriminal, gotIncarceration, left.seq=right.seq, join_incar(left,right), left outer, KEEP(1), ATMOST(RiskWise.max_atmost));
  
  
  /* ****************************************
   *           Debugging Section            *
   ******************************************/
  // eyeball := 350;
  // OUTPUT(CHOOSEN(SORT(healthcare_in, seq), eyeball), NAMED('healthcare_in'));
  // OUTPUT(CHOOSEN(SORT(gotProviderIds, seq), eyeball), NAMED('gotProviderIds'));
  // OUTPUT(CHOOSEN(SORT(gotMedLic, seq), eyeball), NAMED('gotMedLic'));
  // OUTPUT(CHOOSEN(SORT(gotProfLicDid, seq), eyeball), NAMED('gotProfLicDid'));
  // OUTPUT(CHOOSEN(SORT(gotProfLicBdid, seq), eyeball), NAMED('gotProfLicBdid'));
  // OUTPUT(CHOOSEN(SORT(allMLPLRecs, seq), eyeball), NAMED('allMLPLRecs'));
  // OUTPUT(CHOOSEN(SORT(rolledMLPL, seq), eyeball), NAMED('rolledMLPL'));
  // OUTPUT(CHOOSEN(SORT(finalMLPL, seq), eyeball), NAMED('finalMLPL'));
  // OUTPUT(CHOOSEN(SORT(gotSexOffender_SPK, seq), eyeball), NAMED('gotSexOffender_SPK'));
  // OUTPUT(CHOOSEN(SORT(gotSexOffenderTemp, seq), eyeball), NAMED('gotSexOffenderTemp'));
  // OUTPUT(CHOOSEN(SORT(gotSexOffender, seq), eyeball), NAMED('gotSexOffender'));
  // OUTPUT(CHOOSEN(SORT(rolledSexOffender, seq), eyeball), NAMED('rolledSexOffender'));
  // OUTPUT(CHOOSEN(SORT(gotTMSIDRMSID, seq), eyeball), NAMED('gotTMSIDRMSID'));
  // OUTPUT(CHOOSEN(SORT(gotLiensFilteredSSNs, seq), eyeball), NAMED('gotLiensFilteredSSNs'));
  // OUTPUT(CHOOSEN(SORT(gotLiensTemp, seq), eyeball), NAMED('gotLiensTemp'));
  // OUTPUT(CHOOSEN(SORT(gotLiensTemp2, seq), eyeball), NAMED('gotLiensTemp2'));
  // OUTPUT(CHOOSEN(SORT(gotLiensCombo, seq), eyeball), NAMED('gotLiensCombo'));
  // OUTPUT(CHOOSEN(SORT(gotLiens, seq), eyeball), NAMED('gotLiens'));
  // OUTPUT(CHOOSEN(SORT(rolledLiens, seq), eyeball), NAMED('rolledLiens'));
  // OUTPUT(CHOOSEN(didSancID, eyeball), NAMED('didSancID'));
  // OUTPUT(CHOOSEN(didRelativeSancID, eyeball), NAMED('didRelativeSancID'));
  // OUTPUT(CHOOSEN(bdidSancID, eyeball), NAMED('bdidSancID'));
  // OUTPUT(CHOOSEN(corpaffilSancID, eyeball), NAMED('corpaffilSancID'));
  // OUTPUT(CHOOSEN(sancDid, eyeball), NAMED('sancDid'));
  // OUTPUT(CHOOSEN(sancDidRelative, eyeball), NAMED('sancDidRelative'));
  // OUTPUT(CHOOSEN(sancBDID, eyeball), NAMED('sancBDID'));
  // OUTPUT(CHOOSEN(sancBDIDCorpAffil, eyeball), NAMED('sancBDIDCorpAffil'));
  // OUTPUT(CHOOSEN(SORT(gotSanctionsTemp, seq), eyeball), NAMED('gotSanctionsTemp'));
  // OUTPUT(CHOOSEN(SORT(gotSanctions, seq), eyeball), NAMED('gotSanctions'));
  // OUTPUT(CHOOSEN(SORT(rolledSanctions, seq), eyeball), NAMED('rolledSanctions'));
  // OUTPUT(CHOOSEN(SORT(cleanedSanctions, seq), eyeball), NAMED('cleanedSanctions'));
  // OUTPUT(CHOOSEN(SORT(final_sanctions, seq), eyeball), NAMED('final_sanctions'));
  // OUTPUT(CHOOSEN(SORT(providerDID, seq), eyeball), NAMED('providerDID'));
  // OUTPUT(CHOOSEN(SORT(providerRelative, seq), eyeball), NAMED('providerRelative'));
  // OUTPUT(CHOOSEN(SORT(providerBDID, seq), eyeball), NAMED('providerBDID'));
  // OUTPUT(CHOOSEN(SORT(providerCorpAffil, seq), eyeball), NAMED('providerCorpAffil'));
  // OUTPUT(CHOOSEN(SORT(providerRelativeCorpAffil, seq), eyeball), NAMED('providerRelativeCorpAffil'));
  // OUTPUT(CHOOSEN(SORT(gotProvider, seq), eyeball), NAMED('gotProvider'));
  // OUTPUT(CHOOSEN(SORT(rolledProvider, seq), eyeball), NAMED('rolledProvider'));
  // OUTPUT(CHOOSEN(SORT(cleanedProvider, seq), eyeball), NAMED('cleanedProvider'));
  // OUTPUT(CHOOSEN(SORT(final_provider, seq), eyeball), NAMED('final_provider'));
  // OUTPUT(CHOOSEN(SORT(offenderDID, seq), eyeball), NAMED('offenderDID'));
  // OUTPUT(CHOOSEN(SORT(offenderRelativeDID, seq), eyeball), NAMED('offenderRelativeDID'));
  // OUTPUT(CHOOSEN(SORT(offenderOffensesDID, seq), eyeball), NAMED('offenderOffensesDID'));
  // OUTPUT(CHOOSEN(SORT(offenderOffensesRel, seq), eyeball), NAMED('offenderOffensesRel'));
  // OUTPUT(CHOOSEN(SORT(offenderOffenses, seq), eyeball), NAMED('offenderOffenses'));
  // OUTPUT(CHOOSEN(SORT(offenderCourtOffensesDID, seq), eyeball), NAMED('offenderCourtOffensesDID'));
  // OUTPUT(CHOOSEN(SORT(offenderCourtOffensesRel, seq), eyeball), NAMED('offenderCourtOffensesRel'));
  // OUTPUT(CHOOSEN(SORT(offenderCourtOffenses, seq), eyeball), NAMED('offenderCourtOffenses'));
  // OUTPUT(CHOOSEN(SORT(gotOffensesSort, seq), eyeball), NAMED('gotOffensesSort'));
  // OUTPUT(CHOOSEN(SORT(gotOffenses, seq), eyeball), NAMED('gotOffenses'));
  // OUTPUT(CHOOSEN(DEDUP(SORT(gotOffenses, seq, offender_key), seq, offender_key), eyeball), NAMED('gotOffensesUniqueOFK'));
  // OUTPUT(CHOOSEN(SORT(countedOffensesTemp, seq, provider_type, dont_count1, dont_count2, dont_count3), eyeball), NAMED('countedOffensesTemp'));
  // OUTPUT(CHOOSEN(SORT(countedOffenses, seq), eyeball), NAMED('countedOffenses'));
  // OUTPUT(CHOOSEN(SORT(rolledOffenses, seq), eyeball), NAMED('rolledOffenses'));
  // OUTPUT(CHOOSEN(SORT(cleanedOffenses, seq), eyeball), NAMED('cleanedOffenses'));
  // OUTPUT(CHOOSEN(SORT(final_Offenses, seq), eyeball), NAMED('final_Offenses'));
  // OUTPUT(CHOOSEN(SORT(gotIncarcerationTemp, seq), eyeball), NAMED('gotIncarcerationTemp'));
  // OUTPUT(CHOOSEN(SORT(gotIncarceration, seq), eyeball), NAMED('gotIncarceration'));
  
  
  /* ****************************************
   *          Return Final Output           *
   ******************************************/
  return withIncarceration;
END;