export layout_TX_Statewide := module

//Input Files
export birthdate:=
record
   string dob_idn;
   string per_idn;
   string dob_dte;
   string typ_cod;
end;

/////////////////////////////////
export crt_stat := 
record
   string crs_idn;
   string trs_idn;
   string agy_txt;
   string csc_cod;
   string cau_nbr;
   string fpo_cod;
   string cdd_dte;
   string goc_cod;
   string con_cod;
   string col_txt;
   string ldc_cod;
   string cdn_cod;
   string dos_dte;
   string css_cod;
   string csf_qty;
   string cmt_cod;
   string cpr_cod;
   string cfn_qty;
   string cst_qty;
   string cpl_txt;
   string cpn_nbr;
   string dca_dte;
   string dda_cod;
   string fcd_cod;
   string arc_txt;
   string mcc_cod;
   string dmv_cod;
  end;

/////////////////////////////////
export custody := 
record
   string cus_idn;
   string ind_idn;
   string doo_dte;
   string crn_nbr;
   string agy_txt;
   string pid_nbr;
   string sxd_dte;
   string coc_cod;
   string ssd_dte;
   string ssn_cod;
   string sle_txt;
   string rec_cod;
   string unt_dte;
end;

/////////////////////////////////
export indv := 
record
   string ind_idn;
   string dps_number;
   string ico_txt;
end;

/////////////////////////////////
export nam := 
record
   string nam_idn;
   string per_idn;
   string name_txt;
   string lna_txt;
   string fna_txt;
   string typ_cod;
end;

/////////////////////////////////
export offense := 
record
   string off_idn;
   string trs_idn;
   string agy_txt;
   string doo_dte;
   string aon_cod;
   string aol_txt;
   string lda_cod;
   string goc_cod;
   string adn_cod;
   string add_cod;
   string ada_dte;
   string ref_txt;
   string ipn_nbr;
   string ica_nbr;
   string dmv_cod;
end;

////////////////////////////////
export person := 
record
   string per_idn;
   string sex_cod;
   string rac_cod;
   string eth_cod;
   string hgt_qty;
   string wgt_qty;
   string hai_cod;
   string eye_cod;
   string ind_idn;
end;

////////////////////////////////
export prosecution := 
record
   string pro_idn;
   string trs_idn;
   string agy_txt;
   string act_dte;
   string paf_cod;
   string pon_cod;
   string pol_txt;
   string ldp_cod;
   string goc_cod;
   string dmv_cod;
end;

/////////////////////////////////
export trn := 
record
   string trn_idn;
   string ind_idn;
   string doa_dte;
   string seq_cod;
   string trn_nbr;
   string agy_txt;
end;


/////////////////////////////////
export trs := 
record
   string trs_idn;
   string trn_idn;
   string trs_cod;
   string avl_cod;
   string off_cod;
   string pro_cod;
   string crs_cod;

end;

/////////////////////////////////
export cmbndFile := 
record
   string nam_idn;
   string per_idn;
   string name_txt;
   string lna_txt;
   string fna_txt;
   string typ_cod;
   string sex_cod;
   string rac_cod;
   string eth_cod;
   string hgt_qty;
   string wgt_qty;
   string hai_cod;
   string eye_cod;
   string ind_idn;
   string dob_idn;
   string dob_dte;
   string dps_number;
   string ico_txt;
   string cus_idn;
   string doo_dte;
   string crn_nbr;
   string agy_txt;
   string pid_nbr;
   string sxd_dte;
   string coc_cod;
   string ssd_dte;
   string ssn_cod;
   string sle_txt;
   string rec_cod;
   string unt_dte;
   string trn_idn;
   string doa_dte;
   string seq_cod;
   string trn_nbr;
   string off_idn;
   string trs_idn;
   string aon_cod;
   string aol_txt;
   string lda_cod;
   string goc_cod;
   string adn_cod;
   string add_cod;
   string ada_dte;
   string ref_txt;
   string ipn_nbr;
   string ica_nbr;
   string dmv_cod;
   string pro_idn;
   string act_dte;
   string paf_cod;
   string pon_cod;
   string pol_txt;
   string ldp_cod;
   string trs_cod;
   string avl_cod;
   string off_cod;
   string pro_cod;
   string crs_cod;
   string crs_idn;
   string csc_cod;
   string cau_nbr;
   string fpo_cod;
   string cdd_dte;
   string con_cod;
   string col_txt;
   string ldc_cod;
   string cdn_cod;
   string dos_dte;
   string css_cod;
   string csf_qty;
   string cmt_cod;
   string cpr_cod;
   string cfn_qty;
   string cst_qty;
   string cpl_txt;
   string cpn_nbr;
   string dca_dte;
   string dda_cod;
   string fcd_cod;
   string arc_txt;
   string mcc_cod;
end;
//Additional Files

export expunged:= 
record
string id;
string source;
string lastname;
string firstname;
string middlename;
string DOB;
string offense;
string filedate;
string arrestdate;
string DLNumber;
string SSN;
string cv_flag;
end;

export nondisclosures:= 
record
string DPS_NBR;
string NAM_TXT;
string DOB_DTE;
string AGY_TXT;
string TRN_NBR;
string TRS_COD;
string DOA_DTE;
string DOO_DTE;
string AON_COD;
string AON_LIT;
string AOL_TXT;
string CAU_NBR;
string CDD_DTE;
string CPR_COD;
end;

export okc_expunged := 
record
string Source;
string record_id;
string date_added;
string first_name;
string last_name;
string middle_name;
string address_line_1;
string address_line_2;
string city;
string state;
string zip;
string date_of_birth;
string social_security_number;
string offense_state;
string offense_county;
string case_number_1;
string case_number_2;
string case_number_3;
string offense_description_1;
string offense_description_2;
string offense_description_3;
string offense_date_1;
string offense_date_2;
string offense_date_3;
string attachment_link;
end;

end;