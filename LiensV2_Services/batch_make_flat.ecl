
IMPORT BatchServices, LiensV2_Services;

STRING fn_DisplayAddress1( DATASET(liensv2_services.layout_lien_party_address) address) :=
  FUNCTION
    RETURN TRIM(address[1].prim_range) + ' '
         + TRIM(address[1].predir) + ' '
         + TRIM(address[1].prim_name) + ' '
         + TRIM(address[1].addr_suffix) + ' '
         + TRIM(address[1].postdir);
  END;

STRING fn_DisplayAddress2( DATASET(liensv2_services.layout_lien_party_address) address) :=
  FUNCTION
    RETURN TRIM(address[1].unit_desig) + ' ' + TRIM(address[1].sec_range);
  END;
  
STRING fn_FormatSSN(STRING9 ssn) :=
  FUNCTION
    unformattedSSN := IF( LENGTH(TRIM(ssn)) = 4,
                          '00000' + ssn,
                          ssn
                        );
    formattedSSN := unformattedSSN[1..3] + '-' + unformattedSSN[4..5] + '-' + unformattedSSN[6..9];
    
    RETURN IF( LENGTH(TRIM(ssn)) = 0, '', formattedSSN );
  END;
  
EXPORT LiensV2_Services.Batch_Layouts.batch_out batch_make_flat(LiensV2_Services.Batch_Layouts.int_layout_error_match_codes l) :=
  TRANSFORM
  
    SELF.Matchcodes := l.matchcodes;
    SELF.error_code := l.error_code;
    SELF.filing_jurisdiction := l.filing_jurisdiction;
    SELF.filing_jurisdiction_name := IF( l.filing_state = 'IL', // Only Illinois provides a value IN the filing_state field.
                                             'ILLINOIS',
                                             l.filing_jurisdiction_name
                                            );
    SELF.case_number := IF( l.case_number[ LENGTH(TRIM(l.case_number)) ] = '-', // Remove any trailing hyphen.
                                             l.case_number[ 1..LENGTH(TRIM(l.case_number)) - 1 ],
                                             l.case_number
                                            );
    SELF.amount := IF( l.amount != '',
                                             BatchServices.Functions.convert_to_currency( l.amount ),
                                             ''
                                            );
    SELF.filing_status := IF( l.filing_status[1].filing_status_desc != '', // Move any values from the _desc field to filing_status. We won't display the _desc field at ALL.
                                             l.filing_status[1].filing_status_desc,
                                             l.filing_status[1].filing_status
                                            );
    // debtors
    
    // ..debtor 1
    SELF.debtor_1_party_1_did := l.debtors[1].parsed_parties[1].did;
    SELF.debtor_1_party_1_bdid := l.debtors[1].parsed_parties[1].bdid;
    SELF.debtor_1_party_1_UltID := l.debtors[1].parsed_parties[1].ultid;
    SELF.debtor_1_party_1_OrgID := l.debtors[1].parsed_parties[1].orgid;
    SELF.debtor_1_party_1_SELEID := l.debtors[1].parsed_parties[1].seleid;
    SELF.debtor_1_party_1_ProxID := l.debtors[1].parsed_parties[1].proxid;
    SELF.debtor_1_party_1_POWID := l.debtors[1].parsed_parties[1].powid;
    SELF.debtor_1_party_1_EmpID := l.debtors[1].parsed_parties[1].empid;
    SELF.debtor_1_party_1_DotID := l.debtors[1].parsed_parties[1].dotid;
    SELF.debtor_1_party_1_title := l.debtors[1].parsed_parties[1].title;
    SELF.debtor_1_party_1_fname := l.debtors[1].parsed_parties[1].fname;
    SELF.debtor_1_party_1_mname := l.debtors[1].parsed_parties[1].mname;
    SELF.debtor_1_party_1_lname := l.debtors[1].parsed_parties[1].lname;
    SELF.debtor_1_party_1_name_suffix := l.debtors[1].parsed_parties[1].name_suffix;
    SELF.debtor_1_party_1_cname := l.debtors[1].parsed_parties[1].cname;
    
    SELF.debtor_1_party_1_orig_name := l.debtors[1].orig_name;
    
    SELF.debtor_1_party_1_ssn := fn_FormatSSN(l.debtors[1].parsed_parties[1].ssn);
    SELF.debtor_1_party_1_tax_id := l.debtors[1].parsed_parties[1].tax_id;
  
    SELF.debtor_1_party_1_address1 := fn_DisplayAddress1( DATASET(l.debtors[1].addresses[1]) );
    SELF.debtor_1_party_1_address2 := fn_DisplayAddress2( DATASET(l.debtors[1].addresses[1]) );
    SELF.debtor_1_party_1_p_city_name := l.debtors[1].addresses[1].p_city_name;
    SELF.debtor_1_party_1_st := l.debtors[1].addresses[1].st;
    SELF.debtor_1_party_1_zip := l.debtors[1].addresses[1].zip;
    SELF.debtor_1_party_1_zip4 := l.debtors[1].addresses[1].zip4;
    SELF.debtor_1_party_1_msa := l.debtors[1].addresses[1].msa;
    SELF.debtor_1_party_1_county_name := l.debtors[1].addresses[1].county_name;
    SELF.debtor_1_party_1_phone := l.debtors[1].addresses[1].phones[1].phone;
    
    SELF.debtor_1_party_2_did := l.debtors[1].parsed_parties[2].did;
    SELF.debtor_1_party_2_bdid := l.debtors[1].parsed_parties[2].bdid;
    SELF.debtor_1_party_2_UltID := l.debtors[1].parsed_parties[2].ultid;
    SELF.debtor_1_party_2_OrgID := l.debtors[1].parsed_parties[2].orgid;
    SELF.debtor_1_party_2_SELEID := l.debtors[1].parsed_parties[2].seleid;
    SELF.debtor_1_party_2_ProxID := l.debtors[1].parsed_parties[2].proxid;
    SELF.debtor_1_party_2_POWID := l.debtors[1].parsed_parties[2].powid;
    SELF.debtor_1_party_2_EmpID := l.debtors[1].parsed_parties[2].empid;
    SELF.debtor_1_party_2_DotID := l.debtors[1].parsed_parties[2].dotid;
    SELF.debtor_1_party_2_title := l.debtors[1].parsed_parties[2].title;
    SELF.debtor_1_party_2_fname := l.debtors[1].parsed_parties[2].fname;
    SELF.debtor_1_party_2_mname := l.debtors[1].parsed_parties[2].mname;
    SELF.debtor_1_party_2_lname := l.debtors[1].parsed_parties[2].lname;
    SELF.debtor_1_party_2_name_suffix := l.debtors[1].parsed_parties[2].name_suffix;
    SELF.debtor_1_party_2_cname := l.debtors[1].parsed_parties[2].cname;

    SELF.debtor_1_party_2_ssn := fn_FormatSSN(l.debtors[1].parsed_parties[2].ssn);
    SELF.debtor_1_party_2_tax_id := l.debtors[1].parsed_parties[2].tax_id;
  
    SELF.debtor_1_party_2_address1 := fn_DisplayAddress1( DATASET(l.debtors[1].addresses[2]) );
    SELF.debtor_1_party_2_address2 := fn_DisplayAddress2( DATASET(l.debtors[1].addresses[2]) );
    SELF.debtor_1_party_2_p_city_name := l.debtors[1].addresses[2].p_city_name;
    SELF.debtor_1_party_2_st := l.debtors[1].addresses[2].st;
    SELF.debtor_1_party_2_zip := l.debtors[1].addresses[2].zip;
    SELF.debtor_1_party_2_zip4 := l.debtors[1].addresses[2].zip4;
    SELF.debtor_1_party_2_msa := l.debtors[1].addresses[2].msa;
    SELF.debtor_1_party_2_county_name := l.debtors[1].addresses[2].county_name;
    SELF.debtor_1_party_2_phone := l.debtors[1].addresses[2].phones[1].phone;

    // ..debtor 2
    SELF.debtor_2_party_1_did := l.debtors[2].parsed_parties[1].did;
    SELF.debtor_2_party_1_bdid := l.debtors[2].parsed_parties[1].bdid;
    SELF.debtor_2_party_1_UltID := l.debtors[2].parsed_parties[1].ultid;
    SELF.debtor_2_party_1_OrgID := l.debtors[2].parsed_parties[1].orgid;
    SELF.debtor_2_party_1_SELEID := l.debtors[2].parsed_parties[1].seleid;
    SELF.debtor_2_party_1_ProxID := l.debtors[2].parsed_parties[1].proxid;
    SELF.debtor_2_party_1_POWID := l.debtors[2].parsed_parties[1].powid;
    SELF.debtor_2_party_1_EmpID := l.debtors[2].parsed_parties[1].empid;
    SELF.debtor_2_party_1_DotID := l.debtors[2].parsed_parties[1].dotid;
    SELF.debtor_2_party_1_title := l.debtors[2].parsed_parties[1].title;
    SELF.debtor_2_party_1_fname := l.debtors[2].parsed_parties[1].fname;
    SELF.debtor_2_party_1_mname := l.debtors[2].parsed_parties[1].mname;
    SELF.debtor_2_party_1_lname := l.debtors[2].parsed_parties[1].lname;
    SELF.debtor_2_party_1_name_suffix := l.debtors[2].parsed_parties[1].name_suffix;
    SELF.debtor_2_party_1_cname := l.debtors[2].parsed_parties[1].cname;
    
    SELF.debtor_2_party_1_orig_name := l.debtors[2].orig_name;
    
    SELF.debtor_2_party_1_ssn := fn_FormatSSN(l.debtors[2].parsed_parties[1].ssn);
    SELF.debtor_2_party_1_tax_id := l.debtors[2].parsed_parties[1].tax_id;
  
    SELF.debtor_2_party_1_address1 := fn_DisplayAddress1( DATASET(l.debtors[2].addresses[1]) );
    SELF.debtor_2_party_1_address2 := fn_DisplayAddress2( DATASET(l.debtors[2].addresses[1]) );
    SELF.debtor_2_party_1_p_city_name := l.debtors[2].addresses[1].p_city_name;
    SELF.debtor_2_party_1_st := l.debtors[2].addresses[1].st;
    SELF.debtor_2_party_1_zip := l.debtors[2].addresses[1].zip;
    SELF.debtor_2_party_1_zip4 := l.debtors[2].addresses[1].zip4;
    SELF.debtor_2_party_1_msa := l.debtors[2].addresses[1].msa;
    SELF.debtor_2_party_1_county_name := l.debtors[2].addresses[1].county_name;
    SELF.debtor_2_party_1_phone := l.debtors[2].addresses[1].phones[1].phone;
    
    SELF.debtor_2_party_2_did := l.debtors[2].parsed_parties[2].did;
    SELF.debtor_2_party_2_bdid := l.debtors[2].parsed_parties[2].bdid;
    SELF.debtor_2_party_2_UltID := l.debtors[2].parsed_parties[2].ultid;
    SELF.debtor_2_party_2_OrgID := l.debtors[2].parsed_parties[2].orgid;
    SELF.debtor_2_party_2_SELEID := l.debtors[2].parsed_parties[2].seleid;
    SELF.debtor_2_party_2_ProxID := l.debtors[2].parsed_parties[2].proxid;
    SELF.debtor_2_party_2_POWID := l.debtors[2].parsed_parties[2].powid;
    SELF.debtor_2_party_2_EmpID := l.debtors[2].parsed_parties[2].empid;
    SELF.debtor_2_party_2_DotID := l.debtors[2].parsed_parties[2].dotid;
    SELF.debtor_2_party_2_title := l.debtors[2].parsed_parties[2].title;
    SELF.debtor_2_party_2_fname := l.debtors[2].parsed_parties[2].fname;
    SELF.debtor_2_party_2_mname := l.debtors[2].parsed_parties[2].mname;
    SELF.debtor_2_party_2_lname := l.debtors[2].parsed_parties[2].lname;
    SELF.debtor_2_party_2_name_suffix := l.debtors[2].parsed_parties[2].name_suffix;
    SELF.debtor_2_party_2_cname := l.debtors[2].parsed_parties[2].cname;

    SELF.debtor_2_party_2_ssn := fn_FormatSSN(l.debtors[2].parsed_parties[2].ssn);
    SELF.debtor_2_party_2_tax_id := l.debtors[2].parsed_parties[2].tax_id;
  
    SELF.debtor_2_party_2_address1 := fn_DisplayAddress1( DATASET(l.debtors[2].addresses[2]) );
    SELF.debtor_2_party_2_address2 := fn_DisplayAddress2( DATASET(l.debtors[2].addresses[2]) );
    SELF.debtor_2_party_2_p_city_name := l.debtors[2].addresses[2].p_city_name;
    SELF.debtor_2_party_2_st := l.debtors[2].addresses[2].st;
    SELF.debtor_2_party_2_zip := l.debtors[2].addresses[2].zip;
    SELF.debtor_2_party_2_zip4 := l.debtors[2].addresses[2].zip4;
    SELF.debtor_2_party_2_msa := l.debtors[2].addresses[2].msa;
    SELF.debtor_2_party_2_county_name := l.debtors[2].addresses[2].county_name;
    SELF.debtor_2_party_2_phone := l.debtors[2].addresses[2].phones[1].phone;

    // ..debtor 3
    SELF.debtor_3_party_1_did := l.debtors[3].parsed_parties[1].did;
    SELF.debtor_3_party_1_bdid := l.debtors[3].parsed_parties[1].bdid;
    SELF.debtor_3_party_1_UltID := l.debtors[3].parsed_parties[1].ultid;
    SELF.debtor_3_party_1_OrgID := l.debtors[3].parsed_parties[1].orgid;
    SELF.debtor_3_party_1_SELEID := l.debtors[3].parsed_parties[1].seleid;
    SELF.debtor_3_party_1_ProxID := l.debtors[3].parsed_parties[1].proxid;
    SELF.debtor_3_party_1_POWID := l.debtors[3].parsed_parties[1].powid;
    SELF.debtor_3_party_1_EmpID := l.debtors[3].parsed_parties[1].empid;
    SELF.debtor_3_party_1_DotID := l.debtors[3].parsed_parties[1].dotid;
    SELF.debtor_3_party_1_title := l.debtors[3].parsed_parties[1].title;
    SELF.debtor_3_party_1_fname := l.debtors[3].parsed_parties[1].fname;
    SELF.debtor_3_party_1_mname := l.debtors[3].parsed_parties[1].mname;
    SELF.debtor_3_party_1_lname := l.debtors[3].parsed_parties[1].lname;
    SELF.debtor_3_party_1_name_suffix := l.debtors[3].parsed_parties[1].name_suffix;
    SELF.debtor_3_party_1_cname := l.debtors[3].parsed_parties[1].cname;

    SELF.debtor_3_party_1_orig_name := l.debtors[3].orig_name;
    
    SELF.debtor_3_party_1_ssn := fn_FormatSSN(l.debtors[3].parsed_parties[1].ssn);
    SELF.debtor_3_party_1_tax_id := l.debtors[3].parsed_parties[1].tax_id;
  
    SELF.debtor_3_party_1_address1 := fn_DisplayAddress1( DATASET(l.debtors[3].addresses[1]) );
    SELF.debtor_3_party_1_address2 := fn_DisplayAddress2( DATASET(l.debtors[3].addresses[1]) );
    SELF.debtor_3_party_1_p_city_name := l.debtors[3].addresses[1].p_city_name;
    SELF.debtor_3_party_1_st := l.debtors[3].addresses[1].st;
    SELF.debtor_3_party_1_zip := l.debtors[3].addresses[1].zip;
    SELF.debtor_3_party_1_zip4 := l.debtors[3].addresses[1].zip4;
    SELF.debtor_3_party_1_msa := l.debtors[3].addresses[1].msa;
    SELF.debtor_3_party_1_county_name := l.debtors[3].addresses[1].county_name;
    SELF.debtor_3_party_1_phone := l.debtors[3].addresses[1].phones[1].phone;
    
    SELF.debtor_3_party_2_did := l.debtors[3].parsed_parties[2].did;
    SELF.debtor_3_party_2_bdid := l.debtors[3].parsed_parties[2].bdid;
    SELF.debtor_3_party_2_UltID := l.debtors[3].parsed_parties[2].ultid;
    SELF.debtor_3_party_2_OrgID := l.debtors[3].parsed_parties[2].orgid;
    SELF.debtor_3_party_2_SELEID := l.debtors[3].parsed_parties[2].seleid;
    SELF.debtor_3_party_2_ProxID := l.debtors[3].parsed_parties[2].proxid;
    SELF.debtor_3_party_2_POWID := l.debtors[3].parsed_parties[2].powid;
    SELF.debtor_3_party_2_EmpID := l.debtors[3].parsed_parties[2].empid;
    SELF.debtor_3_party_2_DotID := l.debtors[3].parsed_parties[2].dotid;
    SELF.debtor_3_party_2_title := l.debtors[3].parsed_parties[2].title;
    SELF.debtor_3_party_2_fname := l.debtors[3].parsed_parties[2].fname;
    SELF.debtor_3_party_2_mname := l.debtors[3].parsed_parties[2].mname;
    SELF.debtor_3_party_2_lname := l.debtors[3].parsed_parties[2].lname;
    SELF.debtor_3_party_2_name_suffix := l.debtors[3].parsed_parties[2].name_suffix;
    SELF.debtor_3_party_2_cname := l.debtors[3].parsed_parties[2].cname;

    SELF.debtor_3_party_2_ssn := fn_FormatSSN(l.debtors[3].parsed_parties[2].ssn);
    SELF.debtor_3_party_2_tax_id := l.debtors[3].parsed_parties[2].tax_id;
  
    SELF.debtor_3_party_2_address1 := fn_DisplayAddress1( DATASET(l.debtors[3].addresses[2]) );
    SELF.debtor_3_party_2_address2 := fn_DisplayAddress2( DATASET(l.debtors[3].addresses[2]) );
    SELF.debtor_3_party_2_p_city_name := l.debtors[3].addresses[2].p_city_name;
    SELF.debtor_3_party_2_st := l.debtors[3].addresses[2].st;
    SELF.debtor_3_party_2_zip := l.debtors[3].addresses[2].zip;
    SELF.debtor_3_party_2_zip4 := l.debtors[3].addresses[2].zip4;
    SELF.debtor_3_party_2_msa := l.debtors[3].addresses[2].msa;
    SELF.debtor_3_party_2_county_name := l.debtors[3].addresses[2].county_name;
    SELF.debtor_3_party_2_phone := l.debtors[3].addresses[2].phones[1].phone;

    // ..debtor 4
    SELF.debtor_4_party_1_did := l.debtors[4].parsed_parties[1].did;
    SELF.debtor_4_party_1_bdid := l.debtors[4].parsed_parties[1].bdid;
    SELF.debtor_4_party_1_UltID := l.debtors[4].parsed_parties[1].ultid;
    SELF.debtor_4_party_1_OrgID := l.debtors[4].parsed_parties[1].orgid;
    SELF.debtor_4_party_1_SELEID := l.debtors[4].parsed_parties[1].seleid;
    SELF.debtor_4_party_1_ProxID := l.debtors[4].parsed_parties[1].proxid;
    SELF.debtor_4_party_1_POWID := l.debtors[4].parsed_parties[1].powid;
    SELF.debtor_4_party_1_EmpID := l.debtors[4].parsed_parties[1].empid;
    SELF.debtor_4_party_1_DotID := l.debtors[4].parsed_parties[1].dotid;
    SELF.debtor_4_party_1_title := l.debtors[4].parsed_parties[1].title;
    SELF.debtor_4_party_1_fname := l.debtors[4].parsed_parties[1].fname;
    SELF.debtor_4_party_1_mname := l.debtors[4].parsed_parties[1].mname;
    SELF.debtor_4_party_1_lname := l.debtors[4].parsed_parties[1].lname;
    SELF.debtor_4_party_1_name_suffix := l.debtors[4].parsed_parties[1].name_suffix;
    SELF.debtor_4_party_1_cname := l.debtors[4].parsed_parties[1].cname;

    SELF.debtor_4_party_1_orig_name := l.debtors[4].orig_name;
    
    SELF.debtor_4_party_1_ssn := fn_FormatSSN(l.debtors[4].parsed_parties[1].ssn);
    SELF.debtor_4_party_1_tax_id := l.debtors[4].parsed_parties[1].tax_id;
  
    SELF.debtor_4_party_1_address1 := fn_DisplayAddress1( DATASET(l.debtors[4].addresses[1]) );
    SELF.debtor_4_party_1_address2 := fn_DisplayAddress2( DATASET(l.debtors[4].addresses[1]) );
    SELF.debtor_4_party_1_p_city_name := l.debtors[4].addresses[1].p_city_name;
    SELF.debtor_4_party_1_st := l.debtors[4].addresses[1].st;
    SELF.debtor_4_party_1_zip := l.debtors[4].addresses[1].zip;
    SELF.debtor_4_party_1_zip4 := l.debtors[4].addresses[1].zip4;
    SELF.debtor_4_party_1_msa := l.debtors[4].addresses[1].msa;
    SELF.debtor_4_party_1_county_name := l.debtors[4].addresses[1].county_name;
    SELF.debtor_4_party_1_phone := l.debtors[4].addresses[1].phones[1].phone;
    
    SELF.debtor_4_party_2_did := l.debtors[4].parsed_parties[2].did;
    SELF.debtor_4_party_2_bdid := l.debtors[4].parsed_parties[2].bdid;
    SELF.debtor_4_party_2_UltID := l.debtors[4].parsed_parties[2].ultid;
    SELF.debtor_4_party_2_OrgID := l.debtors[4].parsed_parties[2].orgid;
    SELF.debtor_4_party_2_SELEID := l.debtors[4].parsed_parties[2].seleid;
    SELF.debtor_4_party_2_ProxID := l.debtors[4].parsed_parties[2].proxid;
    SELF.debtor_4_party_2_POWID := l.debtors[4].parsed_parties[2].powid;
    SELF.debtor_4_party_2_EmpID := l.debtors[4].parsed_parties[2].empid;
    SELF.debtor_4_party_2_DotID := l.debtors[4].parsed_parties[2].dotid;
    SELF.debtor_4_party_2_title := l.debtors[4].parsed_parties[2].title;
    SELF.debtor_4_party_2_fname := l.debtors[4].parsed_parties[2].fname;
    SELF.debtor_4_party_2_mname := l.debtors[4].parsed_parties[2].mname;
    SELF.debtor_4_party_2_lname := l.debtors[4].parsed_parties[2].lname;
    SELF.debtor_4_party_2_name_suffix := l.debtors[4].parsed_parties[2].name_suffix;
    SELF.debtor_4_party_2_cname := l.debtors[4].parsed_parties[2].cname;

    SELF.debtor_4_party_2_ssn := fn_FormatSSN(l.debtors[4].parsed_parties[2].ssn);
    SELF.debtor_4_party_2_tax_id := l.debtors[4].parsed_parties[2].tax_id;
  
    SELF.debtor_4_party_2_address1 := fn_DisplayAddress1( DATASET(l.debtors[4].addresses[2]) );
    SELF.debtor_4_party_2_address2 := fn_DisplayAddress2( DATASET(l.debtors[4].addresses[2]) );
    SELF.debtor_4_party_2_p_city_name := l.debtors[4].addresses[2].p_city_name;
    SELF.debtor_4_party_2_st := l.debtors[4].addresses[2].st;
    SELF.debtor_4_party_2_zip := l.debtors[4].addresses[2].zip;
    SELF.debtor_4_party_2_zip4 := l.debtors[4].addresses[2].zip4;
    SELF.debtor_4_party_2_msa := l.debtors[4].addresses[2].msa;
    SELF.debtor_4_party_2_county_name := l.debtors[4].addresses[2].county_name;
    SELF.debtor_4_party_2_phone := l.debtors[4].addresses[2].phones[1].phone;

    // ..debtor 5
    SELF.debtor_5_party_1_did := l.debtors[5].parsed_parties[1].did;
    SELF.debtor_5_party_1_bdid := l.debtors[5].parsed_parties[1].bdid;
    SELF.debtor_5_party_1_UltID := l.debtors[5].parsed_parties[1].ultid;
    SELF.debtor_5_party_1_OrgID := l.debtors[5].parsed_parties[1].orgid;
    SELF.debtor_5_party_1_SELEID := l.debtors[5].parsed_parties[1].seleid;
    SELF.debtor_5_party_1_ProxID := l.debtors[5].parsed_parties[1].proxid;
    SELF.debtor_5_party_1_POWID := l.debtors[5].parsed_parties[1].powid;
    SELF.debtor_5_party_1_EmpID := l.debtors[5].parsed_parties[1].empid;
    SELF.debtor_5_party_1_DotID := l.debtors[5].parsed_parties[1].dotid;
    SELF.debtor_5_party_1_title := l.debtors[5].parsed_parties[1].title;
    SELF.debtor_5_party_1_fname := l.debtors[5].parsed_parties[1].fname;
    SELF.debtor_5_party_1_mname := l.debtors[5].parsed_parties[1].mname;
    SELF.debtor_5_party_1_lname := l.debtors[5].parsed_parties[1].lname;
    SELF.debtor_5_party_1_name_suffix := l.debtors[5].parsed_parties[1].name_suffix;
    SELF.debtor_5_party_1_cname := l.debtors[5].parsed_parties[1].cname;

    SELF.debtor_5_party_1_orig_name := l.debtors[5].orig_name;
    
    SELF.debtor_5_party_1_ssn := fn_FormatSSN(l.debtors[5].parsed_parties[1].ssn);
    SELF.debtor_5_party_1_tax_id := l.debtors[5].parsed_parties[1].tax_id;
  
    SELF.debtor_5_party_1_address1 := fn_DisplayAddress1( DATASET(l.debtors[5].addresses[1]) );
    SELF.debtor_5_party_1_address2 := fn_DisplayAddress2( DATASET(l.debtors[5].addresses[1]) );
    SELF.debtor_5_party_1_p_city_name := l.debtors[5].addresses[1].p_city_name;
    SELF.debtor_5_party_1_st := l.debtors[5].addresses[1].st;
    SELF.debtor_5_party_1_zip := l.debtors[5].addresses[1].zip;
    SELF.debtor_5_party_1_zip4 := l.debtors[5].addresses[1].zip4;
    SELF.debtor_5_party_1_msa := l.debtors[5].addresses[1].msa;
    SELF.debtor_5_party_1_county_name := l.debtors[5].addresses[1].county_name;
    SELF.debtor_5_party_1_phone := l.debtors[5].addresses[1].phones[1].phone;
    
    SELF.debtor_5_party_2_did := l.debtors[5].parsed_parties[2].did;
    SELF.debtor_5_party_2_bdid := l.debtors[5].parsed_parties[2].bdid;
    SELF.debtor_5_party_2_UltID := l.debtors[5].parsed_parties[2].ultid;
    SELF.debtor_5_party_2_OrgID := l.debtors[5].parsed_parties[2].orgid;
    SELF.debtor_5_party_2_SELEID := l.debtors[5].parsed_parties[2].seleid;
    SELF.debtor_5_party_2_ProxID := l.debtors[5].parsed_parties[2].proxid;
    SELF.debtor_5_party_2_POWID := l.debtors[5].parsed_parties[2].powid;
    SELF.debtor_5_party_2_EmpID := l.debtors[5].parsed_parties[2].empid;
    SELF.debtor_5_party_2_DotID := l.debtors[5].parsed_parties[2].dotid;
    SELF.debtor_5_party_2_title := l.debtors[5].parsed_parties[2].title;
    SELF.debtor_5_party_2_fname := l.debtors[5].parsed_parties[2].fname;
    SELF.debtor_5_party_2_mname := l.debtors[5].parsed_parties[2].mname;
    SELF.debtor_5_party_2_lname := l.debtors[5].parsed_parties[2].lname;
    SELF.debtor_5_party_2_name_suffix := l.debtors[5].parsed_parties[2].name_suffix;
    SELF.debtor_5_party_2_cname := l.debtors[5].parsed_parties[2].cname;

    SELF.debtor_5_party_2_ssn := fn_FormatSSN(l.debtors[5].parsed_parties[2].ssn);
    SELF.debtor_5_party_2_tax_id := l.debtors[5].parsed_parties[2].tax_id;
  
    SELF.debtor_5_party_2_address1 := fn_DisplayAddress1( DATASET(l.debtors[5].addresses[2]) );
    SELF.debtor_5_party_2_address2 := fn_DisplayAddress2( DATASET(l.debtors[5].addresses[2]) );
    SELF.debtor_5_party_2_p_city_name := l.debtors[5].addresses[2].p_city_name;
    SELF.debtor_5_party_2_st := l.debtors[5].addresses[2].st;
    SELF.debtor_5_party_2_zip := l.debtors[5].addresses[2].zip;
    SELF.debtor_5_party_2_zip4 := l.debtors[5].addresses[2].zip4;
    SELF.debtor_5_party_2_msa := l.debtors[5].addresses[2].msa;
    SELF.debtor_5_party_2_county_name := l.debtors[5].addresses[2].county_name;
    SELF.debtor_5_party_2_phone := l.debtors[5].addresses[2].phones[1].phone;

    // ..debtor 6
    SELF.debtor_6_party_1_did := l.debtors[6].parsed_parties[1].did;
    SELF.debtor_6_party_1_bdid := l.debtors[6].parsed_parties[1].bdid;
    SELF.debtor_6_party_1_UltID := l.debtors[6].parsed_parties[1].ultid;
    SELF.debtor_6_party_1_OrgID := l.debtors[6].parsed_parties[1].orgid;
    SELF.debtor_6_party_1_SELEID := l.debtors[6].parsed_parties[1].seleid;
    SELF.debtor_6_party_1_ProxID := l.debtors[6].parsed_parties[1].proxid;
    SELF.debtor_6_party_1_POWID := l.debtors[6].parsed_parties[1].powid;
    SELF.debtor_6_party_1_EmpID := l.debtors[6].parsed_parties[1].empid;
    SELF.debtor_6_party_1_DotID := l.debtors[6].parsed_parties[1].dotid;
    SELF.debtor_6_party_1_title := l.debtors[6].parsed_parties[1].title;
    SELF.debtor_6_party_1_fname := l.debtors[6].parsed_parties[1].fname;
    SELF.debtor_6_party_1_mname := l.debtors[6].parsed_parties[1].mname;
    SELF.debtor_6_party_1_lname := l.debtors[6].parsed_parties[1].lname;
    SELF.debtor_6_party_1_name_suffix := l.debtors[6].parsed_parties[1].name_suffix;
    SELF.debtor_6_party_1_cname := l.debtors[6].parsed_parties[1].cname;

    SELF.debtor_6_party_1_orig_name := l.debtors[6].orig_name;
    
    SELF.debtor_6_party_1_ssn := fn_FormatSSN(l.debtors[6].parsed_parties[1].ssn);
    SELF.debtor_6_party_1_tax_id := l.debtors[6].parsed_parties[1].tax_id;
  
    SELF.debtor_6_party_1_address1 := fn_DisplayAddress1( DATASET(l.debtors[6].addresses[1]) );
    SELF.debtor_6_party_1_address2 := fn_DisplayAddress2( DATASET(l.debtors[6].addresses[1]) );
    SELF.debtor_6_party_1_p_city_name := l.debtors[6].addresses[1].p_city_name;
    SELF.debtor_6_party_1_st := l.debtors[6].addresses[1].st;
    SELF.debtor_6_party_1_zip := l.debtors[6].addresses[1].zip;
    SELF.debtor_6_party_1_zip4 := l.debtors[6].addresses[1].zip4;
    SELF.debtor_6_party_1_msa := l.debtors[6].addresses[1].msa;
    SELF.debtor_6_party_1_county_name := l.debtors[6].addresses[1].county_name;
    SELF.debtor_6_party_1_phone := l.debtors[6].addresses[1].phones[1].phone;
    
    SELF.debtor_6_party_2_did := l.debtors[6].parsed_parties[2].did;
    SELF.debtor_6_party_2_bdid := l.debtors[6].parsed_parties[2].bdid;
    SELF.debtor_6_party_2_UltID := l.debtors[6].parsed_parties[2].ultid;
    SELF.debtor_6_party_2_OrgID := l.debtors[6].parsed_parties[2].orgid;
    SELF.debtor_6_party_2_SELEID := l.debtors[6].parsed_parties[2].seleid;
    SELF.debtor_6_party_2_ProxID := l.debtors[6].parsed_parties[2].proxid;
    SELF.debtor_6_party_2_POWID := l.debtors[6].parsed_parties[2].powid;
    SELF.debtor_6_party_2_EmpID := l.debtors[6].parsed_parties[2].empid;
    SELF.debtor_6_party_2_DotID := l.debtors[6].parsed_parties[2].dotid;
    SELF.debtor_6_party_2_title := l.debtors[6].parsed_parties[2].title;
    SELF.debtor_6_party_2_fname := l.debtors[6].parsed_parties[2].fname;
    SELF.debtor_6_party_2_mname := l.debtors[6].parsed_parties[2].mname;
    SELF.debtor_6_party_2_lname := l.debtors[6].parsed_parties[2].lname;
    SELF.debtor_6_party_2_name_suffix := l.debtors[6].parsed_parties[2].name_suffix;
    SELF.debtor_6_party_2_cname := l.debtors[6].parsed_parties[2].cname;

    SELF.debtor_6_party_2_ssn := fn_FormatSSN(l.debtors[6].parsed_parties[2].ssn);
    SELF.debtor_6_party_2_tax_id := l.debtors[6].parsed_parties[2].tax_id;
  
    SELF.debtor_6_party_2_address1 := fn_DisplayAddress1( DATASET(l.debtors[6].addresses[2]) );
    SELF.debtor_6_party_2_address2 := fn_DisplayAddress2( DATASET(l.debtors[6].addresses[2]) );
    SELF.debtor_6_party_2_p_city_name := l.debtors[6].addresses[2].p_city_name;
    SELF.debtor_6_party_2_st := l.debtors[6].addresses[2].st;
    SELF.debtor_6_party_2_zip := l.debtors[6].addresses[2].zip;
    SELF.debtor_6_party_2_zip4 := l.debtors[6].addresses[2].zip4;
    SELF.debtor_6_party_2_msa := l.debtors[6].addresses[2].msa;
    SELF.debtor_6_party_2_county_name := l.debtors[6].addresses[2].county_name;
    SELF.debtor_6_party_2_phone := l.debtors[6].addresses[2].phones[1].phone;

    // ..debtor 7
    SELF.debtor_7_party_1_did := l.debtors[7].parsed_parties[1].did;
    SELF.debtor_7_party_1_bdid := l.debtors[7].parsed_parties[1].bdid;
    SELF.debtor_7_party_1_UltID := l.debtors[7].parsed_parties[1].ultid;
    SELF.debtor_7_party_1_OrgID := l.debtors[7].parsed_parties[1].orgid;
    SELF.debtor_7_party_1_SELEID := l.debtors[7].parsed_parties[1].seleid;
    SELF.debtor_7_party_1_ProxID := l.debtors[7].parsed_parties[1].proxid;
    SELF.debtor_7_party_1_POWID := l.debtors[7].parsed_parties[1].powid;
    SELF.debtor_7_party_1_EmpID := l.debtors[7].parsed_parties[1].empid;
    SELF.debtor_7_party_1_DotID := l.debtors[7].parsed_parties[1].dotid;
    SELF.debtor_7_party_1_title := l.debtors[7].parsed_parties[1].title;
    SELF.debtor_7_party_1_fname := l.debtors[7].parsed_parties[1].fname;
    SELF.debtor_7_party_1_mname := l.debtors[7].parsed_parties[1].mname;
    SELF.debtor_7_party_1_lname := l.debtors[7].parsed_parties[1].lname;
    SELF.debtor_7_party_1_name_suffix := l.debtors[7].parsed_parties[1].name_suffix;
    SELF.debtor_7_party_1_cname := l.debtors[7].parsed_parties[1].cname;

    SELF.debtor_7_party_1_orig_name := l.debtors[7].orig_name;
    
    SELF.debtor_7_party_1_ssn := fn_FormatSSN(l.debtors[7].parsed_parties[1].ssn);
    SELF.debtor_7_party_1_tax_id := l.debtors[7].parsed_parties[1].tax_id;
  
    SELF.debtor_7_party_1_address1 := fn_DisplayAddress1( DATASET(l.debtors[7].addresses[1]) );
    SELF.debtor_7_party_1_address2 := fn_DisplayAddress2( DATASET(l.debtors[7].addresses[1]) );
    SELF.debtor_7_party_1_p_city_name := l.debtors[7].addresses[1].p_city_name;
    SELF.debtor_7_party_1_st := l.debtors[7].addresses[1].st;
    SELF.debtor_7_party_1_zip := l.debtors[7].addresses[1].zip;
    SELF.debtor_7_party_1_zip4 := l.debtors[7].addresses[1].zip4;
    SELF.debtor_7_party_1_msa := l.debtors[7].addresses[1].msa;
    SELF.debtor_7_party_1_county_name := l.debtors[7].addresses[1].county_name;
    SELF.debtor_7_party_1_phone := l.debtors[7].addresses[1].phones[1].phone;
    
    SELF.debtor_7_party_2_did := l.debtors[7].parsed_parties[2].did;
    SELF.debtor_7_party_2_bdid := l.debtors[7].parsed_parties[2].bdid;
    SELF.debtor_7_party_2_UltID := l.debtors[7].parsed_parties[2].ultid;
    SELF.debtor_7_party_2_OrgID := l.debtors[7].parsed_parties[2].orgid;
    SELF.debtor_7_party_2_SELEID := l.debtors[7].parsed_parties[2].seleid;
    SELF.debtor_7_party_2_ProxID := l.debtors[7].parsed_parties[2].proxid;
    SELF.debtor_7_party_2_POWID := l.debtors[7].parsed_parties[2].powid;
    SELF.debtor_7_party_2_EmpID := l.debtors[7].parsed_parties[2].empid;
    SELF.debtor_7_party_2_DotID := l.debtors[7].parsed_parties[2].dotid;
    SELF.debtor_7_party_2_title := l.debtors[7].parsed_parties[2].title;
    SELF.debtor_7_party_2_fname := l.debtors[7].parsed_parties[2].fname;
    SELF.debtor_7_party_2_mname := l.debtors[7].parsed_parties[2].mname;
    SELF.debtor_7_party_2_lname := l.debtors[7].parsed_parties[2].lname;
    SELF.debtor_7_party_2_name_suffix := l.debtors[7].parsed_parties[2].name_suffix;
    SELF.debtor_7_party_2_cname := l.debtors[7].parsed_parties[2].cname;

    SELF.debtor_7_party_2_ssn := fn_FormatSSN(l.debtors[7].parsed_parties[2].ssn);
    SELF.debtor_7_party_2_tax_id := l.debtors[7].parsed_parties[2].tax_id;
  
    SELF.debtor_7_party_2_address1 := fn_DisplayAddress1( DATASET(l.debtors[7].addresses[2]) );
    SELF.debtor_7_party_2_address2 := fn_DisplayAddress2( DATASET(l.debtors[7].addresses[2]) );
    SELF.debtor_7_party_2_p_city_name := l.debtors[7].addresses[2].p_city_name;
    SELF.debtor_7_party_2_st := l.debtors[7].addresses[2].st;
    SELF.debtor_7_party_2_zip := l.debtors[7].addresses[2].zip;
    SELF.debtor_7_party_2_zip4 := l.debtors[7].addresses[2].zip4;
    SELF.debtor_7_party_2_msa := l.debtors[7].addresses[2].msa;
    SELF.debtor_7_party_2_county_name := l.debtors[7].addresses[2].county_name;
    SELF.debtor_7_party_2_phone := l.debtors[7].addresses[2].phones[1].phone;
      

    // creditors (1)
    SELF.creditor_did := l.creditors[1].parsed_parties[1].did;
    SELF.creditor_bdid := l.creditors[1].parsed_parties[1].bdid;
    SELF.creditor_UltID := l.creditors[1].parsed_parties[1].ultid;
    SELF.creditor_OrgID := l.creditors[1].parsed_parties[1].orgid;
    SELF.creditor_SELEID := l.creditors[1].parsed_parties[1].seleid;
    SELF.creditor_ProxID := l.creditors[1].parsed_parties[1].proxid;
    SELF.creditor_POWID := l.creditors[1].parsed_parties[1].powid;
    SELF.creditor_EmpID := l.creditors[1].parsed_parties[1].empid;
    SELF.creditor_DotID := l.creditors[1].parsed_parties[1].dotid;
    SELF.creditor_title := l.creditors[1].parsed_parties[1].title;
    SELF.creditor_fname := l.creditors[1].parsed_parties[1].fname;
    SELF.creditor_mname := l.creditors[1].parsed_parties[1].mname;
    SELF.creditor_lname := l.creditors[1].parsed_parties[1].lname;
    SELF.creditor_name_suffix := l.creditors[1].parsed_parties[1].name_suffix;
    SELF.creditor_cname := l.creditors[1].parsed_parties[1].cname;
    SELF.creditor_orig_name := l.creditors[1].orig_name;
    
    SELF.creditor_address1 := fn_DisplayAddress1( DATASET(l.creditors[1].addresses[1]) );
    SELF.creditor_address2 := fn_DisplayAddress2( DATASET(l.creditors[1].addresses[1]) );
    SELF.creditor_p_city_name := l.creditors[1].addresses[1].p_city_name;
    SELF.creditor_st := l.creditors[1].addresses[1].st;
    SELF.creditor_zip := l.creditors[1].addresses[1].zip;
    SELF.creditor_zip4 := l.creditors[1].addresses[1].zip4;
    SELF.creditor_msa := l.creditors[1].addresses[1].msa;
    SELF.creditor_county_name := l.creditors[1].addresses[1].county_name;
    SELF.creditor_phone := l.creditors[1].addresses[1].phones[1].phone;
         
    // attorneys (1)
    SELF.attorney_did := l.attorneys[1].parsed_parties[1].did;
    SELF.attorney_bdid := l.attorneys[1].parsed_parties[1].bdid;
    SELF.attorney_UltID := l.attorneys[1].parsed_parties[1].ultid;
    SELF.attorney_OrgID := l.attorneys[1].parsed_parties[1].orgid;
    SELF.attorney_SELEID := l.attorneys[1].parsed_parties[1].seleid;
    SELF.attorney_ProxID := l.attorneys[1].parsed_parties[1].proxid;
    SELF.attorney_POWID := l.attorneys[1].parsed_parties[1].powid;
    SELF.attorney_EmpID := l.attorneys[1].parsed_parties[1].empid;
    SELF.attorney_DotID := l.attorneys[1].parsed_parties[1].dotid;
    SELF.attorney_title := l.attorneys[1].parsed_parties[1].title;
    SELF.attorney_fname := l.attorneys[1].parsed_parties[1].fname;
    SELF.attorney_mname := l.attorneys[1].parsed_parties[1].mname;
    SELF.attorney_lname := l.attorneys[1].parsed_parties[1].lname;
    SELF.attorney_name_suffix := l.attorneys[1].parsed_parties[1].name_suffix;
    SELF.attorney_cname := l.attorneys[1].parsed_parties[1].cname;
    SELF.attorney_orig_name := l.attorneys[1].orig_name;
    
    SELF.attorney_address1 := fn_DisplayAddress1( DATASET(l.attorneys[1].addresses[1]) );
    SELF.attorney_address2 := fn_DisplayAddress2( DATASET(l.attorneys[1].addresses[1]) );
    SELF.attorney_p_city_name := l.attorneys[1].addresses[1].p_city_name;
    SELF.attorney_st := l.attorneys[1].addresses[1].st;
    SELF.attorney_zip := l.attorneys[1].addresses[1].zip;
    SELF.attorney_zip4 := l.attorneys[1].addresses[1].zip4;
    SELF.attorney_msa := l.attorneys[1].addresses[1].msa;
    SELF.attorney_county_name := l.attorneys[1].addresses[1].county_name;
    SELF.attorney_phone := l.attorneys[1].addresses[1].phones[1].phone;
    
    // filings (4)
    
    SELF.filing_1_filing_number := l.filings[1].filing_number;
    SELF.filing_1_filing_type_desc := l.filings[1].filing_type_desc;
    SELF.filing_1_filing_date := l.filings[1].filing_date;
    SELF.filing_1_filing_time := l.filings[1].filing_time;
    SELF.filing_1_filing_book := l.filings[1].filing_book;
    SELF.filing_1_filing_page := l.filings[1].filing_page;
    SELF.filing_1_agency := l.filings[1].agency;
    SELF.filing_1_agency_state := l.filings[1].agency_state;
    SELF.filing_1_agency_city := l.filings[1].agency_city;
    SELF.filing_1_agency_county := l.filings[1].agency_county;
                                   
    SELF.filing_2_filing_number := l.filings[2].filing_number;
    SELF.filing_2_filing_type_desc := l.filings[2].filing_type_desc;
    SELF.filing_2_filing_date := l.filings[2].filing_date;
    SELF.filing_2_filing_time := l.filings[2].filing_time;
    SELF.filing_2_filing_book := l.filings[2].filing_book;
    SELF.filing_2_filing_page := l.filings[2].filing_page;
    SELF.filing_2_agency := l.filings[2].agency;
    SELF.filing_2_agency_state := l.filings[2].agency_state;
    SELF.filing_2_agency_city := l.filings[2].agency_city;
    SELF.filing_2_agency_county := l.filings[2].agency_county;
                                   
    SELF.filing_3_filing_number := l.filings[3].filing_number;
    SELF.filing_3_filing_type_desc := l.filings[3].filing_type_desc;
    SELF.filing_3_filing_date := l.filings[3].filing_date;
    SELF.filing_3_filing_time := l.filings[3].filing_time;
    SELF.filing_3_filing_book := l.filings[3].filing_book;
    SELF.filing_3_filing_page := l.filings[3].filing_page;
    SELF.filing_3_agency := l.filings[3].agency;
    SELF.filing_3_agency_state := l.filings[3].agency_state;
    SELF.filing_3_agency_city := l.filings[3].agency_city;
    SELF.filing_3_agency_county := l.filings[3].agency_county;
                                   
    SELF.filing_4_filing_number := l.filings[4].filing_number;
    SELF.filing_4_filing_type_desc := l.filings[4].filing_type_desc;
    SELF.filing_4_filing_date := l.filings[4].filing_date;
    SELF.filing_4_filing_time := l.filings[4].filing_time;
    SELF.filing_4_filing_book := l.filings[4].filing_book;
    SELF.filing_4_filing_page := l.filings[4].filing_page;
    SELF.filing_4_agency := l.filings[4].agency;
    SELF.filing_4_agency_state := l.filings[4].agency_state;
    SELF.filing_4_agency_city := l.filings[4].agency_city;
    SELF.filing_4_agency_county := l.filings[4].agency_county;
                                   
    SELF := l;

  END;
