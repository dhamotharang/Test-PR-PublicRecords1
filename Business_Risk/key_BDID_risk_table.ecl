Import Data_Services, doxie, Prte2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
r := Prte2_Business_Header.BDID_risk_Table;
#ELSE
r := business_risk.BDID_risk_Table;
#END;

layout_bdid_risk_table_temp := record
unsigned6 bdid;
unsigned1 PRScore := 0;
unsigned4 PRScore_date;
string120 best_CompanyName := '';
string60 best_addr1 := '';
string60 best_addr2 := '';
string10  best_phone := '';
string9   best_fein := '';
unsigned1 busreg_flag;
unsigned1 corp_flag;
unsigned1 dnb_flag;
unsigned1 irs5500_flag;
unsigned1 st_flag;
unsigned1 ucc_flag;
unsigned1 yp_flag;
unsigned1 tier1srcs;
unsigned1 t1scr5;
unsigned1 currphn;
unsigned1 currcorp;
unsigned1 currbr;
unsigned1 currdnb;
unsigned1 currucc;
unsigned1 curry;
unsigned1 currt1cnt;
unsigned1 currt1src4;
unsigned2 year_lj;
unsigned1 lj;
unsigned1 ustic;
unsigned1 t1x;
unsigned2 OFAC_cnt := 0;
unsigned2 cnt_B;
end;

export key_BDID_risk_table := index(r,{bdid},{r},'~thor_data400::key::BDID_risk_table_'+doxie.Version_SuperKey);

