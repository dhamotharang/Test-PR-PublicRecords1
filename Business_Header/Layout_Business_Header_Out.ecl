// Business Header File Layout for Accurint Business Search
export Layout_Business_Header_Out := record
  string12  bdid;            // Seisint Business Identifier
  string8   dt_first_seen;   // Date record first seen at Seisint
  string8   dt_last_seen;    // Date record last (most recently seen) at Seisint
  string8   dt_vendor_first_reported;
  string8   dt_vendor_last_reported;
  string120 company_name;
  string10  prim_range;
  string2   predir;
  string28  prim_name;
  string4   addr_suffix;
  string2   postdir;
  string5   unit_desig;
  string8   sec_range;
  string25  city;
  string2   state;
  string5   zip;
  string4   zip4;
  string3   county;
  string4   msa;
  string10  geo_lat;
  string11  geo_long;
  string10  phone;
  string9   fein;             // Federal tax id
  string1   current;          // 'Y' Indicates record current within source, otherwise historical
  string2   source;			// source type
  string2   DPPA_State;       // If nonblank, indicates state code for a DPPA restricted record
  string1   gong_flag;        // 'Y' Indicates Gong record(s) present
  string1   yellowpages_flag; // 'Y' Indicates YellowPages record(s) present
  string1   corp_flag;        // 'Y' Indicates Corporate record(s) present
  string1   ucc_flag;         // 'Y' Indicates UCC record(s) present
  string1   bankruptcy_flag;  // 'Y' Indicates Bankruptcy record(s) present
  string1   domain_flag;      // 'Y' Indicates Whois record(s) present
  string1   fbn_flag;         // 'Y' Indicates FBN record(s) present
  string1   busreg_flag;      // 'Y' Indicates Business Registration record(s) present
  string1   edgar_flag;       // 'Y' Indicates SEC EDGAR filing record(s) present
  string1   dnb_flag;         // 'Y' Indicated Dun and Bradstreet record(s) present
  string1   irs_5500_flag;    // 'Y' Indicates IRS 5500 record(s) present
  string1   employee_directory_flag;   // 'Y' Indicates Employee Directory record(s) present
  string1   fdic_flag;        // 'Y' Indicates FDIC record(s) present
  string1   sales_tax_flag;   // 'Y' Indicates State Sales Tax record(s) present
  string1   sec_broker_flag;  // 'Y' Indicates SEC Broker Dealer record(s) present
  string1   fl_non_profit_flag;// 'Y' Indicates FL Non-Profit Corporation record(s) present
  string1   workers_comp_flag; // 'Y' Indicates State Worker's Comp record(s) present
  string1   vickers_flag;     // 'Y' Indicates Vickers record(s) present
  string1   irs_non_profit_flag;// 'Y' Indicates IRS Non Profit Organization record(s) present
  string1   prof_lic_flag;    // 'Y' Indicates Professional License record(s) present
  string1   fl_fbn_flag;       // 'Y' Indicates FL FBN record(s) present
  string1   dea_flag;         // 'Y' Indicates DEA record(s) present
  string1   tradeshow_flag;   // 'Y' Indicates Accurint Tradeshow record(s) present
  string1   ska_flag;		// 'Y' Indicates ska record(s) present
  string1   liens_flag;		// 'Y' Indicates liens and judgments records present
  string1   credit_union_flag; // 'Y' Indicates credit union records present
  string1   fcc_flag; // 'Y' Indicates FCC records present
  string1   ebr_flag; // 'Y' Indicates experian business reports records present
  string1   bbb_member_flag; // 'Y' Indicates experian business reports records present
  string1   bbb_nonmember_flag; // 'Y' Indicates experian business reports records present
  string1   infousa_abius_flag; // 'Y' Indicates experian business reports records present
  string1   infousa_idexec_flag; // 'Y' Indicates experian business reports records present
  string1   infousa_deadco_flag; // 'Y' Indicates experian business reports records present
  string1   infousa_fbns_flag; // 'Y' Indicates experian business reports records present
  string1   vehicles_flag; // 'Y' Indicates experian business reports records present
  string1   watercraft_flag; // 'Y' Indicates experian business reports records present
  string1   ln_property_flag; // 'Y' Indicates experian business reports records present
  end;