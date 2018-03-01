IMPORT Models, Risk_Indicators, RiskWise, RiskView, UT, EASI, std;

//==============================
//=== MoneyLion Custom Model ===
//==============================

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

EXPORT FP1511_1_0 (DATASET(Risk_Indicators.Layout_Boca_Shell) clam,
                                   integer1 num_reasons = 6, 
																	 BOOLEAN isFCRA=FALSE) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
      Layout_Debug := RECORD
			/* Model Input Variables */
			STRING10 model_name;
			unsigned4 seq;
      BOOLEAN truedid;                   			
	    STRING in_dob;                			
	    BOOLEAN hphnpop;                   			
	    STRING phone_ver_experian;        			
	    INTEGER inq_communications_count;  			
	    unsigned2 inq_prepaidcards_count;
			unsigned2 inq_prepaidcards_count01;
			unsigned2 inq_prepaidcards_count03;
			unsigned2 inq_prepaidcards_count06;
			unsigned2 inq_prepaidcards_count12;
			unsigned2 inq_prepaidcards_count24;			
	    INTEGER inq_perphone;             			
	    STRING email_verification;      			
	    INTEGER attr_eviction_count;       			
  	  STRING vf_lexid_ssn_lo_risk_ct;   			
  	  STRING fp_idverrisktype;          			
      STRING fp_varrisktype;            			
  	  STRING fp_srchcomponentrisktype;  			
  	  INTEGER criminal_count;            			
	    INTEGER inferred_age;             			
	    STRING c_easiqlife;               			
	    STRING c_serv_empl;               			
	    REAL c_unemp;                   			
     /* Model Intermediate Variables */			
			INTEGER sysdate;
			INTEGER rv_d32_criminal_count;
			INTEGER rv_d33_eviction_count;
			INTEGER _in_dob;
			REAL yr_in_dob;
			REAL yr_in_dob_int;
			INTEGER rv_comb_age;
			INTEGER rv_i60_inq_prepaidcards_recency;
			STRING iv_f00_email_verification;
			STRING nf_phone_ver_experian;
			INTEGER nf_inq_communications_count;
			INTEGER nf_inq_per_phone;
			INTEGER nf_vf_lexid_ssn_lo_risk_ct;
			STRING nf_fp_idverrisktype;
			STRING nf_fp_varrisktype;
			STRING nf_fp_srchcomponentrisktype;
			REAL new_subscore0;
			REAL new_subscore1;
			REAL new_subscore2;
			REAL new_subscore3;
			REAL new_subscore4;
			REAL new_subscore5;
			REAL new_subscore6;
			REAL new_subscore7;
			REAL new_subscore8;
			REAL new_subscore9;
			REAL new_subscore10;
			REAL new_subscore11;
			REAL new_subscore12;
			REAL new_subscore13;
			REAL new_subscore14;
			REAL new_rawscore;
			REAL new_lnoddsscore;
			REAL new_probscore;
			INTEGER base;
			INTEGER pts;
			REAL odds;
			INTEGER fp1511_1_0;
	
/* some additional fields for debugging */
	    STRING12 geolink1;
			STRING12 geolink2;
			Models.Layout_ModelOut;
			Risk_Indicators.Layout_Boca_Shell clam;
		END;
		
//=============================================
//===  IF the MODEL_DEBUG = TRUE            ===
//===    transform using the debug layout   ===	
//=============================================	
		 layout_debug doModel( clam le, easi.Key_Easi_Census rt ) := TRANSFORM
		 
	#else
	
//=============================================
//===  ELSE                                 ===
//===    transform using the model layout   ===	
//=============================================			 
		 
		 models.layout_modelout doModel( clam le, easi.Key_Easi_Census rt ) := TRANSFORM
	#end
	
	
//============================================
//===   Model Input Variable assignments			
//============================================	
  truedid                          := le.truedid;
	in_dob                           := le.shell_input.dob;
	hphnpop                          := le.input_validation.homephone;
	phone_ver_experian               := le.Experian_Phone_Verification;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_prepaidcards_count           := le.acc_logs.prepaidcards.counttotal;
	inq_prepaidcards_count01         := le.acc_logs.prepaidcards.count01;
	inq_prepaidcards_count03         := le.acc_logs.prepaidcards.count03;
	inq_prepaidcards_count06         := le.acc_logs.prepaidcards.count06;
	inq_prepaidcards_count12         := le.acc_logs.prepaidcards.count12;
	inq_prepaidcards_count24         := le.acc_logs.prepaidcards.count24;
	inq_perphone                     := if(isFCRA, 0, le.acc_logs.inquiryPerPhone );
	email_verification               := le.email_summary.identity_email_verification_level;
	attr_eviction_count              := le.bjl.eviction_count;
  vf_lexid_ssn_lo_risk_ct          := le.virtual_fraud.lexid_ssn_lo_risk_ct;
	// vf_lexid_ssn_lo_risk_ct          := 0;
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
	criminal_count                   := le.bjl.criminal_count;
	inferred_age                     := le.inferred_age;
	
//=====================
//=== census data   ===
//=====================	
	c_easiqlife                      := (STRING)rt.easiqlife;
	c_serv_empl                      := rt.serv_empl;
	c_unemp                          := rt.unemp;

//=================================
//=== address information used  ===
//=== to build the GEOLINK      ===
//=== note this doesn't produce ===
//=== the same geolink as the   ===
//=== code to look up does      ===
//=================================

  geolink1         := le.shell_input.st + 
	                    le.shell_input.county + 
											le.shell_input.geo_blk;
											
	geolink2        := le.Address_Verification.Address_History_1.st +
	                   le.Address_Verification.Address_History_1.county +
										 le.Address_Verification.Address_History_1.geo_blk;  

//============================================
//===   Generated ECL code starts here		
//============================================
  NULL := -999999999;
//========================================================================================  
//===   for round 1 validation set the sysdate to the same value seen in the validation file
//       sysdate := common.sas_date('20150501');	 
//===   for round 2 validation set the sysdate to the archive date
//========================================================================================
  sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

  rv_d32_criminal_count := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));

  rv_d33_eviction_count := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));

  _in_dob := common.sas_date((string)(in_dob));

  yr_in_dob := if(_in_dob = NULL, -1, (sysdate - _in_dob) / 365.25);

  yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

  rv_comb_age := map(
      yr_in_dob_int > 0            => yr_in_dob_int,
      inferred_age > 0 and truedid => inferred_age,
                                      NULL);

  rv_i60_inq_prepaidcards_recency := map(
       not(truedid)             => NULL,
      (BOOLEAN)inq_PrepaidCards_count01 => 1,
      (BOOLEAN)inq_PrepaidCards_count03 => 3,
      (BOOLEAN)inq_PrepaidCards_count06 => 6,
      (BOOLEAN)inq_PrepaidCards_count12 => 12,
      (BOOLEAN)inq_PrepaidCards_count24 => 24,
      (BOOLEAN)inq_PrepaidCards_count   => 99,
                                           0);

  iv_f00_email_verification := if(not(truedid), '', trim(email_verification, LEFT));

  nf_phone_ver_experian := if(not(truedid), '', trim(phone_ver_experian, LEFT));

  nf_inq_communications_count := if(not(truedid), NULL, min(if(inq_Communications_count = NULL, -NULL, inq_Communications_count), 999));

  nf_inq_per_phone := if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999));

  
//	nf_vf_lexid_ssn_lo_risk_ct := if(not(truedid), NULL, min(if(vf_LexID_ssn_lo_risk_ct = NULL, -NULL, vf_LexID_ssn_lo_risk_ct), 999));
//===set this to zero ===
  nf_vf_lexid_ssn_lo_risk_ct := 0;

  nf_fp_idverrisktype := map(
      not(truedid)            => '',
      fp_idverrisktype = ''   => '',
                                 fp_idverrisktype);

  nf_fp_varrisktype := map(
      not(truedid)          => '',
      fp_varrisktype = ''   => '',
                             fp_varrisktype);

  nf_fp_srchcomponentrisktype := map(
      not(truedid)                    => '',
      fp_srchcomponentrisktype = ''   => '',
                                       fp_srchcomponentrisktype);

  new_subscore0 := map(
	    c_easiqlife = ''                                                 => 0,
      NULL < (real)c_easiqlife AND (real)c_easiqlife < 84              => 0.199311,
      84 <= (real)c_easiqlife AND (real)c_easiqlife < 111              => 0.035066,
      111 <= (real)c_easiqlife AND (real)c_easiqlife < 135             => -0.106373,
      135 <= (real)c_easiqlife                                         => -0.186578,
                                                                          0);

  new_subscore1 := map(
      (nf_phone_ver_experian in [' '])  => 0,
      (nf_phone_ver_experian in ['-1']) => 0,
      (nf_phone_ver_experian in ['0'])  => -0.223625,
      (nf_phone_ver_experian in ['1'])  => 0.095031,
                                           0);

  new_subscore2 := map(
      (nf_fp_srchcomponentrisktype in [' '])      => 0,
      (nf_fp_srchcomponentrisktype in ['1'])      => 0.097006,
      (nf_fp_srchcomponentrisktype in ['2', '3']) => -0.030358,
      (nf_fp_srchcomponentrisktype in ['4'])      => -0.033431,
      (nf_fp_srchcomponentrisktype in ['5', '6']) => -0.160741,
      (nf_fp_srchcomponentrisktype in ['7', '8']) => -0.267213,
      (nf_fp_srchcomponentrisktype in ['9'])      => -0.271789,
                                                     0);

  new_subscore3 := map(
      (nf_fp_varrisktype in [' '])           => 0,
      (nf_fp_varrisktype in ['-1'])          => 0,
      (nf_fp_varrisktype in ['1'])           => 0.092299,
      (nf_fp_varrisktype in ['2'])           => 0.015283,
      (nf_fp_varrisktype in ['3'])           => -0.003737,
      (nf_fp_varrisktype in ['4'])           => -0.16205,
      (nf_fp_varrisktype in ['5', '6'])      => -0.164056,
      (nf_fp_varrisktype in ['7', '8', '9']) => -0.455369,
                                                0);

  new_subscore4 := map(
      (nf_fp_idverrisktype in [' '])                          => 0,
      (nf_fp_idverrisktype in ['1'])                          => 0.076073,
      (nf_fp_idverrisktype in ['2'])                          => -0.168056,
      (nf_fp_idverrisktype in ['3', '4', '5', '6', '8', '9']) => -0.171993,
                                                                 0);

  new_subscore5 := map(
      NULL < nf_inq_communications_count AND nf_inq_communications_count < 1 => 0.056452,
      1 <= nf_inq_communications_count AND nf_inq_communications_count < 2   => -0.009898,
      2 <= nf_inq_communications_count AND nf_inq_communications_count < 3   => -0.080873,
      3 <= nf_inq_communications_count AND nf_inq_communications_count < 4   => -0.308192,
      4 <= nf_inq_communications_count AND nf_inq_communications_count < 6   => -0.310514,
      6 <= nf_inq_communications_count                                       => -0.311857,
                                                                              0);

  new_subscore6 := map(
	    c_serv_empl = ''                                              => 0,
      NULL < (integer)c_serv_empl AND (integer)c_serv_empl < 27     => -0.275241,
      27 <= (integer)c_serv_empl AND (integer)c_serv_empl < 86      => -0.042995,
      86 <= (integer)c_serv_empl                                    => 0.069726,
                                                                       0);

  new_subscore7 := map(
      NULL < rv_comb_age AND rv_comb_age < 29 => -0.123171,
      29 <= rv_comb_age AND rv_comb_age < 37  => -0.066091,
      37 <= rv_comb_age AND rv_comb_age < 41  => -0.041397,
      41 <= rv_comb_age AND rv_comb_age < 65  => 0.069305,
      65 <= rv_comb_age                       => -0.335491,
                                                 0);

  new_subscore8 := map(
      NULL < rv_d32_criminal_count AND rv_d32_criminal_count < 1 => 0.067645,
      1 <= rv_d32_criminal_count AND rv_d32_criminal_count < 2   => -0.047617,
      2 <= rv_d32_criminal_count AND rv_d32_criminal_count < 3   => -0.074525,
      3 <= rv_d32_criminal_count AND rv_d32_criminal_count < 10  => -0.091075,
      10 <= rv_d32_criminal_count                                => -0.335374,
                                                                   0);

  new_subscore9 := map(
      NULL < nf_inq_per_phone AND nf_inq_per_phone < 2 => 0.083421,
      2 <= nf_inq_per_phone AND nf_inq_per_phone < 4   => 0.052063,
      4 <= nf_inq_per_phone AND nf_inq_per_phone < 5   => -0.018665,
      5 <= nf_inq_per_phone AND nf_inq_per_phone < 10  => -0.11933,
      10 <= nf_inq_per_phone                           => -0.157943,
                                                          0);
 
  new_subscore10 := map(
	    c_unemp = ''                                      => 0,
      NULL < (REAL)c_unemp AND (REAL)c_unemp < 2.2      => 0.275924,
      2.2 <= (REAL)c_unemp AND (REAL)c_unemp < 3.7      => 0.001164,
      3.7 <= (REAL)c_unemp AND (REAL)c_unemp < 5.3      => -0.024729,
      5.3 <= (REAL)c_unemp AND (REAL)c_unemp < 8.9      => -0.030164,
      8.9 <= (REAL)c_unemp AND (REAL)c_unemp < 12.8     => -0.091736,
      12.8 <= (REAL)c_unemp                             => -0.183955,
                                                           0);

  new_subscore11 := map(
      NULL < rv_i60_inq_prepaidcards_recency AND rv_i60_inq_prepaidcards_recency < 1 => 0.029362,
      1 <= rv_i60_inq_prepaidcards_recency AND rv_i60_inq_prepaidcards_recency < 99  => -0.413185,
      99 <= rv_i60_inq_prepaidcards_recency                                          => -0.213072,
                                                                                      0);

  new_subscore12 := map(
      (iv_f00_email_verification in [' '])                => 0,
      (iv_f00_email_verification in ['0'])                => -0.127076,
      (iv_f00_email_verification in ['1', '2', '3', '4']) => -0.047355,
      (iv_f00_email_verification in ['5'])                => 0.073564,
                                                             0);
//===expecting the subscore13 to always be -0.02901
  new_subscore13 := map(
      NULL < nf_vf_lexid_ssn_lo_risk_ct AND nf_vf_lexid_ssn_lo_risk_ct < 1 => -0.02901,
      1 <= nf_vf_lexid_ssn_lo_risk_ct AND nf_vf_lexid_ssn_lo_risk_ct < 10  => 0.024119,
      10 <= nf_vf_lexid_ssn_lo_risk_ct                                     => 0.46613,
                                                                              0);

  new_subscore14 := map(
      NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 2 => 0.025963,
      2 <= rv_d33_eviction_count AND rv_d33_eviction_count < 4   => -0.126461,
      4 <= rv_d33_eviction_count                                 => -0.260959,
                                                                    0);

  new_rawscore := new_subscore0 +
      new_subscore1 +
      new_subscore2 +
      new_subscore3 +
      new_subscore4 +
      new_subscore5 +
      new_subscore6 +
      new_subscore7 +
      new_subscore8 +
      new_subscore9 +
      new_subscore10 +
      new_subscore11 +
      new_subscore12 +
      new_subscore13 +
      new_subscore14;

  new_lnoddsscore := new_rawscore + 1.478256;

  new_probscore := exp(new_lnoddsscore) / (1 + exp(new_lnoddsscore));

  base := 700;
  pts := 60;
  odds := (1 - 0.183) / 0.183;
  fp1511_1_0 := min(if(max(round(pts * (ln(new_probscore / (1 - new_probscore)) - ln(odds)) / ln(2) + base), 300) = NULL, -NULL, max(round(pts * (ln(new_probscore / (1 - new_probscore)) - ln(odds)) / ln(2) + base), 300)), 999);

//=========================================
//===     part of the TRANSFORM         ===
//=========================================

	#if(MODEL_DEBUG)
	
    self.sysdate                          := sysdate;
    self.rv_d32_criminal_count            := rv_d32_criminal_count;
    self.rv_d33_eviction_count            := rv_d33_eviction_count;
    self._in_dob                          := _in_dob;
    self.yr_in_dob                        := yr_in_dob;
    self.yr_in_dob_int                    := yr_in_dob_int;
    self.rv_comb_age                      := rv_comb_age;
    self.rv_i60_inq_prepaidcards_recency  := rv_i60_inq_prepaidcards_recency;
    self.iv_f00_email_verification        := iv_f00_email_verification;
    self.nf_phone_ver_experian            := nf_phone_ver_experian;
    self.nf_inq_communications_count      := nf_inq_communications_count;
    self.nf_inq_per_phone                 := nf_inq_per_phone;
    self.nf_vf_lexid_ssn_lo_risk_ct       := nf_vf_lexid_ssn_lo_risk_ct;
    self.nf_fp_idverrisktype              := nf_fp_idverrisktype;
    self.nf_fp_varrisktype                := nf_fp_varrisktype;
    self.nf_fp_srchcomponentrisktype      := nf_fp_srchcomponentrisktype;
    self.new_subscore0                    := new_subscore0;
    self.new_subscore1                    := new_subscore1;
    self.new_subscore2                    := new_subscore2;
    self.new_subscore3                    := new_subscore3;
    self.new_subscore4                    := new_subscore4;
    self.new_subscore5                    := new_subscore5;
    self.new_subscore6                    := new_subscore6;
    self.new_subscore7                    := new_subscore7;
    self.new_subscore8                    := new_subscore8;
    self.new_subscore9                    := new_subscore9;
    self.new_subscore10                   := new_subscore10;
    self.new_subscore11                   := new_subscore11;
    self.new_subscore12                   := new_subscore12;
    self.new_subscore13                   := new_subscore13;
    self.new_subscore14                   := new_subscore14;
    self.new_rawscore                     := new_rawscore;
    self.new_lnoddsscore                  := new_lnoddsscore;
    self.new_probscore                    := new_probscore;
    self.base                             := base;
    self.pts                              := pts;
    self.odds                             := odds;
    self.fp1511_1_0                       := fp1511_1_0;
		
		self.c_easiqlife                      := c_easiqlife;               			
	  self.c_serv_empl                      := c_serv_empl;               			
	  self.c_unemp                          := (REAL)c_unemp;   

    SELF.model_name := 'FP1511_1_0';
		SELF.geolink1   := geolink1;
		SELF.geolink2   := geolink2;
	  /* add the Boca Shell data to the end of the Model Results */
    SELF.clam := le;
#end
	
	  self.seq   :=  le.seq;
	  ritmp      :=  Models.fraudpoint3_reasons(le, blank_ip, num_reasons );
	  reasons    :=  Models.Common.checkFraudPoint3RC34(fp1511_1_0, ritmp, num_reasons);
	  self.ri    :=  reasons;
	  self.score := (string)fp1511_1_0;
	  self       := [];
	
//========================================
//===   End of the DoModel Transform  ===
//========================================	
END; 
 
//===========================================================================================
//=== to match the modeler's code for picking Census Data:                               ====
//===  search by 'input' address first and then by 'current' address (which is stored    ====
//===  Adress_Verification.Address_History_1                                             ====
//===========================================================================================
		
	model :=   join(clam, Easi.Key_Easi_Census,
		(left.shell_input.st<>'' and left.shell_input.county <>''	and left.shell_input.geo_blk <> '' and 
		 left.addrpop and 
		 keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk)) 
		 or
		(left.addrpop2 and ~left.addrpop and
		 left.Address_Verification.Address_History_1.st<>'' and left.Address_Verification.Address_History_1.county <>''	and left.Address_Verification.Address_History_1.geo_blk <> '' and 
		 keyed(right.geolink=left.Address_Verification.Address_History_1.st+left.Address_Verification.Address_History_1.county+left.Address_Verification.Address_History_1.geo_blk)), 
		doModel(left, right), left outer,
		atmost(RiskWise.max_atmost)
		,keep(1)
	);

	RETURN(model);
END;



