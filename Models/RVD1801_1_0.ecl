IMPORT ut, Std, RiskWise, RiskWiseFCRA, Risk_Indicators, riskview;

EXPORT rvd1801_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := False;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			Risk_Indicators.Layout_Boca_Shell clam;

			/* Model Input Variables */
			              Integer sysdate                         ; // := sysdate;
                    boolean iv_add_apt                       ; // := iv_add_apt;
                    Integer _in_dob                          ; // := _in_dob;
                    Real yr_in_dob                        ; // := yr_in_dob;
                    Integer yr_in_dob_int                    ; // := yr_in_dob_int;
                    Integer rv_comb_age                      ; // := rv_comb_age;
                    Integer rv_l80_inp_avm_autoval           ; // := rv_l80_inp_avm_autoval;
                    Integer rv_l79_adls_per_sfd_addr         ; // := rv_l79_adls_per_sfd_addr;
                    Integer rv_e55_college_ind               ; // := rv_e55_college_ind;
                    Integer rv_c13_curr_addr_lres            ; // := rv_c13_curr_addr_lres;
                    Integer rv_a41_a42_prop_owner_history    ; // := rv_a41_a42_prop_owner_history;
                    Real fcra_v01_w                       ; // := fcra_v01_w;
                    Real fcra_aa_dist_01                  ; // := fcra_aa_dist_01;
                    STRING fcra_aa_code_01                  ; // := fcra_aa_code_01;
                    Real fcra_v02_w                       ; // := fcra_v02_w;
                    Real fcra_aa_dist_02                  ; // := fcra_aa_dist_02;
                    STRING fcra_aa_code_02                  ; // := fcra_aa_code_02;
                    Real fcra_v03_w                       ; // := fcra_v03_w;
                    Real fcra_aa_dist_03                  ; // := fcra_aa_dist_03;
                    STRING fcra_aa_code_03                  ; // := fcra_aa_code_03;
                    Real fcra_v04_w                       ; // := fcra_v04_w;
                    Real fcra_aa_dist_04                  ; // := fcra_aa_dist_04;
                    STRING fcra_aa_code_04                  ; // := fcra_aa_code_04;
                    Real fcra_v05_w                       ; // := fcra_v05_w;
                    Real fcra_aa_dist_05                  ; // := fcra_aa_dist_05;
                    STRING fcra_aa_code_05                  ; // := fcra_aa_code_05;
                    Real fcra_v06_w                       ; // := fcra_v06_w;
                    Real fcra_aa_dist_06                  ; // := fcra_aa_dist_06;
                    STRING fcra_aa_code_06                  ; // := fcra_aa_code_06;
                    Real fcra_rcvaluel79                  ; // := fcra_rcvaluel79;
                    Real fcra_rcvaluel77                  ; // := fcra_rcvaluel77;
                    Real fcra_rcvaluea45                  ; // := fcra_rcvaluea45;
                    Real fcra_rcvaluea42                  ; // := fcra_rcvaluea42;
                    Real fcra_rcvaluef00                  ; // := fcra_rcvaluef00;
                    Real fcra_rcvaluec13                  ; // := fcra_rcvaluec13;
                    Real fcra_rcvaluec12                  ; // := fcra_rcvaluec12;
                    Real fcra_rcvaluec10                  ; // := fcra_rcvaluec10;
                    Real fcra_lgt                         ; // := fcra_lgt;
                    STRING r_rc1                            ; // := r_rc1;
                    STRING r_rc2                            ; // := r_rc2;
                    STRING r_rc3                            ; // := r_rc3;
                    STRING r_rc4                            ; // := r_rc4;
                    Real r_vl1                            ; // := r_vl1;
                    Real r_vl2                            ; // := r_vl2;
                    Real r_vl3                            ; // := r_vl3;
                    Real r_vl4                            ; // := r_vl4;
                    Boolean iv_rv5_deceased                  ; // := iv_rv5_deceased;
                    STRING iv_rv5_unscorable                ; // := iv_rv5_unscorable;
                    Integer base                             ; // := base;
                    Integer pts                              ; // := pts;
                    Real odds                             ; // := odds;
                    Integer rvd1801_1_0                      ; // := rvd1801_1_0;
                    STRING rc1                              ; // := rc1;
                    STRING rc5                              ; // := rc5;
                    STRING rc2                              ; // := rc2;
                    STRING rc4                              ; // := rc4;
                    STRING rc3                              ; // := rc3;

		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
		truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	ver_sources                      := le.header_summary.ver_sources;
	addrpop                          := le.input_validation.address;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_lres                    := le.lres2;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;
	inferred_age                     := le.inferred_age;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
	NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

//sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));
sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), 1, 0);

_in_dob := common.sas_date((string)(in_dob));

yr_in_dob := if(_in_dob = NULL, -1, (sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

rv_comb_age := map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL);

rv_l80_inp_avm_autoval := if(not(add_input_pop), NULL, add_input_avm_auto_val);

rv_l79_adls_per_sfd_addr := map(
    not(addrpop)   => NULL,
    iv_add_apt = 1 => -1,
                      min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

rv_e55_college_ind := map(
    not(truedid)                                                 => NULL,
    (college_file_type in ['H', 'C', 'A']) or college_attendance => 1,
                                                                    0);

rv_c13_curr_addr_lres := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));

rv_a41_a42_prop_owner_history := map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0);

fcra_v01_w := map(
    rv_comb_age = NULL  => 0,
    rv_comb_age = -1    => 0,
    rv_comb_age <= 29.5 => 0.674339243868,
    rv_comb_age <= 35.5 => 0.293744068978101,
    rv_comb_age <= 44.5 => 0.0972619622832451,
    rv_comb_age <= 52.5 => -0.268621134082597,
                           -0.286911103408092);

fcra_aa_code_01_1 := map(
    rv_comb_age = NULL  => '',
    rv_comb_age = -1    => 'C10',
    rv_comb_age <= 29.5 => 'C10',
    rv_comb_age <= 35.5 => 'C10',
    rv_comb_age <= 44.5 => 'C10',
    rv_comb_age <= 52.5 => 'C10',
                           'C10');

fcra_aa_dist_01 := -0.286911103408092 - fcra_v01_w;

fcra_aa_code_01 := if(fcra_aa_dist_01 = 0, '', fcra_aa_code_01_1);

fcra_v02_w := map(
    rv_l80_inp_avm_autoval = NULL    => 0,
    rv_l80_inp_avm_autoval = -1      => 0,
    rv_l80_inp_avm_autoval <= 519866 => -0.256817809939404,
                                        0.256731511225248);

fcra_aa_code_02_1 := map(
    rv_l80_inp_avm_autoval = NULL    => '',
    rv_l80_inp_avm_autoval = -1      => '',
    rv_l80_inp_avm_autoval <= 519866 => '',
                                        'A45');

fcra_aa_dist_02 := -0.256817809939404 - fcra_v02_w;

fcra_aa_code_02 := if(fcra_aa_dist_02 = 0, '', fcra_aa_code_02_1);

fcra_v03_w := map(
    rv_l79_adls_per_sfd_addr = NULL => 0,
    rv_l79_adls_per_sfd_addr = -1   => -0.0497549616896012,
    rv_l79_adls_per_sfd_addr <= 0.5 => 0.338840674046083,
    rv_l79_adls_per_sfd_addr <= 1.5 => 0.176518932781138,
    rv_l79_adls_per_sfd_addr <= 2.5 => -0.20780727631728,
                                       -0.213451816097116);

fcra_aa_code_03_1 := map(
    rv_l79_adls_per_sfd_addr = NULL => '',
    rv_l79_adls_per_sfd_addr = -1   => 'L77',
    rv_l79_adls_per_sfd_addr <= 0.5 => 'F00',
    rv_l79_adls_per_sfd_addr <= 1.5 => 'L79',
    rv_l79_adls_per_sfd_addr <= 2.5 => 'L79',
                                       '');

fcra_aa_dist_03 := -0.213451816097116 - fcra_v03_w;

fcra_aa_code_03 := if(fcra_aa_dist_03 = 0, '', fcra_aa_code_03_1);

fcra_v04_w := map(
    rv_e55_college_ind = NULL => 0,
    rv_e55_college_ind = -1   => 0,
    rv_e55_college_ind <= 0.5 => -0.268584699629235,
                                 0.145066529614954);

fcra_aa_code_04_1 := map(
    rv_e55_college_ind = NULL => '',
    rv_e55_college_ind = -1   => 'C12',
    rv_e55_college_ind <= 0.5 => 'C12',
                                 'C12');

fcra_aa_dist_04 := -0.268584699629235 - fcra_v04_w;

fcra_aa_code_04 := if(fcra_aa_dist_04 = 0, '', fcra_aa_code_04_1);

fcra_v05_w := map(
    rv_c13_curr_addr_lres = NULL   => 0,
    rv_c13_curr_addr_lres = -1     => 0,
    rv_c13_curr_addr_lres <= 9.5   => 0.237986404609671,
    rv_c13_curr_addr_lres <= 175.5 => 0.0266913207880361,
                                      -0.293338876786299);

fcra_aa_code_05_1 := map(
    rv_c13_curr_addr_lres = NULL   => '',
    rv_c13_curr_addr_lres = -1     => 'C13',
    rv_c13_curr_addr_lres <= 9.5   => 'C13',
    rv_c13_curr_addr_lres <= 175.5 => 'C13',
                                      'C13');

fcra_aa_dist_05 := -0.293338876786299 - fcra_v05_w;

fcra_aa_code_05 := if(fcra_aa_dist_05 = 0, '', fcra_aa_code_05_1);

fcra_v06_w := map(
    rv_a41_a42_prop_owner_history = NULL => 0,
    rv_a41_a42_prop_owner_history = -1   => 0,
    rv_a41_a42_prop_owner_history <= 0.5 => -0.278252872632274,
    rv_a41_a42_prop_owner_history <= 1   => 0.228860223827504,
                                            -0.00203785201646034);

fcra_aa_code_06_1 := map(
    rv_a41_a42_prop_owner_history = NULL => '',
    rv_a41_a42_prop_owner_history = -1   => '',
    rv_a41_a42_prop_owner_history <= 0.5 => '',
    rv_a41_a42_prop_owner_history <= 1   => 'A42',
                                            'C12');

fcra_aa_dist_06 := -0.278252872632274 - fcra_v06_w;

fcra_aa_code_06 := if(fcra_aa_dist_06 = 0, '', fcra_aa_code_06_1);

fcra_rcvaluel79 := (integer)(fcra_aa_code_01 = 'L79') * fcra_aa_dist_01 +
    (integer)(fcra_aa_code_02 = 'L79') * fcra_aa_dist_02 +
    (integer)(fcra_aa_code_03 = 'L79') * fcra_aa_dist_03 +
    (integer)(fcra_aa_code_04 = 'L79') * fcra_aa_dist_04 +
    (integer)(fcra_aa_code_05 = 'L79') * fcra_aa_dist_05 +
    (integer)(fcra_aa_code_06 = 'L79') * fcra_aa_dist_06;

fcra_rcvaluel77 := (integer)(fcra_aa_code_01 = 'L77') * fcra_aa_dist_01 +
    (integer)(fcra_aa_code_02 = 'L77') * fcra_aa_dist_02 +
    (integer)(fcra_aa_code_03 = 'L77') * fcra_aa_dist_03 +
    (integer)(fcra_aa_code_04 = 'L77') * fcra_aa_dist_04 +
    (integer)(fcra_aa_code_05 = 'L77') * fcra_aa_dist_05 +
    (integer)(fcra_aa_code_06 = 'L77') * fcra_aa_dist_06;

fcra_rcvaluea45 := (integer)(fcra_aa_code_01 = 'A45') * fcra_aa_dist_01 +
    (integer)(fcra_aa_code_02 = 'A45') * fcra_aa_dist_02 +
    (integer)(fcra_aa_code_03 = 'A45') * fcra_aa_dist_03 +
    (integer)(fcra_aa_code_04 = 'A45') * fcra_aa_dist_04 +
    (integer)(fcra_aa_code_05 = 'A45') * fcra_aa_dist_05 +
    (integer)(fcra_aa_code_06 = 'A45') * fcra_aa_dist_06;

fcra_rcvaluea42 := (integer)(fcra_aa_code_01 = 'A42') * fcra_aa_dist_01 +
    (integer)(fcra_aa_code_02 = 'A42') * fcra_aa_dist_02 +
    (integer)(fcra_aa_code_03 = 'A42') * fcra_aa_dist_03 +
    (integer)(fcra_aa_code_04 = 'A42') * fcra_aa_dist_04 +
    (integer)(fcra_aa_code_05 = 'A42') * fcra_aa_dist_05 +
    (integer)(fcra_aa_code_06 = 'A42') * fcra_aa_dist_06;

fcra_rcvaluef00 := (integer)(fcra_aa_code_01 = 'F00') * fcra_aa_dist_01 +
    (integer)(fcra_aa_code_02 = 'F00') * fcra_aa_dist_02 +
    (integer)(fcra_aa_code_03 = 'F00') * fcra_aa_dist_03 +
    (integer)(fcra_aa_code_04 = 'F00') * fcra_aa_dist_04 +
    (integer)(fcra_aa_code_05 = 'F00') * fcra_aa_dist_05 +
    (integer)(fcra_aa_code_06 = 'F00') * fcra_aa_dist_06;

fcra_rcvaluec13 := (integer)(fcra_aa_code_01 = 'C13') * fcra_aa_dist_01 +
    (integer)(fcra_aa_code_02 = 'C13') * fcra_aa_dist_02 +
    (integer)(fcra_aa_code_03 = 'C13') * fcra_aa_dist_03 +
    (integer)(fcra_aa_code_04 = 'C13') * fcra_aa_dist_04 +
    (integer)(fcra_aa_code_05 = 'C13') * fcra_aa_dist_05 +
    (integer)(fcra_aa_code_06 = 'C13') * fcra_aa_dist_06;

fcra_rcvaluec12 := (integer)(fcra_aa_code_01 = 'C12') * fcra_aa_dist_01 +
    (integer)(fcra_aa_code_02 = 'C12') * fcra_aa_dist_02 +
    (integer)(fcra_aa_code_03 = 'C12') * fcra_aa_dist_03 +
    (integer)(fcra_aa_code_04 = 'C12') * fcra_aa_dist_04 +
    (integer)(fcra_aa_code_05 = 'C12') * fcra_aa_dist_05 +
    (integer)(fcra_aa_code_06 = 'C12') * fcra_aa_dist_06;

fcra_rcvaluec10 := (integer)(fcra_aa_code_01 = 'C10') * fcra_aa_dist_01 +
    (integer)(fcra_aa_code_02 = 'C10') * fcra_aa_dist_02 +
    (integer)(fcra_aa_code_03 = 'C10') * fcra_aa_dist_03 +
    (integer)(fcra_aa_code_04 = 'C10') * fcra_aa_dist_04 +
    (integer)(fcra_aa_code_05 = 'C10') * fcra_aa_dist_05 +
    (integer)(fcra_aa_code_06 = 'C10') * fcra_aa_dist_06;

fcra_lgt := -4.1012583668945 +
    fcra_v01_w +
    fcra_v02_w +
    fcra_v03_w +
    fcra_v04_w +
    fcra_v05_w +
    fcra_v06_w;

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
 
//*************************************************************************************//
rc_dataset_r := DATASET([
    {'L79', fcra_rcvalueL79},
    {'L77', fcra_rcvalueL77},
    {'A45', fcra_rcvalueA45},
    {'A42', fcra_rcvalueA42},
    {'F00', fcra_rcvalueF00},
    {'C13', fcra_rcvalueC13},
    {'C12', fcra_rcvalueC12},
    {'C10', fcra_rcvalueC10}
    ], ds_layout) (value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_r_sorted := sort(rc_dataset_r, rc_dataset_r.value);

r_rc1 := rc_dataset_r_sorted[1].rc;
r_rc2 := rc_dataset_r_sorted[2].rc;
r_rc3 := rc_dataset_r_sorted[3].rc;
r_rc4 := rc_dataset_r_sorted[4].rc;

r_vl1 := rc_dataset_r_sorted[1].value;
r_vl2 := rc_dataset_r_sorted[2].value;
r_vl3 := rc_dataset_r_sorted[3].value;
r_vl4 := rc_dataset_r_sorted[4].value;
//*************************************************************************************//

rc1_1 := r_rc1;

rc2_1 := r_rc2;

rc3_1 := r_rc3;

rc4_1 := r_rc4;

iv_rv5_deceased := rc_decsflag = '1' or rc_ssndod != 0 or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',')  or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',');

iv_rv5_unscorable := if(riskview.constants.noscore(nas_summary,nap_summary, Add_Input_NAProp, truedid), '1', '0');


base := 700;

pts := -50;

odds := 53 / (3752 - 53);

rvd1801_1_0 := map(
    iv_rv5_deceased         => 200,
    iv_rv5_unscorable = '1' => 222,
                             min(if(max(round(pts * (fcra_lgt - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (fcra_lgt - ln(odds)) / ln(2) + base), 501)), 900));

rc3 := if((rvd1801_1_0 in [200, 222, 900]), '', rc3_1);

rc4 := if((rvd1801_1_0 in [200, 222, 900]), '', rc4_1);

rc2 := if((rvd1801_1_0 in [200, 222, 900]), '', rc2_1);

rc5 := if((rvd1801_1_0 in [200, 222, 900]), '', '');

rc1 := if((rvd1801_1_0 in [200, 222, 900]), '', rc1_1);

	//*************************************************************************************//
	//                     RiskView Version 5 - RVT1608_2 Score Overrides
	//*************************************************************************************//
	// Deceased = 200
	// Unscorable = 222
	// Score Range: 501 - 900
	//*************************************************************************************//


//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVD1801_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVD1801_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVD1801_1_0 = 900 => DATASET([{'00'}], HRILayout),
																				 			 DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI <> '');
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5);                             // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//


	#if(MODEL_DEBUG)
		/* Model Input Variables */
		                self.sysdate                          := sysdate;
                    self.iv_add_apt                       := iv_add_apt;
                    self._in_dob                          := _in_dob;
                    self.yr_in_dob                        := yr_in_dob;
                    self.yr_in_dob_int                    := yr_in_dob_int;
                    self.rv_comb_age                      := rv_comb_age;
                    self.rv_l80_inp_avm_autoval           := rv_l80_inp_avm_autoval;
                    self.rv_l79_adls_per_sfd_addr         := rv_l79_adls_per_sfd_addr;
                    self.rv_e55_college_ind               := rv_e55_college_ind;
                    self.rv_c13_curr_addr_lres            := rv_c13_curr_addr_lres;
                    self.rv_a41_a42_prop_owner_history    := rv_a41_a42_prop_owner_history;
                    self.fcra_v01_w                       := fcra_v01_w;
                    self.fcra_aa_dist_01                  := fcra_aa_dist_01;
                    self.fcra_aa_code_01                  := fcra_aa_code_01;
                    self.fcra_v02_w                       := fcra_v02_w;
                    self.fcra_aa_dist_02                  := fcra_aa_dist_02;
                    self.fcra_aa_code_02                  := fcra_aa_code_02;
                    self.fcra_v03_w                       := fcra_v03_w;
                    self.fcra_aa_dist_03                  := fcra_aa_dist_03;
                    self.fcra_aa_code_03                  := fcra_aa_code_03;
                    self.fcra_v04_w                       := fcra_v04_w;
                    self.fcra_aa_dist_04                  := fcra_aa_dist_04;
                    self.fcra_aa_code_04                  := fcra_aa_code_04;
                    self.fcra_v05_w                       := fcra_v05_w;
                    self.fcra_aa_dist_05                  := fcra_aa_dist_05;
                    self.fcra_aa_code_05                  := fcra_aa_code_05;
                    self.fcra_v06_w                       := fcra_v06_w;
                    self.fcra_aa_dist_06                  := fcra_aa_dist_06;
                    self.fcra_aa_code_06                  := fcra_aa_code_06;
                    self.fcra_rcvaluel79                  := fcra_rcvaluel79;
                    self.fcra_rcvaluel77                  := fcra_rcvaluel77;
                    self.fcra_rcvaluea45                  := fcra_rcvaluea45;
                    self.fcra_rcvaluea42                  := fcra_rcvaluea42;
                    self.fcra_rcvaluef00                  := fcra_rcvaluef00;
                    self.fcra_rcvaluec13                  := fcra_rcvaluec13;
                    self.fcra_rcvaluec12                  := fcra_rcvaluec12;
                    self.fcra_rcvaluec10                  := fcra_rcvaluec10;
                    self.fcra_lgt                         := fcra_lgt;
                    self.r_rc1                            := r_rc1;
                    self.r_rc2                            := r_rc2;
                    self.r_rc3                            := r_rc3;
                    self.r_rc4                            := r_rc4;
                    self.r_vl1                            := r_vl1;
                    self.r_vl2                            := r_vl2;
                    self.r_vl3                            := r_vl3;
                    self.r_vl4                            := r_vl4;
                    self.iv_rv5_deceased                  := iv_rv5_deceased;
                    self.iv_rv5_unscorable                := iv_rv5_unscorable;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.odds                             := odds;
                    self.rvd1801_1_0                      := rvd1801_1_0;
                    self.rc1                              := rc1;
                    self.rc5                              := rc5;
                    self.rc2                              := rc2;
                    self.rc4                              := rc4;
                    self.rc3                              := rc3;


		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvd1801_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
