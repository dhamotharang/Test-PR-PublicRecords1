IMPORT Models, Risk_Indicators,RiskWise, STD, Business_Risk_BIP, easi,ut;



EXPORT BOFM1812_1_0 (//GROUPED DATASET(risk_indicators.Layout_Boca_Shell) clam,
                    GROUPED DATASET(Business_Risk_BIP.Layouts.Shell) busShell
                    ) := FUNCTION
num_reasons   := 4;
boolean business_only := TRUE;
clam := grouped(DATASET([],risk_indicators.Layout_Boca_Shell),seq);


businessplus_layout := record 
//risk_indicators.Layout_Boca_Shell clam;// Business only model, no clam, 
Business_Risk_BIP.Layouts.Shell busShell;

end;



	MODEL_DEBUG := FALSE;
	// MODEL_DEBUG := TRUE;

	isFCRA := False;

HRILayout := RECORD
     STRING5 HRI := '';
     END;

HRI_DS_Layout := Record
DATASET(HRILAYOUT) HRIs;
END;






	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
    
                    integer    sysdate                          ;                      // :=   sysdate;
                    integer    _ver_src_id_er_pos               ;                       // :=  _ver_src_id_er_pos;
                    string    _ver_src_id_fdate_er             ;                       // :=  _ver_src_id_fdate_er;
                    integer    _ver_src_id_fdate_er2            ;                       // :=  _ver_src_id_fdate_er2;
                    Real       mth__ver_src_id_fdate_er         ;                       // :=  mth__ver_src_id_fdate_er;
                    boolean    truebiz_ln                       ;                       // :=  truebiz_ln;
                    Real      bv_mth_ver_src_er_fs             ;                       // :=  bv_mth_ver_src_er_fs;
                    integer    bx_inq_consumer_phn_cnt          ;                       // :=  bx_inq_consumer_phn_cnt;
                    integer    bv_assoc_judg_tot                ;                       // :=  bv_assoc_judg_tot;
                    string    bx_phn_contradictory             ;                       // :=  bx_phn_contradictory;
                    integer    bx_addr_zipcode_ver              ;                       // :=  bx_addr_zipcode_ver;
                    integer    bx_inq_consumer_addr_cnt         ;                       // :=  bx_inq_consumer_addr_cnt;
                    integer    bx_addr_lot_size                 ;                       // :=  bx_addr_lot_size;
                    integer    bx_assoc_county_match_ct         ;                       // :=  bx_assoc_county_match_ct;
                    integer    bv_assoc_felony_tot              ;                       // :=  bv_assoc_felony_tot;
                    integer   bx_tin_match_consumer_address    ;                       // :=  bx_tin_match_consumer_address;
                    integer    bv_ucc_count                     ;                       // :=  bv_ucc_count;
                    boolean    source_ar                        ;                       // :=  source_ar;
                    boolean    source_ba                        ;                       // :=  source_ba;
                    boolean    source_bm                        ;                       // :=  source_bm;
                    boolean    source_c                         ;                       // :=  source_c;
                    boolean    source_cs                        ;                       // :=  source_cs;
                    boolean    source_dn                        ;                       // :=  source_dn;
                    boolean    source_ef                        ;                       // :=  source_ef;
                    boolean    source_ft                        ;                       // :=  source_ft;
                    boolean    source_i                         ;                       // :=  source_i;
                    boolean    source_ia                        ;                       // :=  source_ia;
                    boolean    source_in                        ;                       // :=  source_in;
                    boolean    source_l2                        ;                       // :=  source_l2;
                    boolean    source_p                         ;                       // :=  source_p;
                    boolean    source_ut                        ;                       // :=  source_ut;
                    boolean    source_v2                        ;                       // :=  source_v2;
                    boolean    source_wk                        ;                       // :=  source_wk;
                    integer    num_pos_sources                  ;                       // :=  num_pos_sources;
                    integer    num_neg_sources                  ;                       // :=  num_neg_sources;
                    real    bv_ver_src_derog_ratio           ;                       // :=  bv_ver_src_derog_ratio;
                    integer    bx_consumer_name                 ;                       // :=  bx_consumer_name;
                    real    onyx_v01_w                       ;                       // :=  onyx_v01_w;
                    real    onyx_v02_w                       ;                       // :=  onyx_v02_w;
                    real    onyx_v03_w                       ;                       // :=  onyx_v03_w;
                    real    onyx_v04_w                       ;                       // :=  onyx_v04_w;
                    real    onyx_v05_w                       ;                       // :=  onyx_v05_w;
                    real    onyx_v06_w                       ;                       // :=  onyx_v06_w;
                    real    onyx_v07_w                       ;                       // :=  onyx_v07_w;
                    real    onyx_v08_w                       ;                       // :=  onyx_v08_w;
                    real    onyx_v09_w                       ;                       // :=  onyx_v09_w;
                    real    onyx_v10_w                       ;                       // :=  onyx_v10_w;
                    real    onyx_v11_w                       ;                       // :=  onyx_v11_w;
                    real    onyx_v12_w                       ;                       // :=  onyx_v12_w;
                    real    onyx_v13_w                       ;                       // :=  onyx_v13_w;
                    real    onyx_lgt                         ;                       // :=  onyx_lgt;
                    integer    base                             ;                       // :=  base;
                    integer    pts                              ;                       // :=  pts;
                    real    lgt                              ;                       // :=  lgt;
                    integer    bofm1812_1_0                     ;                       // :=  bofm1812_1_0;                  
                    string4 bbfm_wc1                       ;
                    string4 bbfm_wc2                         ;
                    string4 bbfm_wc3                         ;
                    string4 bbfm_wc4 ;
                    
//Risk_Indicators.Layout_Boca_Shell clam;
Business_Risk_BIP.Layouts.OutputLayout busShell               ;

		END;
    
    
		

  layout_debug doModel (Business_Risk_BIP.Layouts.Shell le) := TRANSFORM

  #else
    models.layout_ModelOut doModel(Business_Risk_BIP.Layouts.Shell le ) := TRANSFORM
		
  #end	 
    
    
  /* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */  
  MaxSASLength := 1000;
  
   
  id_seleid                        := le.Verification.inputidmatchseleid; 
	pop_bus_name                     := le.Input.InputCheckBusName;
	pop_bus_addr                     := le.Input.InputCheckBusAddr;
	pop_bus_fein                     := le.Input.InputCheckBusFEIN;;
	pop_bus_phone                    := le.Input.InputCheckBusPhone;
	ver_src_id_count                 := le.Verification.SourceCountID;
	ver_src_id_list                  := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcelistID, MaxSASLength);
	ver_src_id_firstseen_list        := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcedatefirstseenlistID, MaxSASLength);
	ver_src_list                     := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcelist, MaxSASLength);
	addr_input_zipcode_ver           := le.Verification.AddrZipVerification;
	addr_input_lot_size              := le.Input_Characteristics.InputAddrLotSize;
	phn_input_contradictory          := le.Verification.PhoneNameMismatch;
	cons_record_match_name           := le.Business_To_Person_Link.BusAddrPersonNameOverlap;
	tin_match_cons_w_close_addr      := le.Verification.FEINPersonAddrMatch;
	assoc_count                      := le.Associates.AssociateCount;
	assoc_felony_total               := le.Associates.AssociateFelonyCount;
	assoc_judg_total                 := le.Associates.AssociateJudgmentCount;
	assoc_county_match_count         := le.Associates.AssociateCountyCount;
	ucc_count                        := le.Public_Record.ucccount;
	inq_consumer_addr                := le.Inquiry.inquiryconsumeraddress;
	inq_consumer_phone               := le.Inquiry.inquiryconsumerphone;



//***Begining of the SAS code that was converted to ECL ****//

NULL := -999999999;
sysdate      := __common__( common.sas_date(if(le.Input_Echo.historydate=999999, (string)std.date.today(), (string6)le.Input_Echo.historydate+'01')) ) ;



_ver_src_id_er_pos :=   __common__( Models.Common.findw_cpp(ver_src_id_list, 'ER' , '  ,', 'ie'));

_ver_src_id_fdate_er :=   __common__( if(_ver_src_id_er_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_er_pos), '0'));

_ver_src_id_fdate_er2 :=   __common__( common.sas_date((string)(_ver_src_id_fdate_er)));

mth__ver_src_id_fdate_er :=   __common__( if(min(sysdate, _ver_src_id_fdate_er2) = NULL, NULL, (sysdate - _ver_src_id_fdate_er2) / 30.5));

truebiz_ln :=   __common__( id_seleID != '0' and NOT(((integer)ver_src_id_count in [-1, 0])));

bv_mth_ver_src_er_fs :=   __common__( if(mth__ver_src_id_fdate_er = NULL, -1, mth__ver_src_id_fdate_er));

bx_inq_consumer_phn_cnt :=   __common__( if(not(truebiz_ln) or pop_bus_phone = '0', NULL, (integer)inq_consumer_phone));

bv_assoc_judg_tot :=   __common__( map(
    not(truebiz_ln) => NULL,
    (integer)assoc_count = 0 => -1,
                       (integer)assoc_judg_total));

bx_phn_contradictory :=   __common__( if(not(truebiz_ln) or pop_bus_phone = '0', '', (string)phn_input_contradictory));

bx_addr_zipcode_ver :=   __common__( if(not(truebiz_ln) or pop_bus_addr = '0', NULL, (integer)addr_input_zipcode_ver));

bx_inq_consumer_addr_cnt :=   __common__( if(not(truebiz_ln) or pop_bus_addr = '0', NULL, (integer)inq_consumer_addr));

bx_addr_lot_size :=   __common__( if(not(truebiz_ln) or pop_bus_addr = '0', NULL, (integer)addr_input_lot_size));

bx_assoc_county_match_ct :=   __common__( map(
    not(truebiz_ln) => NULL,
    (integer)assoc_count = 0 => -1,
                       (integer)assoc_county_match_count));

bv_assoc_felony_tot :=   __common__( map(
    not(truebiz_ln) => NULL,
    (integer)assoc_count = 0 => -1,
                       (integer)assoc_felony_total));

bx_tin_match_consumer_address :=   __common__( if(pop_bus_fein = '0', NULL, (integer)tin_match_cons_w_close_addr));

bv_ucc_count :=   __common__( if(not(truebiz_ln), NULL, (integer)ucc_count));

source_ar :=   __common__( Models.Common.findw_cpp(ver_src_list, 'AR' ,  , '') > 0 );

source_ba :=   __common__( Models.Common.findw_cpp(ver_src_list, 'BA' ,  , '') > 0 );

source_bm :=   __common__( Models.Common.findw_cpp(ver_src_list, 'BM' ,  , '') > 0 );

source_c :=   __common__( Models.Common.findw_cpp(ver_src_list, 'C' ,  , '') > 0 );

source_cs :=   __common__( Models.Common.findw_cpp(ver_src_list, 'C#' ,  , '') > 0 );

source_dn :=   __common__( Models.Common.findw_cpp(ver_src_list, 'DN' ,  , '') > 0 );

source_ef :=   __common__( Models.Common.findw_cpp(ver_src_list, 'EF' ,  , '') > 0 );

source_ft :=   __common__( Models.Common.findw_cpp(ver_src_list, 'FT' ,  , '') > 0 );

source_i :=   __common__( Models.Common.findw_cpp(ver_src_list, 'I' ,  , '') > 0 );

source_ia :=   __common__( Models.Common.findw_cpp(ver_src_list, 'IA' ,  , '') > 0 );

source_in :=   __common__( Models.Common.findw_cpp(ver_src_list, 'IN' ,  , '') > 0 );

source_l2 :=   __common__( Models.Common.findw_cpp(ver_src_list, 'L2' ,  , '') > 0 );

source_p :=   __common__( Models.Common.findw_cpp(ver_src_list, 'P' ,  , '') > 0 );

source_ut :=   __common__( Models.Common.findw_cpp(ver_src_list, 'UT' ,  , '') > 0 );

source_v2 :=   __common__( Models.Common.findw_cpp(ver_src_list, 'V2' ,  , '') > 0 );

source_wk :=   __common__( Models.Common.findw_cpp(ver_src_list, 'WK' ,  , '') > 0 );

num_pos_sources :=   __common__( if(max((integer)source_ar, (integer)source_bm, (integer)source_c, (integer)source_cs, 
                                        (integer)source_dn, (integer)source_ef, (integer)source_ft, 
                                        (integer)source_i, (integer)source_ia, (integer)source_in, 
                                        (integer)source_p, (integer)source_v2, 
                                        (integer)source_wk) = NULL, NULL, 
                                        sum((integer)source_ar, (integer)source_bm, (integer)source_c, 
                                        (integer)source_cs, (integer)source_dn, (integer)source_ef, 
                                        (integer)source_ft, (integer)source_i, (integer)source_ia, 
                                        (integer)source_in, (integer)source_p, (integer)source_v2, 
                                        (integer)source_wk)));

num_neg_sources :=   __common__( if(max((integer)source_ba, (integer)source_l2, 
                                        (integer)source_ut) = NULL, NULL, sum((integer)source_ba, 
                                        (integer)source_l2, (integer)source_ut)));

// bv_ver_src_derog_ratio :=   __common__( map(
    // not(truebiz_ln)     => NULL,
    // ver_src_list = ''   => -1,
    // if(max(num_pos_sources, num_neg_sources) = NULL, NULL, sum(if(num_pos_sources = NULL, 0, num_pos_sources), 
          // if(num_neg_sources = NULL, 0, num_neg_sources))) = 0 => -2,
    // num_neg_sources > 0   => round(num_neg_sources / if(max(num_pos_sources, num_neg_sources) = NULL, NULL, 
    // sum(if(num_pos_sources = NULL, 0, num_pos_sources), 
    // if(num_neg_sources = NULL, 0, num_neg_sources)))/.1)*.1,)1,
 
                         // 100 + num_pos_sources));

bv_ver_src_derog_ratio := __common__( map(
    not(truebiz_ln)                                                                                                                                                 => NULL,
    ver_src_list = ''                                                                                                                                             => -1,
    if(max(num_pos_sources, num_neg_sources) = NULL, NULL, 
        sum(if(num_pos_sources = NULL, 0, num_pos_sources), 
            if(num_neg_sources = NULL, 0, num_neg_sources))) = 0 => -2,
    num_neg_sources > 0  => round(((num_neg_sources / 
                                  if(max(num_pos_sources, num_neg_sources) = NULL, NULL, 
                                  sum(if(num_pos_sources = NULL, 0, num_pos_sources), 
                                      if(num_neg_sources = NULL, 0, num_neg_sources)))/.1)*.1),1),
    100 + num_pos_sources) ) ;




bx_consumer_name :=   __common__( if(pop_bus_addr = '0' or pop_bus_name = '0', NULL, (integer)cons_record_match_name));
// bx_consumer_name :=   __common__( if(pop_bus_addr = '0' or pop_bus_name = '0', NULL, cons_record_match_name));

onyx_v01_w :=    map(
    bv_mth_ver_src_er_fs = NULL => 0,
    bv_mth_ver_src_er_fs = -1   => -0.367862038622175,
    bv_mth_ver_src_er_fs <= 18  => 0.758142979400242,
    bv_mth_ver_src_er_fs <= 36  => 0.367581728347106,
    bv_mth_ver_src_er_fs <= 120 => 0.274935595764821,
    bv_mth_ver_src_er_fs <= 240 => 0.0848014241287952,
                                   -0.398356457296239);

onyx_v02_w :=    map(
    bx_inq_consumer_phn_cnt = NULL => 0,
    bx_inq_consumer_phn_cnt = -1   => 0,
    bx_inq_consumer_phn_cnt <= 0   => -0.412633324864157,
    bx_inq_consumer_phn_cnt <= 2   => -0.25821637002198,
    bx_inq_consumer_phn_cnt <= 3   => 0.33991650563676,
    bx_inq_consumer_phn_cnt <= 7   => 0.573064798739712,
                                      0.949609631571065);

onyx_v03_w :=    map(
    bv_assoc_judg_tot = NULL => 0,
    bv_assoc_judg_tot = -1   => -0.0825001917770183,
    bv_assoc_judg_tot <= 0   => -0.313649616879145,
    bv_assoc_judg_tot <= 2   => 0.21062280643896,
                                0.741918083578978);

onyx_v04_w :=    map(
    bx_phn_contradictory = '' => 0,
    (integer)bx_phn_contradictory = -1   => 0,
    (integer)bx_phn_contradictory <= 0   => 0.317716032725384,
    (integer)bx_phn_contradictory <= 3   => -0.318366192168207,
                                   -0.0780434128267627);

onyx_v05_w :=    map(
    bx_addr_zipcode_ver = NULL => 0,
    bx_addr_zipcode_ver = -1   => 0,
    bx_addr_zipcode_ver <= 0   => 0.504359129175186,
                                  0.0416849910985336);

onyx_v06_w :=    map(
    bx_inq_consumer_addr_cnt = NULL => 0,
    bx_inq_consumer_addr_cnt = -1   => 0,
    bx_inq_consumer_addr_cnt <= 0   => -0.192039112465967,
    bx_inq_consumer_addr_cnt <= 1   => -0.269694216729221,
    bx_inq_consumer_addr_cnt <= 4   => -0.240188295073157,
    bx_inq_consumer_addr_cnt <= 10  => 0.130108569268231,
                                       0.404859986618723);

onyx_v07_w :=    map(
    bx_addr_lot_size = NULL    => 0,
    bx_addr_lot_size = -1      => 0,
    bx_addr_lot_size <= 0      => 0.144062761136219,
    bx_addr_lot_size <= 25000  => -0.122756709528916,
    bx_addr_lot_size <= 100000 => -0.24505107750536,
                                  -0.420620071452692);

onyx_v08_w :=    map(
    bx_assoc_county_match_ct = NULL => 0,
    bx_assoc_county_match_ct = -1   => -0.0821324765785893,
    bx_assoc_county_match_ct <= 0   => 0.40910038271964,
    bx_assoc_county_match_ct <= 1   => -0.0654222511863639,
    bx_assoc_county_match_ct <= 2   => -0.286916796323667,
                                       -0.431478487773514);

onyx_v09_w :=    map(
    bv_assoc_felony_tot = NULL => 0,
    bv_assoc_felony_tot = -1   => -0.0850111443734944,
    bv_assoc_felony_tot <= 0   => -0.216538482163102,
                                  0.266092507844507);

onyx_v10_w :=    map(
    bx_tin_match_consumer_address = NULL => 0,
    bx_tin_match_consumer_address = -1   => 0.182785914986287,
    bx_tin_match_consumer_address <= 0   => -0.139445633422447,
                                            0.285187224111812);

onyx_v11_w :=    map(
    bv_ucc_count = NULL => 0,
    bv_ucc_count = -1   => 0,
    bv_ucc_count <= 0   => 0.0942883269639627,
    bv_ucc_count <= 1   => -0.269054108231191,
                           -0.365425052433871);

onyx_v12_w :=    map(
    bv_ver_src_derog_ratio = NULL => 0,
    bv_ver_src_derog_ratio = -1   => 0,
    bv_ver_src_derog_ratio = -2   => 0.0257155141222767,
    bv_ver_src_derog_ratio <= 0.3 => -0.0181208678515847,
    bv_ver_src_derog_ratio <= 1   => 0.467009954995916,
    bv_ver_src_derog_ratio <= 101 => 0.0276260790390463,
    bv_ver_src_derog_ratio <= 103 => -0.169234330996986,
                                     -0.439739782199986);

onyx_v13_w :=    map(
    bx_consumer_name = NULL => 0,
    bx_consumer_name = -1   => 0,
    bx_consumer_name <= 0   => 0.630535755459672,
    bx_consumer_name <= 1   => 0.338951620386374,
                               0.117536034919364);

onyx_lgt :=    -2.78889698176411 +
    onyx_v01_w +
    onyx_v02_w +
    onyx_v03_w +
    onyx_v04_w +
    onyx_v05_w +
    onyx_v06_w +
    onyx_v07_w +
    onyx_v08_w +
    onyx_v09_w +
    onyx_v10_w +
    onyx_v11_w +
    onyx_v12_w +
    onyx_v13_w ; 

base :=   __common__( 700);

pts :=   __common__( -50);

lgt :=   __common__( ln(0.04943944 / (1 - 0.04943944)));

bofm1812_1_0 :=   __common__( round(max((real)300, min(999, if(base + pts * (onyx_lgt - lgt) / ln(2) = NULL, -NULL, base + pts * (onyx_lgt - lgt) / ln(2))))));



 //*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//
 

 
 #if(MODEL_DEBUG) 

                    self.sysdate                          := sysdate;
                    self._ver_src_id_er_pos               := _ver_src_id_er_pos;
                    self._ver_src_id_fdate_er             := _ver_src_id_fdate_er;
                    self._ver_src_id_fdate_er2            := _ver_src_id_fdate_er2;
                    self.mth__ver_src_id_fdate_er         := mth__ver_src_id_fdate_er;
                    self.truebiz_ln                       := truebiz_ln;
                    self.bv_mth_ver_src_er_fs             := bv_mth_ver_src_er_fs;
                    self.bx_inq_consumer_phn_cnt          := bx_inq_consumer_phn_cnt;
                    self.bv_assoc_judg_tot                := bv_assoc_judg_tot;
                    self.bx_phn_contradictory             := bx_phn_contradictory;
                    self.bx_addr_zipcode_ver              := bx_addr_zipcode_ver;
                    self.bx_inq_consumer_addr_cnt         := bx_inq_consumer_addr_cnt;
                    self.bx_addr_lot_size                 := bx_addr_lot_size;
                    self.bx_assoc_county_match_ct         := bx_assoc_county_match_ct;
                    self.bv_assoc_felony_tot              := bv_assoc_felony_tot;
                    self.bx_tin_match_consumer_address    := bx_tin_match_consumer_address;
                    self.bv_ucc_count                     := bv_ucc_count;
                    self.source_ar                        := source_ar;
                    self.source_ba                        := source_ba;
                    self.source_bm                        := source_bm;
                    self.source_c                         := source_c;
                    self.source_cs                        := source_cs;
                    self.source_dn                        := source_dn;
                    self.source_ef                        := source_ef;
                    self.source_ft                        := source_ft;
                    self.source_i                         := source_i;
                    self.source_ia                        := source_ia;
                    self.source_in                        := source_in;
                    self.source_l2                        := source_l2;
                    self.source_p                         := source_p;
                    self.source_ut                        := source_ut;
                    self.source_v2                        := source_v2;
                    self.source_wk                        := source_wk;
                    self.num_pos_sources                  := num_pos_sources;
                    self.num_neg_sources                  := num_neg_sources;
                    self.bv_ver_src_derog_ratio           := bv_ver_src_derog_ratio;
                    self.bx_consumer_name                 := bx_consumer_name;
                    self.onyx_v01_w                       := onyx_v01_w;
                    self.onyx_v02_w                       := onyx_v02_w;
                    self.onyx_v03_w                       := onyx_v03_w;
                    self.onyx_v04_w                       := onyx_v04_w;
                    self.onyx_v05_w                       := onyx_v05_w;
                    self.onyx_v06_w                       := onyx_v06_w;
                    self.onyx_v07_w                       := onyx_v07_w;
                    self.onyx_v08_w                       := onyx_v08_w;
                    self.onyx_v09_w                       := onyx_v09_w;
                    self.onyx_v10_w                       := onyx_v10_w;
                    self.onyx_v11_w                       := onyx_v11_w;
                    self.onyx_v12_w                       := onyx_v12_w;
                    self.onyx_v13_w                       := onyx_v13_w;
                    self.onyx_lgt                         := onyx_lgt;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.bofm1812_1_0                     := bofm1812_1_0;
                    reasonCodes := Models.BB_WarningCodes(clam, Busshell , num_reasons,business_only)[1].hris;
                    self.bbfm_wc1                         := reasonCodes[1].hri;//bbfm_wc
                    self.bbfm_wc2                         := reasonCodes[2].hri;
                    self.bbfm_wc3                         := reasonCodes[3].hri;
                    self.bbfm_wc4                         := reasonCodes[4].hri;
                    self.Busshell                         := le;
                   
           
  
  #else
     
     reasonCodes := Models.BB_WarningCodes(clam, Busshell , num_reasons,business_only)[1].hris;
  
  
  	 SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
                                          
     

                                          


		SELF.score := (STRING3)BOFM1812_1_0;
		SELF.seq := le.input_echo.seq;
  
  #end   
  

      END;

  // model :=   project(busshell, doModel(left) );
   model :=   project(busshell, doModel(left) );
	
 

	return model;
  
END;
