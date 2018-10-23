IMPORT risk_indicators, easi, RiskWise; 
EXPORT PB1708_1_0(
DATASET(ProfileBooster.Layouts.Layout_PB_BatchOut) pb_attributes_in ) := FUNCTION

 
 MODEL_DEBUG := FALSE;
 // MODEL_DEBUG := TRUE;

 layout_temp := RECORD  
 Risk_Indicators.Layout_Input;
  ProfileBooster.Layouts.Layout_PB_BatchOut pb;

	END;
 


#IF(MODEL_DEBUG) 
 layout_debug := RECORD
 // intermediate variables from the model
                     integer seq;
                     string3 _raammbrcnt         ;
                     string3  _prospectage          ;
                    string3   _verifiedcurrresmatchindex       ;
                     string3  _prospectbankingexperience       ;
                     string2   _prospectgender                   ;
                     string2   _raamedincomerange                ;
                     string3   _crtrectimenewest                 ;
                     string2   _resinputownershipindex           ;
                     string3   _hhoccbusinessassocmmbrcnt          ;
                     string2   _ppcurrowner                     ;
                     string3    _hhcrtrecfelonymmbrcnt            ;
                     string3   _crtreclienjudgcnt                ;
                     string3   _hhcrtrecevictionmmbrcnt          ;
                     string2  _verifiedprospectfound           ;
                     string3 _RaACrtRecFelonyMmbrCnt ;
                     string3  _RaACrtRecEvictionMmbrCnt;
                     string3  _RaACrtRecLienJudgMmbrCnt;
 
 
REAL ca_raacrtrecevictionmmbrpct;      
REAL ca_raacrtrecfelonymmbrpct;        
real ca_raacrtreclienjudgmmbrpct;      
REAL ca_raaderogindexpct;              
REAL c_subscore0;                      
REAL c_subscore1;                      
REAL c_subscore2;                      
REAL c_subscore3;                      
REAL c_subscore4;                      
REAL c_subscore5;                      
REAL c_subscore6;                      
REAL c_subscore7;                      
REAL c_subscore8;                      
REAL c_subscore9;                      
REAL c_subscore10;                     
REAL c_subscore11;                     
REAL c_subscore12;                     
REAL c_rawscore;                       
REAL c_lnoddsscore;                    
REAL c_probscore;                      
REAL base;                             
REAL odds;                             
REAL point;                            
REAL pb1708_1_0;                       
unsigned6 Lexid;
STRING Acctno;
//layout_temp;

 END;
    

   layout_debug doModel(pb_attributes_in le) := TRANSFORM
   
  #ELSE
 
   ProfileBooster.Layouts.Layout_PB_BatchOut doModel(pb_attributes_in le) := TRANSFORM


  #END
  
/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */


 
     
          
	raammbrcnt                       := trim(le.attributes.version1.RaAMmbrCnt,all);
	raacrtrecevictionmmbrcnt         := trim(le.attributes.version1.RaACrtRecEvictionMmbrCnt,all);
	raacrtrecfelonymmbrcnt           := trim(le.attributes.version1.RaACrtRecFelonyMmbrCnt,all);
	raacrtreclienjudgmmbrcnt         := trim(le.attributes.version1.RaACrtRecLienJudgMmbrCnt,all);
	prospectage                      := trim(le.attributes.version1.ProspectAge,all);
	verifiedcurrresmatchindex        := trim(le.attributes.version1.VerifiedCurrResMatchIndex,all);
	prospectbankingexperience        := trim(le.attributes.version1.ProspectBankingExperience,all);
	prospectgender                   := trim(le.attributes.version1.ProspectGender,all);
	raamedincomerange                := trim(le.attributes.version1.RaAMedIncomeRange,all);
	crtrectimenewest                 := trim(le.attributes.version1.CrtRecTimeNewest,all);
	resinputownershipindex           := trim(le.attributes.version1.ResInputOwnershipIndex,all);
	hhoccbusinessassocmmbrcnt        := trim(le.attributes.version1.HHOccBusinessAssocMmbrCnt,all);
	ppcurrowner                      := trim(le.attributes.version1.PPCurrOwner,all);
	hhcrtrecfelonymmbrcnt            := trim(le.attributes.version1.HHCrtRecFelonyMmbrCnt,all);
	crtreclienjudgcnt                := trim(le.attributes.version1.CrtRecLienJudgCnt,all);
	hhcrtrecevictionmmbrcnt          := trim(le.attributes.version1.HHCrtRecEvictionMmbrCnt,all);
	verifiedprospectfound            := trim(le.attributes.version1.VerifiedProspectFound,all);

// lexid := le.lexid;
// AcctNo := le.AcctNo;

/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */

NULL := -999999999;

ca_raacrtrecevictionmmbrpct_1 := map(
    RaAMmbrCnt = '' or RaACrtRecEvictionMmbrCnt = '' or (INTEGER)RaAMmbrCnt = -1 or (INTEGER)RaACrtRecEvictionMmbrCnt = -1 => -1,
    (INTEGER)RaAMmbrCnt = 0                                                                                           => -2,
    (real)RaACrtRecEvictionMmbrCnt / (real)RaAMmbrCnt);

ca_raacrtrecfelonymmbrpct_1 := map(
    RaAMmbrCnt = '' or RaACrtRecFelonyMmbrCnt = '' or (INTEGER)RaAMmbrCnt = -1 or (INTEGER)RaACrtRecFelonyMmbrCnt = -1 => -1,
    (INTEGER)RaAMmbrCnt = 0                                                                                       => -2,
    (real)RaACrtRecFelonyMmbrCnt / (real)RaAMmbrCnt);

ca_raacrtreclienjudgmmbrpct_1 := map(
    RaAMmbrCnt = '' or RaACrtRecLienJudgMmbrCnt = '' or (INTEGER)RaAMmbrCnt = -1 or (INTEGER)RaACrtRecLienJudgMmbrCnt = -1 => -1,
    (INTEGER)RaAMmbrCnt = 0                                                                                           => -2,
    (real)RaACrtRecLienJudgMmbrCnt / (real)RaAMmbrCnt);

ca_raacrtrecevictionmmbrpct := map(
    RaAMmbrCnt = '' or RaACrtRecEvictionMmbrCnt = '' or (INTEGER)RaAMmbrCnt = -1 or (INTEGER)RaACrtRecEvictionMmbrCnt = -1 => -1,
    (INTEGER)RaAMmbrCnt = 0                                                                                           => -2,
    (real)RaACrtRecEvictionMmbrCnt / (real)RaAMmbrCnt);

ca_raacrtrecfelonymmbrpct := map(
    RaAMmbrCnt = '' or RaACrtRecFelonyMmbrCnt = '' or (INTEGER)RaAMmbrCnt = -1 or (INTEGER)RaACrtRecFelonyMmbrCnt = -1 => -1,
    (INTEGER)RaAMmbrCnt = 0                                                                                       => -2,
    (real)RaACrtRecFelonyMmbrCnt / (real)RaAMmbrCnt);

ca_raacrtreclienjudgmmbrpct := map(
    RaAMmbrCnt = '' or RaACrtRecLienJudgMmbrCnt = '' or (INTEGER)RaAMmbrCnt = -1 or (INTEGER)RaACrtRecLienJudgMmbrCnt = -1 => -1,
    (INTEGER)RaAMmbrCnt = 0                                                                                           => -2,
    (real)RaACrtRecLienJudgMmbrCnt / (real)RaAMmbrCnt);

ca_raaderogindexpct := map(
    ca_raacrtrecevictionmmbrpct = NULL or ca_raacrtrecfelonymmbrpct = NULL or ca_raacrtreclienjudgmmbrpct = NULL or ca_raacrtrecevictionmmbrpct = -1 or ca_raacrtrecfelonymmbrpct = -1 or ca_raacrtreclienjudgmmbrpct = -1 => -1,
    (INTEGER)RaAMmbrCnt = 0                                                                                                                                                                                                         => -2,
    ca_raacrtrecevictionmmbrpct > 0.20 and ca_raacrtrecfelonymmbrpct > 0                                                                                                                                                   => 5,
    ca_raacrtrecevictionmmbrpct > 0 and ca_raacrtrecfelonymmbrpct > 0                                                                                                                                                      => 4,
    ca_raacrtrecevictionmmbrpct = 0 and ca_raacrtrecfelonymmbrpct > 0 or ca_raacrtrecfelonymmbrpct = 0 and ca_raacrtrecevictionmmbrpct > 0                                                                                 => 3,
    ca_raacrtrecevictionmmbrpct = 0 and ca_raacrtrecfelonymmbrpct = 0 and ca_raacrtreclienjudgmmbrpct > 0                                                                                                                  => 2,
                                                                                                                                                                                                                              1);

c_subscore0 := map(
    NULL < (INTEGER)ProspectAge AND (INTEGER)ProspectAge < 0 => -0.000000,
    0 <= (INTEGER)ProspectAge AND (INTEGER)ProspectAge < 18  => -0.000000,
    18 <= (INTEGER)ProspectAge AND (INTEGER)ProspectAge < 29 => 0.355803,
    29 <= (INTEGER)ProspectAge AND (INTEGER)ProspectAge < 41 => 0.290983,
    41 <= (INTEGER)ProspectAge AND (INTEGER)ProspectAge < 43 => 0.213884,
    43 <= (INTEGER)ProspectAge AND (INTEGER)ProspectAge < 46 => 0.046228,
    46 <= (INTEGER)ProspectAge AND (INTEGER)ProspectAge < 52 => 0.054436,
    52 <= (INTEGER)ProspectAge AND (INTEGER)ProspectAge < 54 => -0.281190,
    54 <= (INTEGER)ProspectAge                      => -0.436746,
                                              -0.000000);

c_subscore1 := map(
    ((INTEGER)VerifiedCurrResMatchIndex in [0]) => 0.083770,
    ((INTEGER)VerifiedCurrResMatchIndex in [1]) => -0.486707,
    ((INTEGER)VerifiedCurrResMatchIndex in [2]) => -0.306496,
                                          -0.000000);

c_subscore2 := map(
    ((INTEGER)ProspectBankingExperience in [0]) => 0.111761,
    ((INTEGER)ProspectBankingExperience in [1]) => -0.180193,
    ((INTEGER)ProspectBankingExperience in [2]) => -0.299209,
                                          0.000000);

c_subscore3 := map(
    (ProspectGender in ['0']) => 0.000000,
    (ProspectGender in ['F']) => -0.172758,
    (ProspectGender in ['M']) => 0.204271,
                                 0.000000);

c_subscore4 := map(
    (ca_raaderogindexpct in [-2])   => -0.000000,
    (ca_raaderogindexpct in [1])    => -0.469419,
    (ca_raaderogindexpct in [2])    => -0.034388,
    (ca_raaderogindexpct in [3])    => 0.046227,
    (ca_raaderogindexpct in [4, 5]) => 0.098465,
                                       -0.000000);

c_subscore5 := map(
    ((INTEGER)RaAMedIncomeRange in [-1])              => 0.000000,
    ((INTEGER)RaAMedIncomeRange in [1, 2])            => 0.379819,
    ((INTEGER)RaAMedIncomeRange in [3])               => 0.301368,
    ((INTEGER)RaAMedIncomeRange in [4])               => 0.124484,
    ((INTEGER)RaAMedIncomeRange in [5])               => 0.018423,
    ((INTEGER)RaAMedIncomeRange in [6])               => -0.058413,
    ((INTEGER)RaAMedIncomeRange in [7, 8, 9, 10, 11]) => -0.152462,
                                                0.000000);

c_subscore6 := map(
    NULL < (INTEGER)CrtRecTimeNewest AND (INTEGER)CrtRecTimeNewest < 1  => -0.000000,
    1 <= (INTEGER)CrtRecTimeNewest AND (INTEGER)CrtRecTimeNewest < 11   => 0.336887,
    11 <= (INTEGER)CrtRecTimeNewest AND (INTEGER)CrtRecTimeNewest < 34  => 0.108511,
    34 <= (INTEGER)CrtRecTimeNewest AND (INTEGER)CrtRecTimeNewest < 67  => -0.087436,
    67 <= (INTEGER)CrtRecTimeNewest AND (INTEGER)CrtRecTimeNewest < 100 => -0.103899,
    100 <= (INTEGER)CrtRecTimeNewest                           => -0.180423,
                                                         -0.000000);

c_subscore7 := map(
    ((INTEGER)ResInputOwnershipIndex in [0])    => 0.000000,
    ((INTEGER)ResInputOwnershipIndex in [1])    => 0.088494,
    ((INTEGER)ResInputOwnershipIndex in [2, 3]) => 0.039085,
    ((INTEGER)ResInputOwnershipIndex in [4])    => -0.420054,
                                          0.000000);

c_subscore8 := map(
    NULL < (INTEGER)HHOccBusinessAssocMmbrCnt AND (INTEGER)HHOccBusinessAssocMmbrCnt < 1 => 0.040473,
    1 <= (INTEGER)HHOccBusinessAssocMmbrCnt                                     => -0.357018,
                                                                          -0.000000);

c_subscore9 := map(
    ((INTEGER)PPCurrOwner in [0]) => 0.054209,
    ((INTEGER)PPCurrOwner in [1]) => -0.132283,
                            0.000000);

c_subscore10 := map(
    NULL < (INTEGER)HHCrtRecFelonyMmbrCnt AND (INTEGER)HHCrtRecFelonyMmbrCnt < 1 => -0.027624,
    1 <= (INTEGER)HHCrtRecFelonyMmbrCnt                                 => 0.259676,
                                                                  0.000000);

c_subscore11 := map(
    NULL < (INTEGER)CrtRecLienJudgCnt AND (INTEGER)CrtRecLienJudgCnt < 1 => -0.056547,
    1 <= (INTEGER)CrtRecLienJudgCnt                             => 0.120435,
                                                          -0.000000);

c_subscore12 := map(
    NULL < (INTEGER)HHCrtRecEvictionMmbrCnt AND (INTEGER)HHCrtRecEvictionMmbrCnt < 1 => -0.029633,
    1 <= (INTEGER)HHCrtRecEvictionMmbrCnt AND (INTEGER)HHCrtRecEvictionMmbrCnt < 2   => 0.072918,
    2 <= (INTEGER)HHCrtRecEvictionMmbrCnt                                   => 0.282968,
                                                                      -0.000000);

c_rawscore := c_subscore0 +
    c_subscore1 +
    c_subscore2 +
    c_subscore3 +
    c_subscore4 +
    c_subscore5 +
    c_subscore6 +
    c_subscore7 +
    c_subscore8 +
    c_subscore9 +
    c_subscore10 +
    c_subscore11 +
    c_subscore12;

c_lnoddsscore := c_rawscore + -2.192713;

c_probscore := exp(c_lnoddsscore) / (1 + exp(c_lnoddsscore));

base := 700;

odds := 0.10 / (1 - 0.10);

point := -40;

pb1708_1_0 := if((INTEGER)VerifiedProspectFound = -1, '', (string)min(if(max(round(point * (c_lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (c_lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));

																																	 
//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//
//Intermediate variables
	#IF(MODEL_DEBUG)
                    
                  
                    
                    self.seq := le.seq;
                    
                     self._raammbrcnt                       := raammbrcnt;
                      self._prospectage                      := ProspectAge;
                      self._verifiedcurrresmatchindex        := VerifiedCurrResMatchIndex;
                      self._prospectbankingexperience        := ProspectBankingExperience;
                      self._prospectgender                   := ProspectGender;
                      self._raamedincomerange                := RaAMedIncomeRange;
                     self._crtrectimenewest                 := CrtRecTimeNewest;
                      self._resinputownershipindex           := ResInputOwnershipIndex;
                      self._hhoccbusinessassocmmbrcnt           := HHOccBusinessAssocMmbrCnt;
                     self._ppcurrowner                      := PPCurrOwner;
                      self._hhcrtrecfelonymmbrcnt            := HHCrtRecFelonyMmbrCnt;
                      self._crtreclienjudgcnt                := CrtRecLienJudgCnt;
                      self._hhcrtrecevictionmmbrcnt          := HHCrtRecEvictionMmbrCnt;
                      self._verifiedprospectfound            := VerifiedProspectFound;
                      self._RaACrtRecFelonyMmbrCnt            := RaACrtRecFelonyMmbrCnt;
                      self._RaACrtRecEvictionMmbrCnt         := RaACrtRecEvictionMmbrCnt;
                      self._RaACrtRecLienJudgMmbrCnt         := RaACrtRecLienJudgMmbrCnt;



                    self.ca_raacrtrecevictionmmbrpct      := ca_raacrtrecevictionmmbrpct;
                    self.ca_raacrtrecfelonymmbrpct        := ca_raacrtrecfelonymmbrpct;
                    self.ca_raacrtreclienjudgmmbrpct      := ca_raacrtreclienjudgmmbrpct;
                    self.ca_raaderogindexpct              := ca_raaderogindexpct;
                    self.c_subscore0                      := c_subscore0;
                    self.c_subscore1                      := c_subscore1;
                    self.c_subscore2                      := c_subscore2;
                    self.c_subscore3                      := c_subscore3;
                    self.c_subscore4                      := c_subscore4;
                    self.c_subscore5                      := c_subscore5;
                    self.c_subscore6                      := c_subscore6;
                    self.c_subscore7                      := c_subscore7;
                    self.c_subscore8                      := c_subscore8;
                    self.c_subscore9                      := c_subscore9;
                    self.c_subscore10                     := c_subscore10;
                    self.c_subscore11                     := c_subscore11;
                    self.c_subscore12                     := c_subscore12;
                    self.c_rawscore                       := c_rawscore;
                    self.c_lnoddsscore                    := c_lnoddsscore;
                    self.c_probscore                      := c_probscore;
                    self.base                             := base;
                    self.odds                             := odds;
                    self.point                            := point;
                    self.pb1708_1_0                       := pb1708_1_0;

                //    SELF.cen                              := rt.cen;
                    SELF                                  := le;
                  //  self    := [];
                    
		#ELSE
      SELF.attributes.version1.score1	:= 	pb1708_1_0;

		#END
			SELF := le;
   
	END;
  
// OUTPUT (pb_attributes_in, NAMED('pb_attributes_in_code'));
// OUTPUT (batch_in_plus_census,NAMED('batch_in_plus_censusz'));
// OUTPUT (pb_batch_in,NAMED('pb_batch_in'));	

    // model := JOIN(pb_attributes_in, batch_in_plus_census, LEFT.seq=RIGHT.seq, doModel(LEFT, RIGHT)); 
    model := PROJECT(pb_attributes_in, doModel(LEFT)); 

		RETURN model;
 
END;

