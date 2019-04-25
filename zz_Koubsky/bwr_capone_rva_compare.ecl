// EXPORT bwr_capone_rva_compare := 'todo';

#workunit('name','RV v3 Attributes');
// #workunit('name','RV v4 Attributes');

import risk_indicators, ut, ashirey, Scoring_Project_Macros, Scoring_QA;

eyeball := 30;

input_layout := RECORD      //RV Attributes v3 XML
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
	RiskProcessing.layout_internal_extras;
 END;

prii_layout := RECORD
		Scoring_Project_Macros.Regression.global_layout;
		Scoring_Project_Macros.Regression.pii_layout;
		Scoring_Project_Macros.Regression.runtime_layout;
 END;







basefilename := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v3_20141111EPIC_baseline';        // use "v3" for version 3 and "v4" for version 4
testfilename := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v3_20141109EPIC_second';        // Can change xml to batch

pii_name := '~scoring_project::in::riskview_v3_batch_capitalone_attributes_20140709';  //choose version 3 or 4.  XML and Batch use same sample.

ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, prii_layout, thor);

// Scoring_QA.COMPARE_DSETS_MACRO( ds_baseline, ds_new, ['AccountNumber'], 0);

join_lay := RECORD
	input_layout;
	prii_layout;
END;

ds_join_baseline := JOIN( ds_baseline, ds_pii, (integer)LEFT.accountnumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF := LEFT; SELF := RIGHT));
ds_join_second := JOIN( ds_new, ds_pii, (integer)LEFT.accountnumber = RIGHT.accountnumber, TRANSFORM(join_lay, SELF := LEFT; SELF := []));

output(count(ds_baseline), named('file1_count'));
output(count(ds_new), named('file2_count'));

output(count(ds_baseline(iaassessedvalue > '0')), named('file1_iaassessed_hit'));
output(choosen(ds_baseline(iaassessedvalue > '0'), 40), named('file1_iaassessed_hit_detail'));
output(count(ds_new(iaassessedvalue > '0')), named('file2_iaassessed_hit'));

output(ave(ds_baseline(iaassessedvalue > '0'), (integer)iaassessedvalue), named('file1_iaassessed_average'));
output(ave(ds_new(iaassessedvalue > '0'), (integer)iaassessedvalue), named('file2_iaassessed_average'));
output(ave(ds_baseline(iaassessedvalue <> ''), (integer)iaassessedvalue), named('file1_iaassessed_average_w_zero'));
output(ave(ds_new(iaassessedvalue <> ''), (integer)iaassessedvalue), named('file2_iaassessed_average_w_zero'));

cmpr := record, maxlength(50000)
	DATASET(input_layout) res;
end;

cmpr2 := record, maxlength(50000)
	DATASET(join_lay) res;
end;

j1 := join(ds_baseline, ds_new, left.AccountNumber = right.AccountNumber
					AND LEFT.iaassessedvalue <> RIGHT.iaassessedvalue,
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

OUTPUT(count(j1), NAMED('diff_assessed_value_count'));
OUTPUT(choosen(j1, 25), NAMED('diff_assessed_value'));

j3 := join(ds_baseline, ds_new, left.AccountNumber = right.AccountNumber
					AND LEFT.iaassessedvalue <> RIGHT.iaassessedvalue
					and left.iaassessedvalue > '0'
					and RIGHT.iaassessedvalue > '0',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

OUTPUT(count(j3), NAMED('diff_hit_to_hit_count'));
OUTPUT(choosen(j3, 25), NAMED('diff_hit_to_hit'));

j2 := join(ds_baseline, ds_new, left.AccountNumber = right.AccountNumber
					AND LEFT.iaassessedvalue <> RIGHT.iaassessedvalue
					and right.iaassessedvalue in ['0', '']
					and left.iaassessedvalue > '0',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));

OUTPUT(count(j2), NAMED('diff_hit_to_nohit_count'));
OUTPUT(choosen(j2, 25), NAMED('diff_hit_to_nohit'));

j4 := join(ds_baseline, ds_new, left.AccountNumber = right.AccountNumber
					AND LEFT.iaassessedvalue <> RIGHT.iaassessedvalue
					and left.iaassessedvalue in ['0', '']
					and RIGHT.iaassessedvalue > '0',
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
					
OUTPUT(count(j4), NAMED('diff_nohit_to_hit_count'));
OUTPUT(choosen(j4, 25), NAMED('diff_nohit_to_hit'));

j11 := join(ds_baseline, ds_new, left.AccountNumber = right.AccountNumber
					AND LEFT.iaassessedvalue <> RIGHT.iaassessedvalue
					and left.iaassessedvalue in ['0', '']
					and right.iaassessedvalue in ['0', ''],
					TRANSFORM(cmpr, SELF.res := LEFT + RIGHT));
					
OUTPUT(count(j11), NAMED('diff_nohit_to_nohit_count'));
OUTPUT(choosen(j11, 25), NAMED('diff_nohit_to_nohit'));

j5 := join(ds_baseline, ds_new, left.AccountNumber = right.AccountNumber
					AND LEFT.iaassessedvalue <> RIGHT.iaassessedvalue
					and left.iaassessedvalue > '0'
					and RIGHT.iaassessedvalue > '0',
					TRANSFORM(input_layout, SELF := LEFT));

output(ave(j5, (integer)iaassessedvalue), named('file1_dual_hit_average'));

j6 := join(ds_baseline, ds_new, left.AccountNumber = right.AccountNumber
					AND LEFT.iaassessedvalue <> RIGHT.iaassessedvalue
					and left.iaassessedvalue > '0'
					and RIGHT.iaassessedvalue > '0',
					TRANSFORM(input_layout, SELF := right));

output(ave(j6,(integer)iaassessedvalue), named('file2_dual_hit_average'));

j7 := join(ds_join_baseline, ds_join_second, left.AccountNumber = right.AccountNumber
					AND LEFT.iaassessedvalue <> RIGHT.iaassessedvalue
					and left.iaassessedvalue > '0'
					and RIGHT.iaassessedvalue > '0'
					and (integer) right.iaassessedvalue - (integer) left.iaassessedvalue > 1000000,
					TRANSFORM(cmpr2, SELF.res := LEFT + RIGHT));

OUTPUT(count(j7), NAMED('diff_hit_to_hit_outlier_count'));
OUTPUT(choosen(j7, 25), NAMED('diff_hit_to_hit_outlier'));