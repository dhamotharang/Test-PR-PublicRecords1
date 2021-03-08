import ProfileBooster, risk_indicators;

export V2_HHestimatedIncome(dataset(ProfileBooster.V2_Layouts.Layout_PB2_BatchOut) clam) := FUNCTION

  MODEL_DEBUG := false;

  #if(MODEL_DEBUG)
    layout_debug := record
			real     v2_hhoccbusinessassocmmbrcnt;
			real     var4_tan;
			real     v2_resinputbusinesscnt;
			real     var52_tan;
			real     v2_lifeevecontrajectoryindex;
			real     var9_tan;
			real     v2_proptimelastsale;
			real     var17_sin;
			real     v2_crtrecseverityindex;
			real     var1_tan;
			real     v2_raacrtreclienjudgamtmax;
			real     var25_tan;
			real     v2_hhcollegetiermmbrhighest;
			real     var2_tan;
			real     v2_raapropcurrownermmbrcnt;
			real     var33_tan;
			real     v2_hhmiddleagemmbrcnt;
			real     var3_sin;
			boolean  v2_assetcurrowner_ge1;
			boolean  v2_hhcrtrclienttl_ge42k;
			boolean  v2_hhoccproflicmmbrcnt_ge1;
			real     v2_hhpropcurravmhighest;
			boolean  v2_hhyoungadultmbrct_ge2;
			boolean  v2_lifeevnamechange_ge1;
			boolean  v2_prosmaritalstatus_eqm;
			boolean  v2_prospectgender_eqm;
			boolean  v2_raacollegetoptiermmbrcnt;
			boolean  v2_raacollowtiermbrct_ge1;
			boolean  v2_raacolmidtiermbrct_ge1;
			boolean  v2_raacrtrecbkmbrct36mo_ge1;
			boolean  v2_raacrtrecevictmmbrct12mo_ge1;
			real     v2_raacrtrecfelonymmbrcnt;
			boolean  v2_raacrtrdlienjudgmbrct12mo_ge1;
			boolean  v2_raaelderlymmbrcnt_ge1;
			boolean  v2_resinputdwelltypeidx_ge3;
			boolean  v2_donotmail_ge1;
			real     score1;
			real     score2;
			real     prob_low;
			real     est_med_hhincome;
			ProfileBooster.V2_Layouts.Layout_PB2_BatchOut;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
		ProfileBooster.V2_Layouts.Layout_PB2_BatchOut doModel( clam le ) := TRANSFORM
  #end

//Start: ECL SAS mapping variables 
v1_hhoccbusinessassocmmbrcnt     := (integer)le.attributes.version1.hhoccbusinessassocmmbrcnt;
v1_resinputbusinesscnt           := (integer)le.attributes.version1.resinputbusinesscnt;
v1_lifeevecontrajectoryindex     := (integer)le.attributes.version1.lifeevecontrajectoryindex;
v1_proptimelastsale              := (integer)le.attributes.version1.proptimelastsale;
v1_crtrecseverityindex           := (integer)le.attributes.version1.crtrecseverityindex;
v1_raacrtreclienjudgamtmax       := (integer)le.attributes.version1.raacrtreclienjudgamtmax;
v1_hhcollegetiermmbrhighest      := (integer)le.attributes.version1.hhcollegetiermmbrhighest;
v1_raapropcurrownermmbrcnt       := (integer)le.attributes.version1.raapropcurrownermmbrcnt;
v1_hhmiddleagemmbrcnt            := (integer)le.attributes.version1.hhmiddleagemmbrcnt;
v1_assetcurrowner                := (integer)le.attributes.version1.assetcurrowner;
v1_hhcrtreclienjudgamtttl        := (integer)le.attributes.version1.hhcrtreclienjudgamtttl;
v1_hhoccproflicmmbrcnt           := (integer)le.attributes.version1.hhoccproflicmmbrcnt;
v1_hhpropcurravmhighest          := (integer)le.attributes.version1.hhpropcurravmhighest;
v1_hhyoungadultmmbrcnt           := (integer)le.attributes.version1.hhyoungadultmmbrcnt;
v1_lifeevnamechange              := (integer)le.attributes.version1.lifeevnamechange;
v1_prospectmaritalstatus         := le.attributes.version1.prospectmaritalstatus;
v1_prospectgender                := le.attributes.version1.prospectgender;
v1_raacollegetoptiermmbrcnt      := (integer)le.attributes.version1.raacollegetoptiermmbrcnt;
v1_raacollegelowtiermmbrcnt      := (integer)le.attributes.version1.raacollegelowtiermmbrcnt;
v1_raacollegemidtiermmbrcnt      := (integer)le.attributes.version1.raacollegemidtiermmbrcnt;
v1_raacrtrecbkrptmmbrcnt36mo     := (integer)le.attributes.version1.raacrtrecbkrptmmbrcnt36mo;
v1_raacrtrecevictionmmbrcnt12mo  := (integer)le.attributes.version1.raacrtrecevictionmmbrcnt12mo;
v1_raacrtrecfelonymmbrcnt        := (integer)le.attributes.version1.raacrtrecfelonymmbrcnt;
v1_raacrtreclienjudgmmbrcnt12mo  := (integer)le.attributes.version1.raacrtreclienjudgmmbrcnt12mo;
v1_raaelderlymmbrcnt             := (integer)le.attributes.version1.raaelderlymmbrcnt;
v1_resinputdwelltypeindex        := (integer)le.attributes.version1.resinputdwelltypeindex;
v1_donotmail                     := (integer)le.attributes.version1.donotmail;

NULL := -999999999;

v2_hhoccbusinessassocmmbrcnt := map(
    v1_hhoccbusinessassocmmbrcnt < 1                                       => -0.061,
    v1_hhoccbusinessassocmmbrcnt >= 1 and v1_hhoccbusinessassocmmbrcnt < 2 => 0.214,
    v1_hhoccbusinessassocmmbrcnt >= 2                                      => 0.368,
                                                                              0);

var4_tan := tan(v2_hhoccbusinessassocmmbrcnt);

v2_resinputbusinesscnt := map(
    v1_resinputbusinesscnt < 1                                 => -0.056,
    v1_resinputbusinesscnt >= 1 and v1_resinputbusinesscnt < 2 => 0.055,
    v1_resinputbusinesscnt >= 2 and v1_resinputbusinesscnt < 8 => 0.141,
    v1_resinputbusinesscnt >= 8                                => -0.169,
                                                                  0);

var52_tan := tan(v2_resinputbusinesscnt);

v2_lifeevecontrajectoryindex := map(
    v1_lifeevecontrajectoryindex < 3                                       => -0.085,
    v1_lifeevecontrajectoryindex >= 3 and v1_lifeevecontrajectoryindex < 5 => 0.306,
    v1_lifeevecontrajectoryindex >= 5 and v1_lifeevecontrajectoryindex < 6 => -0.013,
    v1_lifeevecontrajectoryindex >= 6                                      => 0.439,
                                                                              0);

var9_tan := tan(v2_lifeevecontrajectoryindex);

v2_proptimelastsale := map(
    v1_proptimelastsale < 0                               => -0.042,
    v1_proptimelastsale >= 0 and v1_proptimelastsale < 85 => 0.369,
    v1_proptimelastsale >= 85                             => 0.454,
                                                             0);

var17_sin := sin(v2_proptimelastsale);

v2_crtrecseverityindex := map(
    v1_crtrecseverityindex < 0                                  => 0.312,
    v1_crtrecseverityindex >= 0 and v1_crtrecseverityindex < 1 	=> 0.039,
    v1_crtrecseverityindex >= 1 and v1_crtrecseverityindex < 4 	=> -0.016,
    v1_crtrecseverityindex >= 4 and v1_crtrecseverityindex < 5 	=> -0.175,
    v1_crtrecseverityindex >= 5                                 => -0.255,
                                                                    0);

var1_tan := tan(v2_crtrecseverityindex);

v2_raacrtreclienjudgamtmax := map(
    v1_raacrtreclienjudgamtmax < 1                                          => 0.042,
    v1_raacrtreclienjudgamtmax >= 1 and v1_raacrtreclienjudgamtmax < 75617 	=> -0.043,
    v1_raacrtreclienjudgamtmax >= 75617                                     => 0.126,
                                                                                0);

var25_tan := tan(v2_raacrtreclienjudgamtmax);

v2_hhcollegetiermmbrhighest := map(
    v1_hhcollegetiermmbrhighest < 1                                      => -0.011,
    v1_hhcollegetiermmbrhighest >= 1 and v1_hhcollegetiermmbrhighest < 4 => 0.273,
    v1_hhcollegetiermmbrhighest >= 4                                     => 0.02,
                                                                            0);

var2_tan := tan(v2_hhcollegetiermmbrhighest);

v2_raapropcurrownermmbrcnt := map(
    v1_raapropcurrownermmbrcnt < 1                                     => -0.225,
    v1_raapropcurrownermmbrcnt >= 1 and v1_raapropcurrownermmbrcnt < 2 => -0.099,
    v1_raapropcurrownermmbrcnt >= 2 and v1_raapropcurrownermmbrcnt < 5 => 0.013,
    v1_raapropcurrownermmbrcnt >= 5                                    => 0.114,
                                                                          0);

var33_tan := tan(v2_raapropcurrownermmbrcnt);

v2_hhmiddleagemmbrcnt := map(
    v1_hhmiddleagemmbrcnt < 1                                => -0.065,
    v1_hhmiddleagemmbrcnt >= 1 and v1_hhmiddleagemmbrcnt < 2 => 0.009,
    v1_hhmiddleagemmbrcnt >= 2                               => 0.181,
                                                                0);

var3_sin := v2_hhmiddleagemmbrcnt;

v2_assetcurrowner_ge1 := v1_assetcurrowner >= 1;

v2_hhcrtrclienttl_ge42k := v1_hhcrtreclienjudgamtttl >= 42082;

v2_hhoccproflicmmbrcnt_ge1 := v1_hhoccproflicmmbrcnt >= 1;

v2_hhpropcurravmhighest := map(
    v1_hhpropcurravmhighest < 478                                          => -0.171,
    v1_hhpropcurravmhighest >= 478 and v1_hhpropcurravmhighest < 74923     => -0.666,
    v1_hhpropcurravmhighest >= 74923 and v1_hhpropcurravmhighest < 140697  => -0.191,
    v1_hhpropcurravmhighest >= 140697 and v1_hhpropcurravmhighest < 215600 => 0.1,
    v1_hhpropcurravmhighest >= 215600 and v1_hhpropcurravmhighest < 283183 => 0.313,
    v1_hhpropcurravmhighest >= 283183 and v1_hhpropcurravmhighest < 412899 => 0.482,
    v1_hhpropcurravmhighest >= 412899 and v1_hhpropcurravmhighest < 497041 => 0.581,
    v1_hhpropcurravmhighest >= 497041 and v1_hhpropcurravmhighest < 689575 => 0.771,
    v1_hhpropcurravmhighest >= 689575                                      => 1.101,
                                                                              0);

v2_hhyoungadultmbrct_ge2 := v1_hhyoungadultmmbrcnt >= 2;

v2_lifeevnamechange_ge1 := v1_lifeevnamechange >= 1;

v2_prosmaritalstatus_eqm := v1_prospectmaritalstatus = 'M';

v2_prospectgender_eqm := v1_prospectgender = 'M';

v2_raacollegetoptiermmbrcnt := v1_raacollegetoptiermmbrcnt >= 1;

v2_raacollowtiermbrct_ge1 := v1_raacollegelowtiermmbrcnt >= 1;

v2_raacolmidtiermbrct_ge1 := v1_raacollegemidtiermmbrcnt >= 1;

v2_raacrtrecbkmbrct36mo_ge1 := v1_raacrtrecbkrptmmbrcnt36mo >= 1;

v2_raacrtrecevictmmbrct12mo_ge1 := v1_raacrtrecevictionmmbrcnt12mo >= 1;

v2_raacrtrecfelonymmbrcnt := map(
    v1_raacrtrecfelonymmbrcnt < 1                                     => 0.058,
    v1_raacrtrecfelonymmbrcnt >= 1 and v1_raacrtrecfelonymmbrcnt < 2 	=> -0.166,
    v1_raacrtrecfelonymmbrcnt >= 2 and v1_raacrtrecfelonymmbrcnt < 3 	=> -0.294,
    v1_raacrtrecfelonymmbrcnt >= 3                                    => -0.421,
                                                                          0);

v2_raacrtrdlienjudgmbrct12mo_ge1 := v1_raacrtreclienjudgmmbrcnt12mo >= 1;

v2_raaelderlymmbrcnt_ge1 := v1_raaelderlymmbrcnt >= 1;

v2_resinputdwelltypeidx_ge3 := v1_resinputdwelltypeindex >= 3;

v2_donotmail_ge1 := v1_donotmail >= 1;

score1 := 8.4777 +
    (integer)v2_assetcurrowner_ge1 * 0.0111 +
    var4_tan * 0.1009 +
    var52_tan * 0.2692 +
    var9_tan * 0.0899 +
    (integer)v2_hhcrtrclienttl_ge42k * 0.0289 +
    (integer)v2_hhoccproflicmmbrcnt_ge1 * 0.0188 +
    v2_hhpropcurravmhighest * 0.3157 +
    (integer)v2_hhyoungadultmbrct_ge2 * 0.0033 +
    (integer)v2_lifeevnamechange_ge1 * -0.0066 +
    (integer)v2_prosmaritalstatus_eqm * 0.0211 +
    (integer)v2_prospectgender_eqm * -0.0033 +
    (integer)v2_raacollegetoptiermmbrcnt * 0.0722 +
    (integer)v2_raacollowtiermbrct_ge1 * -0.0111 +
    (integer)v2_raacolmidtiermbrct_ge1 * 0.0277 +
    (integer)v2_raacrtrecbkmbrct36mo_ge1 * -0.0195 +
    (integer)v2_raacrtrecevictmmbrct12mo_ge1 * -0.0321 +
    v2_raacrtrecfelonymmbrcnt * 0.2748 +
    (integer)v2_raacrtrdlienjudgmbrct12mo_ge1 * -0.0134 +
    (integer)v2_raaelderlymmbrcnt_ge1 * 0.008 +
    (integer)v2_resinputdwelltypeidx_ge3 * 0.1082 +
    var17_sin * 0.1458 +
    var1_tan * 0.1653 +
    var25_tan * 0.2681 +
    var2_tan * 0.211 +
    (integer)v2_donotmail_ge1 * 0.0743 +
    var33_tan * 0.2866;

score2 := -3.5145 +
    (integer)v2_assetcurrowner_ge1 * -0.3837 +
    var4_tan * -0.5075 +
    var52_tan * -0.9101 +
    var9_tan * -0.6395 +
    (integer)v2_hhcrtrclienttl_ge42k * 0.1013 +
    (integer)v2_hhoccproflicmmbrcnt_ge1 * -0.0991 +
    v2_hhpropcurravmhighest * -1.9414 +
    (integer)v2_hhyoungadultmbrct_ge2 * -0.3013 +
    (integer)v2_lifeevnamechange_ge1 * -0.1309 +
    (integer)v2_prosmaritalstatus_eqm * -0.2255 +
    (integer)v2_prospectgender_eqm * -0.1477 +
    (integer)v2_raacollegetoptiermmbrcnt * -0.1644 +
    (integer)v2_raacollowtiermbrct_ge1 * 0.2089 +
    (integer)v2_raacolmidtiermbrct_ge1 * -0.0718 +
    (integer)v2_raacrtrecbkmbrct36mo_ge1 * 0.0745 +
    (integer)v2_raacrtrecevictmmbrct12mo_ge1 * 0.368 +
    v2_raacrtrecfelonymmbrcnt * -1.1489 +
    (integer)v2_raacrtrdlienjudgmbrct12mo_ge1 * 0.1501 +
    (integer)v2_raaelderlymmbrcnt_ge1 * 0.0928 +
    (integer)v2_resinputdwelltypeidx_ge3 * -0.3986 +
    var17_sin * -0.757 +
    var1_tan * -0.8949 +
    var25_tan * -0.9317 +
    var2_tan * -0.1982 +
    (integer)v2_donotmail_ge1 * -0.8358 +
    var33_tan * -2.2417;

prob_low := exp(score2) / (1 + exp(score2));

est_med_hhincome := max((real)738, exp(score1) - prob_low * 28000);

est_annual_hhincome := est_med_hhincome * 12;

//Intermediate variables
	#if(MODEL_DEBUG)
			self.v2_hhoccbusinessassocmmbrcnt     := v2_hhoccbusinessassocmmbrcnt;
			self.var4_tan                         := var4_tan;
			self.v2_resinputbusinesscnt           := v2_resinputbusinesscnt;
			self.var52_tan                        := var52_tan;
			self.v2_lifeevecontrajectoryindex     := v2_lifeevecontrajectoryindex;
			self.var9_tan                         := var9_tan;
			self.v2_proptimelastsale              := v2_proptimelastsale;
			self.var17_sin                        := var17_sin;
			self.v2_crtrecseverityindex          	:= v2_crtrecseverityindex;
			self.var1_tan                         := var1_tan;
			self.v2_raacrtreclienjudgamtmax      	:= v2_raacrtreclienjudgamtmax;
			self.var25_tan                        := var25_tan;
			self.v2_hhcollegetiermmbrhighest      := v2_hhcollegetiermmbrhighest;
			self.var2_tan                         := var2_tan;
			self.v2_raapropcurrownermmbrcnt       := v2_raapropcurrownermmbrcnt;
			self.var33_tan                        := var33_tan;
			self.v2_hhmiddleagemmbrcnt            := v2_hhmiddleagemmbrcnt;
			self.var3_sin                         := var3_sin;
			self.v2_assetcurrowner_ge1            := v2_assetcurrowner_ge1;
			self.v2_hhcrtrclienttl_ge42k          := v2_hhcrtrclienttl_ge42k;
			self.v2_hhoccproflicmmbrcnt_ge1       := v2_hhoccproflicmmbrcnt_ge1;
			self.v2_hhpropcurravmhighest          := v2_hhpropcurravmhighest;
			self.v2_hhyoungadultmbrct_ge2         := v2_hhyoungadultmbrct_ge2;
			self.v2_lifeevnamechange_ge1          := v2_lifeevnamechange_ge1;
			self.v2_prosmaritalstatus_eqm         := v2_prosmaritalstatus_eqm;
			self.v2_prospectgender_eqm            := v2_prospectgender_eqm;
			self.v2_raacollegetoptiermmbrcnt      := v2_raacollegetoptiermmbrcnt;
			self.v2_raacollowtiermbrct_ge1        := v2_raacollowtiermbrct_ge1;
			self.v2_raacolmidtiermbrct_ge1        := v2_raacolmidtiermbrct_ge1;
			self.v2_raacrtrecbkmbrct36mo_ge1     	:= v2_raacrtrecbkmbrct36mo_ge1;
			self.v2_raacrtrecevictmmbrct12mo_ge1 	:= v2_raacrtrecevictmmbrct12mo_ge1;
			self.v2_raacrtrecfelonymmbrcnt       	:= v2_raacrtrecfelonymmbrcnt;
			self.v2_raacrtrdlienjudgmbrct12mo_ge1 := v2_raacrtrdlienjudgmbrct12mo_ge1;
			self.v2_raaelderlymmbrcnt_ge1         := v2_raaelderlymmbrcnt_ge1;
			self.v2_resinputdwelltypeidx_ge3      := v2_resinputdwelltypeidx_ge3;
			self.v2_donotmail_ge1                 := v2_donotmail_ge1;
			self.score1                           := score1;
			self.score2                           := score2;
			self.prob_low                         := prob_low;
			self.est_med_hhincome                 := est_med_hhincome;
		#else
			self.attributes.version1.HHEstimatedIncomeRange	:= map(le.attributes.version1.VerifiedProspectFound	= '-1' 	=> '-1',
																														 est_annual_hhincome > 150000													=> '11',
																														 est_annual_hhincome > 120000													=> '10',
																														 est_annual_hhincome > 100000													=> '9',
																														 est_annual_hhincome > 80000													=> '8',
																														 est_annual_hhincome > 60000													=> '7',
																														 est_annual_hhincome > 50000													=> '6',
																														 est_annual_hhincome > 40000													=> '5',
																														 est_annual_hhincome > 35000													=> '4',
																														 est_annual_hhincome > 30000													=> '3',
																														 est_annual_hhincome > 25000													=> '2',
																														 est_annual_hhincome > 0															=> '1',
																																																										 '-1');
		#end
			self := le;
	END;

		model := project(clam, doModel(left)); 

		return model;

END;