 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_type = '',Input_confidence = '',Input_did1 = '',Input_did2 = '',Input_cohabit_score = '',Input_cohabit_cnt = '',Input_coapt_score = '',Input_coapt_cnt = '',Input_copobox_score = '',Input_copobox_cnt = '',Input_cossn_score = '',Input_cossn_cnt = '',Input_copolicy_score = '',Input_copolicy_cnt = '',Input_coclaim_score = '',Input_coclaim_cnt = '',Input_coproperty_score = '',Input_coproperty_cnt = '',Input_bcoproperty_score = '',Input_bcoproperty_cnt = '',Input_coforeclosure_score = '',Input_coforeclosure_cnt = '',Input_bcoforeclosure_score = '',Input_bcoforeclosure_cnt = '',Input_colien_score = '',Input_colien_cnt = '',Input_bcolien_score = '',Input_bcolien_cnt = '',Input_cobankruptcy_score = '',Input_cobankruptcy_cnt = '',Input_bcobankruptcy_score = '',Input_bcobankruptcy_cnt = '',Input_covehicle_score = '',Input_covehicle_cnt = '',Input_coexperian_score = '',Input_coexperian_cnt = '',Input_cotransunion_score = '',Input_cotransunion_cnt = '',Input_coenclarity_score = '',Input_coenclarity_cnt = '',Input_coecrash_score = '',Input_coecrash_cnt = '',Input_bcoecrash_score = '',Input_bcoecrash_cnt = '',Input_cowatercraft_score = '',Input_cowatercraft_cnt = '',Input_coaircraft_score = '',Input_coaircraft_cnt = '',Input_comarriagedivorce_score = '',Input_comarriagedivorce_cnt = '',Input_coucc_score = '',Input_coucc_cnt = '',Input_lname_score = '',Input_phone_score = '',Input_dl_nbr_score = '',Input_total_cnt = '',Input_total_score = '',Input_cluster = '',Input_generation = '',Input_gender = '',Input_lname_cnt = '',Input_rel_dt_first_seen = '',Input_rel_dt_last_seen = '',Input_overlap_months = '',Input_hdr_dt_first_seen = '',Input_hdr_dt_last_seen = '',Input_age_first_seen = '',Input_isanylnamematch = '',Input_isanyphonematch = '',Input_isearlylnamematch = '',Input_iscurrlnamematch = '',Input_ismixedlnamematch = '',Input_ssn1 = '',Input_ssn2 = '',Input_dob1 = '',Input_dob2 = '',Input_current_lname1 = '',Input_current_lname2 = '',Input_early_lname1 = '',Input_early_lname2 = '',Input_addr_ind1 = '',Input_addr_ind2 = '',Input_r2rdid = '',Input_r2cnt = '',Input_personal = '',Input_business = '',Input_other = '',Input_title = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_FileRelative_Monthly;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_type)='' )
      '' 
    #ELSE
        IF( le.Input_type = (TYPEOF(le.Input_type))'','',':type')
    #END
 
+    #IF( #TEXT(Input_confidence)='' )
      '' 
    #ELSE
        IF( le.Input_confidence = (TYPEOF(le.Input_confidence))'','',':confidence')
    #END
 
+    #IF( #TEXT(Input_did1)='' )
      '' 
    #ELSE
        IF( le.Input_did1 = (TYPEOF(le.Input_did1))'','',':did1')
    #END
 
+    #IF( #TEXT(Input_did2)='' )
      '' 
    #ELSE
        IF( le.Input_did2 = (TYPEOF(le.Input_did2))'','',':did2')
    #END
 
+    #IF( #TEXT(Input_cohabit_score)='' )
      '' 
    #ELSE
        IF( le.Input_cohabit_score = (TYPEOF(le.Input_cohabit_score))'','',':cohabit_score')
    #END
 
+    #IF( #TEXT(Input_cohabit_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_cohabit_cnt = (TYPEOF(le.Input_cohabit_cnt))'','',':cohabit_cnt')
    #END
 
+    #IF( #TEXT(Input_coapt_score)='' )
      '' 
    #ELSE
        IF( le.Input_coapt_score = (TYPEOF(le.Input_coapt_score))'','',':coapt_score')
    #END
 
+    #IF( #TEXT(Input_coapt_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_coapt_cnt = (TYPEOF(le.Input_coapt_cnt))'','',':coapt_cnt')
    #END
 
+    #IF( #TEXT(Input_copobox_score)='' )
      '' 
    #ELSE
        IF( le.Input_copobox_score = (TYPEOF(le.Input_copobox_score))'','',':copobox_score')
    #END
 
+    #IF( #TEXT(Input_copobox_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_copobox_cnt = (TYPEOF(le.Input_copobox_cnt))'','',':copobox_cnt')
    #END
 
+    #IF( #TEXT(Input_cossn_score)='' )
      '' 
    #ELSE
        IF( le.Input_cossn_score = (TYPEOF(le.Input_cossn_score))'','',':cossn_score')
    #END
 
+    #IF( #TEXT(Input_cossn_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_cossn_cnt = (TYPEOF(le.Input_cossn_cnt))'','',':cossn_cnt')
    #END
 
+    #IF( #TEXT(Input_copolicy_score)='' )
      '' 
    #ELSE
        IF( le.Input_copolicy_score = (TYPEOF(le.Input_copolicy_score))'','',':copolicy_score')
    #END
 
+    #IF( #TEXT(Input_copolicy_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_copolicy_cnt = (TYPEOF(le.Input_copolicy_cnt))'','',':copolicy_cnt')
    #END
 
+    #IF( #TEXT(Input_coclaim_score)='' )
      '' 
    #ELSE
        IF( le.Input_coclaim_score = (TYPEOF(le.Input_coclaim_score))'','',':coclaim_score')
    #END
 
+    #IF( #TEXT(Input_coclaim_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_coclaim_cnt = (TYPEOF(le.Input_coclaim_cnt))'','',':coclaim_cnt')
    #END
 
+    #IF( #TEXT(Input_coproperty_score)='' )
      '' 
    #ELSE
        IF( le.Input_coproperty_score = (TYPEOF(le.Input_coproperty_score))'','',':coproperty_score')
    #END
 
+    #IF( #TEXT(Input_coproperty_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_coproperty_cnt = (TYPEOF(le.Input_coproperty_cnt))'','',':coproperty_cnt')
    #END
 
+    #IF( #TEXT(Input_bcoproperty_score)='' )
      '' 
    #ELSE
        IF( le.Input_bcoproperty_score = (TYPEOF(le.Input_bcoproperty_score))'','',':bcoproperty_score')
    #END
 
+    #IF( #TEXT(Input_bcoproperty_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_bcoproperty_cnt = (TYPEOF(le.Input_bcoproperty_cnt))'','',':bcoproperty_cnt')
    #END
 
+    #IF( #TEXT(Input_coforeclosure_score)='' )
      '' 
    #ELSE
        IF( le.Input_coforeclosure_score = (TYPEOF(le.Input_coforeclosure_score))'','',':coforeclosure_score')
    #END
 
+    #IF( #TEXT(Input_coforeclosure_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_coforeclosure_cnt = (TYPEOF(le.Input_coforeclosure_cnt))'','',':coforeclosure_cnt')
    #END
 
+    #IF( #TEXT(Input_bcoforeclosure_score)='' )
      '' 
    #ELSE
        IF( le.Input_bcoforeclosure_score = (TYPEOF(le.Input_bcoforeclosure_score))'','',':bcoforeclosure_score')
    #END
 
+    #IF( #TEXT(Input_bcoforeclosure_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_bcoforeclosure_cnt = (TYPEOF(le.Input_bcoforeclosure_cnt))'','',':bcoforeclosure_cnt')
    #END
 
+    #IF( #TEXT(Input_colien_score)='' )
      '' 
    #ELSE
        IF( le.Input_colien_score = (TYPEOF(le.Input_colien_score))'','',':colien_score')
    #END
 
+    #IF( #TEXT(Input_colien_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_colien_cnt = (TYPEOF(le.Input_colien_cnt))'','',':colien_cnt')
    #END
 
+    #IF( #TEXT(Input_bcolien_score)='' )
      '' 
    #ELSE
        IF( le.Input_bcolien_score = (TYPEOF(le.Input_bcolien_score))'','',':bcolien_score')
    #END
 
+    #IF( #TEXT(Input_bcolien_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_bcolien_cnt = (TYPEOF(le.Input_bcolien_cnt))'','',':bcolien_cnt')
    #END
 
+    #IF( #TEXT(Input_cobankruptcy_score)='' )
      '' 
    #ELSE
        IF( le.Input_cobankruptcy_score = (TYPEOF(le.Input_cobankruptcy_score))'','',':cobankruptcy_score')
    #END
 
+    #IF( #TEXT(Input_cobankruptcy_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_cobankruptcy_cnt = (TYPEOF(le.Input_cobankruptcy_cnt))'','',':cobankruptcy_cnt')
    #END
 
+    #IF( #TEXT(Input_bcobankruptcy_score)='' )
      '' 
    #ELSE
        IF( le.Input_bcobankruptcy_score = (TYPEOF(le.Input_bcobankruptcy_score))'','',':bcobankruptcy_score')
    #END
 
+    #IF( #TEXT(Input_bcobankruptcy_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_bcobankruptcy_cnt = (TYPEOF(le.Input_bcobankruptcy_cnt))'','',':bcobankruptcy_cnt')
    #END
 
+    #IF( #TEXT(Input_covehicle_score)='' )
      '' 
    #ELSE
        IF( le.Input_covehicle_score = (TYPEOF(le.Input_covehicle_score))'','',':covehicle_score')
    #END
 
+    #IF( #TEXT(Input_covehicle_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_covehicle_cnt = (TYPEOF(le.Input_covehicle_cnt))'','',':covehicle_cnt')
    #END
 
+    #IF( #TEXT(Input_coexperian_score)='' )
      '' 
    #ELSE
        IF( le.Input_coexperian_score = (TYPEOF(le.Input_coexperian_score))'','',':coexperian_score')
    #END
 
+    #IF( #TEXT(Input_coexperian_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_coexperian_cnt = (TYPEOF(le.Input_coexperian_cnt))'','',':coexperian_cnt')
    #END
 
+    #IF( #TEXT(Input_cotransunion_score)='' )
      '' 
    #ELSE
        IF( le.Input_cotransunion_score = (TYPEOF(le.Input_cotransunion_score))'','',':cotransunion_score')
    #END
 
+    #IF( #TEXT(Input_cotransunion_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_cotransunion_cnt = (TYPEOF(le.Input_cotransunion_cnt))'','',':cotransunion_cnt')
    #END
 
+    #IF( #TEXT(Input_coenclarity_score)='' )
      '' 
    #ELSE
        IF( le.Input_coenclarity_score = (TYPEOF(le.Input_coenclarity_score))'','',':coenclarity_score')
    #END
 
+    #IF( #TEXT(Input_coenclarity_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_coenclarity_cnt = (TYPEOF(le.Input_coenclarity_cnt))'','',':coenclarity_cnt')
    #END
 
+    #IF( #TEXT(Input_coecrash_score)='' )
      '' 
    #ELSE
        IF( le.Input_coecrash_score = (TYPEOF(le.Input_coecrash_score))'','',':coecrash_score')
    #END
 
+    #IF( #TEXT(Input_coecrash_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_coecrash_cnt = (TYPEOF(le.Input_coecrash_cnt))'','',':coecrash_cnt')
    #END
 
+    #IF( #TEXT(Input_bcoecrash_score)='' )
      '' 
    #ELSE
        IF( le.Input_bcoecrash_score = (TYPEOF(le.Input_bcoecrash_score))'','',':bcoecrash_score')
    #END
 
+    #IF( #TEXT(Input_bcoecrash_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_bcoecrash_cnt = (TYPEOF(le.Input_bcoecrash_cnt))'','',':bcoecrash_cnt')
    #END
 
+    #IF( #TEXT(Input_cowatercraft_score)='' )
      '' 
    #ELSE
        IF( le.Input_cowatercraft_score = (TYPEOF(le.Input_cowatercraft_score))'','',':cowatercraft_score')
    #END
 
+    #IF( #TEXT(Input_cowatercraft_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_cowatercraft_cnt = (TYPEOF(le.Input_cowatercraft_cnt))'','',':cowatercraft_cnt')
    #END
 
+    #IF( #TEXT(Input_coaircraft_score)='' )
      '' 
    #ELSE
        IF( le.Input_coaircraft_score = (TYPEOF(le.Input_coaircraft_score))'','',':coaircraft_score')
    #END
 
+    #IF( #TEXT(Input_coaircraft_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_coaircraft_cnt = (TYPEOF(le.Input_coaircraft_cnt))'','',':coaircraft_cnt')
    #END
 
+    #IF( #TEXT(Input_comarriagedivorce_score)='' )
      '' 
    #ELSE
        IF( le.Input_comarriagedivorce_score = (TYPEOF(le.Input_comarriagedivorce_score))'','',':comarriagedivorce_score')
    #END
 
+    #IF( #TEXT(Input_comarriagedivorce_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_comarriagedivorce_cnt = (TYPEOF(le.Input_comarriagedivorce_cnt))'','',':comarriagedivorce_cnt')
    #END
 
+    #IF( #TEXT(Input_coucc_score)='' )
      '' 
    #ELSE
        IF( le.Input_coucc_score = (TYPEOF(le.Input_coucc_score))'','',':coucc_score')
    #END
 
+    #IF( #TEXT(Input_coucc_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_coucc_cnt = (TYPEOF(le.Input_coucc_cnt))'','',':coucc_cnt')
    #END
 
+    #IF( #TEXT(Input_lname_score)='' )
      '' 
    #ELSE
        IF( le.Input_lname_score = (TYPEOF(le.Input_lname_score))'','',':lname_score')
    #END
 
+    #IF( #TEXT(Input_phone_score)='' )
      '' 
    #ELSE
        IF( le.Input_phone_score = (TYPEOF(le.Input_phone_score))'','',':phone_score')
    #END
 
+    #IF( #TEXT(Input_dl_nbr_score)='' )
      '' 
    #ELSE
        IF( le.Input_dl_nbr_score = (TYPEOF(le.Input_dl_nbr_score))'','',':dl_nbr_score')
    #END
 
+    #IF( #TEXT(Input_total_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_total_cnt = (TYPEOF(le.Input_total_cnt))'','',':total_cnt')
    #END
 
+    #IF( #TEXT(Input_total_score)='' )
      '' 
    #ELSE
        IF( le.Input_total_score = (TYPEOF(le.Input_total_score))'','',':total_score')
    #END
 
+    #IF( #TEXT(Input_cluster)='' )
      '' 
    #ELSE
        IF( le.Input_cluster = (TYPEOF(le.Input_cluster))'','',':cluster')
    #END
 
+    #IF( #TEXT(Input_generation)='' )
      '' 
    #ELSE
        IF( le.Input_generation = (TYPEOF(le.Input_generation))'','',':generation')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_lname_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_lname_cnt = (TYPEOF(le.Input_lname_cnt))'','',':lname_cnt')
    #END
 
+    #IF( #TEXT(Input_rel_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_rel_dt_first_seen = (TYPEOF(le.Input_rel_dt_first_seen))'','',':rel_dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_rel_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_rel_dt_last_seen = (TYPEOF(le.Input_rel_dt_last_seen))'','',':rel_dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_overlap_months)='' )
      '' 
    #ELSE
        IF( le.Input_overlap_months = (TYPEOF(le.Input_overlap_months))'','',':overlap_months')
    #END
 
+    #IF( #TEXT(Input_hdr_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_hdr_dt_first_seen = (TYPEOF(le.Input_hdr_dt_first_seen))'','',':hdr_dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_hdr_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_hdr_dt_last_seen = (TYPEOF(le.Input_hdr_dt_last_seen))'','',':hdr_dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_age_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_age_first_seen = (TYPEOF(le.Input_age_first_seen))'','',':age_first_seen')
    #END
 
+    #IF( #TEXT(Input_isanylnamematch)='' )
      '' 
    #ELSE
        IF( le.Input_isanylnamematch = (TYPEOF(le.Input_isanylnamematch))'','',':isanylnamematch')
    #END
 
+    #IF( #TEXT(Input_isanyphonematch)='' )
      '' 
    #ELSE
        IF( le.Input_isanyphonematch = (TYPEOF(le.Input_isanyphonematch))'','',':isanyphonematch')
    #END
 
+    #IF( #TEXT(Input_isearlylnamematch)='' )
      '' 
    #ELSE
        IF( le.Input_isearlylnamematch = (TYPEOF(le.Input_isearlylnamematch))'','',':isearlylnamematch')
    #END
 
+    #IF( #TEXT(Input_iscurrlnamematch)='' )
      '' 
    #ELSE
        IF( le.Input_iscurrlnamematch = (TYPEOF(le.Input_iscurrlnamematch))'','',':iscurrlnamematch')
    #END
 
+    #IF( #TEXT(Input_ismixedlnamematch)='' )
      '' 
    #ELSE
        IF( le.Input_ismixedlnamematch = (TYPEOF(le.Input_ismixedlnamematch))'','',':ismixedlnamematch')
    #END
 
+    #IF( #TEXT(Input_ssn1)='' )
      '' 
    #ELSE
        IF( le.Input_ssn1 = (TYPEOF(le.Input_ssn1))'','',':ssn1')
    #END
 
+    #IF( #TEXT(Input_ssn2)='' )
      '' 
    #ELSE
        IF( le.Input_ssn2 = (TYPEOF(le.Input_ssn2))'','',':ssn2')
    #END
 
+    #IF( #TEXT(Input_dob1)='' )
      '' 
    #ELSE
        IF( le.Input_dob1 = (TYPEOF(le.Input_dob1))'','',':dob1')
    #END
 
+    #IF( #TEXT(Input_dob2)='' )
      '' 
    #ELSE
        IF( le.Input_dob2 = (TYPEOF(le.Input_dob2))'','',':dob2')
    #END
 
+    #IF( #TEXT(Input_current_lname1)='' )
      '' 
    #ELSE
        IF( le.Input_current_lname1 = (TYPEOF(le.Input_current_lname1))'','',':current_lname1')
    #END
 
+    #IF( #TEXT(Input_current_lname2)='' )
      '' 
    #ELSE
        IF( le.Input_current_lname2 = (TYPEOF(le.Input_current_lname2))'','',':current_lname2')
    #END
 
+    #IF( #TEXT(Input_early_lname1)='' )
      '' 
    #ELSE
        IF( le.Input_early_lname1 = (TYPEOF(le.Input_early_lname1))'','',':early_lname1')
    #END
 
+    #IF( #TEXT(Input_early_lname2)='' )
      '' 
    #ELSE
        IF( le.Input_early_lname2 = (TYPEOF(le.Input_early_lname2))'','',':early_lname2')
    #END
 
+    #IF( #TEXT(Input_addr_ind1)='' )
      '' 
    #ELSE
        IF( le.Input_addr_ind1 = (TYPEOF(le.Input_addr_ind1))'','',':addr_ind1')
    #END
 
+    #IF( #TEXT(Input_addr_ind2)='' )
      '' 
    #ELSE
        IF( le.Input_addr_ind2 = (TYPEOF(le.Input_addr_ind2))'','',':addr_ind2')
    #END
 
+    #IF( #TEXT(Input_r2rdid)='' )
      '' 
    #ELSE
        IF( le.Input_r2rdid = (TYPEOF(le.Input_r2rdid))'','',':r2rdid')
    #END
 
+    #IF( #TEXT(Input_r2cnt)='' )
      '' 
    #ELSE
        IF( le.Input_r2cnt = (TYPEOF(le.Input_r2cnt))'','',':r2cnt')
    #END
 
+    #IF( #TEXT(Input_personal)='' )
      '' 
    #ELSE
        IF( le.Input_personal = (TYPEOF(le.Input_personal))'','',':personal')
    #END
 
+    #IF( #TEXT(Input_business)='' )
      '' 
    #ELSE
        IF( le.Input_business = (TYPEOF(le.Input_business))'','',':business')
    #END
 
+    #IF( #TEXT(Input_other)='' )
      '' 
    #ELSE
        IF( le.Input_other = (TYPEOF(le.Input_other))'','',':other')
    #END
 
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
;
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%, fields, FEW ), 1000, -cnt );
ENDMACRO;
