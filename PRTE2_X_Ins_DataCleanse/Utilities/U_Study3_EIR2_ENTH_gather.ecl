/* ******************************************************
Use ENTH and pull The records we want
Save those to thor files for use if needed
DESpray them for use if needed
combine them to grab only the DID, DEDUP - then save and despray that
****************************************************** */


IMPORT PRTE2_Common, ut;
#workunit('name', 'EIR Data Study');

dateString	:= ut.GetDate;
LandingZoneIP := PRTE2_Common.Constants.InsLandingZone;
InsLandingPathPrefix := PRTE2_Common.Constants.InsLandingPathPrefix;														 
DesprayPath := InsLandingPathPrefix+'prct2/BC3800/'; 
SmallFactor 	:= 10000;
MiddleFactor 	:= 100000;
LargeFactor 	:= 1000000;

// ----------------------------------------------------------
// Bankruptcy  -- bankruptcies_v3_children
PrmCSVBk	:= '~thor400_30::TMP::CUSTTEST::EIR2_STUDY::BKRCT_CSV';
TmpCSVBk	:= 'TMP::CUSTTEST::TEMP::BKRCT_CSV_' +  WORKUNIT;
DSBK := BankruptcyV3.key_bankruptcyV3_did(true);
CTBK := ENTH(DSBK,1,MiddleFactor);
CNTBK := COUNT(CTBK);
output(CNTBK,NAMED('BKRUPCY_CNT'));
output(CTBK,NAMED('BKRUPCY'));
output(CTBK,,PrmCSVBk,overwrite);
didBkSet := SET(CTBK,(INTEGER)DID);
DNBK := DesprayPath+'Bankruptcy_'+dateString+'.csv';
PRTE2_Common.DesprayCSV(CTBK, TmpCSVBk, LandingZoneIP, DNBK);

// ----------------------------------------------------------
// Concealed Weapons -- concealed_weapon_licenses_children
PrmCCW	:= '~thor400_30::TMP::CUSTTEST::EIR2_STUDY::CCW_CSV';
TmpCCW	:= 'TMP::CUSTTEST::TEMP::CCW_CSV_' +  WORKUNIT;
DSCCW := doxie_files.key_ccw_did(true);
CTCCW := ENTH(DSCCW,1,SmallFactor);
// CNTCCW := COUNT(CTCCW);
// output(CNTCCW,NAMED('CCW_CNT'));
output(CTCCW,NAMED('CCW'));
output(CTCCW,,PrmCCW,overwrite);
didCCWSet := SET(CTCCW,(INTEGER)DID);
DNCCW := DesprayPath+'ConcealedWeapons_'+dateString+'.csv';
PRTE2_Common.DesprayCSV(CTCCW, TmpCCW, LandingZoneIP, DNCCW);

// ----------------------------------------------------------
// Hunting Fishing -- hunting_licenses_children
PrmHF	:= '~thor400_30::TMP::CUSTTEST::EIR2_STUDY::HF_CSV';
TmpHF	:= 'TMP::CUSTTEST::TEMP::HF_CSV_' +  WORKUNIT;
DSHF := doxie_files.key_hunters_did(true);
CTHF := ENTH(DSHF,1,LargeFactor);
// CNTHF := COUNT(CTHF);
// output(CNTHF,NAMED('HF_CNT'));
output(CTHF,NAMED('HUNTERS'));
output(CTHF,,PrmHF,overwrite);
didHFSet := SET(CTHF,(INTEGER)DID);
DNHF := DesprayPath+'HuntFish_'+dateString+'.csv';
PRTE2_Common.DesprayCSV(CTHF, TmpHF, LandingZoneIP, DNHF);

// ----------------------------------------------------------
// Criminal Offenses  -- DOC2_children
// the heading you provided may refer to more sections, incl sexOffenders -- if so, we can dig deeper
PrmCO	:= '~thor400_30::TMP::CUSTTEST::EIR2_STUDY::CO_CSV';
TmpCO	:= 'TMP::CUSTTEST::TEMP::CO_CSV_' +  WORKUNIT;
DSCO := doxie_files.Key_Offenders(true);
CTCO := ENTH(DSCO,1,LargeFactor);
// CNTCO := COUNT(CTCO);
// output(CNTCO,NAMED('CO_CNT'));
output(CTCO,NAMED('CRIMINAL'));
output(CTCO,,PrmCO,overwrite);
didCOSet := SET(CTCO,(INTEGER)SDID);
DNCO := DesprayPath+'Criminal_'+dateString+'.csv';
PRTE2_Common.DesprayCSV(CTCO, TmpCO, LandingZoneIP, DNCO);



// ----------------------------------------------------------
// Liens and Judgments -- liens_judgements_v2_children
PrmLJ	:= '~thor400_30::TMP::CUSTTEST::EIR2_STUDY::LJ_CSV';
TmpLJ	:= 'TMP::CUSTTEST::TEMP::LJ_CSV_' +  WORKUNIT;
DSLJ := liensv2.key_liens_did_fcra;
CTLJ := ENTH(DSLJ,1,LargeFactor);
// CNTLJ := COUNT(CTLJ);
// output(CNTLJ,NAMED('LJ_CNT'));
output(CTLJ,NAMED('LIENS'));
output(CTLJ,,PrmLJ,overwrite);
didLJSet := SET(CTLJ,(INTEGER)DID);
DNLJ := DesprayPath+'Liens_'+dateString+'.csv';
PRTE2_Common.DesprayCSV(CTLJ, TmpLJ, LandingZoneIP, DNLJ);


// ----------------------------------------------------------
// Professional Licenses -- professional_licenses_children
PrmPL	:= '~thor400_30::TMP::CUSTTEST::EIR2_STUDY::PL_CSV';
TmpPL	:= 'TMP::CUSTTEST::TEMP::PL_CSV_' +  WORKUNIT;
DSPL := prof_licenseV2.key_proflic_did(true);
CTPL := ENTH(DSPL,1,LargeFactor);
// CNTPL := COUNT(CTPL);
// output(CNTPL,NAMED('PL_CNT'));
output(CTPL,NAMED('PROF_LIC'));
output(CTPL,,PrmPL,overwrite);
didPLSet := SET(CTPL,(INTEGER)DID);
DNPL := DesprayPath+'Professional_Lic_'+dateString+'.csv';
PRTE2_Common.DesprayCSV(CTPL, TmpPL, LandingZoneIP, DNPL);

// ----------------------------------------------------------
// UCC Filings -- uccv2_children
PrmUCC	:= '~thor400_30::TMP::CUSTTEST::EIR2_STUDY::UCC_CSV';
TmpUCC	:= 'TMP::CUSTTEST::TEMP::UCC_CSV_' +  WORKUNIT;
DSUCC := uccv2.key_did_w_Type(true);
CTUCC := ENTH(DSUCC,1,LargeFactor);
// CNTUCC := COUNT(CTUCC);
// output(CNTUCC,NAMED('UCC_CNT'));
output(CTUCC,NAMED('UCC'));
output(CTUCC,,PrmUCC,overwrite);
didUCCSet := SET(CTUCC,(INTEGER)DID);
DNUCC := DesprayPath+'UCC_'+dateString+'.csv';
PRTE2_Common.DesprayCSV(CTUCC, TmpUCC, LandingZoneIP, DNUCC);

// ----------------------------------------------------------
// FAA Aircraft 
  // pilot_licenses_children 
	// pilot_certificates_children
	PrmAMN	:= '~thor400_30::TMP::CUSTTEST::EIR2_STUDY::AMN_CSV';
	TmpAMN	:= 'TMP::CUSTTEST::TEMP::AMN_CSV_' +  WORKUNIT;
	DSAMN := faa.key_airmen_did(true);
	CTAMN := ENTH(DSAMN,1,MiddleFactor);
	// CNTAMN := COUNT(CTAMN);
	// output(CNTAMN,NAMED('AMN_CNT'));
	output(CTAMN,NAMED('AIRMEN'));
	output(CTAMN,,PrmAMN,overwrite);
didAMNSet := SET(CTAMN,(INTEGER)DID);
	DNAMN := DesprayPath+'Airmen_'+dateString+'.csv';
	PRTE2_Common.DesprayCSV(CTAMN, TmpAMN, LandingZoneIP, DNAMN);

// ----------------------------------------------------------
  // pilot_aircraft_children    
	PrmACF	:= '~thor400_30::TMP::CUSTTEST::EIR2_STUDY::ACF_CSV';
	TmpACF	:= 'TMP::CUSTTEST::TEMP::ACF_CSV_' +  WORKUNIT;
	DSACF := faa.key_aircraft_did(true);
	CTACF := ENTH(DSACF,1,SmallFactor);
	// CNTACF := COUNT(CTACF);
	// output(CNTACF,NAMED('ACF_CNT'));
	output(CTACF,NAMED('AIRCRAFT'));
	output(CTACF,,PrmACF,overwrite);
didACFSet := SET(CTACF,(INTEGER)DID);
	DNACF := DesprayPath+'Aircraft_'+dateString+'.csv';
	PRTE2_Common.DesprayCSV(CTACF, TmpACF, LandingZoneIP, DNACF);

// ----------------------------------------------------------
// Property -- propertyV2_children
PrmPROP	:= '~thor400_30::TMP::CUSTTEST::EIR2_STUDY::PROP_CSV';
TmpPROP	:= 'TMP::CUSTTEST::TEMP::PROP_CSV_' +  WORKUNIT;
DSPROP := LN_PropertyV2.key_ownership_did(true);
CTPROP := ENTH(DSPROP,1,LargeFactor);
// CNTPROP := COUNT(CTPROP);
// output(CNTPROP,NAMED('PROP_CNT'));
output(CTPROP,NAMED('LNPROP'));
output(CTPROP,,PrmPROP,overwrite);
didPROPSet := SET(CTPROP,(INTEGER)DID);
DNPROP := DesprayPath+'Property_'+dateString+'.csv';
PRTE2_Common.DesprayCSV(CTPROP, TmpPROP, LandingZoneIP, DNPROP);

// ----------------------------------------------------------
// Watercraft -- 
PrmWC	:= '~thor400_30::TMP::CUSTTEST::EIR2_STUDY::WC_CSV';
TmpWC	:= 'TMP::CUSTTEST::TEMP::WC_CSV_' +  WORKUNIT;
DSWC := watercraft.key_watercraft_did(true);
CTWC := ENTH(DSWC,1,MiddleFactor);
// CNTWC := COUNT(CTWC);
// output(CNTWC,NAMED('WC_CNT'));
Output(CTWC,NAMED('WATER'));
output(CTWC,,PrmWC,overwrite);
didWCSet := SET(CTWC,(INTEGER)L_DID);
DNWC := DesprayPath+'WaterCraft_'+dateString+'.csv';
PRTE2_Common.DesprayCSV(CTWC, TmpWC, LandingZoneIP, DNWC);

// ----------------------------------------------------------
DIDREC := RECORD
	INTEGER DID := 0;
END;

TmpAll	:= 'TMP::CUSTTEST::TEMP::DIDSONLY_' +  WORKUNIT;
FinalSet := didBkSet+didCCWSet+didHFSet+didCOSet+didLJSet+didPLSet
						+didUCCSet+didAMNSet+didACFSet+didPROPSet+didWCSet;

DSPreFinal := DATASET(FinalSet,DIDREC);
DSFinal := DEDUP(SORT(DSPreFinal,DID),DID);
PrmALL	:= '~thor400_30::TMP::CUSTTEST::EIR2_STUDY::FINALDEDUPED_DIDS';
output(DSFinal,,PrmALL,overwrite);
DNALL := DesprayPath+'DIDs_Only_'+dateString+'.csv';
PRTE2_Common.DesprayCSV(DSFinal, TmpAll, LandingZoneIP, DNALL);

// ----------------------------------------------------------

