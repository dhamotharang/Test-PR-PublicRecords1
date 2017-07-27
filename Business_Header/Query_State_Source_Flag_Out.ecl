BH_File := Business_Header.File_Business_Header_Out;

Layout_BH_Slim := RECORD
string2   state;
  string1   gong_flag;        // 'Y' Indicates Gong record(s) present
  string1   yellowpages_flag; // 'Y' Indicates YellowPages record(s) present
  string1   corp_flag;        // 'Y' Indicates Corporate record(s) present
  string1   ucc_flag;         // 'Y' Indicates UCC record(s) present
  string1   bankruptcy_flag;  // 'Y' Indicates Bankruptcy record(s) present
  string1   domain_flag;      // 'Y' Indicates Whois record(s) present
  string1   fbn_flag;         // 'Y' Indicates FBN record(s) present
  string1   busreg_flag;      // 'Y' Indicates Business Registration record(s) present
  string1   edgar_flag;       // 'Y' Indicates Edgar record(s) present
  string1   dnb_flag;         // 'Y' Indicated Dun and Bradstreet record(s) present
END;

Layout_BH_Slim SlimBH(Business_Header.Layout_Business_Header_Out L) := TRANSFORM
SELF := L;
END;

BH_Slim := PROJECT(BH_File, SlimBH(LEFT));

Layout_BH_Stat := RECORD
BH_Slim.state;
cnt_gong_flag := COUNT(GROUP, BH_Slim.gong_flag = 'Y');
cnt_yellowpages_flag := COUNT(GROUP, BH_Slim.yellowpages_flag = 'Y');
cnt_ucc_flag := COUNT(GROUP, BH_Slim.ucc_flag = 'Y');
cnt_bankruptcy_flag := COUNT(GROUP, BH_Slim.bankruptcy_flag = 'Y');
cnt_domain_flag := COUNT(GROUP, BH_Slim.domain_flag = 'Y');
cnt_fbn_flag := COUNT(GROUP, BH_Slim.fbn_flag = 'Y');
cnt_busreg_flag := COUNT(GROUP, BH_Slim.busreg_flag = 'Y');
cnt_edgar_flag := COUNT(GROUP, BH_Slim.edgar_flag = 'Y');
cnt_dnb_flag := COUNT(GROUP, BH_Slim.dnb_flag = 'Y');
cnt_corp_flag := COUNT(GROUP, BH_Slim.corp_flag = 'Y');
END;

BH_Stat := TABLE(BH_Slim, Layout_BH_Stat, state, FEW);

OUTPUT(BH_Stat,ALL);