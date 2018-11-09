IMPORT ut, Std, RiskWise, Riskview, RiskWiseFCRA, Risk_Indicators;

EXPORT RVA1611_2_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, boolean isPrescreen) := FUNCTION

	// first run the clam through riskview attributes as this model was built from attributes
	attributes := RiskView.get_attributes_v5(clam, isPrescreen);
	
	MODEL_DEBUG := False;
	
	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Input Variables */
	 unsigned	seq;
	 integer4	sysdate;
	 String	subjectrecordtimeoldest;          
   String	lienjudgmentcount;                
   String	ssndeceased;                      
   String	confirmationsubjectfound;         
   String	addronfilecount;                  
   String	subjectabilityprimaryfactor;      
   String	criminalfelonycount;              
   String	criminalnonfelonycount;           
   String	evictioncount;                   
   String	lienjudgmentseverityindex;        
   String	bankruptcydismissed24month;       
   String	bankruptcystatus;                 
   String	addrinputownershipindex;          
   String	assetprop;                        
   String	inquiryauto12month;               
   String	inquirybanking12month;            
   String	inquirytelcom12month;             
   String	inquirycollections12month;        
   String	shorttermloanrequest12month;      
   String	inquiryshortterm12month;          
   String	shorttermloanrequest;             
   String	sourcenonderogcount03month;       
   String	sourcenonderogcount;              
   String	evictioncount12month;             
   String	criminalfelonycount12month;       
   String	criminalnonfelonycount12month;    
   String	lienjudgmentcount12month;         
   String	addrinputtaxvalue;                
   String	addrinputtaxmarketvalue;          
   String	addrinputavmvalue;                
   String	addrcurrentdwelltype;             
   String	addrcurrentcountyratio;           
   String	shorttermloanrequest24month;      
   String	addrinputdwelltype;               
   String	addrcurrenttaxmarketvalue;        
   Integer	inputtaxmarket;                   
   String	addrcurrenttaxvalue;              
   String	addrcurrentavmvalue;              
   Integer	inputavm;                         
   String	addrchangecount60month;           
   String	ssnsubjectcount;                  
   String	addrinputlengthofres;             
   String	assetpropcurrenttaxtotal;         
   String	educationevidence;                
   String	phoneinputsubjectcount;           
   String	lienjudgmentsmallclaimscount;     
   String	businessassociationtimeoldest;    
   String	addrprevioustimeoldest;           
   String	educationinstitutionrating;       
   String	addrcurrentownershipindex;        
   String	bankruptcycount;                  
   String	assetpersonalcount;               
   String	assetpropevercount;               
   String	addrinputtimeoldest;              
   String	subjectabilityindex;              
		string	 rv5_attr_unscoreable;
		string	 iv_subjectabilityprimaryfactor;
		Integer	 derog_flag;
		string	 ford_rv5_attr_seg;
		Integer	 inqcount;
		Integer	 m5_drg_inquiryindex;
		Integer	 m5_drg_derogseverityindex;
		Integer	 m5_drg_nonderogindex03month;
		Integer	 m5_drg_derogrecentseverityindex;
		Integer	 m5_own_inquiryindex;
		Integer	 m5_own_nonderogindex03month;
		Integer	 iv_inputpropvaluemax;
		Integer	 currenttaxmarket;
		Integer	 iv_inputcurrtaxmarketvaluesfdmax;
		Decimal6_2	 iv_currentcountyratiosfd;
		Integer	 inq_count;
		Integer	 m5_oth_inquiryindex;
		Integer	 m5_oth_nonderogindex03month;
		Integer	 currentavm;
		Integer	 iv_inputcurravmvaluesfdmax;
		Real	 all_drg_subscore0;
		Real	 all_drg_subscore1;
		Real	 all_drg_subscore2;
		Real	 all_drg_subscore3;
		Real	 all_drg_subscore4;
		Real	 all_drg_subscore5;
		Real	 all_drg_subscore6;
		Real	 all_drg_subscore7;
		Real	 all_drg_subscore8;
		Real	 all_drg_subscore9;
		Real	 all_drg_subscore10;
		Real	 all_drg_subscore11;
		Real	 all_drg_subscore12;
		Real	 all_drg_subscore13;
		Real	 all_drg_subscore14;
		Real	 all_drg_subscore15;
		Real	 all_drg_rawscore;
		Real	 all_drg_lnoddsscore;
		Real	 all_drg_probscore;
		Real	 all_own_subscore0;
		Real	 all_own_subscore1;
		Real	 all_own_subscore2;
		Real	 all_own_subscore3;
		Real	 all_own_subscore4;
		Real	 all_own_subscore5;
		Real	 all_own_subscore6;
		Real	 all_own_subscore7;
		Real	 all_own_subscore8;
		Real	 all_own_subscore9;
		Real	 all_own_subscore10;
		Real	 all_own_subscore11;
		Real	 all_own_subscore12;
		Real	 all_own_subscore13;
		Real	 all_own_subscore14;
		Real	 all_own_subscore15;
		Real	 all_own_subscore16;
		Real	 all_own_rawscore;
		Real	 all_own_lnoddsscore;
		Real	 all_own_probscore;
		Real	 all_oth_subscore0;
		Real	 all_oth_subscore1;
		Real	 all_oth_subscore2;
		Real	 all_oth_subscore3;
		Real	 all_oth_subscore4;
		Real	 all_oth_subscore5;
		Real	 all_oth_subscore6;
		Real	 all_oth_subscore7;
		Real	 all_oth_subscore8;
		Real	 all_oth_subscore9;
		Real	 all_oth_subscore10;
		Real	 all_oth_subscore11;
		Real	 all_oth_subscore12;
		Real	 all_oth_rawscore;
		Real	 all_oth_lnoddsscore;
		Real	 all_oth_probscore;
		Integer	 base;
		Integer	 pdo;
		Real	 odds;
		Integer	 rva1611_2_0;
		Real	 all_drg_dist_seg_0;
		String	 all_drg_aacd_0;
		Real	 all_drg_dist_0;
		String	 all_drg_aacd_1;
		Real	 all_drg_dist_1;
		String	 all_drg_aacd_2;
		Real	 all_drg_dist_2;
		String	 all_drg_aacd_3;
		Real	 all_drg_dist_3;
		String	 all_drg_aacd_4;
		Real	 all_drg_dist_4;
		String	 all_drg_aacd_5;
		Real	 all_drg_dist_5;
		String	 all_drg_aacd_6;
		Real	 all_drg_dist_6;
		String	 all_drg_aacd_7;
		Real	 all_drg_dist_7;
		String	 all_drg_aacd_8;
		Real	 all_drg_dist_8;
		String	 all_drg_aacd_9;
		Real	 all_drg_dist_9;
		String	 all_drg_aacd_10;
		Real	 all_drg_dist_10;
		String	 all_drg_aacd_11;
		Real	 all_drg_dist_11;
		String	 all_drg_aacd_12;
		Real	 all_drg_dist_12;
		String	 all_drg_aacd_13;
		Real	 all_drg_dist_13;
		String	 all_drg_aacd_14;
		Real	 all_drg_dist_14;
		String	 all_drg_aacd_15;
		Real	 all_drg_dist_15;
		Real	 all_drg_rcvaluep89;
		Real	 all_drg_rcvaluec21;
		Real	 all_drg_rcvaluel80;
		Real	 all_drg_rcvalued34;
		Real	 all_drg_rcvalued32;
		Real	 all_drg_rcvaluel77;
		Real	 all_drg_rcvalued30;
		Real	 all_drg_rcvalued31;
		Real	 all_drg_rcvaluea46;
		Real	 all_drg_rcvaluec13;
		Real	 all_drg_rcvaluei60;
		Real	 all_drg_rcvaluep85;
		Real	 all_drg_rcvalues66;
		Real	 all_drg_rcvaluec12;
		Real	 all_drg_rcvaluea47;
		Real	 all_drg_rcvalues65;
		Real	 all_drg_rcvaluee57;
		Real	 all_drg_rcvaluec14;
		String	 all_own_aacd_0;
		Real	 all_own_dist_0;
		String	 all_own_aacd_1;
		Real	 all_own_dist_1;
		String	 all_own_aacd_2;
		Real	 all_own_dist_2;
		String	 all_own_aacd_3;
		Real	 all_own_dist_3;
		String	 all_own_aacd_4;
		Real	 all_own_dist_4;
		String	 all_own_aacd_5;
		Real	 all_own_dist_5;
		String	 all_own_aacd_6;
		Real	 all_own_dist_6;
		String	 all_own_aacd_7;
		Real	 all_own_dist_7;
		String	 all_own_aacd_8;
		Real	 all_own_dist_8;
		String	 all_own_aacd_9;
		Real	 all_own_dist_9;
		String	 all_own_aacd_10;
		Real	 all_own_dist_10;
		String	 all_own_aacd_11;
		Real	 all_own_dist_11;
		String	 all_own_aacd_12;
		Real	 all_own_dist_12;
		String	 all_own_aacd_13;
		Real	 all_own_dist_13;
		String	 all_own_aacd_14;
		Real	 all_own_dist_14;
		String	 all_own_aacd_15;
		Real	 all_own_dist_15;
		String	 all_own_aacd_16;
		Real	 all_own_dist_16;
		Real	 all_own_rcvaluea42;
		Real	 all_own_rcvaluep89;
		Real	 all_own_rcvaluec21;
		Real	 all_own_rcvaluel80;
		Real	 all_own_rcvaluec13;
		Real	 all_own_rcvaluel77;
		Real	 all_own_rcvaluep85;
		Real	 all_own_rcvalued31;
		Real	 all_own_rcvaluea46;
		Real	 all_own_rcvaluea47;
		Real	 all_own_rcvaluea45;
		Real	 all_own_rcvaluei60;
		Real	 all_own_rcvaluei61;
		Real	 all_own_rcvalues66;
		Real	 all_own_rcvaluec12;
		Real	 all_own_rcvaluee57;
		Real	 all_own_rcvalues65;
		Real	 all_own_rcvaluec14;
		Real	 all_oth_dist_seg_0;
		string	 all_oth_aacd_0;
		Real	 all_oth_dist_0;
		string	 all_oth_aacd_1;
		Real	 all_oth_dist_1;
		string	 all_oth_aacd_2;
		Real	 all_oth_dist_2;
		string	 all_oth_aacd_3;
		Real	 all_oth_dist_3;
		string	 all_oth_aacd_4;
		Real	 all_oth_dist_4;
		string	 all_oth_aacd_5;
		Real	 all_oth_dist_5;
		string	 all_oth_aacd_6;
		Real	 all_oth_dist_6;
		string	 all_oth_aacd_7;
		Real	 all_oth_dist_7;
		string	 all_oth_aacd_8;
		Real	 all_oth_dist_8;
		string	 all_oth_aacd_9;
		Real	 all_oth_dist_9;
		string	 all_oth_aacd_10;
		Real	 all_oth_dist_10;
		string	 all_oth_aacd_11;
		Real	 all_oth_dist_11;
		string	 all_oth_aacd_12;
		Real	 all_oth_dist_12;
		Real	 all_oth_rcvaluec13;
		Real	 all_oth_rcvaluec21;
		Real	 all_oth_rcvaluep89;
		Real	 all_oth_rcvaluel81;
		Real	 all_oth_rcvaluel80;
		Real	 all_oth_rcvaluel77;
		Real	 all_oth_rcvaluep85;
		Real	 all_oth_rcvaluea47;
		Real	 all_oth_rcvaluea45;
		Real	 all_oth_rcvaluei60;
		Real	 all_oth_rcvaluei61;
		Real	 all_oth_rcvaluea41;
		Real	 all_oth_rcvalues66;
		Real	 all_oth_rcvaluec12;
		Real	 all_oth_rcvaluee57;
		Real	 all_oth_rcvalues65;
		Real	 all_oth_rcvaluec14;
		string	 all_oth_rc1;
		string	 all_oth_rc2;
		string	 all_oth_rc3;
		string	 all_oth_rc4;
		Real	 all_oth_vl1;
		Real	 all_oth_vl2;
		Real	 all_oth_vl3;
		Real	 all_oth_vl4;
		string	 all_own_rc1;
		string	 all_own_rc2;
		string	 all_own_rc3;
		string	 all_own_rc4;
		Real	 all_own_vl1;
		Real	 all_own_vl2;
		Real	 all_own_vl3;
		Real	 all_own_vl4;
		string	 all_drg_rc1;
		string	 all_drg_rc2;
		string	 all_drg_rc3;
		string	 all_drg_rc4;
		Real	 all_drg_vl1;
		Real	 all_drg_vl2;
		Real	 all_drg_vl3;
		Real	 all_drg_vl4;
		string	 _rc_inq;
		string	 rc1;
		string	 rc2;
		string	 rc3;
		string	 rc4;
		string	 rc5;


		Risk_Indicators.Layout_Boca_Shell clam;
	END;
			
		Layout_Debug doModel(attributes le, clam rt) := TRANSFORM
	#else
		Layout_ModelOut doModel(attributes le, clam rt) := TRANSFORM
	#end

	
	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	subjectrecordtimeoldest          := le.subjectrecordtimeoldest;
	lienjudgmentcount                := le.lienjudgmentcount;
	ssndeceased                      := le.ssndeceased;
	confirmationsubjectfound         := le.confirmationsubjectfound;
	addronfilecount                  := le.addronfilecount;
	subjectabilityprimaryfactor      := le.subjectabilityprimaryfactor;
	criminalfelonycount              := le.criminalfelonycount;
	criminalnonfelonycount           := le.criminalnonfelonycount;
	evictioncount                    := le.evictioncount;
	lienjudgmentseverityindex        := le.lienjudgmentseverityindex;
	bankruptcydismissed24month       := le.bankruptcydismissed24month;
	bankruptcystatus                 := le.bankruptcystatus;
	addrinputownershipindex          := le.addrinputownershipindex;
	assetprop                        := le.assetprop;
	inquiryauto12month               := le.inquiryauto12month;
	inquirybanking12month            := le.inquirybanking12month;
	inquirytelcom12month             := le.inquirytelcom12month;
	inquirycollections12month        := le.inquirycollections12month;
	shorttermloanrequest12month      := le.shorttermloanrequest12month;
	inquiryshortterm12month          := le.inquiryshortterm12month;
	shorttermloanrequest             := le.shorttermloanrequest;
	sourcenonderogcount03month       := le.sourcenonderogcount03month;
	sourcenonderogcount              := le.sourcenonderogcount;
	evictioncount12month             := le.evictioncount12month;
	criminalfelonycount12month       := le.criminalfelonycount12month;
	criminalnonfelonycount12month    := le.criminalnonfelonycount12month;
	lienjudgmentcount12month         := le.lienjudgmentcount12month;
	addrinputtaxvalue                := le.addrinputtaxvalue;
	addrinputtaxmarketvalue          := le.addrinputtaxmarketvalue;
	addrinputavmvalue                := le.addrinputavmvalue;
	addrcurrentdwelltype             := le.addrcurrentdwelltype;
	addrcurrentcountyratio           := le.addrcurrentcountyratio;
	shorttermloanrequest24month      := le.shorttermloanrequest24month;
	addrinputdwelltype               := le.addrinputdwelltype;
	addrcurrenttaxmarketvalue        := le.addrcurrenttaxmarketvalue;
	//inputtaxmarket                   := le.addrinputtaxmarketvalue;  // updated the field name
	addrcurrenttaxvalue              := le.addrcurrenttaxvalue;
	addrcurrentavmvalue              := le.addrcurrentavmvalue;
	//inputavm                         := le.AddrInputAVMValue;  // updated the field name
	addrchangecount60month           := le.addrchangecount60month;
	ssnsubjectcount                  := le.ssnsubjectcount;
	addrinputlengthofres             := le.addrinputlengthofres;
	assetpropcurrenttaxtotal         := le.assetpropcurrenttaxtotal;
	educationevidence                := le.educationevidence;
	phoneinputsubjectcount           := le.phoneinputsubjectcount;
	lienjudgmentsmallclaimscount     := le.lienjudgmentsmallclaimscount;
	businessassociationtimeoldest    := le.businessassociationtimeoldest;
	addrprevioustimeoldest           := le.addrprevioustimeoldest;
	educationinstitutionrating       := le.educationinstitutionrating;
	addrcurrentownershipindex        := le.addrcurrentownershipindex;
	bankruptcycount                  := le.bankruptcycount;
	assetpersonalcount               := le.assetpersonalcount;
	assetpropevercount               := le.assetpropevercount;
	addrinputtimeoldest              := le.addrinputtimeoldest;
	subjectabilityindex              := le.subjectabilityindex;
	// placeholder                      := le.placeholder;  // removed this because it is not used
	


	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

sysdate := models.common.sas_date(if(rt.historydate=999999, (STRING8)Std.Date.Today(), (string6)rt.historydate+'01'));

NULL := -999999999;

rv5_attr_unscoreable := map(
    subjectrecordtimeoldest = '' or lienjudgmentcount = ''                     => '0 MISSING',
    (integer)ssndeceased = 1                                                                => '1 SSN DEC',
    (integer)confirmationsubjectfound = 0 or (integer)addronfilecount = -1 or (integer)lienjudgmentcount = -1 => '2 UNSCORE',
                                                                                      '3 SCORE  ');

iv_subjectabilityprimaryfactor := map(
    (subjectabilityprimaryfactor in ['0', '-1'])    => '   ',
    (subjectabilityprimaryfactor in ['E55', 'E56']) => 'C12',
                                                       subjectabilityprimaryfactor);

derog_flag := if((integer)criminalfelonycount > 0 or (integer)criminalnonfelonycount > 0 or (integer)evictioncount > 0 or (integer)lienjudgmentseverityindex > 0 or (integer)bankruptcydismissed24month > 0 or (integer)bankruptcystatus > 1, 1, 0);

ford_rv5_attr_seg := map(
    subjectrecordtimeoldest = ''               => '       ',
    (integer)confirmationsubjectfound = 0                 => '0 NOSUB',
    derog_flag = 1                                   => '1 DEROG',
    (integer)addrinputownershipindex = 4 or (integer)assetprop > 0 => '2 OWNER',
                                                    '3 OTHER');

inqcount := if(max(inquiryauto12month, inquirybanking12month, inquirytelcom12month, inquirycollections12month) = '', NULL, sum(if(inquiryauto12month = '', 0, (Integer)inquiryauto12month), if(inquirybanking12month = '', 0, (Integer)inquirybanking12month), if(inquirytelcom12month = '', 0, (Integer)inquirytelcom12month), if(inquirycollections12month = '', 0, (Integer)inquirycollections12month)));

m5_drg_inquiryindex := map(
    (integer)shorttermloanrequest12month = 1 or (integer)inquiryshortterm12month = 1 and (integer)inquirycollections12month = 1 => 6,
    (integer)inquiryshortterm12month = 1 and inqcount > 0                                                     => 5,
    (integer)inquiryshortterm12month = 1                                                                      => 4,
    inqcount > 0                                                                                     => 3,
    (integer)shorttermloanrequest = 1                                                                         => 2,
                                                                                                        1);

m5_drg_derogseverityindex := map(
    (integer)evictioncount > 2 or (integer)evictioncount > 1 and (integer)criminalfelonycount > 0         => 7,
    (integer)criminalfelonycount > 1                                                    => 6,
    (integer)evictioncount > 1 or (integer)criminalfelonycount > 0 or (integer)criminalnonfelonycount > 2 => 5,
    (integer)evictioncount > 0                                                          => 4,
    (integer)criminalnonfelonycount > 0 and (integer)lienjudgmentcount > 0                       => 3,
    (integer)bankruptcystatus = 2                                                       => 2,
                                                                                  1);

m5_drg_nonderogindex03month := map(
    (integer)sourcenonderogcount03month > 3 and (integer)sourcenonderogcount > 4                                   => 6,
    (integer)sourcenonderogcount03month > 2 and (integer)sourcenonderogcount > 4 or (integer)sourcenonderogcount03month > 3 => 5,
    (integer)sourcenonderogcount03month > 2                                                               => 4,
    (integer)sourcenonderogcount03month > 1                                                               => 3,
    (integer)sourcenonderogcount > 1                                                                      => 2,
                                                                                                    1);

m5_drg_derogrecentseverityindex := map(
    (integer)evictioncount12month > 2 or (integer)criminalfelonycount12month > 0 => 7,
    (integer)evictioncount12month > 0                                   => 6,
    (integer)criminalnonfelonycount12month > 1                          => 5,
    (integer)bankruptcydismissed24month > 0                             => 4,
    (integer)lienjudgmentcount12month > 0                               => 3,
    (integer)criminalnonfelonycount12month > 0                          => 2,
                                                                  1);

iv_inputpropvaluemax_1 := max((Integer)addrinputtaxvalue, (Integer)addrinputtaxmarketvalue, (Integer)addrinputavmvalue);

iv_currentcountyratiosfd_1 := if(not((addrcurrentdwelltype in ['S'])), -9999, (Real)addrcurrentcountyratio);

inq_count_1 := if(max(inquiryauto12month, inquirybanking12month, inquirytelcom12month) = '', NULL, sum(if(inquiryauto12month = '', 0, (Integer)inquiryauto12month), if(inquirybanking12month = '', 0, (Integer)inquirybanking12month), if(inquirytelcom12month = '', 0, (Integer)inquirytelcom12month)));

m5_own_inquiryindex := map(
    (integer)inquiryshortterm12month = 1 or (integer)shorttermloanrequest24month = 1 => 6,
    inq_count_1 > 1                                                => 5,
    inq_count_1 > 0                                                => 4,
    (integer)inquirycollections12month = 1                                  => 3,
    (integer)shorttermloanrequest = 1                                       => 2,
                                                                      1);

m5_own_nonderogindex03month := map(
    (integer)sourcenonderogcount03month > 3 or (integer)sourcenonderogcount03month = 3 and (integer)sourcenonderogcount = 6 => 5,
    (integer)sourcenonderogcount03month = 3 and (integer)sourcenonderogcount = 5                                   => 4,
    (integer)sourcenonderogcount03month = 3                                                               => 3,
    (integer)sourcenonderogcount03month = 2                                                               => 2,
                                                                                                    1);

iv_inputpropvaluemax := max((Integer)addrinputtaxvalue, (Integer)addrinputtaxmarketvalue, (Integer)addrinputavmvalue);

currenttaxmarket := map(
    (addrcurrentdwelltype in ['-1']) or (addrcurrenttaxmarketvalue in ['-1']) => -1,
    not((addrcurrentdwelltype in ['S']))                                      => -9999,
																												(Integer)addrcurrenttaxmarketvalue);
     
inputtaxmarket := map(
		(addrinputdwelltype in ['-1']) or (addrinputtaxmarketvalue in ['-1'])  => -1,                                                                                                                                                                                                                                                                                                                                                                                                                     
   not(( addrinputdwelltype in ['S']))                             => -9999,                                                                                                                                                                                                                                                                                                                                                                                                                  
                                                                   (Integer)addrinputtaxmarketvalue);                                                                                 

iv_inputcurrtaxmarketvaluesfdmax := max((integer)inputtaxmarket, currenttaxmarket);
//iv_inputcurrtaxmarketvaluesfdmax := if (max((integer)inputtaxmarket, currenttaxmarket)= 0, -9999, max((integer)inputtaxmarket, currenttaxmarket));

iv_currentcountyratiosfd := if(not((addrcurrentdwelltype in ['S'])), -9999, (Real)addrcurrentcountyratio);

inq_count := if(max(inquiryauto12month, inquirybanking12month, inquirytelcom12month) = '', NULL, sum(if(inquiryauto12month = '', 0, (Integer)inquiryauto12month), if(inquirybanking12month = '', 0, (Integer)inquirybanking12month), if(inquirytelcom12month = '', 0, (Integer)inquirytelcom12month)));

m5_oth_inquiryindex := map(
    (integer)inquiryshortterm12month = 1 or (integer)shorttermloanrequest24month = 1 => 6,
    inq_count > 1                                                  => 5,
    inq_count > 0                                                  => 4,
    (integer)inquirycollections12month = 1                                  => 3,
    (integer)shorttermloanrequest = 1                                       => 2,
                                                                      1);

m5_oth_nonderogindex03month := map(
    (integer)sourcenonderogcount03month > 3 or (integer)sourcenonderogcount03month > 2 and (integer)sourcenonderogcount > 3 => 6,
    (integer)sourcenonderogcount03month = 3 or (integer)sourcenonderogcount03month > 1 and (integer)sourcenonderogcount > 3 => 5,
    (integer)sourcenonderogcount03month = 2 and (integer)sourcenonderogcount = 3                                   => 4,
    (integer)sourcenonderogcount03month = 2 or (integer)sourcenonderogcount > 2                                    => 3,
    (integer)sourcenonderogcount = 2                                                                      => 2,
                                                                                                    1);
  inputavm := map(
	(addrinputdwelltype in ['-1']) or (addrinputavmvalue in ['-1']) => -1,                                                                                                                                                                                                                                                                                                                                                                                                                                 
   not ((addrinputdwelltype in ['S']))                       => -9999,                                                                                                                                                                                                                                                                                                                                                                                                                              
                                                              (integer)addrinputavmvalue);                                                                                                                                                                                                                                                                                                                                                                                                                  
           
currentavm := map(
    (addrcurrentdwelltype in ['-1']) or (addrcurrenttaxvalue in ['-1']) => -1,
    not((addrcurrentdwelltype in ['S']))                                => -9999,
                                                                           (Integer)addrcurrentavmvalue);

iv_inputcurravmvaluesfdmax := max((integer)inputavm, currentavm);

all_drg_subscore0 := map(
    (m5_drg_inquiryindex in [1]) => 0.297745,
    (m5_drg_inquiryindex in [2]) => 0.009645,
    (m5_drg_inquiryindex in [3]) => -0.278712,
    (m5_drg_inquiryindex in [4]) => -0.525071,
    (m5_drg_inquiryindex in [5]) => -0.960993,
    (m5_drg_inquiryindex in [6]) => -1.065674,
                                    0);

all_drg_subscore1 := map(
    '' < addrchangecount60month AND (integer)addrchangecount60month < 1 => 0.202831,
    1 <= (integer)addrchangecount60month AND (integer)addrchangecount60month < 2   => 0.091418,
    2 <= (integer)addrchangecount60month AND (integer)addrchangecount60month < 3   => -0.07119,
    3 <= (integer)addrchangecount60month AND (integer)addrchangecount60month < 4   => -0.174771,
    4 <= (integer)addrchangecount60month AND (integer)addrchangecount60month < 5   => -0.287268,
    5 <= (integer)addrchangecount60month AND (integer)addrchangecount60month < 6   => -0.315242,
    6 <= (integer)addrchangecount60month                                  => -0.423701,
                                                                    0);

all_drg_subscore2 := map(
    '' < ssnsubjectcount AND (integer)ssnsubjectcount < 0 => 0,
    0 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 1   => -0.824738,
    1 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 2   => 0.045437,
    2 <= (integer)ssnsubjectcount                           => -0.0594,
                                                      0);

all_drg_subscore3 := map(
    (m5_drg_derogseverityindex in [1]) => 0.107487,
    (m5_drg_derogseverityindex in [2]) => 0.018032,
    (m5_drg_derogseverityindex in [3]) => -0.096847,
    (m5_drg_derogseverityindex in [4]) => -0.165029,
    (m5_drg_derogseverityindex in [5]) => -0.196758,
    (m5_drg_derogseverityindex in [6]) => -0.41414,
    (m5_drg_derogseverityindex in [7]) => -0.500484,
                                          0);

all_drg_subscore4 := map(
    (m5_drg_nonderogindex03month in [1]) => -0.244745,
    (m5_drg_nonderogindex03month in [2]) => -0.026702,
    (m5_drg_nonderogindex03month in [3]) => 0.133542,
    (m5_drg_nonderogindex03month in [4]) => 0.359511,
    (m5_drg_nonderogindex03month in [5]) => 0.72659,
    (m5_drg_nonderogindex03month in [6]) => 1.076029,
                                            0);

all_drg_subscore5 := map(
    (m5_drg_derogrecentseverityindex in [1])    => 0.08405,
    (m5_drg_derogrecentseverityindex in [2, 3]) => -0.215455,
    (m5_drg_derogrecentseverityindex in [4])    => -0.2638,
    (m5_drg_derogrecentseverityindex in [5, 6]) => -0.353284,
    (m5_drg_derogrecentseverityindex in [7])    => -0.710803,
                                                   0);

all_drg_subscore6 := map(
    '' < addrinputlengthofres AND (integer)addrinputlengthofres < 1   => -0.244286,
    1 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 5     => -0.138271,
    5 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 147   => 0.044398,
    147 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 217 => 0.157117,
    217 <= (integer)addrinputlengthofres                                => 0.270415,
                                                                  0);

all_drg_subscore7 := map(
    '' < assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 0         => -0.070496,
    0 <= (integer)assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 1           => 0.142728,
    1 <= (integer)assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 13538       => -0.179401,
    13538 <= (integer)assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 22790   => 0.020639,
    22790 <= (integer)assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 194000  => 0.138306,
    194000 <= (integer)assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 237650 => 0.193018,
    237650 <= (integer)assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 551900 => 0.271543,
    551900 <= (integer)assetpropcurrenttaxtotal                                       => 0.420472,
                                                                                0);

all_drg_subscore8 := map(
    (bankruptcystatus in ['1'])       => 0.289004,
    (bankruptcystatus in ['-1', '0']) => -0.031299,
    (bankruptcystatus in ['2'])       => -0.242352,
                                         0);

all_drg_subscore9 := map(
    NULL < iv_inputpropvaluemax AND iv_inputpropvaluemax < 1         => -0.059228,
    1 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 70080       => -0.100104,
    70080 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 100206  => -0.015412,
    100206 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 131695 => -0.001319,
    131695 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 157364 => 0.092145,
    157364 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 201608 => 0.137406,
    201608 <= iv_inputpropvaluemax                                   => 0.213628,
                                                                        0);

all_drg_subscore10 := map(
    '' < educationevidence AND (integer)educationevidence < 1 => -0.027163,
    1 <= (integer)educationevidence                             => 0.219258,
                                                          0);

all_drg_subscore11 := map(
    NULL < iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0     => -0.027152,
    0 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.01    => 0.036305,
    0.01 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.66 => -0.127329,
    0.66 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.85 => -0.061724,
    0.85 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 1.31 => -0.001446,
    1.31 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 1.94 => 0.052024,
    1.94 <= iv_currentcountyratiosfd                                     => 0.209557,
                                                                            0);

all_drg_subscore12 := map(
    '' < phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 0 => -0.038433,
    0 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 1   => -0.026042,
    1 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 2   => 0.127223,
    2 <= (integer)phoneinputsubjectcount                                  => 0.333191,
                                                                    0);

all_drg_subscore13 := map(
    '' < criminalnonfelonycount AND (integer)criminalnonfelonycount < 1 => 0.015225,
    1 <= (integer)criminalnonfelonycount AND (integer)criminalnonfelonycount < 2   => -0.069479,
    2 <= (integer)criminalnonfelonycount AND (integer)criminalnonfelonycount < 3   => -0.155381,
    3 <= (integer)criminalnonfelonycount                                  => -0.192545,
                                                                    0);

all_drg_subscore14 := map(
    '' < lienjudgmentsmallclaimscount AND (integer)lienjudgmentsmallclaimscount < 1 => 0.015473,
    1 <= (integer)lienjudgmentsmallclaimscount                                        => -0.065734,
                                                                                0);

all_drg_subscore15 := map(
    '' < businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 1 => -0.009221,
    1 <= (integer)businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 82  => 0.028897,
    82 <= (integer)businessassociationtimeoldest                                        => 0.124713,
                                                                                  0);

all_drg_rawscore := all_drg_subscore0 +
    all_drg_subscore1 +
    all_drg_subscore2 +
    all_drg_subscore3 +
    all_drg_subscore4 +
    all_drg_subscore5 +
    all_drg_subscore6 +
    all_drg_subscore7 +
    all_drg_subscore8 +
    all_drg_subscore9 +
    all_drg_subscore10 +
    all_drg_subscore11 +
    all_drg_subscore12 +
    all_drg_subscore13 +
    all_drg_subscore14 +
    all_drg_subscore15;

all_drg_lnoddsscore := all_drg_rawscore + 2.369233;

all_drg_probscore := exp(all_drg_lnoddsscore) / (1 + exp(all_drg_lnoddsscore));

all_own_subscore0 := map(
    (m5_own_inquiryindex in [1]) => 0.24842,
    (m5_own_inquiryindex in [2]) => 0.05305,
    (m5_own_inquiryindex in [3]) => -0.517957,
    (m5_own_inquiryindex in [4]) => -0.866494,
    (m5_own_inquiryindex in [5]) => -1.113493,
    (m5_own_inquiryindex in [6]) => -1.229565,
                                    0);

all_own_subscore1 := map(
    '' < ssnsubjectcount AND (integer)ssnsubjectcount < 0 => 0,
    0 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 1   => -1.296923,
    1 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 2   => 0.104897,
    2 <= (integer)ssnsubjectcount                           => -0.107592,
                                                      0);

all_own_subscore2 := map(
    NULL < iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < -1        => -0.116908,
    -1 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 0          => 0.118978,
    0 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 1           => 0.073563,
    1 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 44471       => -0.543453,
    44471 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 67857   => -0.436461,
    67857 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 97576   => -0.24897,
    97576 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 123630  => -0.081339,
    123630 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 148400 => 0.049704,
    148400 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 196830 => 0.142971,
    196830 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 310272 => 0.356854,
    310272 <= iv_inputcurrtaxmarketvaluesfdmax                                               => 0.432753,
                                                                                                0);

all_own_subscore3 := map(
    (m5_own_nonderogindex03month in [1]) => -0.204325,
    (m5_own_nonderogindex03month in [2]) => 0.093787,
    (m5_own_nonderogindex03month in [3]) => 0.373054,
    (m5_own_nonderogindex03month in [4]) => 0.570828,
    (m5_own_nonderogindex03month in [5]) => 0.717521,
                                            0);

all_own_subscore4 := map(
    '' < phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 0 => -0.287664,
    0 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 1   => -0.115123,
    1 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 2   => 0.204167,
    2 <= (integer)phoneinputsubjectcount                                  => 0.655686,
                                                                    0);

all_own_subscore5 := map(
    NULL < iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0     => -0.084461,
    0 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.01    => 0.141582,
    0.01 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.54 => -0.367887,
    0.54 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.68 => -0.269004,
    0.68 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.91 => -0.172406,
    0.91 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 1.14 => -0.144287,
    1.14 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 1.61 => 0.049502,
    1.61 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 1.9  => 0.16017,
    1.9 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 2.92  => 0.236845,
    2.92 <= iv_currentcountyratiosfd                                     => 0.337754,
                                                                            0);

all_own_subscore6 := map(
    '' < addronfilecount AND (integer)addronfilecount < 3 => 0.195553,
    3 <= (integer)addronfilecount AND (integer)addronfilecount < 4   => 0.116653,
    4 <= (integer)addronfilecount AND (integer)addronfilecount < 5   => -0.027793,
    5 <= (integer)addronfilecount AND (integer)addronfilecount < 6   => -0.075601,
    6 <= (integer)addronfilecount AND (integer)addronfilecount < 7   => -0.106008,
    7 <= (integer)addronfilecount AND (integer)addronfilecount < 9   => -0.214295,
    9 <= (integer)addronfilecount AND (integer)addronfilecount < 10  => -0.244755,
    10 <= (integer)addronfilecount                          => -0.26696,
                                                      0);

all_own_subscore7 := map(
    '' < addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 1   => -0.125566,
    1 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 13    => -0.365847,
    13 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 22   => -0.196123,
    22 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 37   => -0.138906,
    37 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 66   => -0.091953,
    66 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 111  => -0.06018,
    111 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 203 => 0.051602,
    203 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 245 => 0.145931,
    245 <= (integer)addrprevioustimeoldest                                  => 0.190884,
                                                                      0);

all_own_subscore8 := map(
    NULL < iv_inputpropvaluemax AND iv_inputpropvaluemax < 0         => 0.076357,
    0 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 1           => -0.056785,
    1 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 55950       => -0.217501,
    55950 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 83612   => -0.127626,
    83612 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 114805  => -0.06339,
    114805 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 143990 => 0.026566,
    143990 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 172365 => 0.064135,
    172365 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 488812 => 0.148609,
    488812 <= iv_inputpropvaluemax                                   => 0.180965,
                                                                        0);

all_own_subscore9 := map(
    (educationinstitutionrating in ['0'])           => -0.036893,
    (educationinstitutionrating in ['1', '2'])      => 0.861946,
    (educationinstitutionrating in ['3'])           => 0.648962,
    (educationinstitutionrating in ['4', '5', '6']) => 0.260986,
                                                       0);

all_own_subscore10 := map(
    (addrcurrentownershipindex in ['0'])           => -0.170214,
    (addrcurrentownershipindex in ['1', '2', '3']) => -0.182255,
    (addrcurrentownershipindex in ['4'])           => 0.065715,
                                                      0);

all_own_subscore11 := map(
    '' < businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 1  => -0.033894,
    1 <= (integer)businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 34   => 0.047308,
    34 <= (integer)businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 86  => 0.10391,
    86 <= (integer)businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 103 => 0.278679,
    103 <= (integer)businessassociationtimeoldest                                        => 0.461587,
                                                                                   0);

all_own_subscore12 := map(
    '' < bankruptcycount AND (integer)bankruptcycount < 1 => 0.028475,
    1 <= (integer)bankruptcycount                           => -0.336549,
                                                      0);

all_own_subscore13 := map(
    '' < assetpersonalcount AND (integer)assetpersonalcount < 1 => -0.027965,
    1 <= (integer)assetpersonalcount AND (integer)assetpersonalcount < 2   => 0.267319,
    2 <= (integer)assetpersonalcount AND (integer)assetpersonalcount < 3   => 0.428098,
    3 <= (integer)assetpersonalcount                              => 0.516604,
                                                            0);

all_own_subscore14 := map(
    '' < addrinputtaxvalue AND (integer)addrinputtaxvalue < 0         => 0,
    0 <= (integer)addrinputtaxvalue AND (integer)addrinputtaxvalue < 1           => -0.07636,
    1 <= (integer)addrinputtaxvalue AND (integer)addrinputtaxvalue < 111066      => -0.003761,
    111066 <= (integer)addrinputtaxvalue AND (integer)addrinputtaxvalue < 161040 => 0.015217,
    161040 <= (integer)addrinputtaxvalue AND (integer)addrinputtaxvalue < 211500 => 0.10555,
    211500 <= (integer)addrinputtaxvalue AND (integer)addrinputtaxvalue < 358948 => 0.184202,
    358948 <= (integer)addrinputtaxvalue                                => 0.286805,
                                                                  0);

all_own_subscore15 := map(
    '' < assetpropevercount AND (integer)assetpropevercount < 1 => -0.221243,
    1 <= (integer)assetpropevercount AND (integer)assetpropevercount < 2   => -0.047532,
    2 <= (integer)assetpropevercount AND (integer)assetpropevercount < 3   => 0.04646,
    3 <= (integer)assetpropevercount AND (integer)assetpropevercount < 4   => 0.181757,
    4 <= (integer)assetpropevercount AND (integer)assetpropevercount < 5   => 0.196957,
    5 <= (integer)assetpropevercount                              => 0.238223,
                                                            0);

all_own_subscore16 := map(
    '' < addrinputtimeoldest AND (integer)addrinputtimeoldest < 1 => -0.162213,
    1 <= (integer)addrinputtimeoldest AND (integer)addrinputtimeoldest < 216 => -0.01691,
    216 <= (integer)addrinputtimeoldest                             => 0.131994,
                                                              0);

all_own_rawscore := all_own_subscore0 +
    all_own_subscore1 +
    all_own_subscore2 +
    all_own_subscore3 +
    all_own_subscore4 +
    all_own_subscore5 +
    all_own_subscore6 +
    all_own_subscore7 +
    all_own_subscore8 +
    all_own_subscore9 +
    all_own_subscore10 +
    all_own_subscore11 +
    all_own_subscore12 +
    all_own_subscore13 +
    all_own_subscore14 +
    all_own_subscore15 +
    all_own_subscore16;

all_own_lnoddsscore := all_own_rawscore + 3.894200;

all_own_probscore := exp(all_own_lnoddsscore) / (1 + exp(all_own_lnoddsscore));

all_oth_subscore0 := map(
    (m5_oth_inquiryindex in [1]) => 0.351463,
    (m5_oth_inquiryindex in [2]) => -0.057541,
    (m5_oth_inquiryindex in [3]) => -0.411904,
    (m5_oth_inquiryindex in [4]) => -0.56375,
    (m5_oth_inquiryindex in [5]) => -0.950198,
    (m5_oth_inquiryindex in [6]) => -1.154296,
                                    0);

all_oth_subscore1 := map(
    '' < ssnsubjectcount AND (integer)ssnsubjectcount < 0 => 0,
    0 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 1   => -0.957985,
    1 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 2   => 0.056289,
    2 <= (integer)ssnsubjectcount                           => -0.149344,
                                                      0);

all_oth_subscore2 := map(
    (m5_oth_nonderogindex03month in [1]) => -0.180397,
    (m5_oth_nonderogindex03month in [2]) => -0.091153,
    (m5_oth_nonderogindex03month in [3]) => 0.120966,
    (m5_oth_nonderogindex03month in [4]) => 0.295682,
    (m5_oth_nonderogindex03month in [5]) => 0.546089,
    (m5_oth_nonderogindex03month in [6]) => 1.016289,
                                            0);

all_oth_subscore3 := map(
    NULL < iv_inputcurravmvaluesfdmax AND iv_inputcurravmvaluesfdmax < -1        => -0.011023,
    -1 <= iv_inputcurravmvaluesfdmax AND iv_inputcurravmvaluesfdmax < 1          => 0.012214,
    1 <= iv_inputcurravmvaluesfdmax AND iv_inputcurravmvaluesfdmax < 70114       => -0.357209,
    70114 <= iv_inputcurravmvaluesfdmax AND iv_inputcurravmvaluesfdmax < 108849  => -0.097139,
    108849 <= iv_inputcurravmvaluesfdmax AND iv_inputcurravmvaluesfdmax < 203545 => 0.078286,
    203545 <= iv_inputcurravmvaluesfdmax AND iv_inputcurravmvaluesfdmax < 478693 => 0.147423,
    478693 <= iv_inputcurravmvaluesfdmax                                         => 0.3807,
                                                                                    0);

all_oth_subscore4 := map(
    '' < addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 1   => 0.118601,
    1 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 13    => -0.217034,
    13 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 26   => -0.162585,
    26 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 40   => -0.016843,
    40 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 60   => 0.006283,
    60 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 78   => 0.012885,
    78 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 109  => 0.055015,
    109 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 161 => 0.072744,
    161 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 224 => 0.104306,
    224 <= (integer)addrprevioustimeoldest                                  => 0.176627,
                                                                      0);

all_oth_subscore5 := map(
    '' < addrinputlengthofres AND (integer)addrinputlengthofres < 1   => -0.219422,
    1 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 7     => 0.022607,
    7 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 105   => 0.04794,
    105 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 241 => 0.069505,
    241 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 384 => 0.269924,
    384 <= (integer)addrinputlengthofres                                => 0.498038,
                                                                  0);

all_oth_subscore6 := map(
    (educationinstitutionrating in ['0'])           => -0.034471,
    (educationinstitutionrating in ['1'])           => 1.047738,
    (educationinstitutionrating in ['2'])           => 0.832486,
    (educationinstitutionrating in ['3'])           => 0.413686,
    (educationinstitutionrating in ['4', '5', '6']) => 0.118403,
                                                       0);

all_oth_subscore7 := map(
    '' < subjectabilityindex AND (integer)subjectabilityindex < 1 => -0.282745,
    1 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 2   => -0.060931,
    2 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 3   => -0.035078,
    3 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 4   => 0.044278,
    4 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 5   => 0.092979,
    5 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 6   => 0.157298,
    6 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 7   => 0.253927,
    7 <= (integer)subjectabilityindex                               => 0.443788,
                                                              0);

all_oth_subscore8 := map(
    '' < phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 0 => -0.021668,
    0 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 1   => -0.032898,
    1 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 2   => 0.116586,
    2 <= (integer)phoneinputsubjectcount                                  => 0.601222,
                                                                    0);

all_oth_subscore9 := map(
    '' < addronfilecount AND (integer)addronfilecount < 2 => 0.117642,
    2 <= (integer)addronfilecount AND (integer)addronfilecount < 3   => 0.094913,
    3 <= (integer)addronfilecount AND (integer)addronfilecount < 5   => 0.011324,
    5 <= (integer)addronfilecount AND (integer)addronfilecount < 6   => -0.055582,
    6 <= (integer)addronfilecount AND (integer)addronfilecount < 8   => -0.094394,
    8 <= (integer)addronfilecount AND (integer)addronfilecount < 10  => -0.130252,
    10 <= (integer)addronfilecount                          => -0.19044,
                                                      0);

all_oth_subscore10 := map(
    (addrinputownershipindex in ['-1']) => 0,
    (addrinputownershipindex in ['0'])  => -0.03748,
    (addrinputownershipindex in ['1'])  => -0.076516,
    (addrinputownershipindex in ['2'])  => 0.008309,
    (addrinputownershipindex in ['3'])  => 0.170182,
                                           0);

all_oth_subscore11 := map(
    '' < businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 1 => -0.017971,
    1 <= (integer)businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 102 => 0.216728,
    102 <= (integer)businessassociationtimeoldest                                       => 0.382327,
                                                                                  0);

all_oth_subscore12 := map(
    '' < assetpropevercount AND (integer)assetpropevercount < 1 => -0.010114,
    1 <= (integer)assetpropevercount AND (integer)assetpropevercount < 2   => 0.092563,
    2 <= (integer)assetpropevercount AND (integer)assetpropevercount < 3   => 0.184801,
    3 <= (integer)assetpropevercount                              => 0.310022,
                                                            0);

all_oth_rawscore := all_oth_subscore0 +
    all_oth_subscore1 +
    all_oth_subscore2 +
    all_oth_subscore3 +
    all_oth_subscore4 +
    all_oth_subscore5 +
    all_oth_subscore6 +
    all_oth_subscore7 +
    all_oth_subscore8 +
    all_oth_subscore9 +
    all_oth_subscore10 +
    all_oth_subscore11 +
    all_oth_subscore12;

all_oth_lnoddsscore := all_oth_rawscore + 2.854845;

all_oth_probscore := exp(all_oth_lnoddsscore) / (1 + exp(all_oth_lnoddsscore));

base := 700;

pdo := 40;

odds := (1 - 0.019) / 0.019;

rva1611_2_0 := map(
    (rv5_attr_unscoreable in ['1 SSN DEC']) => 200,
    (rv5_attr_unscoreable in ['2 UNSCORE']) => 222,
    (ford_rv5_attr_seg in ['1 DEROG'])      => max(min(if(round(pdo * (ln(all_drg_probscore / (1 - all_drg_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(pdo * (ln(all_drg_probscore / (1 - all_drg_probscore)) - ln(odds)) / ln(2) + base)), 900), 501),
    (ford_rv5_attr_seg in ['2 OWNER'])      => max(min(if(round(pdo * (ln(all_own_probscore / (1 - all_own_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(pdo * (ln(all_own_probscore / (1 - all_own_probscore)) - ln(odds)) / ln(2) + base)), 900), 501),
																							 max(min(if(round(pdo * (ln(all_oth_probscore / (1 - all_oth_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(pdo * (ln(all_oth_probscore / (1 - all_oth_probscore)) - ln(odds)) / ln(2) + base)), 900), 501));																							
		 
all_drg_AACD_SEG_0 := if(Ford_RV5_Attr_seg in ['1 DEROG'],'D30','');
     all_drg_DIST_SEG_0 := 2.6080769 - 4.3936108; 

all_drg_aacd_0 := map(
    (m5_drg_inquiryindex in [1])                                     => 'I60',
    (m5_drg_inquiryindex in [2])                                     => 'C21',
    (m5_drg_inquiryindex in [3]) and (integer)inquirycollections12month = 1   => 'I61',
    (m5_drg_inquiryindex in [3])                                     => 'I60',
    (m5_drg_inquiryindex in [4])                                     => 'I60',
    (m5_drg_inquiryindex in [5])                                     => 'I60',
    (m5_drg_inquiryindex in [6]) and (integer)shorttermloanrequest12month = 1 => 'C21',
    (m5_drg_inquiryindex in [6])                                     => 'I61',
                                                                        '');

all_drg_dist_0 := all_drg_subscore0 - 0.297745;

all_drg_aacd_1 := map(
    '' < addrchangecount60month AND (integer)addrchangecount60month < 1 => 'C14',
    1 <= (integer)addrchangecount60month AND (integer)addrchangecount60month < 2   => 'C14',
    2 <= (integer)addrchangecount60month AND (integer)addrchangecount60month < 3   => 'C14',
    3 <= (integer)addrchangecount60month AND (integer)addrchangecount60month < 4   => 'C14',
    4 <= (integer)addrchangecount60month AND (integer)addrchangecount60month < 5   => 'C14',
    5 <= (integer)addrchangecount60month AND (integer)addrchangecount60month < 6   => 'C14',
    6 <= (integer)addrchangecount60month                                  => 'C14',
                                                                    '');

all_drg_dist_1 := all_drg_subscore1 - 0.202831;

all_drg_aacd_2 := map(
    '' < ssnsubjectcount AND (integer)ssnsubjectcount < 0 => 'S65',
    0 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 1   => 'S66',
    1 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 2   => 'S66',
    2 <= (integer)ssnsubjectcount                           => 'S66',
                                                      '');

all_drg_dist_2 := all_drg_subscore2 - 0.045437;

all_drg_aacd_3 := map(
    (m5_drg_derogseverityindex in [1]) => 'D30',
    (m5_drg_derogseverityindex in [2]) => 'D30',
    (m5_drg_derogseverityindex in [3]) => 'D30',
    (m5_drg_derogseverityindex in [4]) => 'D30',
    (m5_drg_derogseverityindex in [5]) => 'D30',
    (m5_drg_derogseverityindex in [6]) => 'D30',
    (m5_drg_derogseverityindex in [7]) => 'D30',
                                          '');

all_drg_dist_3 := all_drg_subscore3 - 0.107487;

all_drg_aacd_4 := map(
    (m5_drg_nonderogindex03month in [1]) => 'C12',
    (m5_drg_nonderogindex03month in [2]) => 'C12',
    (m5_drg_nonderogindex03month in [3]) => 'C12',
    (m5_drg_nonderogindex03month in [4]) => 'C12',
    (m5_drg_nonderogindex03month in [5]) => 'C12',
    (m5_drg_nonderogindex03month in [6]) => 'C12',
                                            '');

all_drg_dist_4 := all_drg_subscore4 - 1.076029;

all_drg_aacd_5 := map(
    (m5_drg_derogrecentseverityindex in [1])    => 'D30',
    (m5_drg_derogrecentseverityindex in [2, 3]) => 'D30',
    (m5_drg_derogrecentseverityindex in [4])    => 'D30',
    (m5_drg_derogrecentseverityindex in [5, 6]) => 'D30',
    (m5_drg_derogrecentseverityindex in [7])    => 'D30',
                                                   '');

all_drg_dist_5 := all_drg_subscore5 - 0.08405;

all_drg_aacd_6 := map(
    '' < addrinputlengthofres AND (integer)addrinputlengthofres < 1   => 'C13',
    1 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 5     => 'C13',
    5 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 147   => 'C13',
    147 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 217 => 'C13',
    217 <= (integer)addrinputlengthofres                                => 'C13',
                                                                  '');

all_drg_dist_6 := all_drg_subscore6 - 0.270415;

all_drg_aacd_7 := map(
    '' < assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 0         => 'A46',
    0 <= (integer)assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 1           => 'A46',
    1 <= (integer)assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 13538       => 'A46',
    13538 <= (integer)assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 22790   => 'A46',
    22790 <= (integer)assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 194000  => 'A46',
    194000 <= (integer)assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 237650 => 'A46',
    237650 <= (integer)assetpropcurrenttaxtotal AND (integer)assetpropcurrenttaxtotal < 551900 => 'A46',
    551900 <= (integer)assetpropcurrenttaxtotal                                       => 'A46',
                                                                                '');

all_drg_dist_7 := all_drg_subscore7 - 0.420472;

all_drg_aacd_8 := map(
    (bankruptcystatus in ['1'])       => 'D31',
    (bankruptcystatus in ['-1', '0']) => '',
    (bankruptcystatus in ['2'])       => 'D31',
                                         '');

all_drg_dist_8 := all_drg_subscore8 - 0.289004;

all_drg_aacd_9 := map(
    NULL < iv_inputpropvaluemax AND iv_inputpropvaluemax < 1         => 'L80',
    1 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 70080       => 'L80',
    70080 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 100206  => 'L80',
    100206 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 131695 => 'L80',
    131695 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 157364 => 'L80',
    157364 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 201608 => 'L80',
    201608 <= iv_inputpropvaluemax                                   => 'L80',
                                                                        '');

all_drg_dist_9 := all_drg_subscore9 - 0.213628;

all_drg_aacd_10 := map(
    '' < educationevidence AND (integer)educationevidence < 1 => 'C12',
    1 <= (integer)educationevidence                             => 'C12',
                                                          '');

all_drg_dist_10 := all_drg_subscore10 - 0.219258;

all_drg_aacd_11 := map(
    NULL < iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0     => 'L77',
    0 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.01    => 'A47',
    0.01 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.66 => 'A47',
    0.66 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.85 => 'A47',
    0.85 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 1.31 => 'A47',
    1.31 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 1.94 => 'A47',
    1.94 <= iv_currentcountyratiosfd                                     => 'A47',
                                                                            '');

all_drg_dist_11 := all_drg_subscore11 - 0.209557;

all_drg_aacd_12 := map(
    '' < phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 0 => 'P85',
    0 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 1   => 'P89',
    1 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 2   => 'P89',
    2 <= (integer)phoneinputsubjectcount                                  => 'P89',
                                                                    '');

all_drg_dist_12 := all_drg_subscore12 - 0.333191;

all_drg_aacd_13 := map(
    '' < criminalnonfelonycount AND (integer)criminalnonfelonycount < 1 => 'D32',
    1 <= (integer)criminalnonfelonycount AND (integer)criminalnonfelonycount < 2   => 'D32',
    2 <= (integer)criminalnonfelonycount AND (integer)criminalnonfelonycount < 3   => 'D32',
    3 <= (integer)criminalnonfelonycount                                  => 'D32',
                                                                    '');

all_drg_dist_13 := all_drg_subscore13 - 0.015225;

all_drg_aacd_14 := map(
    '' < lienjudgmentsmallclaimscount AND (integer)lienjudgmentsmallclaimscount < 1 => 'D34',
    1 <= (integer)lienjudgmentsmallclaimscount                                        => 'D34',
                                                                                '');

all_drg_dist_14 := all_drg_subscore14 - 0.015473;

all_drg_aacd_15 := map(
    '' < businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 1 => 'E57',
    1 <= (integer)businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 82  => 'E57',
    82 <= (integer)businessassociationtimeoldest                                        => 'E57',
                                                                                  '');

all_drg_dist_15 := all_drg_subscore15 - 0.124713;

ds_layout := {STRING rc, REAL value};

// Drg  := dataset([
			// {all_drg_AACD_SEG_0 , all_drg_DIST_SEG_0},  
			// {all_drg_aacd_0, all_drg_dist_0}, 
			// {all_drg_aacd_1, all_drg_dist_1}, 
			// {all_drg_aacd_2, all_drg_dist_2}, 
			// {all_drg_aacd_3, all_drg_dist_3},
			// {all_drg_aacd_4, all_drg_dist_4},
			// {all_drg_aacd_5, all_drg_dist_5},
			// {all_drg_aacd_6, all_drg_dist_6},
			// {all_drg_aacd_7, all_drg_dist_7},
			// {all_drg_aacd_8, all_drg_dist_8},
			// {all_drg_aacd_9, all_drg_dist_9},
			// {all_drg_aacd_10, all_drg_dist_10},
			// {all_drg_aacd_11, all_drg_dist_11},
			// {all_drg_aacd_12, all_drg_dist_12},
			// {all_drg_aacd_13, all_drg_dist_13},
			// {all_drg_aacd_14, all_drg_dist_14},
			// {all_drg_aacd_15, all_drg_dist_15}],
			// ds_layout)(value < 0);
			
		// tbl_Drg :=
				// TABLE( drg, {rc, cnt := SUM(GROUP, value)}, rc); 

all_drg_rcvaluep89 := (integer)(all_drg_aacd_0 = 'P89') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'P89') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'P89') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'P89') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'P89') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'P89') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'P89') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'P89') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'P89') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'P89') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'P89') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'P89') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'P89') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'P89') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'P89') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'P89') * all_drg_dist_15;

all_drg_rcvaluec21 := (integer)(all_drg_aacd_0 = 'C21') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'C21') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'C21') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'C21') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'C21') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'C21') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'C21') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'C21') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'C21') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'C21') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'C21') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'C21') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'C21') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'C21') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'C21') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'C21') * all_drg_dist_15;

all_drg_rcvaluel80 := (integer)(all_drg_aacd_0 = 'L80') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'L80') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'L80') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'L80') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'L80') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'L80') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'L80') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'L80') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'L80') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'L80') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'L80') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'L80') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'L80') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'L80') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'L80') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'L80') * all_drg_dist_15;

all_drg_rcvalued34 := (integer)(all_drg_aacd_0 = 'D34') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'D34') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'D34') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'D34') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'D34') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'D34') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'D34') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'D34') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'D34') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'D34') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'D34') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'D34') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'D34') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'D34') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'D34') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'D34') * all_drg_dist_15;

all_drg_rcvalued32 := (integer)(all_drg_aacd_0 = 'D32') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'D32') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'D32') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'D32') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'D32') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'D32') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'D32') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'D32') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'D32') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'D32') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'D32') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'D32') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'D32') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'D32') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'D32') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'D32') * all_drg_dist_15;

all_drg_rcvaluel77 := (integer)(all_drg_aacd_0 = 'L77') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'L77') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'L77') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'L77') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'L77') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'L77') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'L77') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'L77') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'L77') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'L77') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'L77') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'L77') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'L77') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'L77') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'L77') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'L77') * all_drg_dist_15;

all_drg_rcvalued30 := (integer)(all_drg_aacd_0 = 'D30') * all_drg_dist_0 +
    (integer)(all_drg_aacd_seg_0 = 'D30') * all_drg_dist_seg_0 +
    (integer)(all_drg_aacd_1 = 'D30') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'D30') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'D30') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'D30') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'D30') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'D30') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'D30') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'D30') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'D30') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'D30') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'D30') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'D30') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'D30') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'D30') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'D30') * all_drg_dist_15;

all_drg_rcvalued31 := (integer)(all_drg_aacd_0 = 'D31') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'D31') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'D31') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'D31') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'D31') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'D31') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'D31') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'D31') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'D31') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'D31') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'D31') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'D31') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'D31') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'D31') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'D31') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'D31') * all_drg_dist_15;

all_drg_rcvaluea46 := (integer)(all_drg_aacd_0 = 'A46') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'A46') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'A46') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'A46') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'A46') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'A46') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'A46') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'A46') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'A46') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'A46') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'A46') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'A46') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'A46') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'A46') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'A46') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'A46') * all_drg_dist_15;

all_drg_rcvaluec13 := (integer)(all_drg_aacd_0 = 'C13') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'C13') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'C13') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'C13') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'C13') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'C13') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'C13') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'C13') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'C13') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'C13') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'C13') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'C13') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'C13') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'C13') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'C13') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'C13') * all_drg_dist_15;

all_drg_rcvaluei60 := (integer)(all_drg_aacd_0 = 'I60') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'I60') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'I60') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'I60') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'I60') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'I60') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'I60') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'I60') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'I60') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'I60') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'I60') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'I60') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'I60') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'I60') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'I60') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'I60') * all_drg_dist_15;
		
all_drg_rcvaluei61 := (integer)(all_drg_aacd_0 = 'I61') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'I61') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'I61') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'I61') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'I61') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'I61') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'I61') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'I61') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'I61') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'I61') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'I61') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'I61') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'I61') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'I61') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'I61') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'I61') * all_drg_dist_15;

all_drg_rcvaluep85 := (integer)(all_drg_aacd_0 = 'P85') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'P85') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'P85') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'P85') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'P85') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'P85') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'P85') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'P85') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'P85') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'P85') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'P85') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'P85') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'P85') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'P85') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'P85') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'P85') * all_drg_dist_15;

all_drg_rcvalues66 := (integer)(all_drg_aacd_0 = 'S66') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'S66') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'S66') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'S66') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'S66') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'S66') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'S66') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'S66') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'S66') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'S66') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'S66') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'S66') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'S66') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'S66') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'S66') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'S66') * all_drg_dist_15;

all_drg_rcvaluec12 := (integer)(all_drg_aacd_0 = 'C12') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'C12') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'C12') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'C12') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'C12') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'C12') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'C12') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'C12') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'C12') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'C12') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'C12') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'C12') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'C12') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'C12') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'C12') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'C12') * all_drg_dist_15;

all_drg_rcvaluea47 := (integer)(all_drg_aacd_0 = 'A47') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'A47') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'A47') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'A47') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'A47') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'A47') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'A47') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'A47') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'A47') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'A47') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'A47') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'A47') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'A47') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'A47') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'A47') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'A47') * all_drg_dist_15;

all_drg_rcvalues65 := (integer)(all_drg_aacd_0 = 'S65') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'S65') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'S65') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'S65') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'S65') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'S65') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'S65') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'S65') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'S65') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'S65') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'S65') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'S65') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'S65') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'S65') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'S65') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'S65') * all_drg_dist_15;

all_drg_rcvaluee57 := (integer)(all_drg_aacd_0 = 'E57') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'E57') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'E57') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'E57') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'E57') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'E57') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'E57') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'E57') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'E57') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'E57') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'E57') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'E57') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'E57') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'E57') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'E57') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'E57') * all_drg_dist_15;

all_drg_rcvaluec14 := (integer)(all_drg_aacd_0 = 'C14') * all_drg_dist_0 +
    (integer)(all_drg_aacd_1 = 'C14') * all_drg_dist_1 +
    (integer)(all_drg_aacd_2 = 'C14') * all_drg_dist_2 +
    (integer)(all_drg_aacd_3 = 'C14') * all_drg_dist_3 +
    (integer)(all_drg_aacd_4 = 'C14') * all_drg_dist_4 +
    (integer)(all_drg_aacd_5 = 'C14') * all_drg_dist_5 +
    (integer)(all_drg_aacd_6 = 'C14') * all_drg_dist_6 +
    (integer)(all_drg_aacd_7 = 'C14') * all_drg_dist_7 +
    (integer)(all_drg_aacd_8 = 'C14') * all_drg_dist_8 +
    (integer)(all_drg_aacd_9 = 'C14') * all_drg_dist_9 +
    (integer)(all_drg_aacd_10 = 'C14') * all_drg_dist_10 +
    (integer)(all_drg_aacd_11 = 'C14') * all_drg_dist_11 +
    (integer)(all_drg_aacd_12 = 'C14') * all_drg_dist_12 +
    (integer)(all_drg_aacd_13 = 'C14') * all_drg_dist_13 +
    (integer)(all_drg_aacd_14 = 'C14') * all_drg_dist_14 +
    (integer)(all_drg_aacd_15 = 'C14') * all_drg_dist_15;

all_own_aacd_0 := map(
    (m5_own_inquiryindex in [1])                                     => 'I60',
    (m5_own_inquiryindex in [2])                                     => 'C21',
    (m5_own_inquiryindex in [3])                                     => 'I61',
    (m5_own_inquiryindex in [4])                                     => 'I60',
    (m5_own_inquiryindex in [5])                                     => 'I60',
    (m5_own_inquiryindex in [6]) and (integer)shorttermloanrequest24month = 1 => 'C21',
    (m5_own_inquiryindex in [6])                                     => 'I60',
                                                                        '');

all_own_dist_0 := all_own_subscore0 - 0.24842;

all_own_aacd_1 := map(
    '' < ssnsubjectcount AND (integer)ssnsubjectcount < 0 => 'S65',
    0 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 1   => 'S66',
    1 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 2   => 'S66',
    2 <= (integer)ssnsubjectcount                           => 'S66',
                                                      '');

all_own_dist_1 := all_own_subscore1 - 0.104897;

all_own_aacd_2 := map(
    NULL < iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < -1        => 'L77',
    -1 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 0          => 'A46',
    0 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 1           => 'A47',
    1 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 44471       => 'A47',
    44471 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 67857   => 'A47',
    67857 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 97576   => 'A47',
    97576 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 123630  => 'A47',
    123630 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 148400 => 'A47',
    148400 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 196830 => 'A47',
    196830 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 310272 => 'A47',
    310272 <= iv_inputcurrtaxmarketvaluesfdmax                                               => 'A47',
                                                                                                '');

all_own_dist_2 := all_own_subscore2 - 0.432753;

all_own_aacd_3 := map(
    (m5_own_nonderogindex03month in [1]) => 'C12',
    (m5_own_nonderogindex03month in [2]) => 'C12',
    (m5_own_nonderogindex03month in [3]) => 'C12',
    (m5_own_nonderogindex03month in [4]) => 'C12',
    (m5_own_nonderogindex03month in [5]) => 'C12',
                                            '');

all_own_dist_3 := all_own_subscore3 - 0.717521;

all_own_aacd_4 := map(
    '' < phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 0 => 'P85',
    0 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 1   => 'P89',
    1 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 2   => 'P89',
    2 <= (integer)phoneinputsubjectcount                                  => 'P89',
                                                                    '');

all_own_dist_4 := all_own_subscore4 - 0.655686;

all_own_aacd_5 := map(
    NULL < iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0     => 'L77',
    0 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.01    => 'A47',
    0.01 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.54 => 'A47',
    0.54 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.68 => 'A47',
    0.68 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 0.91 => 'A47',
    0.91 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 1.14 => 'A47',
    1.14 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 1.61 => 'A47',
    1.61 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 1.9  => 'A47',
    1.9 <= iv_currentcountyratiosfd AND iv_currentcountyratiosfd < 2.92  => 'A47',
    2.92 <= iv_currentcountyratiosfd                                     => 'A47',
                                                                            '');

all_own_dist_5 := all_own_subscore5 - 0.337754;

all_own_aacd_6 := map(
    '' < addronfilecount AND (integer)addronfilecount < 3 => 'C14',
    3 <= (integer)addronfilecount AND (integer)addronfilecount < 4   => 'C14',
    4 <= (integer)addronfilecount AND (integer)addronfilecount < 5   => 'C14',
    5 <= (integer)addronfilecount AND (integer)addronfilecount < 6   => 'C14',
    6 <= (integer)addronfilecount AND (integer)addronfilecount < 7   => 'C14',
    7 <= (integer)addronfilecount AND (integer)addronfilecount < 9   => 'C14',
    9 <= (integer)addronfilecount AND (integer)addronfilecount < 10  => 'C14',
    10 <= (integer)addronfilecount                          => 'C14',
                                                      '');

all_own_dist_6 := all_own_subscore6 - 0.195553;

all_own_aacd_7 := map(
    '' < addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 1   => 'C13',
    1 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 13    => 'C13',
    13 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 22   => 'C13',
    22 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 37   => 'C13',
    37 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 66   => 'C13',
    66 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 111  => 'C13',
    111 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 203 => 'C13',
    203 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 245 => 'C13',
    245 <= (integer)addrprevioustimeoldest                                  => 'C13',
                                                                      '');

all_own_dist_7 := all_own_subscore7 - 0.190884;

all_own_aacd_8 := map(
    NULL < iv_inputpropvaluemax AND iv_inputpropvaluemax < 0         => 'L80',
    0 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 1           => 'L80',
    1 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 55950       => 'L80',
    55950 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 83612   => 'L80',
    83612 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 114805  => 'L80',
    114805 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 143990 => 'L80',
    143990 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 172365 => 'L80',
    172365 <= iv_inputpropvaluemax AND iv_inputpropvaluemax < 488812 => 'L80',
    488812 <= iv_inputpropvaluemax                                   => 'L80',
                                                                        '');

all_own_dist_8 := all_own_subscore8 - 0.180965;

all_own_aacd_9 := map(
    (educationinstitutionrating in ['0'])           => 'C12',
    (educationinstitutionrating in ['1', '2'])      => 'C12',
    (educationinstitutionrating in ['3'])           => 'C12',
    (educationinstitutionrating in ['4', '5', '6']) => 'C12',
                                                       'C12');

all_own_dist_9 := all_own_subscore9 - 0.861946;

all_own_aacd_10 := map(
    (addrcurrentownershipindex in ['0'])           => 'A42',
    (addrcurrentownershipindex in ['1', '2', '3']) => 'A42',
    (addrcurrentownershipindex in ['4'])           => 'A42',
                                                      'A42');

all_own_dist_10 := all_own_subscore10 - 0.065715;

all_own_aacd_11 := map(
    '' < businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 1  => 'E57',
    1 <= (integer)businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 34   => 'E57',
    34 <= (integer)businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 86  => 'E57',
    86 <= (integer)businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 103 => 'E57',
    103 <= (integer)businessassociationtimeoldest                                        => 'E57',
                                                                                   '');

all_own_dist_11 := all_own_subscore11 - 0.461587;

all_own_aacd_12 := map(
    '' < bankruptcycount AND (integer)bankruptcycount < 1 => 'D31',
    1 <= (integer)bankruptcycount                           => 'D31',
                                                      '');

all_own_dist_12 := all_own_subscore12 - 0.028475;

all_own_aacd_13 := map(
    '' < assetpersonalcount AND (integer)assetpersonalcount < 1 => 'A45',
    1 <= (integer)assetpersonalcount AND (integer)assetpersonalcount < 2   => 'A45',
    2 <= (integer)assetpersonalcount AND (integer)assetpersonalcount < 3   => 'A45',
    3 <= (integer)assetpersonalcount                              => 'A45',
                                                            '');

all_own_dist_13 := all_own_subscore13 - 0.516604;

all_own_aacd_14 := map(
    '' < addrinputtaxvalue AND (integer)addrinputtaxvalue < 0         => 'L80',
    0 <= (integer)addrinputtaxvalue AND (integer)addrinputtaxvalue < 1           => 'L80',
    1 <= (integer)addrinputtaxvalue AND (integer)addrinputtaxvalue < 111066      => 'L80',
    111066 <= (integer)addrinputtaxvalue AND (integer)addrinputtaxvalue < 161040 => 'L80',
    161040 <= (integer)addrinputtaxvalue AND (integer)addrinputtaxvalue < 211500 => 'L80',
    211500 <= (integer)addrinputtaxvalue AND (integer)addrinputtaxvalue < 358948 => 'L80',
    358948 <= (integer)addrinputtaxvalue                                => 'L80',
                                                                  '');

all_own_dist_14 := all_own_subscore14 - 0.286805;

all_own_aacd_15 := map(
    '' < assetpropevercount AND (integer)assetpropevercount < 1 => 'A45',
    1 <= (integer)assetpropevercount AND (integer)assetpropevercount < 2   => 'A45',
    2 <= (integer)assetpropevercount AND (integer)assetpropevercount < 3   => 'A45',
    3 <= (integer)assetpropevercount AND (integer)assetpropevercount < 4   => 'A45',
    4 <= (integer)assetpropevercount AND (integer)assetpropevercount < 5   => 'A45',
    5 <= (integer)assetpropevercount                              => 'A45',
                                                            '');

all_own_dist_15 := all_own_subscore15 - 0.238223;

all_own_aacd_16 := map(
    '' < addrinputtimeoldest AND (integer)addrinputtimeoldest < 1 => 'C13',
    1 <= (integer)addrinputtimeoldest AND (integer)addrinputtimeoldest < 216 => 'C13',
    216 <= (integer)addrinputtimeoldest                             => 'C13',
                                                              '');

all_own_dist_16 := all_own_subscore16 - 0.131994;

all_own_rcvaluea42 := (integer)(all_own_aacd_0 = 'A42') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'A42') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'A42') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'A42') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'A42') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'A42') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'A42') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'A42') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'A42') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'A42') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'A42') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'A42') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'A42') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'A42') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'A42') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'A42') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'A42') * all_own_dist_16;

all_own_rcvaluep89 := (integer)(all_own_aacd_0 = 'P89') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'P89') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'P89') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'P89') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'P89') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'P89') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'P89') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'P89') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'P89') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'P89') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'P89') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'P89') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'P89') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'P89') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'P89') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'P89') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'P89') * all_own_dist_16;

all_own_rcvaluec21 := (integer)(all_own_aacd_0 = 'C21') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'C21') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'C21') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'C21') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'C21') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'C21') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'C21') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'C21') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'C21') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'C21') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'C21') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'C21') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'C21') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'C21') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'C21') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'C21') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'C21') * all_own_dist_16;

all_own_rcvaluel80 := (integer)(all_own_aacd_0 = 'L80') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'L80') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'L80') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'L80') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'L80') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'L80') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'L80') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'L80') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'L80') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'L80') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'L80') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'L80') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'L80') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'L80') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'L80') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'L80') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'L80') * all_own_dist_16;

all_own_rcvaluec13 := (integer)(all_own_aacd_0 = 'C13') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'C13') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'C13') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'C13') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'C13') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'C13') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'C13') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'C13') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'C13') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'C13') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'C13') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'C13') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'C13') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'C13') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'C13') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'C13') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'C13') * all_own_dist_16;

all_own_rcvaluel77 := (integer)(all_own_aacd_0 = 'L77') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'L77') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'L77') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'L77') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'L77') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'L77') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'L77') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'L77') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'L77') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'L77') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'L77') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'L77') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'L77') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'L77') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'L77') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'L77') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'L77') * all_own_dist_16;

all_own_rcvaluep85 := (integer)(all_own_aacd_0 = 'P85') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'P85') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'P85') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'P85') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'P85') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'P85') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'P85') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'P85') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'P85') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'P85') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'P85') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'P85') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'P85') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'P85') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'P85') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'P85') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'P85') * all_own_dist_16;

all_own_rcvalued31 := (integer)(all_own_aacd_0 = 'D31') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'D31') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'D31') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'D31') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'D31') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'D31') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'D31') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'D31') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'D31') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'D31') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'D31') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'D31') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'D31') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'D31') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'D31') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'D31') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'D31') * all_own_dist_16;

all_own_rcvaluea46 := (integer)(all_own_aacd_0 = 'A46') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'A46') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'A46') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'A46') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'A46') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'A46') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'A46') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'A46') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'A46') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'A46') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'A46') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'A46') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'A46') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'A46') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'A46') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'A46') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'A46') * all_own_dist_16;

all_own_rcvaluea47 := (integer)(all_own_aacd_0 = 'A47') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'A47') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'A47') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'A47') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'A47') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'A47') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'A47') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'A47') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'A47') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'A47') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'A47') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'A47') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'A47') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'A47') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'A47') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'A47') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'A47') * all_own_dist_16;

all_own_rcvaluea45 := (integer)(all_own_aacd_0 = 'A45') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'A45') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'A45') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'A45') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'A45') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'A45') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'A45') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'A45') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'A45') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'A45') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'A45') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'A45') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'A45') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'A45') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'A45') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'A45') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'A45') * all_own_dist_16;

all_own_rcvaluei60 := (integer)(all_own_aacd_0 = 'I60') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'I60') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'I60') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'I60') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'I60') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'I60') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'I60') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'I60') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'I60') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'I60') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'I60') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'I60') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'I60') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'I60') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'I60') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'I60') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'I60') * all_own_dist_16;

all_own_rcvaluei61 := (integer)(all_own_aacd_0 = 'I61') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'I61') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'I61') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'I61') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'I61') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'I61') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'I61') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'I61') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'I61') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'I61') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'I61') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'I61') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'I61') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'I61') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'I61') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'I61') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'I61') * all_own_dist_16;

all_own_rcvalues66 := (integer)(all_own_aacd_0 = 'S66') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'S66') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'S66') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'S66') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'S66') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'S66') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'S66') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'S66') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'S66') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'S66') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'S66') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'S66') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'S66') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'S66') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'S66') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'S66') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'S66') * all_own_dist_16;

all_own_rcvaluec12 := (integer)(all_own_aacd_0 = 'C12') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'C12') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'C12') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'C12') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'C12') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'C12') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'C12') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'C12') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'C12') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'C12') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'C12') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'C12') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'C12') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'C12') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'C12') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'C12') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'C12') * all_own_dist_16;

all_own_rcvaluee57 := (integer)(all_own_aacd_0 = 'E57') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'E57') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'E57') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'E57') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'E57') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'E57') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'E57') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'E57') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'E57') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'E57') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'E57') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'E57') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'E57') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'E57') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'E57') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'E57') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'E57') * all_own_dist_16;

all_own_rcvalues65 := (integer)(all_own_aacd_0 = 'S65') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'S65') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'S65') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'S65') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'S65') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'S65') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'S65') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'S65') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'S65') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'S65') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'S65') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'S65') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'S65') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'S65') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'S65') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'S65') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'S65') * all_own_dist_16;

all_own_rcvaluec14 := (integer)(all_own_aacd_0 = 'C14') * all_own_dist_0 +
    (integer)(all_own_aacd_1 = 'C14') * all_own_dist_1 +
    (integer)(all_own_aacd_2 = 'C14') * all_own_dist_2 +
    (integer)(all_own_aacd_3 = 'C14') * all_own_dist_3 +
    (integer)(all_own_aacd_4 = 'C14') * all_own_dist_4 +
    (integer)(all_own_aacd_5 = 'C14') * all_own_dist_5 +
    (integer)(all_own_aacd_6 = 'C14') * all_own_dist_6 +
    (integer)(all_own_aacd_7 = 'C14') * all_own_dist_7 +
    (integer)(all_own_aacd_8 = 'C14') * all_own_dist_8 +
    (integer)(all_own_aacd_9 = 'C14') * all_own_dist_9 +
    (integer)(all_own_aacd_10 = 'C14') * all_own_dist_10 +
    (integer)(all_own_aacd_11 = 'C14') * all_own_dist_11 +
    (integer)(all_own_aacd_12 = 'C14') * all_own_dist_12 +
    (integer)(all_own_aacd_13 = 'C14') * all_own_dist_13 +
    (integer)(all_own_aacd_14 = 'C14') * all_own_dist_14 +
    (integer)(all_own_aacd_15 = 'C14') * all_own_dist_15 +
    (integer)(all_own_aacd_16 = 'C14') * all_own_dist_16;

 all_oth_AACD_SEG_0 := if(Ford_RV5_Attr_seg in ['3 OTHER'],'A41','');
all_oth_dist_seg_0 := 3.1000180 - 4.3936108;


all_oth_aacd_0 := map(
    (m5_oth_inquiryindex in [1])                                     => 'I60',
    (m5_oth_inquiryindex in [2])                                     => 'C21',
    (m5_oth_inquiryindex in [3])                                     => 'I61',
    (m5_oth_inquiryindex in [4])                                     => 'I60',
    (m5_oth_inquiryindex in [5])                                     => 'I60',
    (m5_oth_inquiryindex in [6]) and (integer)shorttermloanrequest24month = 1 => 'C21',
    (m5_oth_inquiryindex in [6])                                     => 'I60',
                                                                        '');

all_oth_dist_0 := all_oth_subscore0 - 0.351463;

all_oth_aacd_1 := map(
    '' < ssnsubjectcount AND (integer)ssnsubjectcount < 0 => 'S65',
    0 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 1   => 'S66',
    1 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 2   => 'S66',
    2 <= (integer)ssnsubjectcount                           => 'S66',
                                                      '');

all_oth_dist_1 := all_oth_subscore1 - 0.056289;

all_oth_aacd_2 := map(
    (m5_oth_nonderogindex03month in [1]) => 'C12',
    (m5_oth_nonderogindex03month in [2]) => 'C12',
    (m5_oth_nonderogindex03month in [3]) => 'C12',
    (m5_oth_nonderogindex03month in [4]) => 'C12',
    (m5_oth_nonderogindex03month in [5]) => 'C12',
    (m5_oth_nonderogindex03month in [6]) => 'C12',
                                            '');

all_oth_dist_2 := all_oth_subscore2 - 1.016289;

all_oth_aacd_3 := map(
    NULL < iv_inputcurravmvaluesfdmax AND iv_inputcurravmvaluesfdmax < -1        => 'L77',
    -1 <= iv_inputcurravmvaluesfdmax AND iv_inputcurravmvaluesfdmax < 1          => 'A47',
    1 <= iv_inputcurravmvaluesfdmax AND iv_inputcurravmvaluesfdmax < 70114       => 'A47',
    70114 <= iv_inputcurravmvaluesfdmax AND iv_inputcurravmvaluesfdmax < 108849  => 'A47',
    108849 <= iv_inputcurravmvaluesfdmax AND iv_inputcurravmvaluesfdmax < 203545 => 'A47',
    203545 <= iv_inputcurravmvaluesfdmax AND iv_inputcurravmvaluesfdmax < 478693 => 'A47',
    478693 <= iv_inputcurravmvaluesfdmax                                         => 'A47',
                                                                                    '');

all_oth_dist_3 := all_oth_subscore3 - 0.3807;

all_oth_aacd_4 := map(
    '' < addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 1   => 'C13',
    1 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 13    => 'C13',
    13 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 26   => 'C13',
    26 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 40   => 'C13',
    40 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 60   => 'C13',
    60 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 78   => 'C13',
    78 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 109  => 'C13',
    109 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 161 => 'C13',
    161 <= (integer)addrprevioustimeoldest AND (integer)addrprevioustimeoldest < 224 => 'C13',
    224 <= (integer)addrprevioustimeoldest                                  => 'C13',
                                                                      '');

all_oth_dist_4 := all_oth_subscore4 - 0.176627;

all_oth_aacd_5 := map(
    '' < addrinputlengthofres AND (integer)addrinputlengthofres < 1   => 'C13',
    1 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 7     => 'C13',
    7 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 105   => 'C13',
    105 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 241 => 'C13',
    241 <= (integer)addrinputlengthofres AND (integer)addrinputlengthofres < 384 => 'C13',
    384 <= (integer)addrinputlengthofres                                => 'C13',
                                                                  '');

all_oth_dist_5 := all_oth_subscore5 - 0.498038;

all_oth_aacd_6 := map(
    (educationinstitutionrating in ['0'])           => 'C12',
    (educationinstitutionrating in ['1'])           => 'C12',
    (educationinstitutionrating in ['2'])           => 'C12',
    (educationinstitutionrating in ['3'])           => 'C12',
    (educationinstitutionrating in ['4', '5', '6']) => 'C12',
                                                       'C12');

all_oth_dist_6 := all_oth_subscore6 - 1.047738;

all_oth_aacd_7 := map(
    '' < subjectabilityindex AND (integer)subjectabilityindex < 1 => iv_subjectabilityprimaryfactor,
    1 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 2   => iv_subjectabilityprimaryfactor,
    2 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 3   => iv_subjectabilityprimaryfactor,
    3 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 4   => iv_subjectabilityprimaryfactor,
    4 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 5   => iv_subjectabilityprimaryfactor,
    5 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 6   => iv_subjectabilityprimaryfactor,
    6 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 7   => iv_subjectabilityprimaryfactor,
    7 <= (integer)subjectabilityindex                               => iv_subjectabilityprimaryfactor,
                                                              '');

all_oth_dist_7 := all_oth_subscore7 - 0.443788;

all_oth_aacd_8 := map(
    '' < phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 0 => 'P85',
    0 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 1   => 'P89',
    1 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 2   => 'P89',
    2 <= (integer)phoneinputsubjectcount                                  => 'P89',
                                                                    '');

all_oth_dist_8 := all_oth_subscore8 - 0.601222;

all_oth_aacd_9 := map(
    '' < addronfilecount AND (integer)addronfilecount < 2 => 'C14',
    2 <= (integer)addronfilecount AND (integer)addronfilecount < 3   => 'C14',
    3 <= (integer)addronfilecount AND (integer)addronfilecount < 5   => 'C14',
    5 <= (integer)addronfilecount AND (integer)addronfilecount < 6   => 'C14',
    6 <= (integer)addronfilecount AND (integer)addronfilecount < 8   => 'C14',
    8 <= (integer)addronfilecount AND (integer)addronfilecount < 10  => 'C14',
    10 <= (integer)addronfilecount                          => 'C14',
                                                      '');

all_oth_dist_9 := all_oth_subscore9 - 0.117642;

all_oth_aacd_10 := map(
    (addrinputownershipindex in ['-1']) => 'L80',
    (addrinputownershipindex in ['0'])  => 'L80',
    (addrinputownershipindex in ['1'])  => 'L81',
    (addrinputownershipindex in ['2'])  => 'A41',
    (addrinputownershipindex in ['3'])  => 'A41',
                                           '');

all_oth_dist_10 := all_oth_subscore10 - 0.170182;

all_oth_aacd_11 := map(
    '' < businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 1 => 'E57',
    1 <= (integer)businessassociationtimeoldest AND (integer)businessassociationtimeoldest < 102 => 'E57',
    102 <= (integer)businessassociationtimeoldest                                       => 'E57',
                                                                                  '');

all_oth_dist_11 := all_oth_subscore11 - 0.382327;

all_oth_aacd_12 := map(
    '' < assetpropevercount AND (integer)assetpropevercount < 1 => 'A45',
    1 <= (integer)assetpropevercount AND (integer)assetpropevercount < 2   => 'A45',
    2 <= (integer)assetpropevercount AND (integer)assetpropevercount < 3   => 'A45',
    3 <= (integer)assetpropevercount                              => 'A45',
                                                            '');

all_oth_dist_12 := all_oth_subscore12 - 0.310022;


all_oth_rcvaluea42 := (integer)(all_oth_aacd_0 = 'A42') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'A42') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'A42') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'A42') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'A42') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'A42') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'A42') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'A42') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'A42') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'A42') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'A42') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'A42') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'A42') * all_oth_dist_12;

all_oth_rcvaluec13 := (integer)(all_oth_aacd_0 = 'C13') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'C13') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'C13') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'C13') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'C13') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'C13') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'C13') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'C13') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'C13') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'C13') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'C13') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'C13') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'C13') * all_oth_dist_12;

all_oth_rcvaluec21 := (integer)(all_oth_aacd_0 = 'C21') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'C21') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'C21') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'C21') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'C21') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'C21') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'C21') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'C21') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'C21') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'C21') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'C21') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'C21') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'C21') * all_oth_dist_12;

all_oth_rcvaluep89 := (integer)(all_oth_aacd_0 = 'P89') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'P89') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'P89') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'P89') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'P89') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'P89') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'P89') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'P89') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'P89') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'P89') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'P89') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'P89') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'P89') * all_oth_dist_12;
		
all_oth_rcvalued31 := (integer)(all_oth_aacd_0 = 'D31') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'D31') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'D31') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'D31') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'D31') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'D31') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'D31') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'D31') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'D31') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'D31') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'D31') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'D31') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'D31') * all_oth_dist_12;

all_oth_rcvaluel81 := (integer)(all_oth_aacd_0 = 'L81') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'L81') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'L81') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'L81') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'L81') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'L81') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'L81') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'L81') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'L81') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'L81') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'L81') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'L81') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'L81') * all_oth_dist_12;

all_oth_rcvaluel80 := (integer)(all_oth_aacd_0 = 'L80') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'L80') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'L80') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'L80') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'L80') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'L80') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'L80') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'L80') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'L80') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'L80') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'L80') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'L80') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'L80') * all_oth_dist_12;

all_oth_rcvaluel77 := (integer)(all_oth_aacd_0 = 'L77') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'L77') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'L77') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'L77') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'L77') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'L77') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'L77') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'L77') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'L77') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'L77') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'L77') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'L77') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'L77') * all_oth_dist_12;

all_oth_rcvaluep85 := (integer)(all_oth_aacd_0 = 'P85') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'P85') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'P85') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'P85') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'P85') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'P85') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'P85') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'P85') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'P85') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'P85') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'P85') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'P85') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'P85') * all_oth_dist_12;

all_oth_rcvaluea47 := (integer)(all_oth_aacd_0 = 'A47') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'A47') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'A47') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'A47') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'A47') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'A47') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'A47') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'A47') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'A47') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'A47') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'A47') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'A47') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'A47') * all_oth_dist_12;

all_oth_rcvaluea45 := (integer)(all_oth_aacd_0 = 'A45') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'A45') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'A45') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'A45') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'A45') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'A45') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'A45') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'A45') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'A45') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'A45') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'A45') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'A45') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'A45') * all_oth_dist_12;

all_oth_rcvaluei60 := (integer)(all_oth_aacd_0 = 'I60') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'I60') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'I60') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'I60') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'I60') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'I60') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'I60') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'I60') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'I60') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'I60') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'I60') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'I60') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'I60') * all_oth_dist_12;

all_oth_rcvaluei61 := (integer)(all_oth_aacd_0 = 'I61') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'I61') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'I61') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'I61') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'I61') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'I61') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'I61') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'I61') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'I61') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'I61') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'I61') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'I61') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'I61') * all_oth_dist_12;

all_oth_rcvaluea41 := (integer)(all_oth_aacd_0 = 'A41') * all_oth_dist_0 +
		(integer)(all_oth_aacd_seg_0 = 'A41') * all_oth_dist_seg_0 +
		(integer)(all_oth_aacd_1 = 'A41') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'A41') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'A41') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'A41') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'A41') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'A41') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'A41') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'A41') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'A41') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'A41') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'A41') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'A41') * all_oth_dist_12;

all_oth_rcvalues66 := (integer)(all_oth_aacd_0 = 'S66') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'S66') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'S66') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'S66') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'S66') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'S66') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'S66') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'S66') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'S66') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'S66') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'S66') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'S66') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'S66') * all_oth_dist_12;

all_oth_rcvaluec12 := (integer)(all_oth_aacd_0 = 'C12') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'C12') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'C12') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'C12') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'C12') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'C12') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'C12') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'C12') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'C12') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'C12') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'C12') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'C12') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'C12') * all_oth_dist_12;

all_oth_rcvaluee57 := (integer)(all_oth_aacd_0 = 'E57') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'E57') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'E57') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'E57') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'E57') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'E57') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'E57') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'E57') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'E57') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'E57') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'E57') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'E57') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'E57') * all_oth_dist_12;

all_oth_rcvalues65 := (integer)(all_oth_aacd_0 = 'S65') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'S65') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'S65') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'S65') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'S65') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'S65') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'S65') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'S65') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'S65') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'S65') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'S65') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'S65') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'S65') * all_oth_dist_12;

all_oth_rcvaluec14 := (integer)(all_oth_aacd_0 = 'C14') * all_oth_dist_0 +
    (integer)(all_oth_aacd_1 = 'C14') * all_oth_dist_1 +
    (integer)(all_oth_aacd_2 = 'C14') * all_oth_dist_2 +
    (integer)(all_oth_aacd_3 = 'C14') * all_oth_dist_3 +
    (integer)(all_oth_aacd_4 = 'C14') * all_oth_dist_4 +
    (integer)(all_oth_aacd_5 = 'C14') * all_oth_dist_5 +
    (integer)(all_oth_aacd_6 = 'C14') * all_oth_dist_6 +
    (integer)(all_oth_aacd_7 = 'C14') * all_oth_dist_7 +
    (integer)(all_oth_aacd_8 = 'C14') * all_oth_dist_8 +
    (integer)(all_oth_aacd_9 = 'C14') * all_oth_dist_9 +
    (integer)(all_oth_aacd_10 = 'C14') * all_oth_dist_10 +
    (integer)(all_oth_aacd_11 = 'C14') * all_oth_dist_11 +
    (integer)(all_oth_aacd_12 = 'C14') * all_oth_dist_12;


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//



 
//*************************************************************************************//
rc_dataset_all_oth := DATASET([
    {'A42', all_oth_rcvalueA42},
    {'C13', all_oth_rcvalueC13},
    {'D31', all_oth_rcvalueD31},
    {'C21', all_oth_rcvalueC21},
    {'P89', all_oth_rcvalueP89},
    {'L81', all_oth_rcvalueL81},
    {'L80', all_oth_rcvalueL80},
    {'L77', all_oth_rcvalueL77},
    {'P85', all_oth_rcvalueP85},
    {'A47', all_oth_rcvalueA47},
    {'A45', all_oth_rcvalueA45},
    {'I60', all_oth_rcvalueI60},
    {'I61', all_oth_rcvalueI61},
    {'A41', all_oth_rcvalueA41},
    {'S66', all_oth_rcvalueS66},
    {'C12', all_oth_rcvalueC12},
    {'E57', all_oth_rcvalueE57},
    {'S65', all_oth_rcvalueS65},
    {'C14', all_oth_rcvalueC14}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_all_oth_sorted := sort(rc_dataset_all_oth, rc_dataset_all_oth.value);

all_oth_rc1 := rc_dataset_all_oth_sorted[1].rc;
all_oth_rc2 := rc_dataset_all_oth_sorted[2].rc;
all_oth_rc3 := rc_dataset_all_oth_sorted[3].rc;
all_oth_rc4 := rc_dataset_all_oth_sorted[4].rc;

all_oth_vl1 := rc_dataset_all_oth_sorted[1].value;
all_oth_vl2 := rc_dataset_all_oth_sorted[2].value;
all_oth_vl3 := rc_dataset_all_oth_sorted[3].value;
all_oth_vl4 := rc_dataset_all_oth_sorted[4].value;
//*************************************************************************************//

 
//*************************************************************************************//
rc_dataset_all_own := DATASET([
    {'A42', all_own_rcvalueA42},
    {'P89', all_own_rcvalueP89},
    {'C21', all_own_rcvalueC21},
    {'L80', all_own_rcvalueL80},
    {'C13', all_own_rcvalueC13},
    {'L77', all_own_rcvalueL77},
    {'P85', all_own_rcvalueP85},
    {'D31', all_own_rcvalueD31},
    {'A46', all_own_rcvalueA46},
    {'A47', all_own_rcvalueA47},
    {'A45', all_own_rcvalueA45},
    {'I60', all_own_rcvalueI60},
    {'I61', all_own_rcvalueI61},
    {'S66', all_own_rcvalueS66},
    {'C12', all_own_rcvalueC12},
    {'E57', all_own_rcvalueE57},
    {'S65', all_own_rcvalueS65},
    {'C14', all_own_rcvalueC14}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_all_own_sorted := sort(rc_dataset_all_own, rc_dataset_all_own.value);

all_own_rc1 := rc_dataset_all_own_sorted[1].rc;
all_own_rc2 := rc_dataset_all_own_sorted[2].rc;
all_own_rc3 := rc_dataset_all_own_sorted[3].rc;
all_own_rc4 := rc_dataset_all_own_sorted[4].rc;

all_own_vl1 := rc_dataset_all_own_sorted[1].value;
all_own_vl2 := rc_dataset_all_own_sorted[2].value;
all_own_vl3 := rc_dataset_all_own_sorted[3].value;
all_own_vl4 := rc_dataset_all_own_sorted[4].value;
//*************************************************************************************//

 
//*************************************************************************************//
rc_dataset_all_drg := DATASET([
    // {'D30', all_drg_DIST_SEG_0},
    {'P89', all_drg_rcvalueP89},
    {'C21', all_drg_rcvalueC21},
    {'L80', all_drg_rcvalueL80},
    {'D34', all_drg_rcvalueD34},
    {'D32', all_drg_rcvalueD32},
    {'L77', all_drg_rcvalueL77},
    {'D30', all_drg_rcvalueD30},
    {'D31', all_drg_rcvalueD31},
    {'A46', all_drg_rcvalueA46},
    {'C13', all_drg_rcvalueC13},
    {'I60', all_drg_rcvalueI60},
    {'I61', all_drg_rcvalueI61},
    {'P85', all_drg_rcvalueP85},
    {'S66', all_drg_rcvalueS66},
    {'C12', all_drg_rcvalueC12},
    {'A47', all_drg_rcvalueA47},
    {'S65', all_drg_rcvalueS65},
    {'E57', all_drg_rcvalueE57},
    {'C14', all_drg_rcvalueC14}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_all_drg_sorted := sort(rc_dataset_all_drg, rc_dataset_all_drg.value);

all_drg_rc1 := rc_dataset_all_drg_sorted[1].rc;
all_drg_rc2 := rc_dataset_all_drg_sorted[2].rc;
all_drg_rc3 := rc_dataset_all_drg_sorted[3].rc;
all_drg_rc4 := rc_dataset_all_drg_sorted[4].rc;

all_drg_vl1 := rc_dataset_all_drg_sorted[1].value;
all_drg_vl2 := rc_dataset_all_drg_sorted[2].value;
all_drg_vl3 := rc_dataset_all_drg_sorted[3].value;
all_drg_vl4 := rc_dataset_all_drg_sorted[4].value;
//*************************************************************************************//


rc1_3 := map(
    (ford_rv5_attr_seg in ['1 DEROG']) => all_drg_rc1,
    (ford_rv5_attr_seg in ['2 OWNER']) => all_own_rc1,
                                          all_oth_rc1);

rc2_2 := map(
    (ford_rv5_attr_seg in ['1 DEROG']) => all_drg_rc2,
    (ford_rv5_attr_seg in ['2 OWNER']) => all_own_rc2,
                                          all_oth_rc2);

rc4_2 := map(
    (ford_rv5_attr_seg in ['1 DEROG']) => all_drg_rc4,
    (ford_rv5_attr_seg in ['2 OWNER']) => all_own_rc4,
                                          all_oth_rc4);

rc3_2 := map(
    (ford_rv5_attr_seg in ['1 DEROG']) => all_drg_rc3,
    (ford_rv5_attr_seg in ['2 OWNER']) => all_own_rc3,
                                          all_oth_rc3);

rc1_2 := if(trim(rc1_3, ALL) = '', 'C10', rc1_3);

_rc_inq := map(
    (ford_rv5_attr_seg in ['1 DEROG']) and (integer)inquirycollections12month = 1                                                                                    => 'I61',
    (ford_rv5_attr_seg in ['1 DEROG']) and ((integer)inquiryshortterm12month = 1 or (integer)inquiryauto12month = 1 or (integer)inquirybanking12month = 1 or (integer)inquirytelcom12month = 1) => 'I60',
    (ford_rv5_attr_seg in ['2 OWNER']) and (integer)inquirycollections12month = 1                                                                                    => 'I61',
    (ford_rv5_attr_seg in ['2 OWNER']) and ((integer)inquiryshortterm12month = 1 or (integer)inquiryauto12month = 1 or (integer)inquirybanking12month = 1 or (integer)inquirytelcom12month = 1) => 'I60',
    (ford_rv5_attr_seg in ['3 OTHER']) and (integer)inquirycollections12month = 1                                                                                    => 'I61',
    (ford_rv5_attr_seg in ['3 OTHER']) and ((integer)inquiryshortterm12month = 1 or (integer)inquiryauto12month = 1 or (integer)inquirybanking12month = 1 or (integer)inquirytelcom12month = 1) => 'I60',
                                                                                                                                                               '   ');

rc5_c118 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = ''         => '',
    trim(rc3_2, LEFT, RIGHT) = ''         => '',
    trim(rc4_2, LEFT, RIGHT) = ''         => '',
                                             _rc_inq);

// rc1_c118 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim(rc2_2, LEFT, RIGHT) = ''         => '',
    // trim(rc3_2, LEFT, RIGHT) = ''         => '',
    // trim(rc4_2, LEFT, RIGHT) = ''         => '',
                                             // '');

// rc2_c118 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim(rc2_2, LEFT, RIGHT) = ''         => _rc_inq,
    // trim(rc3_2, LEFT, RIGHT) = ''         => '',
    // trim(rc4_2, LEFT, RIGHT) = ''         => '',
                                             // '');

// rc4_c118 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim(rc2_2, LEFT, RIGHT) = ''         => '',
    // trim(rc3_2, LEFT, RIGHT) = ''         => '',
    // trim(rc4_2, LEFT, RIGHT) = ''         => _rc_inq,
                                             // '');

// rc3_c118 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim(rc2_2, LEFT, RIGHT) = ''         => '',
    // trim(rc3_2, LEFT, RIGHT) = ''         => _rc_inq,
    // trim(rc4_2, LEFT, RIGHT) = ''         => '',
                                             // '');

//rc1_1 := if(not((rc1_2 in ['I60', 'I61'])) and not((rc2_2 in ['I60', 'I61'])) and not((rc3_2 in ['I60', 'I61'])) and not((rc4_2 in ['I60', 'I61'])), rc1_c118, rc1_2);

rc5_1 := if(not((rc1_2 in ['I60', 'I61'])) and not((rc2_2 in ['I60', 'I61'])) and not((rc3_2 in ['I60', 'I61'])) and not((rc4_2 in ['I60', 'I61'])), rc5_c118, '');

// rc2_1 := if(not((rc1_2 in ['I60', 'I61'])) and not((rc2_2 in ['I60', 'I61'])) and not((rc3_2 in ['I60', 'I61'])) and not((rc4_2 in ['I60', 'I61'])), rc2_c118, rc2_2);

// rc4_1 := if(not((rc1_2 in ['I60', 'I61'])) and not((rc2_2 in ['I60', 'I61'])) and not((rc3_2 in ['I60', 'I61'])) and not((rc4_2 in ['I60', 'I61'])), rc4_c118, rc4_2);

// rc3_1 := if(not((rc1_2 in ['I60', 'I61'])) and not((rc2_2 in ['I60', 'I61'])) and not((rc3_2 in ['I60', 'I61'])) and not((rc4_2 in ['I60', 'I61'])), rc3_c118, rc3_2);

rc2 := if((rva1611_2_0 in [200, 222, 900]), '', rc2_2);

rc1 := if((rva1611_2_0 in [200, 222, 900]), '', rc1_2);

rc5 := if((rva1611_2_0 in [200, 222, 900]), '', rc5_1);

rc3 := if((rva1611_2_0 in [200, 222, 900]), '', rc3_2);

rc4 := if((rva1611_2_0 in [200, 222, 900]), '', rc4_2);


//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVA1611_2_0 = 200 => DATASET([{'00'}], HRILayout),
													RVA1611_2_0 = 222 => DATASET([{'00'}], HRILayout),
													RVA1611_2_0 = 900 => DATASET([{'00'}], HRILayout),
																							 DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI NOT IN ['', '00']);
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.seq 															:= le.seq;
		self.sysdate                          := sysdate;
	 self.subjectrecordtimeoldest          	:=	subjectrecordtimeoldest;          
   self.lienjudgmentcount                	:=	lienjudgmentcount;                
   self.ssndeceased                      	:=	ssndeceased;                      
   self.confirmationsubjectfound         	:=	confirmationsubjectfound;         
   self.addronfilecount                  	:=	addronfilecount;                  
   self.subjectabilityprimaryfactor      	:=	subjectabilityprimaryfactor;      
   self.criminalfelonycount              	:=	criminalfelonycount;              
   self.criminalnonfelonycount           	:=	criminalnonfelonycount;           
   self.evictioncount                    	:=	evictioncount;                    
   self.lienjudgmentseverityindex        	:=	lienjudgmentseverityindex;        
   self.bankruptcydismissed24month       	:=	bankruptcydismissed24month;       
   self.bankruptcystatus                 	:=	bankruptcystatus;                 
   self.addrinputownershipindex          	:=	addrinputownershipindex;          
   self.assetprop                        	:=	assetprop;                        
   self.inquiryauto12month               	:=	inquiryauto12month;               
   self.inquirybanking12month            	:=	inquirybanking12month;            
   self.inquirytelcom12month             	:=	inquirytelcom12month;             
   self.inquirycollections12month        	:=	inquirycollections12month;        
   self.shorttermloanrequest12month      	:=	shorttermloanrequest12month;      
   self.inquiryshortterm12month          	:=	inquiryshortterm12month;          
   self.shorttermloanrequest             	:=	shorttermloanrequest;             
   self.sourcenonderogcount03month       	:=	sourcenonderogcount03month;       
   self.sourcenonderogcount              	:=	sourcenonderogcount;              
   self.evictioncount12month             	:=	evictioncount12month;             
   self.criminalfelonycount12month       	:=	criminalfelonycount12month;       
   self.criminalnonfelonycount12month    	:=	criminalnonfelonycount12month;    
   self.lienjudgmentcount12month         	:=	lienjudgmentcount12month;         
   self.addrinputtaxvalue                	:=	addrinputtaxvalue;                
   self.addrinputtaxmarketvalue          	:=	addrinputtaxmarketvalue;          
   self.addrinputavmvalue                	:=	addrinputavmvalue;                
   self.addrcurrentdwelltype             	:=	addrcurrentdwelltype;             
   self.addrcurrentcountyratio           	:=	addrcurrentcountyratio;           
   self.shorttermloanrequest24month      	:=	shorttermloanrequest24month;      
   self.addrinputdwelltype               	:=	addrinputdwelltype;               
   self.addrcurrenttaxmarketvalue        	:=	addrcurrenttaxmarketvalue;        
   self.inputtaxmarket                   	:=	inputtaxmarket;                   
   self.addrcurrenttaxvalue              	:=	addrcurrenttaxvalue;              
   self.addrcurrentavmvalue              	:=	addrcurrentavmvalue;              
   self.inputavm                         	:=	inputavm;                         
   self.addrchangecount60month           	:=	addrchangecount60month;           
   self.ssnsubjectcount                  	:=	ssnsubjectcount;                  
   self.addrinputlengthofres             	:=	addrinputlengthofres;             
   self.assetpropcurrenttaxtotal         	:=	assetpropcurrenttaxtotal;         
   self.educationevidence                	:=	educationevidence;                
   self.phoneinputsubjectcount           	:=	phoneinputsubjectcount;           
   self.lienjudgmentsmallclaimscount     	:=	lienjudgmentsmallclaimscount;     
   self.businessassociationtimeoldest    	:=	businessassociationtimeoldest;    
   self.addrprevioustimeoldest           	:=	addrprevioustimeoldest;           
   self.educationinstitutionrating       	:=	educationinstitutionrating;       
   self.addrcurrentownershipindex        	:=	addrcurrentownershipindex;        
   self.bankruptcycount                  	:=	bankruptcycount;                  
   self.assetpersonalcount               	:=	assetpersonalcount;               
   self.assetpropevercount               	:=	assetpropevercount;               
   self.addrinputtimeoldest              	:=	addrinputtimeoldest;              
   self.subjectabilityindex              	:=	subjectabilityindex;              
		self.rv5_attr_unscoreable             := rv5_attr_unscoreable;
		self.iv_subjectabilityprimaryfactor   := iv_subjectabilityprimaryfactor;
		self.derog_flag                       := derog_flag;
		self.ford_rv5_attr_seg                := ford_rv5_attr_seg;
		self.inqcount                         := inqcount;
		self.m5_drg_inquiryindex              := m5_drg_inquiryindex;
		self.m5_drg_derogseverityindex        := m5_drg_derogseverityindex;
		self.m5_drg_nonderogindex03month      := m5_drg_nonderogindex03month;
		self.m5_drg_derogrecentseverityindex  := m5_drg_derogrecentseverityindex;
		self.m5_own_inquiryindex              := m5_own_inquiryindex;
		self.m5_own_nonderogindex03month      := m5_own_nonderogindex03month;
		self.iv_inputpropvaluemax             := iv_inputpropvaluemax;
		self.currenttaxmarket                 := currenttaxmarket;
		self.iv_inputcurrtaxmarketvaluesfdmax := iv_inputcurrtaxmarketvaluesfdmax;
		self.iv_currentcountyratiosfd         := iv_currentcountyratiosfd;
		self.inq_count                        := inq_count;
		self.m5_oth_inquiryindex              := m5_oth_inquiryindex;
		self.m5_oth_nonderogindex03month      := m5_oth_nonderogindex03month;
		self.currentavm                       := currentavm;
		self.iv_inputcurravmvaluesfdmax       := iv_inputcurravmvaluesfdmax;
		self.all_drg_subscore0                := all_drg_subscore0;
		self.all_drg_subscore1                := all_drg_subscore1;
		self.all_drg_subscore2                := all_drg_subscore2;
		self.all_drg_subscore3                := all_drg_subscore3;
		self.all_drg_subscore4                := all_drg_subscore4;
		self.all_drg_subscore5                := all_drg_subscore5;
		self.all_drg_subscore6                := all_drg_subscore6;
		self.all_drg_subscore7                := all_drg_subscore7;
		self.all_drg_subscore8                := all_drg_subscore8;
		self.all_drg_subscore9                := all_drg_subscore9;
		self.all_drg_subscore10               := all_drg_subscore10;
		self.all_drg_subscore11               := all_drg_subscore11;
		self.all_drg_subscore12               := all_drg_subscore12;
		self.all_drg_subscore13               := all_drg_subscore13;
		self.all_drg_subscore14               := all_drg_subscore14;
		self.all_drg_subscore15               := all_drg_subscore15;
		self.all_drg_rawscore                 := all_drg_rawscore;
		self.all_drg_lnoddsscore              := all_drg_lnoddsscore;
		self.all_drg_probscore                := all_drg_probscore;
		self.all_own_subscore0                := all_own_subscore0;
		self.all_own_subscore1                := all_own_subscore1;
		self.all_own_subscore2                := all_own_subscore2;
		self.all_own_subscore3                := all_own_subscore3;
		self.all_own_subscore4                := all_own_subscore4;
		self.all_own_subscore5                := all_own_subscore5;
		self.all_own_subscore6                := all_own_subscore6;
		self.all_own_subscore7                := all_own_subscore7;
		self.all_own_subscore8                := all_own_subscore8;
		self.all_own_subscore9                := all_own_subscore9;
		self.all_own_subscore10               := all_own_subscore10;
		self.all_own_subscore11               := all_own_subscore11;
		self.all_own_subscore12               := all_own_subscore12;
		self.all_own_subscore13               := all_own_subscore13;
		self.all_own_subscore14               := all_own_subscore14;
		self.all_own_subscore15               := all_own_subscore15;
		self.all_own_subscore16               := all_own_subscore16;
		self.all_own_rawscore                 := all_own_rawscore;
		self.all_own_lnoddsscore              := all_own_lnoddsscore;
		self.all_own_probscore                := all_own_probscore;
		self.all_oth_subscore0                := all_oth_subscore0;
		self.all_oth_subscore1                := all_oth_subscore1;
		self.all_oth_subscore2                := all_oth_subscore2;
		self.all_oth_subscore3                := all_oth_subscore3;
		self.all_oth_subscore4                := all_oth_subscore4;
		self.all_oth_subscore5                := all_oth_subscore5;
		self.all_oth_subscore6                := all_oth_subscore6;
		self.all_oth_subscore7                := all_oth_subscore7;
		self.all_oth_subscore8                := all_oth_subscore8;
		self.all_oth_subscore9                := all_oth_subscore9;
		self.all_oth_subscore10               := all_oth_subscore10;
		self.all_oth_subscore11               := all_oth_subscore11;
		self.all_oth_subscore12               := all_oth_subscore12;
		self.all_oth_rawscore                 := all_oth_rawscore;
		self.all_oth_lnoddsscore              := all_oth_lnoddsscore;
		self.all_oth_probscore                := all_oth_probscore;
		self.base                             := base;
		self.pdo                              := pdo;
		self.odds                             := odds;
		self.rva1611_2_0                      := rva1611_2_0;
		self.all_drg_dist_seg_0               := all_drg_dist_seg_0;
		self.all_drg_aacd_0                   := all_drg_aacd_0;
		self.all_drg_dist_0                   := all_drg_dist_0;
		self.all_drg_aacd_1                   := all_drg_aacd_1;
		self.all_drg_dist_1                   := all_drg_dist_1;
		self.all_drg_aacd_2                   := all_drg_aacd_2;
		self.all_drg_dist_2                   := all_drg_dist_2;
		self.all_drg_aacd_3                   := all_drg_aacd_3;
		self.all_drg_dist_3                   := all_drg_dist_3;
		self.all_drg_aacd_4                   := all_drg_aacd_4;
		self.all_drg_dist_4                   := all_drg_dist_4;
		self.all_drg_aacd_5                   := all_drg_aacd_5;
		self.all_drg_dist_5                   := all_drg_dist_5;
		self.all_drg_aacd_6                   := all_drg_aacd_6;
		self.all_drg_dist_6                   := all_drg_dist_6;
		self.all_drg_aacd_7                   := all_drg_aacd_7;
		self.all_drg_dist_7                   := all_drg_dist_7;
		self.all_drg_aacd_8                   := all_drg_aacd_8;
		self.all_drg_dist_8                   := all_drg_dist_8;
		self.all_drg_aacd_9                   := all_drg_aacd_9;
		self.all_drg_dist_9                   := all_drg_dist_9;
		self.all_drg_aacd_10                  := all_drg_aacd_10;
		self.all_drg_dist_10                  := all_drg_dist_10;
		self.all_drg_aacd_11                  := all_drg_aacd_11;
		self.all_drg_dist_11                  := all_drg_dist_11;
		self.all_drg_aacd_12                  := all_drg_aacd_12;
		self.all_drg_dist_12                  := all_drg_dist_12;
		self.all_drg_aacd_13                  := all_drg_aacd_13;
		self.all_drg_dist_13                  := all_drg_dist_13;
		self.all_drg_aacd_14                  := all_drg_aacd_14;
		self.all_drg_dist_14                  := all_drg_dist_14;
		self.all_drg_aacd_15                  := all_drg_aacd_15;
		self.all_drg_dist_15                  := all_drg_dist_15;
		self.all_drg_rcvaluep89               := all_drg_rcvaluep89;
		self.all_drg_rcvaluec21               := all_drg_rcvaluec21;
		self.all_drg_rcvaluel80               := all_drg_rcvaluel80;
		self.all_drg_rcvalued34               := all_drg_rcvalued34;
		self.all_drg_rcvalued32               := all_drg_rcvalued32;
		self.all_drg_rcvaluel77               := all_drg_rcvaluel77;
		self.all_drg_rcvalued30               := all_drg_rcvalued30;
		self.all_drg_rcvalued31               := all_drg_rcvalued31;
		self.all_drg_rcvaluea46               := all_drg_rcvaluea46;
		self.all_drg_rcvaluec13               := all_drg_rcvaluec13;
		self.all_drg_rcvaluei60               := all_drg_rcvaluei60;
		self.all_drg_rcvaluep85               := all_drg_rcvaluep85;
		self.all_drg_rcvalues66               := all_drg_rcvalues66;
		self.all_drg_rcvaluec12               := all_drg_rcvaluec12;
		self.all_drg_rcvaluea47               := all_drg_rcvaluea47;
		self.all_drg_rcvalues65               := all_drg_rcvalues65;
		self.all_drg_rcvaluee57               := all_drg_rcvaluee57;
		self.all_drg_rcvaluec14               := all_drg_rcvaluec14;
		self.all_own_aacd_0                   := all_own_aacd_0;
		self.all_own_dist_0                   := all_own_dist_0;
		self.all_own_aacd_1                   := all_own_aacd_1;
		self.all_own_dist_1                   := all_own_dist_1;
		self.all_own_aacd_2                   := all_own_aacd_2;
		self.all_own_dist_2                   := all_own_dist_2;
		self.all_own_aacd_3                   := all_own_aacd_3;
		self.all_own_dist_3                   := all_own_dist_3;
		self.all_own_aacd_4                   := all_own_aacd_4;
		self.all_own_dist_4                   := all_own_dist_4;
		self.all_own_aacd_5                   := all_own_aacd_5;
		self.all_own_dist_5                   := all_own_dist_5;
		self.all_own_aacd_6                   := all_own_aacd_6;
		self.all_own_dist_6                   := all_own_dist_6;
		self.all_own_aacd_7                   := all_own_aacd_7;
		self.all_own_dist_7                   := all_own_dist_7;
		self.all_own_aacd_8                   := all_own_aacd_8;
		self.all_own_dist_8                   := all_own_dist_8;
		self.all_own_aacd_9                   := all_own_aacd_9;
		self.all_own_dist_9                   := all_own_dist_9;
		self.all_own_aacd_10                  := all_own_aacd_10;
		self.all_own_dist_10                  := all_own_dist_10;
		self.all_own_aacd_11                  := all_own_aacd_11;
		self.all_own_dist_11                  := all_own_dist_11;
		self.all_own_aacd_12                  := all_own_aacd_12;
		self.all_own_dist_12                  := all_own_dist_12;
		self.all_own_aacd_13                  := all_own_aacd_13;
		self.all_own_dist_13                  := all_own_dist_13;
		self.all_own_aacd_14                  := all_own_aacd_14;
		self.all_own_dist_14                  := all_own_dist_14;
		self.all_own_aacd_15                  := all_own_aacd_15;
		self.all_own_dist_15                  := all_own_dist_15;
		self.all_own_aacd_16                  := all_own_aacd_16;
		self.all_own_dist_16                  := all_own_dist_16;
		self.all_own_rcvaluea42               := all_own_rcvaluea42;
		self.all_own_rcvaluep89               := all_own_rcvaluep89;
		self.all_own_rcvaluec21               := all_own_rcvaluec21;
		self.all_own_rcvaluel80               := all_own_rcvaluel80;
		self.all_own_rcvaluec13               := all_own_rcvaluec13;
		self.all_own_rcvaluel77               := all_own_rcvaluel77;
		self.all_own_rcvaluep85               := all_own_rcvaluep85;
		self.all_own_rcvalued31               := all_own_rcvalued31;
		self.all_own_rcvaluea46               := all_own_rcvaluea46;
		self.all_own_rcvaluea47               := all_own_rcvaluea47;
		self.all_own_rcvaluea45               := all_own_rcvaluea45;
		self.all_own_rcvaluei60               := all_own_rcvaluei60;
		self.all_own_rcvaluei61               := all_own_rcvaluei61;
		self.all_own_rcvalues66               := all_own_rcvalues66;
		self.all_own_rcvaluec12               := all_own_rcvaluec12;
		self.all_own_rcvaluee57               := all_own_rcvaluee57;
		self.all_own_rcvalues65               := all_own_rcvalues65;
		self.all_own_rcvaluec14               := all_own_rcvaluec14;
		self.all_oth_dist_seg_0               := all_oth_dist_seg_0;
		self.all_oth_aacd_0                   := all_oth_aacd_0;
		self.all_oth_dist_0                   := all_oth_dist_0;
		self.all_oth_aacd_1                   := all_oth_aacd_1;
		self.all_oth_dist_1                   := all_oth_dist_1;
		self.all_oth_aacd_2                   := all_oth_aacd_2;
		self.all_oth_dist_2                   := all_oth_dist_2;
		self.all_oth_aacd_3                   := all_oth_aacd_3;
		self.all_oth_dist_3                   := all_oth_dist_3;
		self.all_oth_aacd_4                   := all_oth_aacd_4;
		self.all_oth_dist_4                   := all_oth_dist_4;
		self.all_oth_aacd_5                   := all_oth_aacd_5;
		self.all_oth_dist_5                   := all_oth_dist_5;
		self.all_oth_aacd_6                   := all_oth_aacd_6;
		self.all_oth_dist_6                   := all_oth_dist_6;
		self.all_oth_aacd_7                   := all_oth_aacd_7;
		self.all_oth_dist_7                   := all_oth_dist_7;
		self.all_oth_aacd_8                   := all_oth_aacd_8;
		self.all_oth_dist_8                   := all_oth_dist_8;
		self.all_oth_aacd_9                   := all_oth_aacd_9;
		self.all_oth_dist_9                   := all_oth_dist_9;
		self.all_oth_aacd_10                  := all_oth_aacd_10;
		self.all_oth_dist_10                  := all_oth_dist_10;
		self.all_oth_aacd_11                  := all_oth_aacd_11;
		self.all_oth_dist_11                  := all_oth_dist_11;
		self.all_oth_aacd_12                  := all_oth_aacd_12;
		self.all_oth_dist_12                  := all_oth_dist_12;
		self.all_oth_rcvaluec13               := all_oth_rcvaluec13;
		self.all_oth_rcvaluec21               := all_oth_rcvaluec21;
		self.all_oth_rcvaluep89               := all_oth_rcvaluep89;
		self.all_oth_rcvaluel81               := all_oth_rcvaluel81;
		self.all_oth_rcvaluel80               := all_oth_rcvaluel80;
		self.all_oth_rcvaluel77               := all_oth_rcvaluel77;
		self.all_oth_rcvaluep85               := all_oth_rcvaluep85;
		self.all_oth_rcvaluea47               := all_oth_rcvaluea47;
		self.all_oth_rcvaluea45               := all_oth_rcvaluea45;
		self.all_oth_rcvaluei60               := all_oth_rcvaluei60;
		self.all_oth_rcvaluei61               := all_oth_rcvaluei61;
		self.all_oth_rcvaluea41               := all_oth_rcvaluea41;
		self.all_oth_rcvalues66               := all_oth_rcvalues66;
		self.all_oth_rcvaluec12               := all_oth_rcvaluec12;
		self.all_oth_rcvaluee57               := all_oth_rcvaluee57;
		self.all_oth_rcvalues65               := all_oth_rcvalues65;
		self.all_oth_rcvaluec14               := all_oth_rcvaluec14;
		self.all_oth_rc1                      := all_oth_rc1;
		self.all_oth_rc2                      := all_oth_rc2;
		self.all_oth_rc3                      := all_oth_rc3;
		self.all_oth_rc4                      := all_oth_rc4;
		self.all_oth_vl1                      := all_oth_vl1;
		self.all_oth_vl2                      := all_oth_vl2;
		self.all_oth_vl3                      := all_oth_vl3;
		self.all_oth_vl4                      := all_oth_vl4;
		self.all_own_rc1                      := all_own_rc1;
		self.all_own_rc2                      := all_own_rc2;
		self.all_own_rc3                      := all_own_rc3;
		self.all_own_rc4                      := all_own_rc4;
		self.all_own_vl1                      := all_own_vl1;
		self.all_own_vl2                      := all_own_vl2;
		self.all_own_vl3                      := all_own_vl3;
		self.all_own_vl4                      := all_own_vl4;
		self.all_drg_rc1                      := all_drg_rc1;
		self.all_drg_rc2                      := all_drg_rc2;
		self.all_drg_rc3                      := all_drg_rc3;
		self.all_drg_rc4                      := all_drg_rc4;
		self.all_drg_vl1                      := all_drg_vl1;
		self.all_drg_vl2                      := all_drg_vl2;
		self.all_drg_vl3                      := all_drg_vl3;
		self.all_drg_vl4                      := all_drg_vl4;
		self._rc_inq                          := _rc_inq;
		self.rc1                              := rc1;
		self.rc2                              := rc2;
		self.rc3                              := rc3;
		self.rc4                              := rc4;
		self.rc5                              := rc5;
	
		self.clam 														:= rt;
	#else
		self.ri 		:= PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.score 	:= (STRING3)rva1611_2_0;
		self.seq 		:= le.seq;
	#end
	END;

	model := join(attributes, clam, left.seq=right.seq, doModel(LEFT, right));

	RETURN(model);
END;
