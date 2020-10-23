﻿IMPORT Models, Risk_Indicators, STD;

EXPORT get_FIB12010_overrides(DATASET(Risk_Indicators.Layout_Boca_Shell) clam,
                              //Assumes the base layout defined in luci generated code is always the same as Models.fib12010_0.Results.BaseLayout 
                              DATASET(Models.fib12010_0.Results.BaseLayout) FIBN12010_0 
                             ) := FUNCTION

  //same layout that should be defined in Luci generated code
  ScoreMessageLayout := RECORD
    STRING2 MessageType;
    STRING5 Code;
    STRING158 Description;
  END;


Models.fib12010_0.Results.BaseLayout doModel( clam le,  FIBN12010_0 rt ) := TRANSFORM

//ECL to SAS mapping
add_input_advo_drop       := le.advo_input_addr.drop_indicator;
add_input_advo_res_or_bus := le.advo_input_addr.residential_or_business_ind;
add_input_land_use_code   := le.address_verification.input_address_information.standardized_land_use_code;
addrpop                   := le.input_validation.address;
dobpop                    := le.input_validation.dateofbirth;
input_dob_age             := le.shell_input.age;
inputssncharflag          := le.ssn_verIFication.validation.inputsocscharflag;
LexID_deceased            := le.iid.diddeceased;
out_addr_type             := le.shell_input.addr_type;
out_z5                    := le.shell_input.z5;
rc_pwssnvalflag           := le.iid.pwsocsvalflag;
rc_decsflag               := le.iid.decsflag;
rc_dwelltype              := le.iid.dwelltype;
rc_hriskaddrflag          := le.iid.hriskaddrflag;
rc_hrisksic               := le.iid.hrisksic;
rc_pwssndobflag           := le.iid.pwsocsdobflag;
rc_ssndobflag             := le.iid.socsdobflag;
rc_ssndod                 := le.ssn_verIFication.validation.deceaseddate;
rc_ssnvalflag             := le.iid.socsvalflag;
rc_zipclass               := le.iid.zipclass;
rc_ziptypeflag            := le.iid.ziptypeflag;
ssnlength                 := le.input_validation.ssn_length;
ver_sources               := le.header_summary.ver_sources;

FirstName                 := STD.STR.ToUpperCase(le.shell_input.fname);
LastName                  := STD.STR.ToUpperCase(le.shell_input.lname);
City                      := STD.STR.ToUpperCase(le.shell_input.in_city);
Address                   := STD.STR.ToUpperCase(le.shell_input.in_streetAddress);
Zip                       := le.shell_input.in_zipCode;
HPhone                    := le.shell_input.phone10;
SSN                       := le.shell_input.ssn;

final_score_1             := rt.score;
fp3_wc1                   := rt.Messages[1].Code;
fp3_wc2                   := rt.Messages[2].Code;
fp3_wc3                   := rt.Messages[3].Code;
fp3_wc4                   := rt.Messages[4].Code;
fp3_wc5                   := rt.Messages[5].Code;
fp3_wc6                   := rt.Messages[6].Code;


//========================================================================

NULL := -99999;

BOOLEAN indexw(STRING source, STRING target, STRING delim) :=
	(source = target) OR
	(STD.STR.Find(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = STD.Str.Reverse(target) + delim);

overwrite_248 := (INTEGER)(indexw(STD.STR.ToUpperCase(TRIM(ver_sources, ALL)), 'DS', ',') OR indexw(STD.STR.ToUpperCase(TRIM(ver_sources, ALL)), 'DE', ',') OR LexID_deceased);

overwrite_232 := MAP(
    ssnlength != '9'                    => 0,
    rc_decsflag = '1' OR rc_ssndod != 0 => 1,
                                           0);

overwrite_233 := MAP(
    ~dobpop OR ssnlength != '9'                  => 0,
    rc_ssndobflag = '1' or rc_pwssndobflag = '1' => 1,
                                                    0);

overwrite_230 := MAP(
    ssnlength != '9'                                                                                     => 0,
    (rc_ssnvalflag IN ['1', '2']) OR (rc_pwssnvalflag in ['1', '3']) OR (inputssncharflag in ['1', '3']) => 1,
                                                                                                            0);

overwrite_018 := dobpop AND (INTEGER)input_dob_age < 18;

overwrite_157 := addrpop AND rc_hrisksic = '2225';

overwrite_163 := MAP(
    ~addrpop AND out_z5 = ''                                                                                                                                                                                                                                                                                          => 0,
    rc_hriskaddrflag = '1' OR rc_ziptypeflag = '1' OR STD.STR.ToUpperCase(TRIM(rc_dwelltype, LEFT, RIGHT)) = 'E' OR STD.STR.ToUpperCase(TRIM(rc_zipclass, LEFT, RIGHT)) = 'P' OR STD.STR.ToUpperCase(TRIM(out_addr_type, LEFT, RIGHT)) = 'P' OR STD.STR.ToUpperCase(TRIM((string)add_input_advo_drop, LEFT, RIGHT)) = 'C' => 1,
                                                                                                                                                                                                                                                                                                                         0);

overwrite_166 := addrpop AND (add_input_land_use_code in ['0135', '0136', '0137', '0138', '0454', '0512', '0531', '1006', '1109', '4018']);

overwrite_153 := addrpop AND (TRIM(TRIM((string)add_input_advo_res_or_bus, LEFT), LEFT, RIGHT) in ['B', 'D']);

Friv_name_check := IF(TRIM(FirstName) + ' ' + TRIM(LastName) in Models.FraudAdvisor_Constants.Friv_name_list, TRUE, FALSE);
Friv_city_check := IF(TRIM(City) in Models.FraudAdvisor_Constants.Friv_city_list, TRUE, FALSE);
Friv_address_check := IF(TRIM(Address) + ' ' + TRIM(Zip) in Models.FraudAdvisor_Constants.Friv_address_list OR Friv_city_check, TRUE, FALSE);
Friv_phone_check := IF(TRIM(HPhone) in Models.FraudAdvisor_Constants.Friv_phone_list, TRUE, FALSE);
Friv_ssn_check := IF(TRIM(SSN) in Models.FraudAdvisor_Constants.Friv_ssn_list, TRUE, FALSE);

Multi_Friv_check := Count((INTEGER)Friv_name_check + (INTEGER)Friv_address_check + (INTEGER)Friv_phone_check + (INTEGER)Friv_ssn_check) > 1;

//Fictitious Name or Address
overwrite_010 := (Friv_name_check OR Friv_address_check) AND NOT Multi_Friv_check;

//Primary phone number likely fictitious
overwrite_573 := Friv_phone_check AND NOT Multi_Friv_check;

//Suspected frivolous input
overwrite_088 := Multi_Friv_check;

//What is this doing? It's not used....
num_ows := IF(max((INTEGER)overwrite_010, (INTEGER)overwrite_573, (INTEGER)overwrite_088, overwrite_233, overwrite_230, (INTEGER)overwrite_018, (INTEGER)overwrite_157, overwrite_163, (INTEGER)overwrite_166, (INTEGER)overwrite_153) = NULL, 
              NULL, 
              SUM((INTEGER)overwrite_010, 
                  (INTEGER)overwrite_573, 
                  (INTEGER)overwrite_088, 
                  IF(overwrite_233 = NULL, 0, overwrite_233), 
                  IF(overwrite_230 = NULL, 0, overwrite_230), 
                  (INTEGER)overwrite_018, 
                  (INTEGER)overwrite_157, 
                  IF(overwrite_163 = NULL, 0, overwrite_163), 
                  (INTEGER)overwrite_166, 
                  (INTEGER)overwrite_153));

or01 := '010';

or02 := '573';

or03 := '088';

or04 := '233';

or05 := '230';

or06 := '018';

or07 := '157';

or08 := '163';

or09 := '166';

or10 := '153';

ds_layout := {STRING rc, INTEGER ind};

rc_dataset := DATASET([
    {or01,    overwrite_010},
    {or02,    overwrite_573},
    {or03,    overwrite_088},
    {or04,    overwrite_233},
    {or05,    overwrite_230},
    {or06,    overwrite_018},
    {or07,    overwrite_157},
    {or08,    overwrite_163},
    {or09,    overwrite_166},
    {or10,    overwrite_153},
    {fp3_wc1, 1},
    {fp3_wc2, 1},
    {fp3_wc3, 1},
    {fp3_wc4, 1},
    {fp3_wc5, 1},
    {fp3_wc6, 1}
    ], ds_layout)(ind = 1);

final_wc1_1 := rc_dataset[1].rc;
final_wc2_1 := rc_dataset[2].rc;
final_wc3_1 := rc_dataset[3].rc;
final_wc4_1 := rc_dataset[4].rc;
final_wc5_1 := rc_dataset[5].rc;
final_wc6_1 := rc_dataset[6].rc;

// final_score_1 is the output from the LUCI model

final_score := MAP(
    overwrite_248 = 1 => '999',
    overwrite_232 = 1 => '999',
                         final_score_1);

final_wc1 := MAP(
    overwrite_248 = 1 => '248',
    overwrite_232 = 1 => '232',
                         final_wc1_1);

final_wc2 := MAP(
    overwrite_248 = 1 => '248',
    overwrite_232 = 1 => '232',
                         final_wc2_1);

final_wc3 := MAP(
    overwrite_248 = 1 => '248',
    overwrite_232 = 1 => '232',
                         final_wc3_1);

final_wc4 := MAP(
    overwrite_248 = 1 => '248',
    overwrite_232 = 1 => '232',
                         final_wc4_1);

final_wc5 := MAP(
    overwrite_248 = 1 => '248',
    overwrite_232 = 1 => '232',
                         final_wc5_1);

final_wc6 := MAP(
    overwrite_248 = 1 => '248',
    overwrite_232 = 1 => '232',
                         final_wc6_1);


  RC1 := DATASET([{'',final_wc1,''}],ScoreMessageLayout);
  RC2 := DATASET([{'',final_wc2,''}],ScoreMessageLayout);
  RC3 := DATASET([{'',final_wc3,''}],ScoreMessageLayout);
  RC4 := DATASET([{'',final_wc4,''}],ScoreMessageLayout);
  RC5 := DATASET([{'',final_wc5,''}],ScoreMessageLayout);
  RC6 := DATASET([{'',final_wc6,''}],ScoreMessageLayout);
  
	SELF.score := (STRING)final_score;
  SELF.Messages := RC1+RC2+RC3+RC4+RC5+RC6;
  //assign all other fields from rt since we want to keep it in the luci defined layouts for now
  SELF := rt; 
	SELF := [];
END;

  model :=   JOIN(clam, FIBN12010_0,
                (STRING)LEFT.seq = RIGHT.TransactionID,
                doModel(LEFT, RIGHT), LEFT OUTER,
                ATMOST(Models.FraudAdvisor_Constants.LUCI_atmost)
                ,KEEP(1));
	
	RETURN model;

END;