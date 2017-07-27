export Layout_Profile_Score_Output := record
unsigned6 bdid;
unsigned2 score;  // BDID score
unsigned4 seq;
unsigned1 PRScore := 0;  // Profile risk score
DATASET(Business_Risk.Layout_Profile_Risk_Desc) PRReasonCodes;		
string60 best_CompanyName := '';
string60 best_addr1 := '';
string30	best_city := '';
string2	best_state := '';
string5	best_zip :='';
string4	best_zip4 := '';
string10  best_phone := '';
string9   best_fein := '';
unsigned1 busreg_flag := 0;
unsigned1 corp_flag := 0;
unsigned1 dnb_flag := 0;
unsigned1 irs5500_flag := 0;
unsigned1 st_flag := 0;
unsigned1 ucc_flag := 0;
unsigned1 yp_flag := 0;
unsigned1 tier1srcs := 0;
unsigned1 t1scr5 := 0;
unsigned1 currphn := 0;
unsigned1 currcorp := 0;
unsigned1 currbr := 0;
unsigned1 currdnb := 0;
unsigned1 currucc := 0;
unsigned1 curry := 0;
unsigned1 currt1cnt := 0;
unsigned1 currt1src4 := 0;
unsigned2 year_lj := 0;
unsigned1 lj := 0;
unsigned1 ustic := 0;
unsigned1 t1x := 0;
unsigned2 OFAC_cnt := 0;
unsigned2 cnt_B := 0;
end;