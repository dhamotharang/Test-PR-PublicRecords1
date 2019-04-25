#workunit('name','Profile Booster');

import risk_indicators, ut, ashirey,scoring_project_pip;

eyeball := 20;

Layout := RECORD
  string30 acctno;
  unsigned6 seq;
  unsigned6 lexid;
  string2 v1_donotmail;
  string2 v1_verifiedprospectfound;
  string2 v1_verifiedname;
  string2 v1_verifiedssn;
  string2 v1_verifiedphone;
  string2 v1_verifiedcurrresmatchindex;
  string3 v1_prospecttimeonrecord;
  string3 v1_prospecttimelastupdate;
  string2 v1_prospectlastupdate12mo;
  string3 v1_prospectage;
  string2 v1_prospectgender;
  string2 v1_prospectmaritalstatus;
  string2 v1_prospectestimatedincomerange;
  string2 v1_prospectdeceased;
  string2 v1_prospectcollegeattending;
  string2 v1_prospectcollegeattended;
  string2 v1_prospectcollegeprogramtype;
  string2 v1_prospectcollegeprivate;
  string2 v1_prospectcollegetier;
  string2 v1_prospectbankingexperience;
  string2 v1_assetcurrowner;
  string2 v1_propcurrowner;
  string3 v1_propcurrownedcnt;
  string7 v1_propcurrownedassessedttl;
  string7 v1_propcurrownedavmttl;
  string3 v1_proptimelastsale;
  string3 v1_propeverownedcnt;
  string3 v1_propeversoldcnt;
  string3 v1_propsoldcnt12mo;
  string5 v1_propsoldratio;
  string3 v1_proppurchasecnt12mo;
  string2 v1_ppcurrowner;
  string3 v1_ppcurrownedcnt;
  string3 v1_ppcurrownedautocnt;
  string3 v1_ppcurrownedmtrcyclecnt;
  string3 v1_ppcurrownedaircrftcnt;
  string3 v1_ppcurrownedwtrcrftcnt;
  string3 v1_lifeevtimelastmove;
  string2 v1_lifeevnamechange;
  string2 v1_lifeevnamechangecnt12mo;
  string3 v1_lifeevtimefirstassetpurchase;
  string3 v1_lifeevtimelastassetpurchase;
  string3 v1_lifeeveverresidedcnt;
  string5 v1_lifeevlastmovetaxratiodiff;
  string2 v1_lifeevecontrajectory;
  string2 v1_lifeevecontrajectoryindex;
  string2 v1_rescurrownershipindex;
  string7 v1_rescurravmvalue;
  string7 v1_rescurravmvalue12mo;
  string5 v1_rescurravmratiodiff12mo;
  string7 v1_rescurravmvalue60mo;
  string5 v1_rescurravmratiodiff60mo;
  string5 v1_rescurravmcntyratio;
  string5 v1_rescurravmtractratio;
  string5 v1_rescurravmblockratio;
  string2 v1_rescurrdwelltype;
  string2 v1_rescurrdwelltypeindex;
  string2 v1_rescurrmortgagetype;
  string7 v1_rescurrmortgageamount;
  string3 v1_rescurrbusinesscnt;
  string2 v1_resinputownershipindex;
  string7 v1_resinputavmvalue;
  string7 v1_resinputavmvalue12mo;
  string5 v1_resinputavmratiodiff12mo;
  string7 v1_resinputavmvalue60mo;
  string5 v1_resinputavmratiodiff60mo;
  string5 v1_resinputavmcntyratio;
  string5 v1_resinputavmtractratio;
  string5 v1_resinputavmblockratio;
  string2 v1_resinputdwelltype;
  string2 v1_resinputdwelltypeindex;
  string2 v1_resinputmortgagetype;
  string7 v1_resinputmortgageamount;
  string3 v1_resinputbusinesscnt;
  string3 v1_crtreccnt;
  string3 v1_crtreccnt12mo;
  string3 v1_crtrectimenewest;
  string3 v1_crtrecfelonycnt;
  string3 v1_crtrecfelonycnt12mo;
  string3 v1_crtrecfelonytimenewest;
  string3 v1_crtrecmsdmeancnt;
  string3 v1_crtrecmsdmeancnt12mo;
  string3 v1_crtrecmsdmeantimenewest;
  string3 v1_crtrecevictioncnt;
  string3 v1_crtrecevictioncnt12mo;
  string3 v1_crtrecevictiontimenewest;
  string3 v1_crtreclienjudgcnt;
  string3 v1_crtreclienjudgcnt12mo;
  string3 v1_crtreclienjudgtimenewest;
  string7 v1_crtreclienjudgamtttl;
  string3 v1_crtrecbkrptcnt;
  string3 v1_crtrecbkrptcnt12mo;
  string3 v1_crtrecbkrpttimenewest;
  string2 v1_crtrecseverityindex;
  string2 v1_occproflicense;
  string2 v1_occproflicensecategory;
  string2 v1_occbusinessassociation;
  string3 v1_occbusinessassociationtime;
  string2 v1_occbusinesstitleleadership;
  string2 v1_interestsportperson;
  string3 v1_hhteenagermmbrcnt;
  string3 v1_hhyoungadultmmbrcnt;
  string3 v1_hhmiddleagemmbrcnt;
  string3 v1_hhseniormmbrcnt;
  string3 v1_hhelderlymmbrcnt;
  string3 v1_hhcnt;
  string2 v1_hhestimatedincomerange;
  string3 v1_hhcollegeattendedmmbrcnt;
  string3 v1_hhcollege2yrattendedmmbrcnt;
  string3 v1_hhcollege4yrattendedmmbrcnt;
  string3 v1_hhcollegegradattendedmmbrcnt;
  string3 v1_hhcollegeprivatemmbrcnt;
  string2 v1_hhcollegetiermmbrhighest;
  string3 v1_hhpropcurrownermmbrcnt;
  string3 v1_hhpropcurrownedcnt;
  string7 v1_hhpropcurravmhighest;
  string3 v1_hhppcurrownedcnt;
  string3 v1_hhppcurrownedautocnt;
  string3 v1_hhppcurrownedmtrcyclecnt;
  string3 v1_hhppcurrownedaircrftcnt;
  string3 v1_hhppcurrownedwtrcrftcnt;
  string3 v1_hhcrtrecmmbrcnt;
  string3 v1_hhcrtrecmmbrcnt12mo;
  string3 v1_hhcrtrecfelonymmbrcnt;
  string3 v1_hhcrtrecfelonymmbrcnt12mo;
  string3 v1_hhcrtrecmsdmeanmmbrcnt;
  string3 v1_hhcrtrecmsdmeanmmbrcnt12mo;
  string3 v1_hhcrtrecevictionmmbrcnt;
  string3 v1_hhcrtrecevictionmmbrcnt12mo;
  string3 v1_hhcrtreclienjudgmmbrcnt;
  string3 v1_hhcrtreclienjudgmmbrcnt12mo;
  string7 v1_hhcrtreclienjudgamtttl;
  string3 v1_hhcrtrecbkrptmmbrcnt;
  string3 v1_hhcrtrecbkrptmmbrcnt12mo;
  string3 v1_hhcrtrecbkrptmmbrcnt24mo;
  string3 v1_hhoccproflicmmbrcnt;
  string3 v1_hhoccbusinessassocmmbrcnt;
  string3 v1_hhinterestsportpersonmmbrcnt;
  string3 v1_raateenagemmbrcnt;
  string3 v1_raayoungadultmmbrcnt;
  string3 v1_raamiddleagemmbrcnt;
  string3 v1_raaseniormmbrcnt;
  string3 v1_raaelderlymmbrcnt;
  string3 v1_raahhcnt;
  string3 v1_raammbrcnt;
  string2 v1_raamedincomerange;
  string3 v1_raacollegeattendedmmbrcnt;
  string3 v1_raacollege2yrattendedmmbrcnt;
  string3 v1_raacollege4yrattendedmmbrcnt;
  string3 v1_raacollegegradattendedmmbrcnt;
  string3 v1_raacollegeprivatemmbrcnt;
  string3 v1_raacollegetoptiermmbrcnt;
  string3 v1_raacollegemidtiermmbrcnt;
  string3 v1_raacollegelowtiermmbrcnt;
  string3 v1_raapropcurrownermmbrcnt;
  string7 v1_raapropowneravmhighest;
  string7 v1_raapropowneravmmed;
  string3 v1_raappcurrownermmbrcnt;
  string3 v1_raappcurrownerautommbrcnt;
  string3 v1_raappcurrownermtrcyclemmbrcnt;
  string3 v1_raappcurrowneraircrftmmbrcnt;
  string3 v1_raappcurrownerwtrcrftmmbrcnt;
  string3 v1_raacrtrecmmbrcnt;
  string3 v1_raacrtrecmmbrcnt12mo;
  string3 v1_raacrtrecfelonymmbrcnt;
  string3 v1_raacrtrecfelonymmbrcnt12mo;
  string3 v1_raacrtrecmsdmeanmmbrcnt;
  string3 v1_raacrtrecmsdmeanmmbrcnt12mo;
  string3 v1_raacrtrecevictionmmbrcnt;
  string3 v1_raacrtrecevictionmmbrcnt12mo;
  string3 v1_raacrtreclienjudgmmbrcnt;
  string3 v1_raacrtreclienjudgmmbrcnt12mo;
  string7 v1_raacrtreclienjudgamtmax;
  string3 v1_raacrtrecbkrptmmbrcnt36mo;
  string3 v1_raaoccproflicmmbrcnt;
  string3 v1_raaoccbusinessassocmmbrcnt;
  string3 v1_raainterestsportpersonmmbrcnt;
  string3 score1;
  string15 scorename1;
  string2 reason1;
  string2 reason2;
  string2 reason3;
  string2 reason4;
  string2 reason5;
  string2 reason6;
  string errorcode;
 END;


basefilename := '~scoringqa::out::nonfcra::profile_booster_batch_capitalone_attributes_v1_20161118_emaildatakeys_20161025_baseline';
testfilename := '~scoringqa::out::nonfcra::profile_booster_batch_capitalone_attributes_v1_20161118_emaildatakeys_20161104_second';


ds_baseline := dataset(basefilename,Layout, Thor);
ds_new := dataset(testfilename,Layout, Thor);

ds_base_NoErrors := ds_baseline(errorcode='');
ds_test_NoErrors := ds_new(errorcode='');

//output(choosen(ds_baseline, eyeball), NAMED('baseline'));
//output(choosen(ds_new, eyeball), NAMED('test'));
//output(COUNT(ds_baseline), NAMED('baseline_count'));
//output(COUNT(ds_new), NAMED('test_count'));   
   
 cmpr := record, maxlength(50000)
		 dataset(Layout) res;
	 end;
 blank := DATASET(1, TRANSFORM(Layout, SELF.acctno := '-', SELF := []));

// j1 := join(ds_baseline, ds_new, left.acctno = right.acctno
				// AND left.bjl.criminal_count <> right.bjl.criminal_count,
			// transform(cmpr, self.res := left + right));

// j2 := join(ds_baseline, ds_new, left.AccountNumber = right.AccountNumber
				// AND left.iid.watchlist_table = ''
			// transform(cmpr, self.res := left + right + blank));

// j3 := join(ds_baseline, ds_new, left.AccountNumber = right.AccountNumber
				// AND left.iid.watchlist_table <> ''
			// transform(cmpr, self.res := left + right + blank));


// OUTPUT(COUNT(j1), named('num_nonderogs30_Count'));
// OUTPUT(COUNT(j2), named('Increase_num_nonderogs30_Count'));
// OUTPUT(COUNT(j3), named('Decrease_num_nonderogs30_Count'));

// OUTPUT(CHOOSEN(j1, eyeball), NAMED('diff_num_nonderogs30'));
// OUTPUT(CHOOSEN(j2, eyeball), NAMED('Increase_num_nonderogs30'));
// OUTPUT(CHOOSEN(j3, eyeball), NAMED('Decrease_num_nonderogs30'));


ashirey.flatten(ds_base_NoErrors, flatten_baseline);
ashirey.flatten(ds_test_NoErrors, flatten_second);

scoring_project_pip.COMPARE_DSETS_MACRO(flatten_baseline, flatten_second, ['acctno'], 0);
   