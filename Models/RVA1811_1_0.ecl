IMPORT ut, Std, RiskWise, Riskview, RiskWiseFCRA, Risk_Indicators;

EXPORT RVA1811_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, boolean isPrescreen) := FUNCTION

	// first run the clam through riskview attributes as this model was built from attributes
	attributes := RiskView.get_attributes_v5(clam, isPrescreen);
	
	MODEL_DEBUG := False;
	// MODEL_DEBUG := TRUE;
	
	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Input Variables */
                    unsigned	seq ;
                    integer4	sysdate; //                  sysdate;			
                    string inquiryshortterm12month;     
string inquirytelcom12month     ;   
string inquirycollections12month   ;
string inquirybanking12month   ;    
string inquiryauto12month ;         
string criminalnonfelonycount;
string criminalfelonycount;
string criminalnonfelonycount12month;
string criminalfelonycount12month;
string evictioncount12month;
string evictioncount;
string lienjudgmentcount12month;
string lienjudgmentothercount;
string lienjudgmentsmallclaimscount;
string businessassociationtimeoldest;
string businessassociationindex ;    
string businessassociation    ;      
string subjectstabilityindex;
string SubjectStabilityPrimaryFactor;
string sourcenonderogcount03month;
string assetpropcurrenttaxtotal;
string derogtimenewest;
string criminalnonfelonytimenewest;
string addronfilecount;
string addrinputlengthofres;
string addrinputmatchindex;
string addrinputavmvalue;
string addrinputavmvalue60month;
string addrprevioustimeoldest;
string addrpreviouslengthofres;
string confirmationsubjectfound ;
String ssndeceased; 
                    string   stabilityreason   ;                      //                  stabilityreason;				
                    integer   ca_inquiry_comb   ;                      //                  ca_inquiry_comb;					
                    integer   ca_derog_severity  ;                     //                  ca_derog_severity;					
                    integer   ca_business_level ;                      //                  ca_business_level;					
                    real   upd_v01_w          ;                     //                  upd_v01_w;					
                    real   upd_aa_dist_01    ;                      //                  upd_aa_dist_01;					
                    real   upd_v02_w         ;                      //                  upd_v02_w;					
                    real   upd_aa_dist_02    ;                      //                  upd_aa_dist_02;					
                    real   upd_v03_w        ;                       //                  upd_v03_w;					
                    real   upd_aa_dist_03    ;                      //                  upd_aa_dist_03;					
                    real   upd_v04_w        ;                       //                  upd_v04_w;					
                    real   upd_aa_dist_04   ;                       //                  upd_aa_dist_04;					
                    real   upd_v05_w        ;                       //                  upd_v05_w;					
                    real   upd_aa_dist_05   ;                       //                  upd_aa_dist_05;					
                    real   upd_v06_w        ;                       //                  upd_v06_w;					
                    real   upd_aa_dist_06   ;                       //                  upd_aa_dist_06;					
                    real   upd_v07_w        ;                       //                  upd_v07_w;					
                    real   upd_aa_dist_07   ;                       //                  upd_aa_dist_07;					
                    real   upd_v08_w        ;                       //                  upd_v08_w;					
                    real   upd_aa_dist_08   ;                       //                  upd_aa_dist_08;					
                    real   upd_v09_w        ;                       //                  upd_v09_w;					
                    real   upd_aa_dist_09   ;                       //                  upd_aa_dist_09;					
                    real   upd_v10_w        ;                       //                  upd_v10_w;					
                    real   upd_aa_dist_10   ;                       //                  upd_aa_dist_10;					
                    real   upd_v11_w        ;                       //                  upd_v11_w;					
                    real   upd_aa_dist_11   ;                       //                  upd_aa_dist_11;					
                    real   upd_v12_w        ;                       //                  upd_v12_w;					
                    real   upd_aa_dist_12   ;                       //                  upd_aa_dist_12;					
                    real   upd_v13_w        ;                       //                  upd_v13_w;					
                    real   upd_aa_dist_13   ;                       //                  upd_aa_dist_13;					
                    real   upd_v14_w        ;                       //                  upd_v14_w;					
                    real   upd_aa_dist_14   ;                       //                  upd_aa_dist_14;					
                    real   upd_v15_w        ;                       //                  upd_v15_w;					
                    real   upd_aa_dist_15  ;                        //                  upd_aa_dist_15;					
                    real   upd_v16_w        ;                       //                  upd_v16_w;					
                    real   upd_aa_dist_16   ;                       //                  upd_aa_dist_16;					
                    real   upd_lgt          ;                       //                  upd_lgt;					
                    Integer   base             ;                       //                  base;					
                    integer   pts              ;                       //                  pts;					
                    real   lgt               ;                      //                  lgt;					
                    integer   rva1811_1_0       ;                      //                  rva1811_1_0;					
                    string   upd_aa_code_01    ;                      //                  upd_aa_code_01;					
                    string   upd_aa_code_02   ;                       //                  upd_aa_code_02;					
                    string   upd_aa_code_03   ;                       //                  upd_aa_code_03;					
                    string   upd_aa_code_04  ;                        //                  upd_aa_code_04;					
                    string   upd_aa_code_05  ;                        //                  upd_aa_code_05;					
                    string   upd_aa_code_06   ;                       //                  upd_aa_code_06;					
                    string   upd_aa_code_07  ;                        //                  upd_aa_code_07;					
                    string   upd_aa_code_08  ;                        //                  upd_aa_code_08;					
                    string   upd_aa_code_09   ;                       //                  upd_aa_code_09;					
                    string   upd_aa_code_10   ;                       //                  upd_aa_code_10;					
                    string   upd_aa_code_11   ;                       //                  upd_aa_code_11;					
                    string   upd_aa_code_12   ;                       //                  upd_aa_code_12;					
                    string   upd_aa_code_13   ;                       //                  upd_aa_code_13;					
                    string   upd_aa_code_14   ;                       //                  upd_aa_code_14;					
                    string   upd_aa_code_15   ;                       //                  upd_aa_code_15;					
                    string   upd_aa_code_16   ;                       //                  upd_aa_code_16;					
                    real   upd_rcvaluel80   ;                       //                  upd_rcvaluel80;					
                    real   upd_rcvalued34   ;                       //                  upd_rcvalued34;					
                    real   upd_rcvalued32   ;                       //                  upd_rcvalued32;					
                    real   upd_rcvalued33   ;                       //                  upd_rcvalued33;					
                    real   upd_rcvalued30  ;                        //                  upd_rcvalued30;					
                    real   upd_rcvaluea46   ;                       //                  upd_rcvaluea46;					
                    real   upd_rcvaluei60   ;                       //                  upd_rcvaluei60;					
                    real   upd_rcvaluef03   ;                       //                  upd_rcvaluef03;					
                    real   upd_rcvaluec13   ;                       //                  upd_rcvaluec13;					
                    real   upd_rcvaluec12   ;                       //                  upd_rcvaluec12;					
                    real   upd_rcvaluec14   ;                       //                  upd_rcvaluec14;					
                    string   _rc_inq         ;                        //                  _rc_inq;					
                    string   rc5             ;                        //                  rc5;					
                    string   rc2             ;                        //                  rc2;					
                    string   rc4             ;                        //                  rc4;					
                    string   rc3             ;                        //                  rc3;					
                    string   rc1             ;                        //                  rc1;					


		Risk_Indicators.Layout_Boca_Shell clam;
	END;
			
		Layout_Debug doModel(attributes le, clam rt) := TRANSFORM
	#else
		Layout_ModelOut doModel(attributes le, clam rt) := TRANSFORM
	#end


	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	ssndeceased                      := le.ssndeceased;
	confirmationsubjectfound         := le.confirmationsubjectfound;
	addronfilecount                  := le.addronfilecount;
	criminalfelonycount              := le.criminalfelonycount;
	criminalnonfelonycount           := le.criminalnonfelonycount;
	evictioncount                    := le.evictioncount;
	inquiryauto12month               := le.inquiryauto12month;
	inquirybanking12month            := le.inquirybanking12month;
	inquirytelcom12month             := le.inquirytelcom12month;
	inquirycollections12month        := le.inquirycollections12month;
  inquiryshortterm12month          := le.inquiryshortterm12month;
	sourcenonderogcount03month       := le.sourcenonderogcount03month;
	evictioncount12month             := le.evictioncount12month;
	criminalfelonycount12month       := le.criminalfelonycount12month;
	criminalnonfelonycount12month    := le.criminalnonfelonycount12month;
	lienjudgmentcount12month         := le.lienjudgmentcount12month;
	addrinputavmvalue                := le.addrinputavmvalue;
	inputtaxmarket                   := le.addrinputtaxmarketvalue;  // updated the field name
	inputavm                         := le.AddrInputAVMValue;  // updated the field name
	addrinputlengthofres             := le.addrinputlengthofres;
	assetpropcurrenttaxtotal         := le.assetpropcurrenttaxtotal;
	lienjudgmentsmallclaimscount     := le.lienjudgmentsmallclaimscount;
	lienjudgmentothercount           := le.lienjudgmentothercount;
  businessassociationindex         := le.businessassociationindex;
  businessassociation              := le.businessassociation;
  subjectstabilityindex            := le.subjectstabilityindex;
  SubjectStabilityPrimaryFactor    := le.SubjectStabilityPrimaryFactor;
  derogtimenewest                  := le.derogtimenewest;
  criminalnonfelonytimenewest      := le.criminalnonfelonytimenewest;
  addrinputmatchindex              := le.addrinputmatchindex;
  addrinputavmvalue60month         := le.addrinputavmvalue60month;
  addrpreviouslengthofres          := le.addrpreviouslengthofres;
  businessassociationtimeoldest    := le.businessassociationtimeoldest;
	addrprevioustimeoldest           := le.addrprevioustimeoldest;
	//placeholder                      := le.placeholder;  // removed this because it is not used
	


	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

sysdate := models.common.sas_date(if(rt.historydate=999999, (STRING8)Std.Date.Today(), (string6)rt.historydate+'01'));

NULL := -999999999;


//stabilityreason := if(not(((integer)SubjectStabilityPrimaryFactor in ['-1', '0'])) and not((integer)SubjectStabilityPrimaryFactor = NULL), SubjectStabilityPrimaryFactor, NULL);
stabilityreason := if(not((SubjectStabilityPrimaryFactor in ['-1', '0'])) and not(SubjectStabilityPrimaryFactor = ''), SubjectStabilityPrimaryFactor, '');

ca_inquiry_comb := if((integer)inquiryshortterm12month = NULL or (integer)inquiryshortterm12month = -1, -1, min(7, if((integer)inquiryshortterm12month * 3 +
    (integer)inquirytelcom12month * 2 +
    (integer)inquirycollections12month * 2 +
    (integer)inquirybanking12month +
    (integer)inquiryauto12month = NULL, -NULL, (integer)inquiryshortterm12month * 3 +
    (integer)inquirytelcom12month * 2 +
   (integer) inquirycollections12month * 2 +
   (integer) inquirybanking12month +
    (integer)inquiryauto12month)));

ca_derog_severity := map(
    (integer)criminalfelonycount = NULL or (integer)criminalfelonycount = -1 => -1,
   (integer) criminalfelonycount > 1                                => 7,
   (integer) criminalnonfelonycount12month > 1                      => 6,
    (integer)criminalfelonycount12month > 0                         => 6,
    (integer)evictioncount12month > 1                               => 5,
   (integer) evictioncount12month > 0                               => 5,
   (integer) criminalnonfelonycount > 0                             => 4,
   (integer) criminalfelonycount > 0                                => 3,
   (integer) evictioncount > 0                                      => 3,
   (integer) lienjudgmentcount12month > 0                           => 2,
   (integer) lienjudgmentothercount > 0                             => 2,
   (integer) lienjudgmentsmallclaimscount > 0                       => 1,
                                                              0);

ca_business_level := map(
    (integer)businessassociation = NULL or (integer)businessassociation = -1 => -1,
    (integer)businessassociationtimeoldest > 96                     => 3,
    (integer)businessassociationindex = 3                           => 2,
    (integer)businessassociation = 1                                => 1,
                                                              0);

upd_v01_w := map(
    (integer)subjectstabilityindex = NULL => 0,
   (integer) subjectstabilityindex = -1   => 0.181837163542683,
    (integer)subjectstabilityindex <= 1.5 => 0.137526739937227,
    (integer)subjectstabilityindex <= 2.5 => 0.0260029097230483,
   (integer) subjectstabilityindex <= 3.5 => 0.00758755778021166,
   (integer) subjectstabilityindex <= 5.5 => -0.0369220479811426,
    (integer)subjectstabilityindex <= 6.5 => -0.111029091107434,
    (integer)subjectstabilityindex <= 7.5 => -0.147441713450278,
   (integer) subjectstabilityindex <= 8.5 => -0.190436443528206,
                                    -0.222409087026716);

upd_aa_code_01_1 := map(
   (integer) subjectstabilityindex = NULL => '',
   (integer) subjectstabilityindex = -1   => '',
   (integer) subjectstabilityindex <= 1.5 => (string)stabilityreason,
    (integer)subjectstabilityindex <= 2.5 => (string)stabilityreason,
   (integer) subjectstabilityindex <= 3.5 => (string)stabilityreason,
   (integer) subjectstabilityindex <= 5.5 => (string)stabilityreason,
   (integer) subjectstabilityindex <= 6.5 => (string)stabilityreason,
    (integer)subjectstabilityindex <= 7.5 => (string)stabilityreason,
   (integer) subjectstabilityindex <= 8.5 => (string)stabilityreason,
                                    '');

upd_aa_dist_01 := -0.222409087026716 - upd_v01_w;

upd_v02_w := map(
   (integer)sourcenonderogcount03month = NULL => 0,
   (integer) sourcenonderogcount03month = -1   => 0.220437728476883,
   (integer) sourcenonderogcount03month <= 1.5 => 0.0542014072440068,
    (integer)sourcenonderogcount03month <= 2.5 => -0.149495214255389,
                                         -0.384678947023875);

upd_aa_code_02_1 := map(
   (integer) sourcenonderogcount03month = NULL => '',
   (integer) sourcenonderogcount03month = -1   => '',
   (integer) sourcenonderogcount03month <= 1.5 => 'C12',
    (integer)sourcenonderogcount03month <= 2.5 => 'C12',
                                         'C12');

upd_aa_dist_02 := -0.384678947023875 - upd_v02_w;

upd_v03_w := map(
    (integer)assetpropcurrenttaxtotal = NULL      => 0,
    (integer)assetpropcurrenttaxtotal = -1        => 0.0300066747687415,
    (integer)assetpropcurrenttaxtotal <= 3405.5   => 0.0291837174028458,
    (integer)assetpropcurrenttaxtotal <= 12563    => -0.081929592058807,
    (integer)assetpropcurrenttaxtotal <= 50203    => -0.0834988170625104,
    (integer)assetpropcurrenttaxtotal <= 73953.5  => -0.152212369056141,
    (integer)assetpropcurrenttaxtotal <= 117045   => -0.23268029029733,
    (integer)assetpropcurrenttaxtotal <= 138440.5 => -0.346451535561001,
                                            -0.484039735065267);

upd_aa_code_03_1 := map(
    (integer)assetpropcurrenttaxtotal = NULL      => '',
    (integer)assetpropcurrenttaxtotal = -1        => '',
    (integer)assetpropcurrenttaxtotal <= 3405.5   => 'A46',
    (integer)assetpropcurrenttaxtotal <= 12563    => 'A46',
    (integer)assetpropcurrenttaxtotal <= 50203    => 'A46',
    (integer)assetpropcurrenttaxtotal <= 73953.5  => 'A46',
    (integer)assetpropcurrenttaxtotal <= 117045   => 'A46',
    (integer)assetpropcurrenttaxtotal <= 138440.5 => 'A46',
                                            'A46');

upd_aa_dist_03 := -0.484039735065267 - upd_v03_w;

upd_v04_w := map(
    (integer)derogtimenewest = NULL  => 0,
   (integer) derogtimenewest = -1    => -0.0267644472122111,
    (integer)derogtimenewest <= 1.5  => 0.237710211469643,
    (integer)derogtimenewest <= 9.5  => 0.140400260845869,
    (integer)derogtimenewest <= 15.5 => 0.111197052496799,
   (integer) derogtimenewest <= 18.5 => 0.0700666685090342,
    (integer)derogtimenewest <= 27.5 => 0.0546554932311541,
    (integer)derogtimenewest <= 28.5 => 0.0364824145616398,
                               0.00205570618116173);

upd_aa_code_04_1 := map(
    (integer)derogtimenewest = NULL  => '',
    (integer)derogtimenewest = -1    => '',
    (integer)derogtimenewest <= 1.5  => 'D30',
    (integer)derogtimenewest <= 9.5  => 'D30',
    (integer)derogtimenewest <= 15.5 => 'D30',
    (integer)derogtimenewest <= 18.5 => 'D30',
    (integer)derogtimenewest <= 27.5 => 'D30',
    (integer)derogtimenewest <= 28.5 => 'D30',
                               'D30');

upd_aa_dist_04 := -0.0267644472122111 - upd_v04_w;

upd_v05_w := map(
    (integer)criminalnonfelonytimenewest = NULL  => 0,
    (integer)criminalnonfelonytimenewest = -1    => -0.00824769531601609,
    (integer)criminalnonfelonytimenewest <= 21.5 => 0.232229095902652,
    (integer)criminalnonfelonytimenewest <= 54.5 => 0.137743521294841,
    (integer)criminalnonfelonytimenewest <= 62.5 => 0.120512280673604,
                                           0.0567190503797937);

upd_aa_code_05_1 := map(
   (integer)criminalnonfelonytimenewest = NULL  => '',
    (integer)criminalnonfelonytimenewest = -1    => '',
    (integer)criminalnonfelonytimenewest <= 21.5 => 'D32',
    (integer)criminalnonfelonytimenewest <= 54.5 => 'D32',
    (integer)criminalnonfelonytimenewest <= 62.5 => 'D32',
                                           'D32');

upd_aa_dist_05 := -0.00824769531601609 - upd_v05_w;

upd_v06_w := map(
    (integer)inquirytelcom12month = NULL => 0,
    (integer)inquirytelcom12month = -1   => 0.0263708329917378,
    (integer)inquirytelcom12month <= 0.5 => -0.00278552640689684,
                                   0.0401346945080611);

upd_aa_code_06_1 := map(
    (integer)inquirytelcom12month = NULL => '',
    (integer)inquirytelcom12month = -1   => '',
    (integer)inquirytelcom12month <= 0.5 => '',
                                   'I60');

upd_aa_dist_06 := -0.00278552640689684 - upd_v06_w;

upd_v07_w := map(
    (integer)addronfilecount = NULL  => 0,
    (integer)addronfilecount = -1    => 0.119864842872202,
    (integer)addronfilecount <= 1.5  => -0.0973201826835835,
    (integer)addronfilecount <= 3.5  => -0.0686179393853994,
    (integer)addronfilecount <= 4.5  => -0.0521965138474189,
    (integer)addronfilecount <= 7.5  => 0.00115098408055701,
    (integer)addronfilecount <= 8.5  => 0.0314093773014447,
    (integer)addronfilecount <= 9.5  => 0.0448651098521489,
    (integer)addronfilecount <= 11.5 => 0.0745384585787878,
    (integer)addronfilecount <= 12.5 => 0.0944939274927974,
    (integer)addronfilecount <= 14.5 => 0.151159671321548,
                               0.231423937957376);

upd_aa_code_07_1 := map(
    (integer)addronfilecount = NULL  => '',
    (integer)addronfilecount = -1    => '',
    (integer)addronfilecount <= 1.5  => '',
    (integer)addronfilecount <= 3.5  => 'C14',
    (integer)addronfilecount <= 4.5  => 'C14',
    (integer)addronfilecount <= 7.5  => 'C14',
    (integer)addronfilecount <= 8.5  => 'C14',
    (integer)addronfilecount <= 9.5  => 'C14',
    (integer)addronfilecount <= 11.5 => 'C14',
    (integer)addronfilecount <= 12.5 => 'C14',
    (integer)addronfilecount <= 14.5 => 'C14',
                               'C14');

upd_aa_dist_07 := -0.0973201826835835 - upd_v07_w;

upd_v08_w := map(
    (integer)addrinputlengthofres = NULL   => 0,
    (integer)addrinputlengthofres = -1     => 0.0613501161711894,
    (integer)addrinputlengthofres <= 3.5   => 0.0319669460903394,
    (integer)addrinputlengthofres <= 11.5  => 0.00423303142071761,
    (integer)addrinputlengthofres <= 15.5  => -0.0122737573457879,
    (integer)addrinputlengthofres <= 47.5  => -0.0215662804798392,
    (integer)addrinputlengthofres <= 62.5  => -0.0346694262118746,
    (integer)addrinputlengthofres <= 194.5 => -0.0362109150484191,
    (integer)addrinputlengthofres <= 272.5 => -0.0696339356457126,
    (integer)addrinputlengthofres <= 303.5 => -0.0844989813350547,
                                     -0.113915620421392);

upd_aa_code_08_1 := map(
    (integer)addrinputlengthofres = NULL   => '',
    (integer)addrinputlengthofres = -1     => '',
    (integer)addrinputlengthofres <= 3.5   => 'C13',
    (integer)addrinputlengthofres <= 11.5  => 'C13',
    (integer)addrinputlengthofres <= 15.5  => 'C13',
    (integer)addrinputlengthofres <= 47.5  => 'C13',
    (integer)addrinputlengthofres <= 62.5  => 'C13',
    (integer)addrinputlengthofres <= 194.5 => 'C13',
    (integer)addrinputlengthofres <= 272.5 => 'C13',
    (integer)addrinputlengthofres <= 303.5 => 'C13',
                                     '');

upd_aa_dist_08 := -0.113915620421392 - upd_v08_w;

upd_v09_w := map(
    (integer)addrinputmatchindex = NULL => 0,
    (integer)addrinputmatchindex = -1   => 0.0997864262376414,
    (integer)addrinputmatchindex <= 1.5 => 0.0695750422593124,
                                  -0.0471711600998709);

upd_aa_code_09_1 := map(
    (integer)addrinputmatchindex = NULL => '',
    (integer)addrinputmatchindex = -1   => '',
    (integer)addrinputmatchindex <= 1.5 => 'F03',
                                  '');

upd_aa_dist_09 := -0.0471711600998709 - upd_v09_w;

upd_v10_w := map(
    (integer)addrinputavmvalue = NULL      => 0,
    (integer)addrinputavmvalue = -1        => 0.0276163525558144,
    (integer)addrinputavmvalue <= 12556    => 0.330487671933958,
    (integer)addrinputavmvalue <= 14958.5  => 0.133653477242843,
    (integer)addrinputavmvalue <= 44615.5  => 0.0726759967659344,
    (integer)addrinputavmvalue <= 53361    => 0.0168749391854427,
    (integer)addrinputavmvalue <= 76401.5  => -0.0453146034292894,
    (integer)addrinputavmvalue <= 129976   => -0.0868171473081524,
    (integer)addrinputavmvalue <= 133673.5 => -0.120781680331485,
    (integer)addrinputavmvalue <= 278165.5 => -0.184484498950567,
                                     -0.203471543984613);

upd_aa_code_10_1 := map(
    (integer)addrinputavmvalue = NULL      => '',
    (integer)addrinputavmvalue = -1        => '',
    (integer)addrinputavmvalue <= 12556    => 'L80',
    (integer)addrinputavmvalue <= 14958.5  => 'L80',
    (integer)addrinputavmvalue <= 44615.5  => 'L80',
    (integer)addrinputavmvalue <= 53361    => 'L80',
    (integer)addrinputavmvalue <= 76401.5  => 'L80',
    (integer)addrinputavmvalue <= 129976   => 'L80',
    (integer)addrinputavmvalue <= 133673.5 => 'L80',
    (integer)addrinputavmvalue <= 278165.5 => 'L80',
                                     '');

upd_aa_dist_10 := -0.203471543984613 - upd_v10_w;

upd_v11_w := map(
    (integer)addrinputavmvalue60month = NULL      => 0,
    (integer)addrinputavmvalue60month = -1        => 0.0220467745768506,
    (integer)addrinputavmvalue60month <= 13649.5  => 0.35169007236109,
    (integer)addrinputavmvalue60month <= 42208    => 0.153556603353097,
    (integer)addrinputavmvalue60month <= 73516    => -0.00581708076792618,
    (integer)addrinputavmvalue60month <= 81285.5  => -0.10636797840782,
    (integer)addrinputavmvalue60month <= 171248.5 => -0.108232788461311,
    (integer)addrinputavmvalue60month <= 201140.5 => -0.200646391822753,
    (integer)addrinputavmvalue60month <= 312714   => -0.221535165514286,
                                            -0.278487203371769);

upd_aa_code_11_1 := map(
    (integer)addrinputavmvalue60month = NULL      => '',
    (integer)addrinputavmvalue60month = -1        => '',
    (integer)addrinputavmvalue60month <= 13649.5  => 'L80',
    (integer)addrinputavmvalue60month <= 42208    => 'L80',
    (integer)addrinputavmvalue60month <= 73516    => 'L80',
    (integer)addrinputavmvalue60month <= 81285.5  => 'L80',
    (integer)addrinputavmvalue60month <= 171248.5 => 'L80',
    (integer)addrinputavmvalue60month <= 201140.5 => 'L80',
    (integer)addrinputavmvalue60month <= 312714   => 'L80',
                                            '');

upd_aa_dist_11 := -0.278487203371769 - upd_v11_w;

upd_v12_w := map(
    (integer)addrprevioustimeoldest = NULL   => 0,
    (integer)addrprevioustimeoldest = -1     => -0.0506344229856914,
   (integer) addrprevioustimeoldest <= 1.5   => 0.156534494232101,
    (integer)addrprevioustimeoldest <= 9.5   => 0.105562473679782,
    (integer)addrprevioustimeoldest <= 10.5  => 0.0764571011964059,
    (integer)addrprevioustimeoldest <= 13.5  => 0.0637723868093138,
    (integer)addrprevioustimeoldest <= 27.5  => 0.0503870652721466,
    (integer)addrprevioustimeoldest <= 56.5  => 0.0369009852586179,
    (integer)addrprevioustimeoldest <= 110.5 => -0.0141149122830015,
    (integer)addrprevioustimeoldest <= 175.5 => -0.0538091784035612,
    (integer)addrprevioustimeoldest <= 189.5 => -0.083667351029038,
                                       -0.109988278684627);

upd_aa_code_12_1 := map(
    (integer)addrprevioustimeoldest = NULL   => '',
   (integer) addrprevioustimeoldest = -1     => '',
    (integer)addrprevioustimeoldest <= 1.5   => 'C13',
    (integer)addrprevioustimeoldest <= 9.5   => 'C13',
    (integer)addrprevioustimeoldest <= 10.5  => 'C13',
    (integer)addrprevioustimeoldest <= 13.5  => 'C13',
    (integer)addrprevioustimeoldest <= 27.5  => 'C13',
    (integer)addrprevioustimeoldest <= 56.5  => 'C13',
    (integer)addrprevioustimeoldest <= 110.5 => 'C13',
    (integer)addrprevioustimeoldest <= 175.5 => 'C13',
    (integer)addrprevioustimeoldest <= 189.5 => 'C13',
                                       '');

upd_aa_dist_12 := -0.109988278684627 - upd_v12_w;

upd_v13_w := map(
    (integer)addrpreviouslengthofres = NULL   => 0,
    (integer)addrpreviouslengthofres = -1     => -0.0664613084117775,
    (integer)addrpreviouslengthofres <= 12.5  => 0.0743831324247378,
    (integer)addrpreviouslengthofres <= 41.5  => 0.0148345426050152,
    (integer)addrpreviouslengthofres <= 55.5  => -0.0153800307232816,
    (integer)addrpreviouslengthofres <= 92.5  => -0.046060009578692,
    (integer)addrpreviouslengthofres <= 188.5 => -0.0611588944477988,
                                        -0.131268299959117);

upd_aa_code_13_1 := map(
    (integer)addrpreviouslengthofres = NULL   => '',
    (integer)addrpreviouslengthofres = -1     => '',
    (integer)addrpreviouslengthofres <= 12.5  => 'C13',
    (integer)addrpreviouslengthofres <= 41.5  => 'C13',
    (integer)addrpreviouslengthofres <= 55.5  => 'C13',
    (integer)addrpreviouslengthofres <= 92.5  => 'C13',
    (integer)addrpreviouslengthofres <= 188.5 => 'C13',
                                        '');

upd_aa_dist_13 := -0.131268299959117 - upd_v13_w;

upd_v14_w := map(
    ca_inquiry_comb = NULL => 0,
    ca_inquiry_comb = -1   => 0.293447229131333,
    ca_inquiry_comb <= 0.5 => -0.164272653553933,
    ca_inquiry_comb <= 1.5 => -0.0137517668381381,
    ca_inquiry_comb <= 2.5 => 0.120419378094602,
    ca_inquiry_comb <= 3.5 => 0.310846720471348,
    ca_inquiry_comb <= 4.5 => 0.425083578179523,
    ca_inquiry_comb <= 5.5 => 0.568724442066785,
                              0.770997831906808);

upd_aa_code_14_1 := map(
    ca_inquiry_comb = NULL => '',
    ca_inquiry_comb = -1   => '',
    ca_inquiry_comb <= 0.5 => '',
    ca_inquiry_comb <= 1.5 => 'I60',
    ca_inquiry_comb <= 2.5 => 'I60',
    ca_inquiry_comb <= 3.5 => 'I60',
    ca_inquiry_comb <= 4.5 => 'I60',
    ca_inquiry_comb <= 5.5 => 'I60',
                              'I60');

upd_aa_dist_14 := -0.164272653553933 - upd_v14_w;

upd_v15_w := map(
    ca_derog_severity = NULL => 0,
    ca_derog_severity = -1   => 0.170446765700309,
    ca_derog_severity <= 0.5 => -0.0424869552673436,
    ca_derog_severity <= 1.5 => -0.0224573781185902,
    ca_derog_severity <= 2.5 => 0.0396346626142914,
    ca_derog_severity <= 3.5 => 0.108928965153843,
    ca_derog_severity <= 4.5 => 0.166560525266604,
    ca_derog_severity <= 6.5 => 0.390958042890788,
                                0.549666719583504);

upd_aa_code_15_1 := map(
    ca_derog_severity = NULL => '',
    ca_derog_severity = -1   => '',
    ca_derog_severity <= 0.5 => '',
    ca_derog_severity <= 1.5 => 'D34',
    ca_derog_severity <= 2.5 => 'D34',
    ca_derog_severity <= 3.5 => 'D30',
    ca_derog_severity <= 4.5 => 'D32',
    ca_derog_severity <= 5.5 => 'D33',
    ca_derog_severity <= 6.5 => 'D32',
                                'D32');

upd_aa_dist_15 := -0.0424869552673436 - upd_v15_w;

upd_v16_w := map(
    ca_business_level = NULL => 0,
    ca_business_level = -1   => 0.162360712208683,
    ca_business_level <= 0.5 => 0.00873523867205352,
    ca_business_level <= 1.5 => -0.0958556452915454,
    ca_business_level <= 2.5 => -0.165862358144897,
                                -0.246679678282086);

upd_aa_code_16_1 := map(
    ca_business_level = NULL => '',
    ca_business_level = -1   => '',
    ca_business_level <= 0.5 => 'C12',
    ca_business_level <= 1.5 => 'C12',
    ca_business_level <= 2.5 => 'C12',
                                '');

upd_aa_dist_16 := -0.246679678282086 - upd_v16_w;

upd_lgt := -2.95436166971637 +
    upd_v01_w +
    upd_v02_w +
    upd_v03_w +
    upd_v04_w +
    upd_v05_w +
    upd_v06_w +
    upd_v07_w +
    upd_v08_w +
    upd_v09_w +
    upd_v10_w +
    upd_v11_w +
    upd_v12_w +
    upd_v13_w +
    upd_v14_w +
    upd_v15_w +
    upd_v16_w;

base := 700;

pts := -55;

lgt := ln(0.049 / (1 - 0.049));

rva1811_1_0 := map( (integer)ssndeceased = 1 => 200,
                   (integer)confirmationsubjectfound < 1 =>222, 
                   min(if(max(round(base + pts * (upd_lgt - lgt) / ln(2)), 501) = NULL, 
                  -NULL, max(round(base + pts * (upd_lgt - lgt) / ln(2)), 501)), 900));

upd_aa_code_01 := if(upd_aa_dist_01 = 0, '', upd_aa_code_01_1);

upd_aa_code_02 := if(upd_aa_dist_02 = 0, '', upd_aa_code_02_1);

upd_aa_code_03 := if(upd_aa_dist_03 = 0, '', upd_aa_code_03_1);

upd_aa_code_04 := if(upd_aa_dist_04 = 0, '', upd_aa_code_04_1);

upd_aa_code_05 := if(upd_aa_dist_05 = 0, '', upd_aa_code_05_1);

upd_aa_code_06 := if(upd_aa_dist_06 = 0, '', upd_aa_code_06_1);

upd_aa_code_07 := if(upd_aa_dist_07 = 0, '', upd_aa_code_07_1);

upd_aa_code_08 := if(upd_aa_dist_08 = 0, '', upd_aa_code_08_1);

upd_aa_code_09 := if(upd_aa_dist_09 = 0, '', upd_aa_code_09_1);

upd_aa_code_10 := if(upd_aa_dist_10 = 0, '', upd_aa_code_10_1);

upd_aa_code_11 := if(upd_aa_dist_11 = 0, '', upd_aa_code_11_1);

upd_aa_code_12 := if(upd_aa_dist_12 = 0, '', upd_aa_code_12_1);

upd_aa_code_13 := if(upd_aa_dist_13 = 0, '', upd_aa_code_13_1);

upd_aa_code_14 := if(upd_aa_dist_14 = 0, '', upd_aa_code_14_1);

upd_aa_code_15 := if(upd_aa_dist_15 = 0, '', upd_aa_code_15_1);

upd_aa_code_16 := if(upd_aa_dist_16 = 0, '', upd_aa_code_16_1);

upd_rcvaluel80 := (integer)(upd_aa_code_01 = 'L80') * upd_aa_dist_01 +
    (integer)(upd_aa_code_02 = 'L80') * upd_aa_dist_02 +
    (integer)(upd_aa_code_03 = 'L80') * upd_aa_dist_03 +
    (integer)(upd_aa_code_04 = 'L80') * upd_aa_dist_04 +
    (integer)(upd_aa_code_05 = 'L80') * upd_aa_dist_05 +
    (integer)(upd_aa_code_06 = 'L80') * upd_aa_dist_06 +
    (integer)(upd_aa_code_07 = 'L80') * upd_aa_dist_07 +
    (integer)(upd_aa_code_08 = 'L80') * upd_aa_dist_08 +
    (integer)(upd_aa_code_09 = 'L80') * upd_aa_dist_09 +
    (integer)(upd_aa_code_10 = 'L80') * upd_aa_dist_10 +
    (integer)(upd_aa_code_11 = 'L80') * upd_aa_dist_11 +
    (integer)(upd_aa_code_12 = 'L80') * upd_aa_dist_12 +
    (integer)(upd_aa_code_13 = 'L80') * upd_aa_dist_13 +
    (integer)(upd_aa_code_14 = 'L80') * upd_aa_dist_14 +
    (integer)(upd_aa_code_15 = 'L80') * upd_aa_dist_15 +
    (integer)(upd_aa_code_16 = 'L80') * upd_aa_dist_16;

upd_rcvalued34 := (integer)(upd_aa_code_01 = 'D34') * upd_aa_dist_01 +
    (integer)(upd_aa_code_02 = 'D34') * upd_aa_dist_02 +
    (integer)(upd_aa_code_03 = 'D34') * upd_aa_dist_03 +
    (integer)(upd_aa_code_04 = 'D34') * upd_aa_dist_04 +
    (integer)(upd_aa_code_05 = 'D34') * upd_aa_dist_05 +
    (integer)(upd_aa_code_06 = 'D34') * upd_aa_dist_06 +
    (integer)(upd_aa_code_07 = 'D34') * upd_aa_dist_07 +
    (integer)(upd_aa_code_08 = 'D34') * upd_aa_dist_08 +
    (integer)(upd_aa_code_09 = 'D34') * upd_aa_dist_09 +
    (integer)(upd_aa_code_10 = 'D34') * upd_aa_dist_10 +
    (integer)(upd_aa_code_11 = 'D34') * upd_aa_dist_11 +
    (integer)(upd_aa_code_12 = 'D34') * upd_aa_dist_12 +
    (integer)(upd_aa_code_13 = 'D34') * upd_aa_dist_13 +
    (integer)(upd_aa_code_14 = 'D34') * upd_aa_dist_14 +
    (integer)(upd_aa_code_15 = 'D34') * upd_aa_dist_15 +
    (integer)(upd_aa_code_16 = 'D34') * upd_aa_dist_16;

upd_rcvalued32 := (integer)(upd_aa_code_01 = 'D32') * upd_aa_dist_01 +
    (integer)(upd_aa_code_02 = 'D32') * upd_aa_dist_02 +
    (integer)(upd_aa_code_03 = 'D32') * upd_aa_dist_03 +
    (integer)(upd_aa_code_04 = 'D32') * upd_aa_dist_04 +
    (integer)(upd_aa_code_05 = 'D32') * upd_aa_dist_05 +
    (integer)(upd_aa_code_06 = 'D32') * upd_aa_dist_06 +
    (integer)(upd_aa_code_07 = 'D32') * upd_aa_dist_07 +
    (integer)(upd_aa_code_08 = 'D32') * upd_aa_dist_08 +
    (integer)(upd_aa_code_09 = 'D32') * upd_aa_dist_09 +
    (integer)(upd_aa_code_10 = 'D32') * upd_aa_dist_10 +
    (integer)(upd_aa_code_11 = 'D32') * upd_aa_dist_11 +
    (integer)(upd_aa_code_12 = 'D32') * upd_aa_dist_12 +
    (integer)(upd_aa_code_13 = 'D32') * upd_aa_dist_13 +
    (integer)(upd_aa_code_14 = 'D32') * upd_aa_dist_14 +
    (integer)(upd_aa_code_15 = 'D32') * upd_aa_dist_15 +
    (integer)(upd_aa_code_16 = 'D32') * upd_aa_dist_16;

upd_rcvalued33 := (integer)(upd_aa_code_01 = 'D33') * upd_aa_dist_01 +
    (integer)(upd_aa_code_02 = 'D33') * upd_aa_dist_02 +
    (integer)(upd_aa_code_03 = 'D33') * upd_aa_dist_03 +
    (integer)(upd_aa_code_04 = 'D33') * upd_aa_dist_04 +
    (integer)(upd_aa_code_05 = 'D33') * upd_aa_dist_05 +
    (integer)(upd_aa_code_06 = 'D33') * upd_aa_dist_06 +
    (integer)(upd_aa_code_07 = 'D33') * upd_aa_dist_07 +
    (integer)(upd_aa_code_08 = 'D33') * upd_aa_dist_08 +
    (integer)(upd_aa_code_09 = 'D33') * upd_aa_dist_09 +
    (integer)(upd_aa_code_10 = 'D33') * upd_aa_dist_10 +
    (integer)(upd_aa_code_11 = 'D33') * upd_aa_dist_11 +
    (integer)(upd_aa_code_12 = 'D33') * upd_aa_dist_12 +
    (integer)(upd_aa_code_13 = 'D33') * upd_aa_dist_13 +
    (integer)(upd_aa_code_14 = 'D33') * upd_aa_dist_14 +
    (integer)(upd_aa_code_15 = 'D33') * upd_aa_dist_15 +
    (integer)(upd_aa_code_16 = 'D33') * upd_aa_dist_16;

upd_rcvalued30 := (integer)(upd_aa_code_01 = 'D30') * upd_aa_dist_01 +
    (integer)(upd_aa_code_02 = 'D30') * upd_aa_dist_02 +
    (integer)(upd_aa_code_03 = 'D30') * upd_aa_dist_03 +
    (integer)(upd_aa_code_04 = 'D30') * upd_aa_dist_04 +
    (integer)(upd_aa_code_05 = 'D30') * upd_aa_dist_05 +
    (integer)(upd_aa_code_06 = 'D30') * upd_aa_dist_06 +
    (integer)(upd_aa_code_07 = 'D30') * upd_aa_dist_07 +
    (integer)(upd_aa_code_08 = 'D30') * upd_aa_dist_08 +
    (integer)(upd_aa_code_09 = 'D30') * upd_aa_dist_09 +
    (integer)(upd_aa_code_10 = 'D30') * upd_aa_dist_10 +
    (integer)(upd_aa_code_11 = 'D30') * upd_aa_dist_11 +
    (integer)(upd_aa_code_12 = 'D30') * upd_aa_dist_12 +
    (integer)(upd_aa_code_13 = 'D30') * upd_aa_dist_13 +
    (integer)(upd_aa_code_14 = 'D30') * upd_aa_dist_14 +
    (integer)(upd_aa_code_15 = 'D30') * upd_aa_dist_15 +
    (integer)(upd_aa_code_16 = 'D30') * upd_aa_dist_16;

upd_rcvaluea46 := (integer)(upd_aa_code_01 = 'A46') * upd_aa_dist_01 +
    (integer)(upd_aa_code_02 = 'A46') * upd_aa_dist_02 +
    (integer)(upd_aa_code_03 = 'A46') * upd_aa_dist_03 +
    (integer)(upd_aa_code_04 = 'A46') * upd_aa_dist_04 +
    (integer)(upd_aa_code_05 = 'A46') * upd_aa_dist_05 +
    (integer)(upd_aa_code_06 = 'A46') * upd_aa_dist_06 +
    (integer)(upd_aa_code_07 = 'A46') * upd_aa_dist_07 +
    (integer)(upd_aa_code_08 = 'A46') * upd_aa_dist_08 +
    (integer)(upd_aa_code_09 = 'A46') * upd_aa_dist_09 +
    (integer)(upd_aa_code_10 = 'A46') * upd_aa_dist_10 +
    (integer)(upd_aa_code_11 = 'A46') * upd_aa_dist_11 +
    (integer)(upd_aa_code_12 = 'A46') * upd_aa_dist_12 +
    (integer)(upd_aa_code_13 = 'A46') * upd_aa_dist_13 +
    (integer)(upd_aa_code_14 = 'A46') * upd_aa_dist_14 +
    (integer)(upd_aa_code_15 = 'A46') * upd_aa_dist_15 +
    (integer)(upd_aa_code_16 = 'A46') * upd_aa_dist_16;

upd_rcvaluei60 := (integer)(upd_aa_code_01 = 'I60') * upd_aa_dist_01 +
    (integer)(upd_aa_code_02 = 'I60') * upd_aa_dist_02 +
    (integer)(upd_aa_code_03 = 'I60') * upd_aa_dist_03 +
    (integer)(upd_aa_code_04 = 'I60') * upd_aa_dist_04 +
    (integer)(upd_aa_code_05 = 'I60') * upd_aa_dist_05 +
    (integer)(upd_aa_code_06 = 'I60') * upd_aa_dist_06 +
    (integer)(upd_aa_code_07 = 'I60') * upd_aa_dist_07 +
    (integer)(upd_aa_code_08 = 'I60') * upd_aa_dist_08 +
    (integer)(upd_aa_code_09 = 'I60') * upd_aa_dist_09 +
    (integer)(upd_aa_code_10 = 'I60') * upd_aa_dist_10 +
    (integer)(upd_aa_code_11 = 'I60') * upd_aa_dist_11 +
    (integer)(upd_aa_code_12 = 'I60') * upd_aa_dist_12 +
    (integer)(upd_aa_code_13 = 'I60') * upd_aa_dist_13 +
    (integer)(upd_aa_code_14 = 'I60') * upd_aa_dist_14 +
    (integer)(upd_aa_code_15 = 'I60') * upd_aa_dist_15 +
    (integer)(upd_aa_code_16 = 'I60') * upd_aa_dist_16;

upd_rcvaluef03 := (integer)(upd_aa_code_01 = 'F03') * upd_aa_dist_01 +
    (integer)(upd_aa_code_02 = 'F03') * upd_aa_dist_02 +
    (integer)(upd_aa_code_03 = 'F03') * upd_aa_dist_03 +
    (integer)(upd_aa_code_04 = 'F03') * upd_aa_dist_04 +
    (integer)(upd_aa_code_05 = 'F03') * upd_aa_dist_05 +
    (integer)(upd_aa_code_06 = 'F03') * upd_aa_dist_06 +
    (integer)(upd_aa_code_07 = 'F03') * upd_aa_dist_07 +
    (integer)(upd_aa_code_08 = 'F03') * upd_aa_dist_08 +
    (integer)(upd_aa_code_09 = 'F03') * upd_aa_dist_09 +
    (integer)(upd_aa_code_10 = 'F03') * upd_aa_dist_10 +
    (integer)(upd_aa_code_11 = 'F03') * upd_aa_dist_11 +
    (integer)(upd_aa_code_12 = 'F03') * upd_aa_dist_12 +
    (integer)(upd_aa_code_13 = 'F03') * upd_aa_dist_13 +
    (integer)(upd_aa_code_14 = 'F03') * upd_aa_dist_14 +
    (integer)(upd_aa_code_15 = 'F03') * upd_aa_dist_15 +
    (integer)(upd_aa_code_16 = 'F03') * upd_aa_dist_16;

upd_rcvaluec13 := (integer)(upd_aa_code_01 = 'C13') * upd_aa_dist_01 +
    (integer)(upd_aa_code_02 = 'C13') * upd_aa_dist_02 +
    (integer)(upd_aa_code_03 = 'C13') * upd_aa_dist_03 +
    (integer)(upd_aa_code_04 = 'C13') * upd_aa_dist_04 +
    (integer)(upd_aa_code_05 = 'C13') * upd_aa_dist_05 +
    (integer)(upd_aa_code_06 = 'C13') * upd_aa_dist_06 +
    (integer)(upd_aa_code_07 = 'C13') * upd_aa_dist_07 +
    (integer)(upd_aa_code_08 = 'C13') * upd_aa_dist_08 +
    (integer)(upd_aa_code_09 = 'C13') * upd_aa_dist_09 +
    (integer)(upd_aa_code_10 = 'C13') * upd_aa_dist_10 +
    (integer)(upd_aa_code_11 = 'C13') * upd_aa_dist_11 +
    (integer)(upd_aa_code_12 = 'C13') * upd_aa_dist_12 +
    (integer)(upd_aa_code_13 = 'C13') * upd_aa_dist_13 +
    (integer)(upd_aa_code_14 = 'C13') * upd_aa_dist_14 +
    (integer)(upd_aa_code_15 = 'C13') * upd_aa_dist_15 +
    (integer)(upd_aa_code_16 = 'C13') * upd_aa_dist_16;

upd_rcvaluec12 := (integer)(upd_aa_code_01 = 'C12') * upd_aa_dist_01 +
    (integer)(upd_aa_code_02 = 'C12') * upd_aa_dist_02 +
    (integer)(upd_aa_code_03 = 'C12') * upd_aa_dist_03 +
    (integer)(upd_aa_code_04 = 'C12') * upd_aa_dist_04 +
    (integer)(upd_aa_code_05 = 'C12') * upd_aa_dist_05 +
    (integer)(upd_aa_code_06 = 'C12') * upd_aa_dist_06 +
    (integer)(upd_aa_code_07 = 'C12') * upd_aa_dist_07 +
    (integer)(upd_aa_code_08 = 'C12') * upd_aa_dist_08 +
    (integer)(upd_aa_code_09 = 'C12') * upd_aa_dist_09 +
    (integer)(upd_aa_code_10 = 'C12') * upd_aa_dist_10 +
    (integer)(upd_aa_code_11 = 'C12') * upd_aa_dist_11 +
    (integer)(upd_aa_code_12 = 'C12') * upd_aa_dist_12 +
    (integer)(upd_aa_code_13 = 'C12') * upd_aa_dist_13 +
    (integer)(upd_aa_code_14 = 'C12') * upd_aa_dist_14 +
    (integer)(upd_aa_code_15 = 'C12') * upd_aa_dist_15 +
    (integer)(upd_aa_code_16 = 'C12') * upd_aa_dist_16;

upd_rcvaluec14 := (integer)(upd_aa_code_01 = 'C14') * upd_aa_dist_01 +
    (integer)(upd_aa_code_02 = 'C14') * upd_aa_dist_02 +
    (integer)(upd_aa_code_03 = 'C14') * upd_aa_dist_03 +
    (integer)(upd_aa_code_04 = 'C14') * upd_aa_dist_04 +
    (integer)(upd_aa_code_05 = 'C14') * upd_aa_dist_05 +
    (integer)(upd_aa_code_06 = 'C14') * upd_aa_dist_06 +
    (integer)(upd_aa_code_07 = 'C14') * upd_aa_dist_07 +
    (integer)(upd_aa_code_08 = 'C14') * upd_aa_dist_08 +
    (integer)(upd_aa_code_09 = 'C14') * upd_aa_dist_09 +
    (integer)(upd_aa_code_10 = 'C14') * upd_aa_dist_10 +
    (integer)(upd_aa_code_11 = 'C14') * upd_aa_dist_11 +
    (integer)(upd_aa_code_12 = 'C14') * upd_aa_dist_12 +
    (integer)(upd_aa_code_13 = 'C14') * upd_aa_dist_13 +
    (integer)(upd_aa_code_14 = 'C14') * upd_aa_dist_14 +
    (integer)(upd_aa_code_15 = 'C14') * upd_aa_dist_15 +
    (integer)(upd_aa_code_16 = 'C14') * upd_aa_dist_16;


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
 
//*************************************************************************************//
rc_dataset_upd_1 := DATASET([
    {'L80', upd_rcvalueL80},
    {'D34', upd_rcvalueD34},
    {'D32', upd_rcvalueD32},
    {'D33', upd_rcvalueD33},
    {'D30', upd_rcvalueD30},
    {'A46', upd_rcvalueA46},
    {'I60', upd_rcvalueI60},
    {'F03', upd_rcvalueF03},
    {'C13', upd_rcvalueC13},
    {'C12', upd_rcvalueC12},
    {'C14', upd_rcvalueC14}
    ], ds_layout)(value < 0);
    
rc_dataset_upd_2 := DATASET([
    {upd_aa_code_01,upd_aa_dist_01}
    ], ds_layout)(value < 0);


rc_dataset_upd := if (upd_aa_code_01 not in 
                  ['','L80','D34', 'D32', 'D33', 
                   'D30', 'A46', 'I60', 'F03', 
                   'C13', 'C12', 'C14'],
                  rc_dataset_upd_1 + rc_dataset_upd_2,rc_dataset_upd_1 );

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_upd_sorted := sort(rc_dataset_upd, rc_dataset_upd.value);

upd_rc1 := rc_dataset_upd_sorted[1].rc;
upd_rc2 := rc_dataset_upd_sorted[2].rc;
upd_rc3 := rc_dataset_upd_sorted[3].rc;
upd_rc4 := rc_dataset_upd_sorted[4].rc;

upd_vl1 := rc_dataset_upd_sorted[1].value;
upd_vl2 := rc_dataset_upd_sorted[2].value;
upd_vl3 := rc_dataset_upd_sorted[3].value;
upd_vl4 := rc_dataset_upd_sorted[4].value;
//*************************************************************************************//

rc1_3 := upd_rc1;

rc2_2 := upd_rc2;

rc3_2 := upd_rc3;

rc4_2 := upd_rc4;



_rc_inq := if(upd_aa_dist_06 + upd_aa_dist_14 < 0, 'I60', '');

 

rc3_c56 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc2_c56 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc5_c56 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                             _rc_inq);

rc1_c56 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc4_c56 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                             '');





// rc3_1 := if(not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc3_c56, rc3_2);

// rc2_1 := if(not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc2_c56, rc2_2);

// rc1_2 := if(not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c56, rc1_3);

// rc4_1 := if(not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc4_c56, rc4_2);

 // rc5_1 := if(not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc5_c56, '');



 rc3_1 := if( rc3_c56 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc3_c56, rc3_2);

 rc2_1 := if(rc2_c56 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc2_c56, rc2_2);

 rc1_2 := if(rc1_c56 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c56, rc1_3);

 rc4_1 := if(rc4_c56 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc4_c56, rc4_2);

 rc5_1 := if(rc5_c56 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc5_c56, '');





 rc4 := if((rva1811_1_0 in [200, 222, 900]), '', rc4_1);

 rc5 := if((rva1811_1_0 in [200, 222, 900]), '', rc5_1);

 rc1_1 := if((rva1811_1_0 in [200, 222, 900]), '', rc1_2);

 rc2 := if((rva1811_1_0 in [200, 222, 900]), '', rc2_1);

 rc3 := if((rva1811_1_0 in [200, 222, 900]), '', rc3_1);



rc1 := if(500 < rva1811_1_0 AND rva1811_1_0 < 900 and rc1_1 = '', 'C12', rc1_1);



//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVA1811_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVA1811_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVA1811_1_0 = 900 => DATASET([{'00'}], HRILayout),
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
    self.	 inquiryshortterm12month     			:=	 inquiryshortterm12month     			;
    self.	inquirytelcom12month        			:=	inquirytelcom12month        			;
    self.	inquirycollections12month   			:=	inquirycollections12month   			;
    self.	inquirybanking12month       			:=	inquirybanking12month       			;
    self.	inquiryauto12month          			:=	inquiryauto12month          			;
    self.	criminalnonfelonycount			:=	criminalnonfelonycount			;
    self.	criminalfelonycount			:=	criminalfelonycount			;
    self.	criminalnonfelonycount12month			:=	criminalnonfelonycount12month			;
    self.	criminalfelonycount12month			:=	criminalfelonycount12month			;
    self.	evictioncount12month			:=	evictioncount12month			;
    self.	evictioncount			:=	evictioncount			;
    self.	lienjudgmentcount12month			:=	lienjudgmentcount12month			;
    self.	lienjudgmentothercount			:=	lienjudgmentothercount			;
    self.	lienjudgmentsmallclaimscount			:=	lienjudgmentsmallclaimscount			;
    self.	businessassociationtimeoldest			:=	businessassociationtimeoldest			;
    self.	businessassociationindex     			:=	businessassociationindex     			;
    self.	businessassociation          			:=	businessassociation          			;
    self.	subjectstabilityindex			:=	subjectstabilityindex			;
    self.	SubjectStabilityPrimaryFactor			:=	SubjectStabilityPrimaryFactor			;
    self.	sourcenonderogcount03month			:=	sourcenonderogcount03month			;
    self.	assetpropcurrenttaxtotal			:=	assetpropcurrenttaxtotal			;
    self.	derogtimenewest			:=	derogtimenewest			;
    self.	criminalnonfelonytimenewest			:=	criminalnonfelonytimenewest			;
    self.	addronfilecount			:=	addronfilecount			;
    self.	addrinputlengthofres			:=	addrinputlengthofres			;
    self.	addrinputmatchindex			:=	addrinputmatchindex			;
    self.	addrinputavmvalue			:=	addrinputavmvalue			;
    self.	addrinputavmvalue60month			:=	addrinputavmvalue60month			;
    self.	addrprevioustimeoldest			:=	addrprevioustimeoldest			;
    self.	addrpreviouslengthofres			:=	addrpreviouslengthofres			;
    self.	confirmationsubjectfound 			:=	confirmationsubjectfound 			;
    self.ssndeceased                      := ssndeceased;
                    SELF.seq 															:= le.seq;
                    self.sysdate                          := sysdate;
                    self.stabilityreason                  := stabilityreason;
                    self.ca_inquiry_comb                  := ca_inquiry_comb;
                    self.ca_derog_severity                := ca_derog_severity;
                    self.ca_business_level                := ca_business_level;
                    self.upd_v01_w                        := upd_v01_w;
                    self.upd_aa_dist_01                   := upd_aa_dist_01;
                    self.upd_v02_w                        := upd_v02_w;
                    self.upd_aa_dist_02                   := upd_aa_dist_02;
                    self.upd_v03_w                        := upd_v03_w;
                    self.upd_aa_dist_03                   := upd_aa_dist_03;
                    self.upd_v04_w                        := upd_v04_w;
                    self.upd_aa_dist_04                   := upd_aa_dist_04;
                    self.upd_v05_w                        := upd_v05_w;
                    self.upd_aa_dist_05                   := upd_aa_dist_05;
                    self.upd_v06_w                        := upd_v06_w;
                    self.upd_aa_dist_06                   := upd_aa_dist_06;
                    self.upd_v07_w                        := upd_v07_w;
                    self.upd_aa_dist_07                   := upd_aa_dist_07;
                    self.upd_v08_w                        := upd_v08_w;
                    self.upd_aa_dist_08                   := upd_aa_dist_08;
                    self.upd_v09_w                        := upd_v09_w;
                    self.upd_aa_dist_09                   := upd_aa_dist_09;
                    self.upd_v10_w                        := upd_v10_w;
                    self.upd_aa_dist_10                   := upd_aa_dist_10;
                    self.upd_v11_w                        := upd_v11_w;
                    self.upd_aa_dist_11                   := upd_aa_dist_11;
                    self.upd_v12_w                        := upd_v12_w;
                    self.upd_aa_dist_12                   := upd_aa_dist_12;
                    self.upd_v13_w                        := upd_v13_w;
                    self.upd_aa_dist_13                   := upd_aa_dist_13;
                    self.upd_v14_w                        := upd_v14_w;
                    self.upd_aa_dist_14                   := upd_aa_dist_14;
                    self.upd_v15_w                        := upd_v15_w;
                    self.upd_aa_dist_15                   := upd_aa_dist_15;
                    self.upd_v16_w                        := upd_v16_w;
                    self.upd_aa_dist_16                   := upd_aa_dist_16;
                    self.upd_lgt                          := upd_lgt;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.rva1811_1_0                      := rva1811_1_0;
                    self.upd_aa_code_01                   := upd_aa_code_01;
                    self.upd_aa_code_02                   := upd_aa_code_02;
                    self.upd_aa_code_03                   := upd_aa_code_03;
                    self.upd_aa_code_04                   := upd_aa_code_04;
                    self.upd_aa_code_05                   := upd_aa_code_05;
                    self.upd_aa_code_06                   := upd_aa_code_06;
                    self.upd_aa_code_07                   := upd_aa_code_07;
                    self.upd_aa_code_08                   := upd_aa_code_08;
                    self.upd_aa_code_09                   := upd_aa_code_09;
                    self.upd_aa_code_10                   := upd_aa_code_10;
                    self.upd_aa_code_11                   := upd_aa_code_11;
                    self.upd_aa_code_12                   := upd_aa_code_12;
                    self.upd_aa_code_13                   := upd_aa_code_13;
                    self.upd_aa_code_14                   := upd_aa_code_14;
                    self.upd_aa_code_15                   := upd_aa_code_15;
                    self.upd_aa_code_16                   := upd_aa_code_16;
                    self.upd_rcvaluel80                   := upd_rcvaluel80;
                    self.upd_rcvalued34                   := upd_rcvalued34;
                    self.upd_rcvalued32                   := upd_rcvalued32;
                    self.upd_rcvalued33                   := upd_rcvalued33;
                    self.upd_rcvalued30                   := upd_rcvalued30;
                    self.upd_rcvaluea46                   := upd_rcvaluea46;
                    self.upd_rcvaluei60                   := upd_rcvaluei60;
                    self.upd_rcvaluef03                   := upd_rcvaluef03;
                    self.upd_rcvaluec13                   := upd_rcvaluec13;
                    self.upd_rcvaluec12                   := upd_rcvaluec12;
                    self.upd_rcvaluec14                   := upd_rcvaluec14;
                    self._rc_inq                          := _rc_inq;
                    self.rc5                              := rc5;
                    self.rc2                              := rc2;
                    self.rc4                              := rc4;
                    self.rc3                              := rc3;
                    self.rc1                              := rc1;

	
		self.clam 														:= rt;
	#else
		self.ri 		:= PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.score 	:= (STRING3)rva1811_1_0;
		self.seq 		:= le.seq;
	#end
	END;

	model := join(attributes, clam, left.seq=right.seq, doModel(LEFT, right));

	RETURN(model);
END;
