EXPORT RV_Attributes_V3_BATCH_Macro (fcraroxie_IP,neutralroxie_IP, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro


IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

unsigned8 no_of_records := records_ToRun;
integer eyeball := 50;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String neutralroxieIP := neutralroxie_IP ; 
String fcraroxieIP := fcraroxie_IP ;

Infile_name :=  Input_file_name;

String outfile_name :=  Output_file_name ;

archive_date := (integer) ut.getdate ;
// today         := ut.GetDate[3..];

string DataRestrictionMask  := '10000100010001 '; // to restrict fares, experian, transunion and experian FCRA

//==================  input file layout  ========================
layout_input := RECORD
    Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;
 

f1 := IF(no_of_records <= 0, dataset(ut.foreign_prod + infile_name, layout_input, CSV(heading(single), quote('"'))) ,
                            CHOOSEN(DATASET(ut.foreign_prod + infile_name, layout_input, CSV(heading(single), quote('"'))), no_of_records));
														
ds_input := distribute(f1, hash64(accountnumber));

//====================================================
//=============  Service settings ====================
//====================================================
// Neutral service ip
// neutral_roxie_IP := riskwise.shortcuts.staging_neutral_roxieip ;

// FCRA service settings
// fcraroxieIP := riskwise.shortcuts.staging_fcra_roxieip ;
// prod RiskWise.Shortcuts.prod_batch_fcra; 		// FCRAbatch Roxie





layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	boolean IncludeVersion3;
	BOOLEAN IsPreScreen;	
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input le, integer c) := TRANSFORM
	self.seq := c;
	SELF.acctno :=(string) le.accountnumber;
	SELF.Name_First := le.FirstName;
	SELF.Name_Middle := le.MiddleName;
	SELF.Name_Last := le.LastName;
	SELF.street_addr := le.StreetAddress;
	SELF.p_City_name := le.CITY;
	SELF.St := le.STATE;
	SELF.z5 := le.ZIP;
	SELF.Home_Phone := le.HomePhone;
	SELF.SSN := le.SSN;
	SELF.DOB := le.DateOfBirth;
	SELF.Work_Phone := le.WorkPhone;
	self.historydateyyyymm := le.historydateyyyymm ;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{'FCRA', neutralroxieIP}], risk_indicators.layout_gateways_in);
	SELF.IsPreScreen := true;		
	self.IncludeVersion3 := true;
	SELF.DataRestrictionMask := DataRestrictionMask;
END;
	
soap_in := PROJECT(ds_input, make_rv_in(LEFT, counter));
// OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('soap_in'));

roxie_out_layout := RECORD
	models.Layout_RiskView_Batch_Out;
	string200 errorcode;
END;
       
roxie_out_layout myfail(soap_in L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.acctno := l.batch_in[1].acctno;
	self := [];
end;

resu := soapcall(soap_in, fcraroxieIP ,
										'models.RiskView_Batch_Service', 
										{soap_in},
                    dataset(roxie_out_layout),
										RETRY(retry), TIMEOUT(timeout),
										parallel(threads) ,
										onfail(myfail(LEFT)));

// output(choosen(resu, eyeball), named('soap_results'));
errors := resu(errorcode<>'');
// output(choosen(errors, eyeball), named('errors'));
op := output(count(errors), named('rv_batch30_error_count'));

just_rv_attributes_v3 := 

RECORD
	string12 DID;
	string30 AccountNumber;

 
  string4 ageoldestrecord;
  string4 agenewestrecord;
  string1 isrecentupdate;
  string3 numsources;
  string1 verifiedphonefullname;
  string1 verifiedphonelastname;
  string1 invalidssn;
  string1 invalidphone;
  string1 invalidaddr;
  string1 invaliddl;
  string1 isnover;
  string1 ssndeceased;
  string8 deceaseddate;
  string1 ssnvalid;
  string1 recentissue;
  string8 lowissuedate;
  string8 highissuedate;
  string2 issuestate;
  string1 nonus;
  string1 issued3;
  string1 issuedage5;
  string4 iaageoldestrecord;
  string4 iaagenewestrecord;
  string4 ialenofres;
  string1 iadwelltype;
  string1 ialandusecode;
  string iaassessedvalue;
  string1 iaownedbysubject;
  string1 iafamilyowned;
  string1 iaoccupantowned;
  string4 iaagelastsale;
  string ialastsaleamount;
  string1 ianotprimaryres;
  string1 iaphonelisted;
  string10 iaphonenumber;
  string4 caageoldestrecord;
  string4 caagenewestrecord;
  string4 calenofres;
  string1 cadwelltype;
  string1 calandusecode;
  string caassessedvalue;
  string1 caownedbysubject;
  string1 cafamilyowned;
  string1 caoccupantowned;
  string4 caagelastsale;
  string calastsaleamount;
  string1 canotprimaryres;
  string1 caphonelisted;
  string10 caphonenumber;
  string4 paageoldestrecord;
  string4 paagenewestrecord;
  string4 palenofres;
  string1 padwelltype;
  string1 palandusecode;
  string paassessedvalue;
  string1 paownedbysubject;
  string1 pafamilyowned;
  string1 paoccupantowned;
  string4 paagelastsale;
  string palastsaleamount;
  string1 paphonelisted;
  string10 paphonenumber;
  string1 inputcurrmatch;
  string distinputcurr;
  string1 diffstate;
  string assesseddiff;
  string2 ecotrajectory;
  string1 inputprevmatch;
  string distcurrprev;
  string1 diffstate2;
  string assesseddiff2;
  string2 ecotrajectory2;
  string1 mobility_indicator;
  string1 statusaddr;
  string1 statusaddr2;
  string1 statusaddr3;
  string3 addrchanges30;
  string3 addrchanges90;
  string3 addrchanges180;
  string3 addrchanges12;
  string3 addrchanges24;
  string3 addrchanges36;
  string3 addrchanges60;
  string3 property_owned_total;
  string14 property_owned_assessed_total;
  string3 property_historically_owned;
  string4 propageoldestpurchase;
  string4 propagenewestpurchase;
  string4 propagenewestsale;
  string3 numpurchase30;
  string3 numpurchase90;
  string3 numpurchase180;
  string3 numpurchase12;
  string3 numpurchase24;
  string3 numpurchase36;
  string3 numpurchase60;
  string3 numsold30;
  string3 numsold90;
  string3 numsold180;
  string3 numsold12;
  string3 numsold24;
  string3 numsold36;
  string3 numsold60;
  string3 numwatercraft;
  string3 numwatercraft30;
  string3 numwatercraft90;
  string3 numwatercraft180;
  string3 numwatercraft12;
  string3 numwatercraft24;
  string3 numwatercraft36;
  string3 numwatercraft60;
  string3 numaircraft;
  string3 numaircraft30;
  string3 numaircraft90;
  string3 numaircraft180;
  string3 numaircraft12;
  string3 numaircraft24;
  string3 numaircraft36;
  string3 numaircraft60;
  string1 wealth_indicator;
  string3 total_number_derogs;
  string4 derogage;
  string3 felonies;
  string4 felonyage;
  string3 felonies30;
  string3 felonies90;
  string3 felonies180;
  string3 felonies12;
  string3 felonies24;
  string3 felonies36;
  string3 felonies60;
  string3 num_liens;
  string3 num_unreleased_liens;
  string4 lienfiledage;
  string3 num_unreleased_liens30;
  string3 num_unreleased_liens90;
  string3 num_unreleased_liens180;
  string3 num_unreleased_liens12;
  string3 num_unreleased_liens24;
  string3 num_unreleased_liens36;
  string3 num_unreleased_liens60;
  string3 num_released_liens;
  string4 lienreleasedage;
  string3 num_released_liens30;
  string3 num_released_liens90;
  string3 num_released_liens180;
  string3 num_released_liens12;
  string3 num_released_liens24;
  string3 num_released_liens36;
  string3 num_released_liens60;
  string3 bankruptcy_count;
  string4 bankruptcyage;
  string1 filing_type;
  string35 disposition;
  string3 bankruptcy_count30;
  string3 bankruptcy_count90;
  string3 bankruptcy_count180;
  string3 bankruptcy_count12;
  string3 bankruptcy_count24;
  string3 bankruptcy_count36;
  string3 bankruptcy_count60;
  string3 eviction_count;
  string4 evictionage;
  string3 eviction_count30;
  string3 eviction_count90;
  string3 eviction_count180;
  string3 eviction_count12;
  string3 eviction_count24;
  string3 eviction_count36;
  string3 eviction_count60;
  string3 num_nonderogs;
  string3 num_nonderogs30;
  string3 num_nonderogs90;
  string3 num_nonderogs180;
  string3 num_nonderogs12;
  string3 num_nonderogs24;
  string3 num_nonderogs36;
  string3 num_nonderogs60;
  string3 num_proflic;
  string4 proflicage;
  string60 proflic_type;
  string8 expire_date_last_proflic;
  string3 num_proflic30;
  string3 num_proflic90;
  string3 num_proflic180;
  string3 num_proflic12;
  string3 num_proflic24;
  string3 num_proflic36;
  string3 num_proflic60;
  string3 num_proflic_exp30;
  string3 num_proflic_exp90;
  string3 num_proflic_exp180;
  string3 num_proflic_exp12;
  string3 num_proflic_exp24;
  string3 num_proflic_exp36;
  string3 num_proflic_exp60;
  string1 addrhighrisk;
  string1 phonehighrisk;
  string1 addrprison;
  string1 zippobox;
  string1 zipcorpmil;
  string1 phonestatus;
  string1 phonepager;
  string1 phonemobile;
  string1 phonezipmismatch;
  string4 phoneaddrdist;
  string1 correctedflag;
  string1 securityfreeze;
  string1 securityalert;
  string1 idtheftflag;
  string1 ssnnotfound;
  string3 verifiedname;
  string3 verifiedssn;
  string3 verifiedphone;
  string3 verifiedaddress;
  string3 verifieddob;
  string3 inferredminimumage;
  string3 bestreportedage;
  string3 subjectssncount;
  string3 subjectaddrcount;
  string3 subjectphonecount;
  string3 subjectssnrecentcount;
  string3 subjectaddrrecentcount;
  string3 subjectphonerecentcount;
  string3 ssnidentitiescount;
  string3 ssnaddrcount;
  string3 ssnidentitiesrecentcount;
  string3 ssnaddrrecentcount;
  string3 inputaddridentitiescount;
  string3 inputaddrssncount;
  string3 inputaddrphonecount;
  string3 inputaddridentitiesrecentcount;
  string3 inputaddrssnrecentcount;
  string3 inputaddrphonerecentcount;
  string3 phoneidentitiescount;
  string3 phoneidentitiesrecentcount;
  string1 ssnissuedpriordob;
  string4 inputaddrtaxyr;
  string14 inputaddrtaxmarketvalue;
  string14 inputaddravmtax;
  string14 inputaddravmsalesprice;
  string14 inputaddravmhedonic;
  string14 inputaddravmvalue;
  string3 inputaddravmconfidence;
  string8 inputaddrcountyindex;
  string8 inputaddrtractindex;
  string8 inputaddrblockindex;
  string4 curraddrtaxyr;
  string14 curraddrtaxmarketvalue;
  string14 curraddravmtax;
  string14 curraddravmsalesprice;
  string14 curraddravmhedonic;
  string14 curraddravmvalue;
  string3 curraddravmconfidence;
  string8 curraddrcountyindex;
  string8 curraddrtractindex;
  string8 curraddrblockindex;
  string4 prevaddrtaxyr;
  string14 prevaddrtaxmarketvalue;
  string14 prevaddravmtax;
  string14 prevaddravmsalesprice;
  string14 prevaddravmhedonic;
  string14 prevaddravmvalue;
  string3 prevaddravmconfidence;
  string8 prevaddrcountyindex;
  string8 prevaddrtractindex;
  string8 prevaddrblockindex;
  string1 educationattendedcollege;
  string1 educationprogram2yr;
  string1 educationprogram4yr;
  string1 educationprogramgraduate;
  string1 educationinstitutionprivate;
  string1 educationinstitutionrating;
  string predictedannualincome;
  string14 propnewestsaleprice;
  string8 propnewestsalepurchaseindex;
  string3 subprimesolicitedcount;
  string3 subprimesolicitedcount01;
  string3 subprimesolicitedcount03;
  string3 subprimesolicitedcount06;
  string3 subprimesolicitedcount12;
  string3 subprimesolicitedcount24;
  string3 subprimesolicitedcount36;
  string3 subprimesolicitedcount60;
  string14 lienfederaltaxfiledtotal;
  string14 lientaxotherfiledtotal;
  string14 lienforeclosurefiledtotal;
  string14 lienpreforeclosurefiledtotal;
  string14 lienlandlordtenantfiledtotal;
  string14 lienjudgmentfiledtotal;
  string14 liensmallclaimsfiledtotal;
  string14 lienotherfiledtotal;
  string14 lienfederaltaxreleasedtotal;
  string14 lientaxotherreleasedtotal;
  string14 lienforeclosurereleasedtotal;
  string14 lienpreforeclosurereleasedtotal;
  string14 lienlandlordtenantreleasedtotal;
  string14 lienjudgmentreleasedtotal;
  string14 liensmallclaimsreleasedtotal;
  string14 lienotherreleasedtotal;
  string3 lienfederaltaxfiledcount;
  string3 lientaxotherfiledcount;
  string3 lienforeclosurefiledcount;
  string3 lienpreforeclosurefiledcount;
  string3 lienlandlordtenantfiledcount;
  string3 lienjudgmentfiledcount;
  string3 liensmallclaimsfiledcount;
  string3 lienotherfiledcount;
  string3 lienfederaltaxreleasedcount;
  string3 lientaxotherreleasedcount;
  string3 lienforeclosurereleasedcount;
  string3 lienpreforeclosurereleasedcount;
  string3 lienlandlordtenantreleasedcount;
  string3 lienjudgmentreleasedcount;
  string3 liensmallclaimsreleasedcount;
  string3 lienotherreleasedcount;
  string1 proflictypecategory;
  string4 phoneedaageoldestrecord;
  string4 phoneedaagenewestrecord;
  string4 phoneotherageoldestrecord;
  string4 phoneotheragenewestrecord;
  string1 prescreenoptout;
  string6 history_date;
  string200 errorcode;
 END;



rv_attributes_v3 := project(resu, 
	transform(just_rv_attributes_v3, 
	self.accountnumber := left.acctno;
	self.history_date := (string6)archive_date;
  self.invalidssn := left.isSSNInvalid;	

SELF.verifiedphonefullname:=  left.isPhoneFullNameMatch ;
SELF.verifiedphonelastname:=  left.isPhoneLastNameMatch ;
SELF.invalidphone:=  left.isPhoneInvalid;
SELF.invalidaddr:=  left.isAddrInvalid;
SELF.invaliddl:=  left.isDLInvalid;
SELF.ssndeceased:=  left.isDeceased;
SELF.ssnvalid:=  left.isSSNValid;
SELF.recentissue:=  left.isRecentIssue;
SELF.nonus:=  left.isNonUS;
SELF.issued3:=  left.isIssued3;
SELF.issuedage5:=  left.isIssuedAge5;
SELF.iaownedbysubject:=  left.IAisOwnedBySubject;
SELF.iafamilyowned:=  left.IAisFamilyOwned;
SELF.iaoccupantowned:=  left.IAisOccupantOwned;
SELF.ianotprimaryres:=  left.IAisNotPrimaryRes;
SELF.caownedbysubject:=  left.CAisOwnedBySubject;
SELF.cafamilyowned:=  left.CAisFamilyOwned;
SELF.caoccupantowned:=  left.CAisOccupantOwned;
SELF.canotprimaryres:=  left.CAisNotPrimaryRes;
SELF.paownedbysubject:=  left.PAisOwnedBySubject;
SELF.pafamilyowned:=  left.PAisFamilyOwned;
SELF.paoccupantowned:=  left.PAisOccupantOwned;
SELF.inputcurrmatch:=  left.isInputCurrMatch;
SELF.diffstate:=  left.isDiffState;
SELF.inputprevmatch:=  left.isInputPrevMatch;
SELF.diffstate2:=  left.isDiffState2;
SELF.addrhighrisk:=  left.isAddrHighRisk;
SELF.phonehighrisk:=  left.isPhoneHighRisk;
SELF.addrprison:=  left.isAddrPrison;
SELF.zippobox:=  left.isZipPOBox;
SELF.zipcorpmil:=  left.isZipCorpMil;
SELF.phonepager:=  left.isPhonePager;
SELF.phonemobile:=  left.isPhoneMobile;
SELF.phonezipmismatch:=  left.isPhoneZipMismatch;
	
	
	// self.RecentUpdate	:= left.isrecentupdate		;
	// self.SrcsConfirmIDAddrCount	:= left.numsources		;
	// self.VerificationFailure	:= left.isnover		;
	// self.SSNDateDeceased	:= left.deceaseddate		;
	// self.SSNRecent	:= left.isrecentissue		;
	// self.SSNLowIssueDate	:= left.lowissuedate		;
	// self.InputAddrAgeNewestRecord	:= left.iaagenewestrecord		;
	// self.InputAddrAleft.OfRes	:= left.ialeft.ofres		;
	// self.InputAddrDwellType	:= left.iadwelltype		;
	// self.InputAddrLandUseCode	:= left.ialandusecode		;
	// self.InputAddrOwnedBySubject	:= left.iaownedbysubject		;
	// self.InputAddrFamilyOwned	:= left.iafamilyowned		;
	// self.InputAddrOccupantOwned	:= left.iaoccupantowned		;
	// self.InputAddrAgeLastSaleft.:= left.iaagelastsaleft.	;
	// self.InputAddrLastSaleft.Price	:= left.ialastsaleft.mount		;
	// self.InputAddrNotPrimaryRes	:= left.ianotprimaryres		;
	// self.InputAddrActivePhoneList	:= left.iaphonelisted		;
	// self.InputAddrActivePhoneNumber	:= left.iaphonenumber		;
	// self.InputAddrTaxValue	:= left.iaassessedvalue		;
	// self.CurrAddrAgeOldestRecord	:= left.caageoldestrecord		;
	// self.CurrAddrAgeNewestRecord	:= left.caagenewestrecord		;
	// self.CurrAddrleft.OfRes	:= left.caleft.ofres		;
	// self.CurrAddrDwellType	:= left.cadwelltype		;
	// self.CurrAddrALandUseCode	:= left.calandusecode		;
	// self.CurrAddrApplicantOwned	:= left.caownedbysubject		;
	// self.CurrAddrFamilyOwned	:= left.cafamilyowned		;
	// self.CurrAddrOccupantOwned	:= left.caoccupantowned		;
	// self.CurrAddrAgeLastSaleft.:= left.caagelastsaleft.	;
	// self.CurrAddrLastSaleft.Price	:= left.calastsaleft.mount		;
	// self.CurrAddrNotPrimaryRes	:= left.canotprimaryres		;
	// self.CurrAddrActivePhoneList	:= left.caphonelisted		;
	// self.CurrAddrActivePhoneNumber	:= left.caphonenumber		;
	// self.CurrAddrTaxValue	:= left.caassessedvalue		;
	// self.PrevAddrAgeOldestRecord	:= left.paageoldestrecord		;
	// self.PrevAddrAgeNewestRecord	:= left.paagenewestrecord		;
	// self.PrevAddrleft.OfRes	:= left.paleft.ofres		;
	// self.PrevAddrDwellType	:= left.padwelltype		;
	// self.PrevAddrLandUseCode	:= left.palandusecode		;
	// self.PrevAddrApplicantOwned	:= left.paownedbysubject		;
	// self.PrevAddrFamilyOwned	:= left.pafamilyowned		;
	// self.PrevAddrOccupantOwned	:= left.paoccupantowned		;
	// self.PrevAddrAgeLastSaleft.:= left.paagelastsaleft.	;
	// self.PrevAddrLastSaleft.Price	:= left.palastsaleft.mount		;
	// self.PrevAddrPhoneListed	:= left.paphonelisted		;
	// self.PrevAddrPhoneNumber	:= left.paphonenumber		;
	// self.PrevAddrAssessedValue	:= left.paassessedvalue		;
	// self.InputCurrAddrMatch	:= left.inputcurrmatch		;
	// self.InputCurrAddrDistance	:= left.distinputcurr		;
	// self.InputCurrAddrStateDiff	:= left.diffstate		;
	// self.InputCurrAddrTaxDiff	:= left.assesseddiff		;
	// self.InputCurrEconTrajectory	:= left.ecotrajectory		;
	// self.InputPrevAddrMatch	:= left.inputprevmatch		;
	// self.CurrPrevAddrDistance	:= left.distcurrprev		;
	// self.CurrPrevAddrStateDiff	:= left.diffstate2		;
	// self.CurrPrevAddrTaxDiff	:= left.assesseddiff2		;
	// self.PrevCurrEconTrajectory	:= left.ecotrajectory2		;
	// self.AddrStability	:= left.mobility_indicator		;
	// self.StatusMostRecent	:= left.statusaddr		;
	// self.StatusPrevious	:= left.statusaddr2		;
	// self.StatusNextPrevious	:= left.statusaddr3		;
	// self.AddrChangeCount01	:= left.addrchanges30		;
	// self.AddrChangeCount03	:= left.addrchanges90		;
	// self.AddrChangeCount06	:= left.addrchanges180		;
	// self.AddrChangeCount12	:= left.addrchanges12		;
	// self.AddrChangeCount24	:= left.addrchanges24		;
	// self.AddrChangeCount36	:= left.addrchanges36		;
	// self.AddrChangeCount60	:= left.addrchanges60		;
	// self.PropOwnedCount	:= left.property_owned_total		;
	// self.PropOwnedTaxTotal	:= left.property_owned_assessed_total		;
	// self.PropOwnedHistoricalCount	:= left.property_historically_owned		;
	// self.PropPurchasedCount01	:= left.numpurchase30		;
	// self.PropPurchasedCount03	:= left.numpurchase90		;
	// self.PropPurchasedCount06	:= left.numpurchase180		;
	// self.PropPurchasedCount12	:= left.numpurchase12		;
	// self.PropPurchasedCount24	:= left.numpurchase24		;
	// self.PropPurchasedCount36	:= left.numpurchase36		;
	// self.PropPurchasedCount60	:= left.numpurchase60		;
	// self.PropSoldCount01	:= left.numsold30		;
	// self.PropSoldCount03	:= left.numsold90		;
	// self.PropSoldCount06	:= left.numsold180		;
	// self.PropSoldCount12	:= left.numsold12		;
	// self.PropSoldCount24	:= left.numsold24		;
	// self.PropSoldCount36	:= left.numsold36		;
	// self.PropSoldCount60	:= left.numsold60		;
	// self.WatercraftCount	:= left.numwatercraft		;
	// self.WatercraftCount01	:= left.numwatercraft30		;
	// self.WatercraftCount03	:= left.numwatercraft90		;
	// self.WatercraftCount06	:= left.numwatercraft180		;
	// self.WatercraftCount12	:= left.numwatercraft12		;
	// self.WatercraftCount24	:= left.numwatercraft24		;
	// self.WatercraftCount36	:= left.numwatercraft36		;
	// self.WatercraftCount60	:= left.numwatercraft60		;
	// self.AircraftCount	:= left.numaircraft		;
	// self.AircraftCount01	:= left.numaircraft30		;
	// self.AircraftCount03	:= left.numaircraft90		;
	// self.AircraftCount06	:= left.numaircraft180		;
	// self.AircraftCount12	:= left.numaircraft12		;
	// self.AircraftCount24	:= left.numaircraft24		;
	// self.AircraftCount36	:= left.numaircraft36		;
	// self.AircraftCount60	:= left.numaircraft60		;
	// self.WealthIndex	:= left.wealth_indicator		;
	// self.DerogCount	:= left.total_number_derogs		;
	// self.FelonyCount	:= left.felonies		;
	// self.FelonyCount01	:= left.felonies30		;
	// self.FelonyCount03	:= left.felonies90		;
	// self.FelonyCount06	:= left.felonies180		;
	// self.FelonyCount12	:= left.felonies12		;
	// self.FelonyCount24	:= left.felonies24		;
	// self.FelonyCount36	:= left.felonies36		;
	// self.FelonyCount60	:= left.felonies60		;
	// self.LienCount	:= left.num_liens		;
	// self.LienFileft.Count	:= left.num_unreleft.sed_liens		;
	// self.LienFileft.Count01	:= left.num_unreleft.sed_liens30		;
	// self.LienFileft.Count03	:= left.num_unreleft.sed_liens90		;
	// self.LienFileft.Count06	:= left.num_unreleft.sed_liens180		;
	// self.LienFileft.Count12	:= left.num_unreleft.sed_liens12		;
	// self.LienFileft.Count24	:= left.num_unreleft.sed_liens24		;
	// self.LienFileft.Count36	:= left.num_unreleft.sed_liens36		;
	// self.LienFileft.Count60	:= left.num_unreleft.sed_liens60		;
	// self.LienReleft.sedCount	:= left.num_releft.sed_liens		;
	// self.LienReleft.sedCount01	:= left.num_releft.sed_liens30		;
	// self.LienReleft.sedCount03	:= left.num_releft.sed_liens90		;
	// self.LienReleft.sedCount06	:= left.num_releft.sed_liens180		;
	// self.LienReleft.sedCount12	:= left.num_releft.sed_liens12		;
	// self.LienReleft.sedCount24	:= left.num_releft.sed_liens24		;
	// self.LienReleft.sedCount36	:= left.num_releft.sed_liens36		;
	// self.LienReleft.sedCount60	:= left.num_releft.sed_liens60		;
	// self.BankruptcyCount	:= left.bankruptcy_count		;
	// self.BankruptcyType	:= left.filing_type		;
	// self.BankruptcyStatus	:= left.disposition		;
	// self.BankruptcyCount01	:= left.bankruptcy_count30		;
	// self.BankruptcyCount03	:= left.bankruptcy_count90		;
	// self.BankruptcyCount06	:= left.bankruptcy_count180		;
	// self.BankruptcyCount12	:= left.bankruptcy_count12		;
	// self.BankruptcyCount24	:= left.bankruptcy_count24		;
	// self.BankruptcyCount36	:= left.bankruptcy_count36		;
	// self.BankruptcyCount60	:= left.bankruptcy_count60		;
	// self.EvictionCount	:= left.eviction_count		;
	// self.EvictionCount01	:= left.eviction_count30		;
	// self.EvictionCount03	:= left.eviction_count90		;
	// self.EvictionCount06	:= left.eviction_count180		;
	// self.EvictionCount12	:= left.eviction_count12		;
	// self.EvictionCount24	:= left.eviction_count24		;
	// self.EvictionCount36	:= left.eviction_count36		;
	// self.EvictionCount60	:= left.eviction_count60		;
	// self.NonDerogCount	:= left.num_nonderogs		;
	// self.NonDerogCount01	:= left.num_nonderogs30		;
	// self.NonDerogCount03	:= left.num_nonderogs90		;
	// self.NonDerogCount06	:= left.num_nonderogs180		;
	// self.NonDerogCount12	:= left.num_nonderogs12		;
	// self.NonDerogCount24	:= left.num_nonderogs24		;
	// self.NonDerogCount36	:= left.num_nonderogs36		;
	// self.NonDerogCount60	:= left.num_nonderogs60		;
	// self.ProfLicCount	:= left.num_proflic		;
	// self.ProfLicCount01	:= left.num_proflic30		;
	// self.ProfLicCount03	:= left.num_proflic90		;
	// self.ProfLicCount06	:= left.num_proflic180		;
	// self.ProfLicCount12	:= left.num_proflic12		;
	// self.ProfLicCount24	:= left.num_proflic24		;
	// self.ProfLicCount36	:= left.num_proflic36		;
	// self.ProfLicCount60	:= left.num_proflic60		;
	// self.ProflicExpireCount01	:= left.num_proflic_exp30		;
	// self.ProflicExpireCount03	:= left.num_proflic_exp90		;
	// self.ProflicExpireCount06	:= left.num_proflic_exp180		;
	// self.ProflicExpireCount12	:= left.num_proflic_exp12		;
	// self.ProflicExpireCount24	:= left.num_proflic_exp24		;
	// self.ProflicExpireCount36	:= left.num_proflic_exp36		;
	// self.ProflicExpireCount60	:= left.num_proflic_exp60		;
	// self.InputPhoneStatus	:= left.phonestatus		;
	// self.InputPhonePager	:= left.phonepager		;
	// self.InputPhoneMobileft.:= left.phonemobileft.	;
	// self.InvalidPhoneZip	:= left.phonezipmismatch		;
	// self.InputPhoneAddrDist	:= left.phoneaddrdist		;
	// self.InputAddrHighRisk	:= left.addrhighrisk		;
	// self.InputPhoneHighRisk	:= left.phonehighrisk		;
	// self.InputAddrPrison	:= left.addrprison		;
	// self.InputZipPOBox	:= left.zippobox		;
	// self.InputZipCorpMil	:= left.zipcorpmil		;
	self := left;
		));			


op_final := output(rv_attributes_v3 ,,outfile_name,CSV(heading(single), quote('"')), overwrite);

fin_res := sequential(op, op_final);

return fin_res;

endmacro;