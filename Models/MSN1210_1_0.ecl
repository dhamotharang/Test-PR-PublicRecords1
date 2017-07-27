import risk_indicators, ut, easi, riskwise;

MSN_DEBUG := false;

export MSN1210_1_0( grouped dataset(risk_indicators.layout_boca_shell) clam, 
										grouped	dataset(models.layouts.layout_LeadIntegrity_attributes_batch) LI_attr ) := FUNCTION

	#if(MSN_DEBUG)
		layout_debug := record
			integer propownedlevel                   ; //propownedlevel;
			integer bk_discharge                     ; //bk_discharge;
			integer bk_dismiss                       ; //bk_dismiss;
			string  bk_disposition                   ; //bk_disposition;
			integer inputphonetype_lvl;
			real    a_subscore0                      ; //a_subscore0;
			real    a_subscore1                      ; //a_subscore1;
			real    a_subscore2                      ; //a_subscore2;
			real    a_subscore3                      ; //a_subscore3;
			real    a_subscore4                      ; //a_subscore4;
			real    a_subscore5                      ; //a_subscore5;
			real    a_subscore6                      ; //a_subscore6;
			real    a_subscore7                      ; //a_subscore7;
			real    a_subscore8                      ; //a_subscore8;
			real    a_subscore9                      ; //a_subscore9;
			real    a_subscore10                     ; //a_subscore10;
			real    a_subscore11                     ; //a_subscore11;
			real    a_subscore12                     ; //a_subscore12;
			real    a_subscore13                     ; //a_subscore13;
			real    a_subscore14                     ; //a_subscore14;
			real    a_subscore15                     ; //a_subscore15;
			real    a_subscore16                     ; //a_subscore16;
			real    a_subscore17                     ; //a_subscore17;
			real    a_rawscore                       ; //a_rawscore;
			real    a_lnoddsscore                    ; //a_lnoddsscore;
			real    a_probscore                      ; //a_probscore;
			real    probscore                        ; //probscore;
			integer MSN1210_1_0                      ; //MSN1210_1_0;
			string  Donotmail											; //ri.Version4.Donotmail;
			integer PropOwnedCount								; //(integer)ri.Version4.PropOwnedCount;
			integer PropOwnedHistoricalCount			; //(integer)ri.Version4.PropOwnedHistoricalCount;
			string  Bankruptcystatus							; //ri.Version4.Bankruptcystatus;
			integer Prsearchpersonalfinancecount	; //(integer)ri.Version4.Prsearchpersonalfinancecount;
			integer Verifiedname									; //(integer)ri.Version4.Verifiedname;
			integer Inputaddrlenofres							; //(integer)ri.Version4.Inputaddrlenofres;
			integer Ssnlowissueage								; //(integer)ri.Version4.Ssnlowissueage;
			integer Prsearchaddridentities				; //(integer)ri.Version4.Prsearchaddridentities;
			integer addrchangecount60							; //(integer)ri.Version4.addrchangecount60;
			integer evictioncount									; //(integer)ri.Version4.evictioncount;
			integer curraddrmedianincome					; //(integer)ri.Version4.curraddrmedianincome;
			integer phoneedaageoldestrecord				; //(integer)ri.Version4.phoneedaageoldestrecord;
			integer lienfiledcount60							; //(integer)ri.Version4.lienfiledcount60;
			integer educationattendedcollege			; //(integer)ri.Version4.educationattendedcollege;
			integer felonycount										; //(integer)ri.Version4.felonycount;
			integer businessinputaddrcount				; //(integer)ri.Version4.businessinputaddrcount;
			integer addrmostrecentmoveage					; //(integer)ri.Version4.addrmostrecentmoveage;
			string  inputphonetype    						; //ri.Version4.inputphonetype;
			integer subprimeofferrequestcount60		; //(integer)ri.Version4.subprimeofferrequestcount60;
			integer ssnproblems										; //(integer)ri.Version4.ssnproblems;
			integer ssnagedeceased 								; //(integer)ri.Version4.ssnagedeceased;		
			risk_indicators.layout_boca_shell clam;
			models.layout_modelout;
		end;
		layout_debug doModel( clam le, LI_attr ri ) := TRANSFORM
	#else
		models.layout_modelout doModel( clam le, LI_attr ri ) := TRANSFORM
	#end
			Donotmail											:= ri.Version4.Donotmail;
			PropOwnedCount								:= (integer)ri.Version4.PropOwnedCount;
			PropOwnedHistoricalCount			:= (integer)ri.Version4.PropOwnedHistoricalCount;
			Bankruptcystatus							:= ri.Version4.Bankruptcystatus;
			Prsearchpersonalfinancecount	:= (integer)ri.Version4.Prsearchpersonalfinancecount;
			Verifiedname									:= (integer)ri.Version4.Verifiedname;
			Inputaddrlenofres							:= (integer)ri.Version4.Inputaddrlenofres;
			Ssnlowissueage								:= (integer)ri.Version4.Ssnlowissueage;
			Prsearchaddridentities				:= (integer)ri.Version4.Prsearchaddridentities;
			addrchangecount60							:= (integer)ri.Version4.addrchangecount60;
			evictioncount									:= (integer)ri.Version4.evictioncount;
			curraddrmedianincome					:= (integer)ri.Version4.curraddrmedianincome;
			phoneedaageoldestrecord				:= (integer)ri.Version4.phoneedaageoldestrecord;
			lienfiledcount60							:= (integer)ri.Version4.lienfiledcount60;
			educationattendedcollege			:= (integer)ri.Version4.educationattendedcollege;
			felonycount										:= (integer)ri.Version4.felonycount;
			businessinputaddrcount				:= (integer)ri.Version4.businessinputaddrcount;
			addrmostrecentmoveage					:= (integer)ri.Version4.addrmostrecentmoveage;
			inputphonetype    						:= ri.Version4.inputphonetype;
			subprimeofferrequestcount60		:= (integer)ri.Version4.subprimeofferrequestcount60;
			ssnproblems										:= (integer)ri.Version4.ssnproblems;
			ssnagedeceased 								:= (integer)ri.Version4.ssnagedeceased;


NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

propownedlevel := map(
    donotmail = '1'                                     => NULL,
    PropOwnedCount = 0 and PropOwnedHistoricalCount = 0 => 0,
    PropOwnedCount = 0 and PropOwnedHistoricalCount > 0 => 1,
    PropOwnedCount > 0                                  => 2,
                                                           NULL);

bk_discharge := contains_i(StringLib.StringToUpperCase(bankruptcystatus), 'DISCHARGE');

bk_dismiss := contains_i(StringLib.StringToUpperCase(bankruptcystatus), 'DISMISS');

bk_disposition := map(
    donotmail = '1'              => '          ',
    (bankruptcystatus in ['-1']) => '-1        ',
    bk_discharge > 0             => 'Discharged',
    bk_dismiss > 0               => 'Dismissed ',
                                    'Other     ');

//this inputphonetype_lvl variable was missing from the original converted ECL code - Nick emailed later 
inputphonetype_lvl := map(
    donotmail = '1'                => NULL,
    (inputphonetype in ['-1'])     => -1,
    (inputphonetype in ['0'])      => 0,
    (inputphonetype in ['1', '3']) => 1,
    (inputphonetype in ['7'])      => 2,
                                      3);

a_subscore0 := map(
    NULL < prsearchpersonalfinancecount AND prsearchpersonalfinancecount < 1 => -0.224376,
    1 <= prsearchpersonalfinancecount                                        => 0.151312,
                                                                                -0.000000);

a_subscore1 := map(
    (verifiedname in [0])    => -0.377885,
    (verifiedname in [1, 2]) => -0.796350,
    (verifiedname in [3])    => 0.040619,
                                0.000000);

a_subscore2 := map(
    NULL < inputaddrlenofres AND inputaddrlenofres < 0  => 0.210739,
    0 <= inputaddrlenofres AND inputaddrlenofres < 3    => 0.162264,
    3 <= inputaddrlenofres AND inputaddrlenofres < 8    => -0.032775,
    8 <= inputaddrlenofres AND inputaddrlenofres < 19   => -0.108752,
    19 <= inputaddrlenofres AND inputaddrlenofres < 74  => -0.132877,
    74 <= inputaddrlenofres AND inputaddrlenofres < 183 => -0.134256,
    183 <= inputaddrlenofres                            => -0.178050,
                                                           0.000000);

a_subscore3 := map(
    NULL < ssnlowissueage AND ssnlowissueage < 0   => -0.205087,
    0 <= ssnlowissueage AND ssnlowissueage < 70    => -0.687074,
    70 <= ssnlowissueage AND ssnlowissueage < 191  => -0.419714,
    191 <= ssnlowissueage AND ssnlowissueage < 240 => -0.051956,
    240 <= ssnlowissueage AND ssnlowissueage < 313 => 0.067339,
    313 <= ssnlowissueage AND ssnlowissueage < 377 => 0.111658,
    377 <= ssnlowissueage AND ssnlowissueage < 437 => 0.065644,
    437 <= ssnlowissueage AND ssnlowissueage < 497 => -0.031774,
    497 <= ssnlowissueage AND ssnlowissueage < 574 => -0.208758,
    574 <= ssnlowissueage                          => -0.347504,
                                                      -0.000000);

a_subscore4 := map(
    NULL < prsearchaddridentities AND prsearchaddridentities < 1 => -0.160949,
    1 <= prsearchaddridentities AND prsearchaddridentities < 2   => -0.008736,
    2 <= prsearchaddridentities AND prsearchaddridentities < 3   => 0.061154,
    3 <= prsearchaddridentities AND prsearchaddridentities < 4   => 0.145746,
    4 <= prsearchaddridentities                                  => 0.250180,
                                                                    0.000000);

a_subscore5 := map(
    (propownedlevel in [0]) => 0.034950,
    (propownedlevel in [2]) => -0.216878,
    (propownedlevel in [1]) => -0.231488,
                               -0.000000);

a_subscore6 := map(
    NULL < addrchangecount60 AND addrchangecount60 < 1 => -0.119891,
    1 <= addrchangecount60 AND addrchangecount60 < 4   => -0.077136,
    4 <= addrchangecount60 AND addrchangecount60 < 7   => 0.001436,
    7 <= addrchangecount60 AND addrchangecount60 < 10  => 0.069526,
    10 <= addrchangecount60                            => 0.137952,
                                                          -0.000000);

a_subscore7 := map(
    NULL < evictioncount AND evictioncount < 1 => -0.040249,
    1 <= evictioncount AND evictioncount < 2   => 0.067348,
    2 <= evictioncount AND evictioncount < 3   => 0.087600,
    3 <= evictioncount                         => 0.150196,
                                                  -0.000000);

a_subscore8 := map(
    (bk_disposition in ['-1'])         => 0.017138,
    (bk_disposition in ['Discharged']) => -0.238785,
    (bk_disposition in ['Dismissed'])  => 0.101842,
                                          0.000000);

a_subscore9 := map(
    NULL < curraddrmedianincome AND curraddrmedianincome < 0       => -0.000000,
    0 <= curraddrmedianincome AND curraddrmedianincome < 34204     => 0.088450,
    34204 <= curraddrmedianincome AND curraddrmedianincome < 79627 => -0.048800,
    79627 <= curraddrmedianincome                                  => -0.123703,
                                                                      -0.000000);

a_subscore10 := map(
    NULL < phoneedaageoldestrecord AND phoneedaageoldestrecord < 0  => 0.000000,
    0 <= phoneedaageoldestrecord AND phoneedaageoldestrecord < 71   => 0.072458,
    71 <= phoneedaageoldestrecord AND phoneedaageoldestrecord < 142 => -0.006031,
    142 <= phoneedaageoldestrecord                                  => -0.260214,
                                                                       0.000000);

a_subscore11 := map(
    NULL < lienfiledcount60 AND lienfiledcount60 < 1 => -0.038680,
    1 <= lienfiledcount60                            => 0.088476,
                                                        0.000000);

a_subscore12 := map(
    (educationattendedcollege in [0]) => 0.011960,
    (educationattendedcollege in [1]) => -0.255214,
                                         0.000000);

a_subscore13 := map(
    NULL < felonycount AND felonycount < 1 => -0.014977,
    1 <= felonycount                       => 0.184737,
                                              0.000000);

a_subscore14 := map(
    NULL < businessinputaddrcount AND businessinputaddrcount < 0 => 0.000000,
    0 <= businessinputaddrcount AND businessinputaddrcount < 1   => 0.027143,
    1 <= businessinputaddrcount AND businessinputaddrcount < 4   => -0.015415,
    4 <= businessinputaddrcount AND businessinputaddrcount < 28  => -0.047594,
    28 <= businessinputaddrcount                                 => -0.259305,
                                                                    0.000000);

a_subscore15 := map(
    NULL < addrmostrecentmoveage AND addrmostrecentmoveage < 0   => -0.006604,
    0 <= addrmostrecentmoveage AND addrmostrecentmoveage < 71    => 0.037436,
    71 <= addrmostrecentmoveage AND addrmostrecentmoveage < 93   => 0.013067,
    93 <= addrmostrecentmoveage AND addrmostrecentmoveage < 135  => 0.002395,
    135 <= addrmostrecentmoveage AND addrmostrecentmoveage < 173 => -0.053671,
    173 <= addrmostrecentmoveage AND addrmostrecentmoveage < 276 => -0.110925,
    276 <= addrmostrecentmoveage                                 => -0.152378,
                                                                    0.000000);

a_subscore16 := map(
    (inputphonetype_lvl in [-1]) => -0.005268,
    (inputphonetype_lvl in [0])  => -0.110698,
    (inputphonetype_lvl in [1])  => 0.050902,
    (inputphonetype_lvl in [2])  => -0.641941,
                                    0.000000);

a_subscore17 := map(
    NULL < subprimeofferrequestcount60 AND subprimeofferrequestcount60 < 1 => -0.014402,
    1 <= subprimeofferrequestcount60                                       => 0.053574,
                                                                              0.000000);

a_rawscore := a_subscore0 +
    a_subscore1 +
    a_subscore2 +
    a_subscore3 +
    a_subscore4 +
    a_subscore5 +
    a_subscore6 +
    a_subscore7 +
    a_subscore8 +
    a_subscore9 +
    a_subscore10 +
    a_subscore11 +
    a_subscore12 +
    a_subscore13 +
    a_subscore14 +
    a_subscore15 +
    a_subscore16 +
    a_subscore17;

a_lnoddsscore := a_rawscore + -3.590252;

a_probscore := exp(a_lnoddsscore) / (1 + exp(a_lnoddsscore));

probscore := map(
    a_probscore < 0.0015924593 => max(0.0015924593, a_probscore),
    a_probscore > 0.1109960563 => min(0.1109960563, if(a_probscore = NULL, -NULL, a_probscore)),
                                  a_probscore);

msn1210_1_0_2 := map(
    0.0015924593 <= probscore AND probscore <= 0.0064801718 => max(min(if(round((probscore - 0.0015924592) / (0.0064801718 - 0.0015924592) * 25  + 300) = NULL, -NULL, round((probscore - 0.0015924592) / (0.0064801718 - 0.0015924592) * 25  + 300)), 324), 300),
    0.0064801718 <  probscore AND probscore <= 0.0072748691 => max(min(if(round((probscore - 0.0064801718) / (0.0072748691 - 0.0064801718) * 25  + 325) = NULL, -NULL, round((probscore - 0.0064801718) / (0.0072748691 - 0.0064801718) * 25  + 325)), 349), 325),
    0.0072748691 <  probscore AND probscore <= 0.0078723981 => max(min(if(round((probscore - 0.0072748691) / (0.0078723981 - 0.0072748691) * 25  + 350) = NULL, -NULL, round((probscore - 0.0072748691) / (0.0078723981 - 0.0072748691) * 25  + 350)), 374), 350),
    0.0078723981 <  probscore AND probscore <= 0.0084681248 => max(min(if(round((probscore - 0.0078723981) / (0.0084681248 - 0.0078723981) * 25  + 375) = NULL, -NULL, round((probscore - 0.0078723981) / (0.0084681248 - 0.0078723981) * 25  + 375)), 399), 375),

    0.0084681248 <  probscore AND probscore <= 0.0110229681 => max(min(if(round((probscore - 0.0084681248) / (0.0110229681 - 0.0084681248) * 100 + 400) = NULL, -NULL, round((probscore - 0.0084681248) / (0.0110229681 - 0.0084681248) * 100 + 400)), 499), 400),
    0.0110229681 <  probscore AND probscore <= 0.0137297282 => max(min(if(round((probscore - 0.0110229681) / (0.0137297282 - 0.0110229681) * 100 + 500) = NULL, -NULL, round((probscore - 0.0110229681) / (0.0137297282 - 0.0110229681) * 100 + 500)), 599), 500),
    0.0137297282 <  probscore AND probscore <= 0.0174602317 => max(min(if(round((probscore - 0.0137297282) / (0.0174602317 - 0.0137297282) * 100 + 600) = NULL, -NULL, round((probscore - 0.0137297282) / (0.0174602317 - 0.0137297282) * 100 + 600)), 699), 600),
    0.0174602317 <  probscore AND probscore <= 0.0226569737 => max(min(if(round((probscore - 0.0174602317) / (0.0226569737 - 0.0174602317) * 100 + 700) = NULL, -NULL, round((probscore - 0.0174602317) / (0.0226569737 - 0.0174602317) * 100 + 700)), 799), 700),
    0.0226569737 <  probscore AND probscore <= 0.0309454479 => max(min(if(round((probscore - 0.0226569737) / (0.0309454479 - 0.0226569737) * 100 + 800) = NULL, -NULL, round((probscore - 0.0226569737) / (0.0309454479 - 0.0226569737) * 100 + 800)), 899), 800),

    0.0309454479 <  probscore AND probscore <= 0.0340212009 => max(min(if(round((probscore - 0.0309454479) / (0.0340212009 - 0.0309454479) * 25  + 900) = NULL, -NULL, round((probscore - 0.0309454479) / (0.0340212009 - 0.0309454479) * 25  + 900)), 924), 900),
    0.0340212009 <  probscore AND probscore <= 0.0381728583 => max(min(if(round((probscore - 0.0340212009) / (0.0381728583 - 0.0340212009) * 25  + 925) = NULL, -NULL, round((probscore - 0.0340212009) / (0.0381728583 - 0.0340212009) * 25  + 925)), 949), 925),
    0.0381728583 <  probscore AND probscore <= 0.0448633164 => max(min(if(round((probscore - 0.0381728583) / (0.0448633164 - 0.0381728583) * 25  + 950) = NULL, -NULL, round((probscore - 0.0381728583) / (0.0448633164 - 0.0381728583) * 25  + 950)), 974), 950),
                                                               max(min(if(round((probscore - 0.0448633164) / (0.1109960563 - 0.0448633164) * 25  + 975) = NULL, -NULL, round((probscore - 0.0448633164) / (0.1109960563 - 0.0448633164) * 25  + 975)), 999), 975));

msn1210_1_0_1 := map(
    ssnproblems = 5     => 200,
    ssnagedeceased > -1 => 200,
                           msn1210_1_0_2);

MSN1210_1_0 := if(donotmail = '1', 210, msn1210_1_0_1);

		#if(MSN_DEBUG)
			self.clam := le;
			self.propownedlevel                   := propownedlevel;
			self.bk_discharge                     := bk_discharge;
			self.bk_dismiss                       := bk_dismiss;
			self.bk_disposition                   := bk_disposition;
			self.inputphonetype_lvl               := inputphonetype_lvl;
			self.a_subscore0                      := a_subscore0;
			self.a_subscore1                      := a_subscore1;
			self.a_subscore2                      := a_subscore2;
			self.a_subscore3                      := a_subscore3;
			self.a_subscore4                      := a_subscore4;
			self.a_subscore5                      := a_subscore5;
			self.a_subscore6                      := a_subscore6;
			self.a_subscore7                      := a_subscore7;
			self.a_subscore8                      := a_subscore8;
			self.a_subscore9                      := a_subscore9;
			self.a_subscore10                     := a_subscore10;
			self.a_subscore11                     := a_subscore11;
			self.a_subscore12                     := a_subscore12;
			self.a_subscore13                     := a_subscore13;
			self.a_subscore14                     := a_subscore14;
			self.a_subscore15                     := a_subscore15;
			self.a_subscore16                     := a_subscore16;
			self.a_subscore17                     := a_subscore17;
			self.a_rawscore                       := a_rawscore;
			self.a_lnoddsscore                    := a_lnoddsscore;
			self.a_probscore                      := a_probscore;
			self.probscore                        := probscore;
			self.MSN1210_1_0                      := MSN1210_1_0;
			self.Donotmail												:= Donotmail;
			self.PropOwnedCount										:= PropOwnedCount;
			self.PropOwnedHistoricalCount					:= PropOwnedHistoricalCount;
			self.Bankruptcystatus									:= Bankruptcystatus;
			self.Prsearchpersonalfinancecount			:= Prsearchpersonalfinancecount;
			self.Verifiedname											:= Verifiedname;
			self.Inputaddrlenofres								:= Inputaddrlenofres;
			self.Ssnlowissueage										:= Ssnlowissueage;
			self.Prsearchaddridentities						:= Prsearchaddridentities;
			self.addrchangecount60								:= addrchangecount60;
			self.evictioncount										:= evictioncount;
			self.curraddrmedianincome							:= curraddrmedianincome;
			self.phoneedaageoldestrecord					:= phoneedaageoldestrecord;
			self.lienfiledcount60									:= lienfiledcount60;
			self.educationattendedcollege					:= educationattendedcollege;
			self.felonycount											:= felonycount;
			self.businessinputaddrcount						:= businessinputaddrcount;
			self.addrmostrecentmoveage						:= addrmostrecentmoveage;
			self.inputphonetype    								:= inputphonetype;
			self.subprimeofferrequestcount60			:= subprimeofferrequestcount60;
			self.ssnproblems											:= ssnproblems;
			self.ssnagedeceased 									:= ssnagedeceased;
		#END
		self.seq := le.seq;
		self.score := (string3)MSN1210_1_0;
		rc := riskwise.Reasons( le );  //produce the "standard" Lead Integrity warning codes
		reasons := 
			  if( rc.rc77, rc.makeRC('77') )
			& if( rc.rc78, rc.makeRC('78') )
			& if( rc.rc02, rc.makeRC('02') )
			& if( rc.rc50, rc.makeRC('50') )
			& if( rc.rc97, rc.makeRC('97') )
			& if( rc.rc9N, rc.makeRC('9N') )
			& if( rc.rc98, rc.makeRC('98') )
			& if( rc.rcEV, rc.makeRC('EV') )
			& if( rc.rc9W, rc.makeRC('9W') )
			& if( rc.rc9H, rc.makeRC('9H') )
			& if( rc.rc22, rc.makeRC('22') )
			& if( rc.rc23, rc.makeRC('23') )
			& if( rc.rc24, rc.makeRC('24') )
			& if( rc.rc25, rc.makeRC('25') )
			& if( rc.rc26, rc.makeRC('26') )
			& if( rc.rc37, rc.makeRC('37') )
			& if( rc.rc48, rc.makeRC('48') )
			& if( rc.rc9E, rc.makeRC('9E') )
			& if( rc.rcFQ, rc.makeRC('FQ') )
			& if( rc.rcFR, rc.makeRC('FR') )
			& if( rc.rc99, rc.makeRC('99') )
			// & if( rc.rc9K, rc.makeRC('9K') )
			& if( le.shell_input.addr_type = 'H', rc.makeRC('9K') )
			& if( rc.rc9F, rc.makeRC('9F') )
			& if( rc.rc9A, rc.makeRC('9A') )
			& if( rc.rc9B, rc.makeRC('9B') )
			& if( rc.rc06, rc.makeRC('06') )
			& if( rc.rc51, rc.makeRC('51') )
			& if( rc.rc71, rc.makeRC('71') )
			& if( rc.rc72, rc.makeRC('72') )
			& if( rc.rc39, rc.makeRC('39') )
			& if( rc.rcMI, rc.makeRC('MI') )
			& if( rc.rc38, rc.makeRC('38') )
			& if( rc.rcMS, rc.makeRC('MS') )
			& if( rc.rc89, rc.makeRC('89') )
			& if( rc.rcMN, rc.makeRC('MN') )
			& if( rc.rc52, rc.makeRC('52') )
			& if( rc.rc14, rc.makeRC('14') )
			& if( rc.rc11, rc.makeRC('11') )
			& if( rc.rc12, rc.makeRC('12') )
			& if( rc.rc40, rc.makeRC('40') )
			& if( rc.rc13, rc.makeRC('13') )
			& if( rc.rc85, rc.makeRC('85') )
			& if( rc.rc90, rc.makeRC('90') )
			& if( rc.rc9G, rc.makeRC('9G') )
			& if( rc.rc9D, rc.makeRC('9D') )
			& if( rc.rc9J, rc.makeRC('9J') )
			& if( rc.rc9C, rc.makeRC('9C') )
			& if( rc.rcFB, rc.makeRC('FB') )
			// & if( rc.rc9O, rc.makeRC('9O') )
			& if( le.velocity_counters.phones_per_addr = 0, rc.makeRC('9O') )
			// & if( rc.rc9M, rc.makeRC('9M') )
			& if( (integer1)le.wealth_indicator <= 2, rc.makeRC('9M') )
			& if( rc.rc9I, rc.makeRC('9I') )
			& if( rc.rcPV, rc.makeRC('PV') )
			& if( rc.rc29, rc.makeRC('29') )
			& if( rc.rc30, rc.makeRC('30') )
			& rc.makeRC('00')
			& rc.makeRC('00')
			& rc.makeRC('00')
			& rc.makeRC('00')
			& rc.makeRC('00')
			& rc.makeRC('00')
		;

		self.ri := choosen( reasons, 6 );	
END;

model := join( clam, LI_attr, 
		(string)left.seq = right.seq, 
		doModel(left, right), left outer, ATMOST(RiskWise.max_atmost), KEEP(1) );

	return model;
	
END;
