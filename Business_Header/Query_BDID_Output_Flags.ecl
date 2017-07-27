f := Business_Header.File_Business_Header_Out;

Layout_BDID_Flags := record
f.bdid;            // Seisint Business Identifier
f.current;          // 'Y' Indicates record current within source, otherwise historical
f.gong_flag;        // 'Y' Indicates Gong record(s) present
f.yellowpages_flag; // 'Y' Indicates YellowPages record(s) present
f.corp_flag;        // 'Y' Indicates Corporate record(s) present
f.ucc_flag;         // 'Y' Indicates UCC record(s) present
f.bankruptcy_flag;  // 'Y' Indicates Bankruptcy record(s) present
f.domain_flag;      // 'Y' Indicates Whois record(s) present
f.fbn_flag;         // 'Y' Indicates FBN record(s) present
f.busreg_flag;      // 'Y' Indicates Business Registration record(s) present
f.edgar_flag;       // 'Y' Indicates SEC EDGAR filing record(s) present
f.dnb_flag;         // 'Y' Indicated Dun and Bradstreet record(s) present
f.irs_5500_flag;    // 'Y' Indicates IRS 5500 record(s) present
f.gov_phone_flag;   // 'Y' Indicates Government Phone record(s) present
f.fdic_flag;        // 'Y' Indicates FDIC record(s) present
f.ca_sales_tax_flag;// 'Y' Indicates CA_Sales_Tax record(s) present
f.sec_broker_flag;  // 'Y' Indicates SEC Broker Dealer record(s) present
f.fl_non_profit_flag;// 'Y' Indicates FL Non-Profit Corporation record(s) present
f.ms_workers_comp_flag;  // 'Y' Indicates MS Worker's Comp record(s) present
f.vickers_flag;     // 'Y' Indicates Vickers record(s) present
f.ia_sales_tax_flag;// 'Y' Indicates IA_Sales_Tax record(s) present
f.irs_non_profit_flag;// 'Y' Indicates IRS Non Profit Organization record(s) present
f.prof_lic_flag;    // 'Y' Indicates Professional License record(s) present
end;

fslim := table(f, Layout_BDID_Flags);

fdedup := dedup(fslim, bdid, all);

layout_stat := record
unsigned4 current_cnt := count(group, fdedup.current='Y');
unsigned4 gong_flag_cnt := count(group, fdedup.gong_flag='Y');
unsigned4 yellowpages_flag_cnt := count(group, fdedup.yellowpages_flag='Y');
unsigned4 corp_flag_cnt := count(group, fdedup.corp_flag='Y');
unsigned4 ucc_flag_cnt := count(group, fdedup.ucc_flag='Y');
unsigned4 bankruptcy_flag_cnt := count(group, fdedup.bankruptcy_flag='Y');
unsigned4 domain_flag_cnt := count(group, fdedup.domain_flag='Y');
unsigned4 fbn_flag_cnt := count(group, fdedup.fbn_flag='Y');
unsigned4 busreg_flag_cnt := count(group, fdedup.busreg_flag='Y');
unsigned4 edgar_flag_cnt := count(group, fdedup.edgar_flag='Y');
unsigned4 dnb_flag_cnt := count(group, fdedup.dnb_flag='Y');
unsigned4 irs_5500_flag_cnt := count(group, fdedup.irs_5500_flag='Y');
unsigned4 gov_phone_flag_cnt := count(group, fdedup.gov_phone_flag='Y');
unsigned4 fdic_flag_cnt := count(group, fdedup.fdic_flag='Y');
unsigned4 ca_sales_tax_flag_cnt := count(group, fdedup.ca_sales_tax_flag='Y');
unsigned4 sec_broker_flag_cnt := count(group, fdedup.sec_broker_flag='Y');
unsigned4 fl_non_profit_flag_cnt := count(group, fdedup.fl_non_profit_flag='Y');
unsigned4 ms_workers_comp_flag_cnt := count(group, fdedup.ms_workers_comp_flag='Y');
unsigned4 vickers_flag_cnt := count(group, fdedup.vickers_flag='Y');
unsigned4 ia_sales_tax_flag_cnt := count(group, fdedup.ia_sales_tax_flag='Y');
unsigned4 irs_non_profit_flag_cnt := count(group, fdedup.irs_non_profit_flag='Y');
unsigned4 prof_lic_flag_cnt := count(group, fdedup.prof_lic_flag='Y');
end;

fstat := table(fdedup, layout_stat, few);

output(fstat);