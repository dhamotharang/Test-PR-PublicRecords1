import ProfileBooster, risk_indicators;

export V2_estimatedIncome(dataset(ProfileBooster.V2_Layouts.Layout_PB2_BatchOut) clam) := FUNCTION

  MODEL_DEBUG := false;

  #if(MODEL_DEBUG)
    layout_debug := record
			boolean  v2_hhcrtrecevictmbrct12mo_ge1;
			real     v2_hhoccbusinessassocmmbrcnt;
			real     v2_hhoccproflicmmbrcnt;
			real     v2_lifeevecontrajectory;
			real     v2_propeversoldcnt;
			real     v2_prospectage;
			boolean  v2_prospectmaritalstatus_eqm;
			boolean  v2_raacgetoptiermmbrcnt_ge1;
			boolean  v2_raacolmidtiermbrct_ge1;
			boolean  v2_raacrtrcbkrptmbrct36mo_ge1;
			boolean  v2_raacrtrclienjudgmbrct12mo_ge1;
			boolean  v2_raacrtrecevictmbrcnt12mo_ge1;
			real     v2_raaoccbusinessassocmmbrcnt;
			real     v2_rescurrbusinesscnt;
			real     v2_crtreclienjudgamtttl;
			boolean  v2_resinputdwelltype_eqs;
			boolean  v2_verifiedphone_ge1;
			real     v2_crtrecbkrpttimenewest;
			real     var1_sin;
			real     v2_propcurrownedavmttl;
			real     var23_tan;
			real     v2_raacrtrecfelonymmbrcnt;
			real     var33_tan;
			real     v2_raacrtreclienjudgamtmax;
			real     var34_sin;
			real     v2_raapropowneravmmed;
			real     var39_cos;
			real     v2_crtrecseverityindex;
			real     var3_cos;
			real     v2_hhcollegetiermmbrhighest;
			real     var5_tan;
			real     v2_hhyoungadultmmbrcnt;
			real     var13_tan;
			real     score1;
			real     score2;
			real     est_monthly_income;
			real     est_monthly_income_adj;
			ProfileBooster.V2_Layouts.Layout_PB2_BatchOut;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
		ProfileBooster.V2_Layouts.Layout_PB2_BatchOut doModel( clam le ) := TRANSFORM
  #end

//Start: ECL SAS mapping variables 
v1_HHMmbrWEvictCnt1Y  	          := (integer)le.attributes.version2.HHMmbrWEvictCnt1Y;
v1_hhoccbusinessassocmmbrcnt     	:= (integer)le.attributes.version2.HHMmbrWBusAssocCnt;
v1_hhoccproflicmmbrcnt           	:= (integer)le.attributes.version2.HHMmbrWithProfLicCnt;
v1_lifeevecontrajectory          	:= (integer)le.attributes.version2.LifeAddrEconTrajType;
v1_propcurrownedavmttl           	:= (integer)le.attributes.version2.AstPropCurrAVMTot;
v1_propeversoldcnt               	:= (integer)le.attributes.version2.AstPropSoldCntEv;
v1_prospectage                   	:= (integer)le.attributes.version2.DemAge;
v1_prospectmaritalstatus         	:= le.attributes.version2.DemIsMarriedFlag;
v1_raacollegetoptiermmbrcnt      	:= (integer)le.attributes.version2.RaAWTopTierCollCnt;
v1_raacollegemidtiermmbrcnt      	:= (integer)le.attributes.version2.RaAWMidTierCollCnt;
v1_raacrtrecbkrptmmbrcnt36mo    	:= (integer)le.attributes.version2.RaAWBkCnt2Y;//couldn't find 3 year  so used 2 year raacrtrecbkrptmmbrcnt36mo;
v1_raacrtreclienjudgmmbrcnt12mo 	:= (integer)le.attributes.version2.RaAWLnJCnt1Y;
v1_raacrtrecevictionmmbrcnt12mo 	:= (integer)le.attributes.version2.RaAWEvictCnt1Y;
v1_raaoccbusinessassocmmbrcnt    	:= (integer)le.attributes.version2.RaAWBusAssocCnt;
v1_rescurrbusinesscnt            	:= (integer)le.attributes.version2.CurrAddrBusRegCnt;
v1_crtreclienjudgamtttl         	:= (integer)le.attributes.version2.DrgLnJAmtTot7Y;
v1_resinputdwelltype             	:= le.attributes.version2.InpAddrType;
v1_verifiedphone                 	:= (integer)le.attributes.version2.VerInpPhoneFlag;
v1_crtrecbkrpttimenewest        	:= (integer)le.attributes.version2.DrgBkNewMsnc10Y;
v1_raacrtrecfelonymmbrcnt       	:= (integer)le.attributes.version2.RaAWCrimFelCnt7Y;
v1_raacrtreclienjudgamtmax      	:= (integer)le.attributes.version2.RaALnJAmtTot;//couldn't find raacrtreclienjudgamtmax;
v1_raapropowneravmmed            	:= (integer)le.attributes.version2.RaAPropCurrAVMValAvg;//couldn't find raapropowneravmmed;
v1_crtrecseverityindex          	:= (integer)le.attributes.version2.DrgSeverityIndx7Y;
v1_hhcollegetiermmbrhighest      	:= (integer)le.attributes.version2.HHMmbrCollTierHighest;
v1_hhyoungadultmmbrcnt           	:= (integer)le.attributes.version2.HHYoungAdultMmbrCnt;
// var34_sin                        := le.;

NULL := -999999999;

v2_hhcrtrecevictmbrct12mo_ge1 := v1_HHMmbrWEvictCnt1Y >= 1;

v2_hhoccbusinessassocmmbrcnt := map(
    v1_hhoccbusinessassocmmbrcnt < 1                                       => -0.133,
    v1_hhoccbusinessassocmmbrcnt >= 1 and v1_hhoccbusinessassocmmbrcnt < 2 => 0.477,
    v1_hhoccbusinessassocmmbrcnt >= 2                                      => 0.764,
                                                                              0);

v2_hhoccproflicmmbrcnt := map(
    v1_hhoccproflicmmbrcnt < 1                                 => -0.037,
    v1_hhoccproflicmmbrcnt >= 1 and v1_hhoccproflicmmbrcnt < 2 => 0.394,
    v1_hhoccproflicmmbrcnt >= 2                                => 0.693,
                                                                  0);

v2_lifeevecontrajectory := map(
    v1_lifeevecontrajectory < 3                                   => -0.062,
    v1_lifeevecontrajectory >= 3 and v1_lifeevecontrajectory < 6  => 0.109,
    v1_lifeevecontrajectory >= 6 and v1_lifeevecontrajectory < 11 => 0.262,
    v1_lifeevecontrajectory >= 11                                 => 0.55,
                                                                     0);

v2_propcurrownedavmttl_1 := map(
    v1_propcurrownedavmttl < 2965                                        => -0.236,
    v1_propcurrownedavmttl >= 2965 and v1_propcurrownedavmttl < 147005   => -0.077,
    v1_propcurrownedavmttl >= 147005 and v1_propcurrownedavmttl < 228113 => 0.233,
    v1_propcurrownedavmttl >= 228113 and v1_propcurrownedavmttl < 307525 => 0.473,
    v1_propcurrownedavmttl >= 307525 and v1_propcurrownedavmttl < 398147 => 0.666,
    v1_propcurrownedavmttl >= 398147 and v1_propcurrownedavmttl < 469988 => 0.77,
    v1_propcurrownedavmttl >= 469988 and v1_propcurrownedavmttl < 609532 => 0.915,
    v1_propcurrownedavmttl >= 609532 and v1_propcurrownedavmttl < 958058 => 1.2,
    v1_propcurrownedavmttl >= 958058                                     => 1.617,
                                                                            0);

v2_propeversoldcnt := map(
    v1_propeversoldcnt < 1                             => -0.064,
    v1_propeversoldcnt >= 1 and v1_propeversoldcnt < 2 => 0.512,
    v1_propeversoldcnt >= 2 and v1_propeversoldcnt < 3 => 0.786,
    v1_propeversoldcnt >= 3                            => 1.154,
                                                          0);

v2_prospectage := map(
    v1_prospectage < 18                          => -0.337,
    v1_prospectage >= 18 and v1_prospectage < 24 => -0.641,
    v1_prospectage >= 24 and v1_prospectage < 30 => -0.182,
    v1_prospectage >= 30 and v1_prospectage < 38 => 0.156,
    v1_prospectage >= 38 and v1_prospectage < 44 => 0.286,
    v1_prospectage >= 44 and v1_prospectage < 49 => 0.3,
    v1_prospectage >= 49 and v1_prospectage < 54 => 0.283,
    v1_prospectage >= 54 and v1_prospectage < 64 => 0.19,
    v1_prospectage >= 64                         => -0.168,
                                                    0);

v2_prospectmaritalstatus_eqm := v1_prospectmaritalstatus = 'M';

v2_raacgetoptiermmbrcnt_ge1 := v1_raacollegetoptiermmbrcnt >= 1;

v2_raacolmidtiermbrct_ge1 := v1_raacollegemidtiermmbrcnt >= 1;

v2_raacrtrcbkrptmbrct36mo_ge1 := v1_raacrtrecbkrptmmbrcnt36mo >= 1;

v2_raacrtrclienjudgmbrct12mo_ge1 := v1_raacrtreclienjudgmmbrcnt12mo >= 1;

v2_raacrtrecevictmbrcnt12mo_ge1 := v1_raacrtrecevictionmmbrcnt12mo >= 1;

v2_raaoccbusinessassocmmbrcnt := map(
    v1_raaoccbusinessassocmmbrcnt < 1                                        => -0.128,
    v1_raaoccbusinessassocmmbrcnt >= 1 and v1_raaoccbusinessassocmmbrcnt < 2 => -0.016,
    v1_raaoccbusinessassocmmbrcnt >= 2 and v1_raaoccbusinessassocmmbrcnt < 3 => 0.08,
    v1_raaoccbusinessassocmmbrcnt >= 3 and v1_raaoccbusinessassocmmbrcnt < 5 => 0.198,
    v1_raaoccbusinessassocmmbrcnt >= 5 and v1_raaoccbusinessassocmmbrcnt < 6 => 0.323,
    v1_raaoccbusinessassocmmbrcnt >= 6                                       => 0.572,
                                                                                0);

v2_rescurrbusinesscnt := map(
    v1_rescurrbusinesscnt < 1                                => -0.124,
    v1_rescurrbusinesscnt >= 1 and v1_rescurrbusinesscnt < 2 => 0.177,
    v1_rescurrbusinesscnt >= 2 and v1_rescurrbusinesscnt < 3 => 0.337,
    v1_rescurrbusinesscnt >= 3 and v1_rescurrbusinesscnt < 5 => 0.429,
    v1_rescurrbusinesscnt >= 5                               => 0.208,
                                                                0);

v2_crtreclienjudgamtttl := map(
    v1_crtreclienjudgamtttl < 4541                                        => -0.017,
    v1_crtreclienjudgamtttl >= 4541 and v1_crtreclienjudgamtttl < 8864   	=> 0.024,
    v1_crtreclienjudgamtttl >= 8864 and v1_crtreclienjudgamtttl < 10019  	=> 0.106,
    v1_crtreclienjudgamtttl >= 10019 and v1_crtreclienjudgamtttl < 30863 	=> 0.233,
    v1_crtreclienjudgamtttl >= 30863                                      => 0.555,
                                                                              0);

v2_resinputdwelltype_eqs := v1_resinputdwelltype = 'S';

v2_verifiedphone_ge1 := v1_verifiedphone >= 1;

v2_crtrecbkrpttimenewest := map(
    v1_crtrecbkrpttimenewest < 1                                      => 0.001,
    v1_crtrecbkrpttimenewest >= 1 and v1_crtrecbkrpttimenewest < 48  	=> -0.143,
    v1_crtrecbkrpttimenewest >= 48 and v1_crtrecbkrpttimenewest < 91 	=> -0.012,
    v1_crtrecbkrpttimenewest >= 91                                    => 0.186,
                                                                          0);

var1_sin := sin(v2_crtrecbkrpttimenewest);

v2_propcurrownedavmttl := map(
    v1_propcurrownedavmttl < 2965                                        => -0.236,
    v1_propcurrownedavmttl >= 2965 and v1_propcurrownedavmttl < 147005   => -0.077,
    v1_propcurrownedavmttl >= 147005 and v1_propcurrownedavmttl < 228113 => 0.233,
    v1_propcurrownedavmttl >= 228113 and v1_propcurrownedavmttl < 307525 => 0.473,
    v1_propcurrownedavmttl >= 307525 and v1_propcurrownedavmttl < 398147 => 0.666,
    v1_propcurrownedavmttl >= 398147 and v1_propcurrownedavmttl < 469988 => 0.77,
    v1_propcurrownedavmttl >= 469988 and v1_propcurrownedavmttl < 609532 => 0.915,
    v1_propcurrownedavmttl >= 609532 and v1_propcurrownedavmttl < 958058 => 1.2,
    v1_propcurrownedavmttl >= 958058                                     => 1.617,
                                                                            0);

var23_tan := tan(v2_propcurrownedavmttl);

v2_raacrtrecfelonymmbrcnt := map(
    v1_raacrtrecfelonymmbrcnt < 1                                     => 0.045,
    v1_raacrtrecfelonymmbrcnt >= 1 and v1_raacrtrecfelonymmbrcnt < 2 	=> -0.131,
    v1_raacrtrecfelonymmbrcnt >= 2                                    => -0.259,
                                                                          0);

var33_tan := tan(v2_raacrtrecfelonymmbrcnt);

v2_raacrtreclienjudgamtmax := map(
    v1_raacrtreclienjudgamtmax < 1                                          => 0.011,
    v1_raacrtreclienjudgamtmax >= 1 and v1_raacrtreclienjudgamtmax < 23726 	=> -0.041,
    v1_raacrtreclienjudgamtmax >= 23726                                     => 0.144,
                                                                                0);

var34_sin := sin(v2_raacrtreclienjudgamtmax);

v2_raapropowneravmmed := map(
    v1_raapropowneravmmed < 314                                        => -0.185,
    v1_raapropowneravmmed >= 314 and v1_raapropowneravmmed < 81425     => -0.337,
    v1_raapropowneravmmed >= 81425 and v1_raapropowneravmmed < 122626  => -0.218,
    v1_raapropowneravmmed >= 122626 and v1_raapropowneravmmed < 159675 => -0.125,
    v1_raapropowneravmmed >= 159675 and v1_raapropowneravmmed < 223140 => -0.035,
    v1_raapropowneravmmed >= 223140 and v1_raapropowneravmmed < 277560 => 0.08,
    v1_raapropowneravmmed >= 277560 and v1_raapropowneravmmed < 372060 => 0.199,
    v1_raapropowneravmmed >= 372060 and v1_raapropowneravmmed < 439661 => 0.275,
    v1_raapropowneravmmed >= 439661 and v1_raapropowneravmmed < 558936 => 0.362,
    v1_raapropowneravmmed >= 558936                                    => 0.529,
                                                                          0);

var39_cos := cos(v2_raapropowneravmmed);

v2_crtrecseverityindex := map(
    v1_crtrecseverityindex < 0                                  => 0,
    v1_crtrecseverityindex >= 0 and v1_crtrecseverityindex < 4 	=> 0.013,
    v1_crtrecseverityindex >= 4                                 => -0.192,
                                                                    0);

var3_cos := cos(v2_crtrecseverityindex);

v2_hhcollegetiermmbrhighest := map(
    v1_hhcollegetiermmbrhighest < 1                                      => -0.01,
    v1_hhcollegetiermmbrhighest >= 1 and v1_hhcollegetiermmbrhighest < 4 => 0.258,
    v1_hhcollegetiermmbrhighest >= 4                                     => 0.02,
                                                                            0);

var5_tan := tan(v2_hhcollegetiermmbrhighest);

v2_hhyoungadultmmbrcnt := map(
    v1_hhyoungadultmmbrcnt < 1                                 => -0.037,
    v1_hhyoungadultmmbrcnt >= 1 and v1_hhyoungadultmmbrcnt < 2 => 0.031,
    v1_hhyoungadultmmbrcnt >= 2                                => 0.15,
                                                                  0);

var13_tan := tan(v2_hhyoungadultmmbrcnt);

score1 := 6.14938 +
    var1_sin * 0.31161 +
    var23_tan * 0.00099445 +
    var33_tan * 0.29337 +
    var34_sin * 0.14182 +
    var39_cos * -0.86431 +
    var3_cos * 2.95891 +
    var5_tan * 0.29788 +
    (integer)v2_hhcrtrecevictmbrct12mo_ge1 * -0.0519 +
    v2_hhoccbusinessassocmmbrcnt * 0.2302 +
    v2_hhoccproflicmmbrcnt * 0.1816 +
    v2_lifeevecontrajectory * 0.11823 +
    v2_propcurrownedavmttl * 0.34197 +
    v2_propeversoldcnt * 0.13831 +
    v2_prospectage * 0.23155 +
    (integer)v2_prospectmaritalstatus_eqm * 0.01224 +
    (integer)v2_raacgetoptiermmbrcnt_ge1 * 0.06372 +
    (integer)v2_raacolmidtiermbrct_ge1 * 0.02649 +
    (integer)v2_raacrtrcbkrptmbrct36mo_ge1 * -0.02644 +
    (integer)v2_raacrtrclienjudgmbrct12mo_ge1 * -0.019 +
    (integer)v2_raacrtrecevictmbrcnt12mo_ge1 * -0.02483 +
    v2_raaoccbusinessassocmmbrcnt * 0.25168 +
    v2_rescurrbusinesscnt * 0.16449 +
    v2_crtreclienjudgamtttl * 0.18932 +
    (integer)v2_resinputdwelltype_eqs * 0.04564 +
    (integer)v2_verifiedphone_ge1 * 0.02971 +
    var13_tan * 0.04962;

score2 := 12.4309 +
    var1_sin * -0.93 +
    var23_tan * -0.0565 +
    var33_tan * -1.3934 +
    var34_sin * -0.1127 +
    var39_cos * 1.9127 +
    var3_cos * -17.3188 +
    var5_tan * -1.5187 +
    (integer)v2_hhcrtrecevictmbrct12mo_ge1 * 0.1549 +
    v2_hhoccbusinessassocmmbrcnt * -0.7746 +
    v2_hhoccproflicmmbrcnt * -0.8743 +
    v2_lifeevecontrajectory * -0.4811 +
    v2_propcurrownedavmttl * -1.8125 +
    v2_propeversoldcnt * -0.5674 +
    v2_prospectage * -1.3229 +
    (integer)v2_prospectmaritalstatus_eqm * -0.0901 +
    (integer)v2_raacgetoptiermmbrcnt_ge1 * -0.2791 +
    (integer)v2_raacolmidtiermbrct_ge1 * -0.0922 +
    (integer)v2_raacrtrcbkrptmbrct36mo_ge1 * 0.0614 +
    (integer)v2_raacrtrclienjudgmbrct12mo_ge1 * 0.069 +
    (integer)v2_raacrtrecevictmbrcnt12mo_ge1 * 0.1177 +
    v2_raaoccbusinessassocmmbrcnt * -1.0535 +
    v2_rescurrbusinesscnt * -0.4062 +
    v2_crtreclienjudgamtttl * -0.4779 +
    (integer)v2_resinputdwelltype_eqs * -0.0648 +
    (integer)v2_verifiedphone_ge1 * -0.2358 +
    var13_tan * -2.2577;

est_monthly_income := exp(score1);

est_monthly_income_adj := max((real)738, exp(score1) - 7000 * exp(score2) / (1 + exp(score2)));

est_annual_income_adj	:= est_monthly_income_adj * 12;

//Intermediate variables
	#if(MODEL_DEBUG)
			self.v2_hhcrtrecevictmbrct12mo_ge1   	:= v2_hhcrtrecevictmbrct12mo_ge1;
			self.v2_hhoccbusinessassocmmbrcnt     := v2_hhoccbusinessassocmmbrcnt;
			self.v2_hhoccproflicmmbrcnt           := v2_hhoccproflicmmbrcnt;
			self.v2_lifeevecontrajectory          := v2_lifeevecontrajectory;
			self.v2_propeversoldcnt               := v2_propeversoldcnt;
			self.v2_prospectage                   := v2_prospectage;
			self.v2_prospectmaritalstatus_eqm     := v2_prospectmaritalstatus_eqm;
			self.v2_raacgetoptiermmbrcnt_ge1      := v2_raacgetoptiermmbrcnt_ge1;
			self.v2_raacolmidtiermbrct_ge1        := v2_raacolmidtiermbrct_ge1;
			self.v2_raacrtrcbkrptmbrct36mo_ge1    := v2_raacrtrcbkrptmbrct36mo_ge1;
			self.v2_raacrtrclienjudgmbrct12mo_ge1 := v2_raacrtrclienjudgmbrct12mo_ge1;
			self.v2_raacrtrecevictmbrcnt12mo_ge1 	:= v2_raacrtrecevictmbrcnt12mo_ge1;
			self.v2_raaoccbusinessassocmmbrcnt    := v2_raaoccbusinessassocmmbrcnt;
			self.v2_rescurrbusinesscnt            := v2_rescurrbusinesscnt;
			self.v2_crtreclienjudgamtttl         	:= v2_crtreclienjudgamtttl;
			self.v2_resinputdwelltype_eqs         := v2_resinputdwelltype_eqs;
			self.v2_verifiedphone_ge1             := v2_verifiedphone_ge1;
			self.v2_crtrecbkrpttimenewest        	:= v2_crtrecbkrpttimenewest;
			self.var1_sin                         := var1_sin;
			self.v2_propcurrownedavmttl           := v2_propcurrownedavmttl;
			self.var23_tan                        := var23_tan;
			self.v2_raacrtrecfelonymmbrcnt       	:= v2_raacrtrecfelonymmbrcnt;
			self.var33_tan                        := var33_tan;
			self.v2_raacrtreclienjudgamtmax      	:= v2_raacrtreclienjudgamtmax;
			self.var34_sin                        := var34_sin;
			self.v2_raapropowneravmmed            := v2_raapropowneravmmed;
			self.var39_cos                        := var39_cos;
			self.v2_crtrecseverityindex          	:= v2_crtrecseverityindex;
			self.var3_cos                         := var3_cos;
			self.v2_hhcollegetiermmbrhighest      := v2_hhcollegetiermmbrhighest;
			self.var5_tan                         := var5_tan;
			self.v2_hhyoungadultmmbrcnt           := v2_hhyoungadultmmbrcnt;
			self.var13_tan                        := var13_tan;
			self.score1                           := score1;
			self.score2                           := score2;
			self.est_monthly_income               := est_monthly_income;
			self.est_monthly_income_adj           := est_monthly_income_adj;
		#else
			self.attributes.version2.DemEstInc	:= map(le.attributes.version2.VerProspectFoundFlag	= '-1' 	=> '-1',
																																	 est_annual_income_adj > 150000												=> '11',
																																	 est_annual_income_adj > 120000												=> '10',
																																	 est_annual_income_adj > 100000												=> '9',
																																	 est_annual_income_adj > 80000												=> '8',
																																	 est_annual_income_adj > 60000												=> '7',
																																	 est_annual_income_adj > 50000												=> '6',
																																	 est_annual_income_adj > 40000												=> '5',
																																	 est_annual_income_adj > 35000												=> '4',
																																	 est_annual_income_adj > 30000	 											=> '3',
																																	 est_annual_income_adj > 25000												=> '2',
																																	 est_annual_income_adj > 0														=> '1',
																																																													 '-1');
		#end
			self := le;
	END;

		model := project(clam, doModel(left)); 

		return model;

END;