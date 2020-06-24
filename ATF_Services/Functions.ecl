import AutoStandardI, ut, codes, atf_services, iesp, suppress, FCRA;

export Functions := module

  shared ms(string70 a, string70 b, string70 c) :=
      map(a = '' => b,
          b = '' => a,
          ut.StringSimilar(a,c) <= ut.StringSimilar(b,c) => a,b);
          
  shared fullNameValue(string fn, string mn, string lna, string name) :=
         if (fn = '' AND mn = '' AND lna = '', name, '');
         
  shared streetAddress1Value(string prim_name, string prim_range, string predir, string addr_suffix, string postdir) :=
              if (prim_name != '',
                          trim(prim_range,left,right) + ' ' + trim(predir,left,right) + ' ' +
                          trim(prim_name,left,right) + ' ' + trim(addr_suffix) + ' ' +
                          trim(postdir,left,right), '');
         
  shared streetAddress2Value(string p_city_name, string v_city_name, string param_city, string st, string zip) :=
              if (trim(ms(p_city_name, v_city_name, param_city),left,right) != '',
                                      trim(ms(p_city_name, v_city_name, param_city),left,right) + ' ' +
                                      trim(st,left,right) + ' ' + trim(zip,left,right), '');
                                      
  export stateCityZipValue(string p_city_name, string v_city_name, string param_city, string st, string zip) :=
               if (trim(ms(p_city_name, v_city_name, param_city),left,right) != '' OR zip != '',
                          trim(st) + ' ' + trim(ms(p_city_name,v_city_name,param_city),left,right) + ' ' + trim(zip), '');
                          
  export string4 code_to_year(string cd, string date = '') :=
    FUNCTION
      // Bugzilla: 32701
      // The date coming in is in the form yyyymmdd ~ date div 100000 is yyy
      // ((date div 10000) mod 10) gives the 4th y of the year (the issue year) which is used to
      // determine the expiration date decade.
      // ex: incoming date=20060101 & incoming code=9 Ex2: incoming date=20060101 & incoming code=2
      // for both: issue_decade = 200 & issue_year = 6
      // since 6 < 9 -- the expiration date is 2009 since 6 > 2 -- the expiration date is 2012
      
      issue_decade := (integer)date div 100000;
      issue_year := ((integer)date div 10000) % 10;
      
      // Make sure the date has a length of 8 & all integers (a valid date)
      date_check := IF(LENGTH(TRIM(date, left, right)) = 8,
                        IF(stringlib.stringfilterout(date, '0123456789') = '',
                            TRIM(date, left, right),
                            ''
                        ),
                        ''
                    );
                    
      code_check := IF(stringlib.stringfilterout(cd[1], '0123456789') = '',
                        cd[1],
                        ''
                    );
      int_code_check := (integer)code_check;
      
      // If the expiration date code (cd) is greater than or equal to the issue_year
      // the expiration date decade does not change
      // else the expiration date decade must increase one (or the exp date will be in the past)
      // otherwise the the incoming date or expiration code is invalid - return all zeros
      
      true_exp_yr := IF(date_check != '' AND code_check != '',
                        IF (int_code_check >= issue_year,
                           (string)(issue_decade * 10 + int_code_check),
                           (string)(((issue_decade + 1) * 10) + int_code_check)
                        ),
                        '0000'
                     );
        
      RETURN true_exp_yr;
    END;
  
    export string2 code_to_month(string cd1) :=
      FUNCTION
            // A January
            // B February
            // C March
            // D April
            // E May
            // F June
            // G July
            // H August
            // J September
            // K October
            // L November
            // M December
        month := CASE (cd1[2], 'A' =>'01',
                               'B' =>'02',
                               'C' =>'03',
                               'D' =>'04',
                               'E' =>'05',
                               'F' =>'06',
                               'G' =>'07',
                               'H' =>'08',
                               'J' =>'09',
                               'K' =>'10',
                               'L' =>'11',
                               'M' =>'12',
                                      '00');
        RETURN month;
      END;
    
  export setAddressFields(string primname, string primrange, string predir, string postdir,
                          string addrsuff, string unitdesig, string secrange, string pcityname,
              string vcityname, string paramcity, string st, string zip, string zip4,
              string countyname, string postalcode) :=
              iesp.ECL2ESP.SetAddress (primname, primrange, predir, postdir, addrsuff, unitdesig, secrange,
                 trim(ms(pcityname, vcityname, paramcity),left,right), st, zip, zip4, countyname, postalcode,
                 streetAddress1Value(primname, primrange, predir, addrsuff, postdir),
                 streetAddress2Value(pcityname, vcityname, paramcity, st, zip),
                 stateCityZipValue(pcityname, vcityname, paramcity, st, zip));

  export fnatfSearchVal(dataset(atf_services.Layouts.rawrecCrimInd) in_recs, ATF_Services.IParam.search_params in_mod) := function
    
    nss_constant := Suppress.Constants.NonSubjectSuppression;
    nss_value := in_mod.non_subject_suppression;
    string in_city := in_mod.city;
        
    iesp.firearm_fcra.t_FcraFirearmRecord xform(in_recs l) := TRANSFORM
      raw_license_name := if(nss_value = nss_constant.doNothing, l.License_Name, '');
      //determine which name to use
      boolean is_license1 := l.rec_code in ATF_Services.Constants.license1_set;
      boolean has_co_subject := l.license1_fname <> '' and l.license1_lname <> ''
                              and l.license2_fname <> '' and l.license2_lname <> '';
      lic_1 := iesp.ECL2ESP.SetName (l.license1_fname, l.license1_mname, l.license1_lname, l.license1_name_suffix, '',
                            fullNameValue(l.license1_fname, l.license1_mname, l.license1_lname, raw_license_name));
      lic_2 := iesp.ECL2ESP.SetName (l.license2_fname, l.license2_mname, l.license2_lname, l.license2_name_suffix, '',
                            fullNameValue(l.license2_fname, l.license2_mname, l.license2_lname, raw_license_name));
      lic_rest := iesp.ECL2ESP.SetName ('', '', FCRA.Constants.FCRA_Restricted, '', '');
      subject_lic := if(is_license1, lic_1, lic_2);
      non_subject_lic := if(is_license1, lic_2, lic_1);
      comp_name := if(is_license1, l.license1_cname, l.license2_cname);
      
      self.UniqueId:=if((unsigned) l.did_out=0,'',(string) l.did_out);
      self.LicenseIssueState := l.Lic_Dist,
      self.licenseNumber := l.license_number,
      
      v3codes_Lic_Type := codes.key_codes_v3 (keyed(file_name='ATF_FIREARMS_EXPLOSIVES'), keyed(field_name='LIC_TYPE'), keyed(field_name2=''), keyed(code=l.Lic_Type));
      self.LicenseType := trim(LIMIT (v3codes_Lic_Type, 1, KEYED)[1].long_desc),//l.Lic_Type,
      
      string8 my_date_string8 := code_to_year(l.lic_xprdte, l.date_first_seen)+ code_to_month(l.lic_xprdte) + '00';
      self.LicenseExpireDate := iesp.ECL2ESP.toDatestring8(my_date_string8),
      
      Self.LicenseName := subject_lic,

      self.RawLicenseName := raw_license_name,
      self.LicenseCompany := comp_name,
      self.TradeName := l.Business_Name,
      self.SSN :=l.best_ssn,
      self.MailingAddress := setAddressFields(l.mail_prim_name, l.mail_prim_range, l.mail_predir, l.mail_postdir, l.mail_suffix,
                                    l.mail_unit_desig,l.mail_sec_range, l.mail_p_city_name,l.mail_v_city_name, in_city,
                  l.mail_st, l.mail_zip, l.mail_zip4,'', ''),
      
      Self.PremiseAddress := setAddressFields(l.premise_prim_name, l.premise_prim_range, l.premise_predir, l.premise_postdir, l.premise_suffix,
                                    l.premise_unit_desig,l.premise_sec_range, l.premise_p_city_name,l.premise_v_city_name, in_city,
                  l.premise_st, l.premise_zip, l.premise_zip4,l.premise_fips_County_name, ''),
      
      self.BusinessPhone := l.Voice_Phone,
      
      v3codes_IRS_Reg := codes.key_codes_v3(keyed(file_name=ATF_Services.Constants.codesv3_file_name),
                                            keyed(field_name=ATF_Services.Constants.codesv3_field_name),
                                            keyed(field_name2=''),
                                            keyed(code=l.irs_region));
      self.IRSRegion := trim(LIMIT (v3codes_IRS_Reg, 1, KEYED)[1].long_desc),//l.irs_region,
      
      self.LicenseRegion := l.Lic_Regn,
      self.CountyName :=l.premise_fips_County_name,
      self._penalty := l.penalt;
      self.AlsoFound := l.isDeepDive;
      self.LicenseNames:= map(nss_value = nss_constant.returnRestrictedDescription => if(has_co_subject, subject_lic & lic_rest, dataset(subject_lic)),
                              nss_value = nss_constant.returnBlank => dataset(subject_lic),
                              (subject_lic & non_subject_lic)(last<>'' and first<>''));
      self.HasCriminalConviction := l.hasCriminalConviction;
      self.IsSexualOffender := l.isSexualOffender;
      self.StatementIDs := l.StatementIDs;
      self.IsDisputed := l.IsDisputed;
      self := [];
    END;
    //dedup by license_number and seq in case the search was done by lnum or autokeys which would yield to dup records.
    dup_recs := sort(dedup(sort(in_recs, license_number, seq, penalt, d_score, bdid_score, if(best_ssn <> '', 1, 2), rec_code), license_number, seq), -date_last_seen);
    final_recs := choosen(project(dup_recs, xform(left)), iesp.Constants.ATF_MAX_COUNT_SEARCH_RECORDS);
    
    return(final_recs);
  end;
  
  export CalculatePenalty(ATF_Services.IParam.search_params in_mod, atf_Services.Layouts.rawrec rec_in) := function
    tempindvmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
        export allow_wildcard := false;
        export city_field := rec_in.premise_p_city_name;
        export did_field := rec_in.did_out;
        export fname_field := rec_in.license1_fname;
        export lname_field := rec_in.license1_lname;
        export mname_field := rec_in.license1_mname;
        export pname_field := rec_in.premise_prim_name;
        export postdir_field := rec_in.premise_postdir;
        export prange_field := rec_in.premise_prim_range;
        export predir_field := rec_in.premise_predir;
        export ssn_field := rec_in.best_ssn;
        export state_field := rec_in.premise_st;
        export suffix_field := rec_in.premise_suffix;
        export sec_range_field := rec_in.premise_sec_range;
        export zip_field := rec_in.premise_zip;
        // Empty non input.
        export city2_field := '';
        export county_field := '';
        export dob_field := '';
        export dod_field := '';
        export phone_field := '';
      end;
      tempindv2mod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
        export allow_wildcard := false;
        export city_field := rec_in.premise_p_city_name;
        export did_field := rec_in.did_out;
        export fname_field := rec_in.license2_fname;
        export lname_field := rec_in.license2_lname;
        export mname_field := rec_in.license2_mname;
        export pname_field := rec_in.premise_prim_name;
        export postdir_field := rec_in.premise_postdir;
        export prange_field := rec_in.premise_prim_range;
        export predir_field := rec_in.premise_predir;
        export ssn_field := rec_in.best_ssn;
        export state_field := rec_in.premise_st;
        export suffix_field := rec_in.premise_suffix;
        export sec_range_field := rec_in.premise_sec_range;
        export zip_field := rec_in.premise_zip;
        // Empty non input.
        export city2_field := '';
        export county_field := '';
        export dob_field := '';
        export dod_field := '';
        export phone_field := '';
      end;
      tempindvmod_mail := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
        export allow_wildcard := false;
        export city_field := rec_in.mail_p_city_name;
        export did_field := rec_in.did_out;
        export fname_field := rec_in.license1_fname;
        export lname_field := rec_in.license1_lname;
        export mname_field := rec_in.license1_mname;
        export pname_field := rec_in.mail_prim_name;
        export postdir_field := rec_in.mail_postdir;
        export prange_field := rec_in.mail_prim_range;
        export predir_field := rec_in.mail_predir;
        export ssn_field := rec_in.best_ssn;
        export state_field := rec_in.mail_st;
        export suffix_field := rec_in.mail_suffix;
        export sec_range_field := rec_in.mail_sec_range;
        export zip_field := rec_in.mail_zip;
        // Empty non input.
        export city2_field := '';
        export county_field := '';
        export dob_field := '';
        export dod_field := '';
        export phone_field := '';
      end;
      tempindv2mod_mail := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
        export allow_wildcard := false;
        export city_field := rec_in.mail_p_city_name;
        export did_field := rec_in.did_out;
        export fname_field := rec_in.license2_fname;
        export lname_field := rec_in.license2_lname;
        export mname_field := rec_in.license2_mname;
        export pname_field := rec_in.mail_prim_name;
        export postdir_field := rec_in.mail_postdir;
        export prange_field := rec_in.mail_prim_range;
        export predir_field := rec_in.mail_predir;
        export ssn_field := rec_in.best_ssn;
        export state_field := rec_in.mail_st;
        export suffix_field := rec_in.mail_suffix;
        export sec_range_field := rec_in.mail_sec_range;
        export zip_field := rec_in.mail_zip;
        // Empty non input.
        export city2_field := '';
        export county_field := '';
        export dob_field := '';
        export dod_field := '';
        export phone_field := '';
      end;
      tempbizmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,opt))
        export allow_wildcard := false;
        export cname_field := rec_in.Business_Name;
        // Empty non input, we only need business name here, address penalty is calculated in previous step.
        export bdid_field := '';
        export city_field := '';
        export fein_field := '';
        export phone_field := '';
        export pname_field := '';
        export postdir_field := '';
        export prange_field := '';
        export predir_field := '';
        export state_field := '';
        export suffix_field := '';
        export sec_range_field := '';
        export zip_field := '';
        export city2_field := '';
        export county_field := '';
      end;
      
      tempPenaltIndv1_premise := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
      tempPenaltIndv1_mail := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod_mail);
      tempPenaltIndv2_premise := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindv2mod);
      tempPenaltIndv2_mail := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindv2mod_mail);
      
      //make sure penalty for individual is applied to correct name
      tempPenaltIndv_premise := if(rec_in.rec_code in ATF_Services.Constants.license1_set, tempPenaltIndv1_premise, tempPenaltIndv2_premise);
      tempPenaltIndv_mail := if(rec_in.rec_code in ATF_Services.Constants.license1_set, tempPenaltIndv1_mail, tempPenaltIndv2_mail);
      
      tempPenaltBiz := AutoStandardI.LIBCALL_PenaltyI_Biz.val_biz_name(tempbizmod);
                  
      tempPenaltIndv := min(dataset([{tempPenaltIndv_premise},
               {tempPenaltIndv_mail}],
               {unsigned1 tmp_penalty}),tmp_penalty);
  return tempPenaltIndv + tempPenaltBiz;
  end;
end;
