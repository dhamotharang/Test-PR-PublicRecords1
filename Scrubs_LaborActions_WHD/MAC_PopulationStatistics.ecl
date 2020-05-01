 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dartid = '',Input_dateadded = '',Input_dateupdated = '',Input_website = '',Input_state = '',Input_caseid = '',Input_employername = '',Input_address1 = '',Input_city = '',Input_employerstate = '',Input_zipcode = '',Input_naicscode = '',Input_totalviolations = '',Input_bw_totalagreedamount = '',Input_cmp_totalassessments = '',Input_ee_totalviolations = '',Input_ee_totalagreedcount = '',Input_ca_countviolations = '',Input_ca_bw_agreedamount = '',Input_ca_ee_agreedcount = '',Input_ccpa_countviolations = '',Input_ccpa_bw_agreedamount = '',Input_ccpa_ee_agreedcount = '',Input_crew_countviolations = '',Input_crew_bw_agreedamount = '',Input_crew_cmp_assessedamount = '',Input_crew_ee_agreedcount = '',Input_cwhssa_countviolations = '',Input_cwhssa_bw_agreedamount = '',Input_cwhssa_ee_agreedcount = '',Input_dbra_cl_countviolations = '',Input_dbra_bw_agreedamount = '',Input_dbra_ee_agreedcount = '',Input_eev_countviolations = '',Input_eppa_countviolations = '',Input_eppa_bw_agreedamount = '',Input_eppa_cmp_assessedamount = '',Input_eppa_ee_agreedcount = '',Input_flsa_countviolations = '',Input_flsa_bw_15a3_agreedamount = '',Input_flsa_bw_agreedamount = '',Input_flsa_bw_minwage_agreedamount = '',Input_flsa_bw_overtime_agreedamount = '',Input_flsa_cmp_assessedamount = '',Input_flsa_ee_agreedcount = '',Input_flsa_cl_countviolations = '',Input_flsa_cl_countminorsemployed = '',Input_flsa_cl_cmp_assessedamount = '',Input_flsa_hmwkr_countviolations = '',Input_flsa_hmwkr_bw_agreedamount = '',Input_flsa_hmwkr_cmp_assessedamount = '',Input_flsa_hmwkr_ee_agreedcount = '',Input_flsa_smw14_bw_agreedamount = '',Input_flsa_smw14_countviolations = '',Input_flsa_smw14_ee_agreedcount = '',Input_flsa_smwap_countviolations = '',Input_flsa_smwap_bw_agreedamount = '',Input_flsa_smwap_ee_agreedcount = '',Input_flsa_smwft_countviolations = '',Input_flsa_smwft_bw_agreedamount = '',Input_flsa_smwft_ee_agreedcount = '',Input_flsa_smwl_countviolations = '',Input_flsa_smwl_bw_agreedamount = '',Input_flsa_smwl_ee_agreedcount = '',Input_flsa_smwmg_countviolations = '',Input_flsa_smwmg_bw_agreedamount = '',Input_flsa_smwmg_ee_agreedcount = '',Input_flsa_smwpw_countviolations = '',Input_flsa_smwpw_bw_agreedamount = '',Input_flsa_smwpw_ee_agreedcount = '',Input_flsa_smwsl_countviolations = '',Input_flsa_smwsl_bw_agreedamount = '',Input_flsa_smwsl_ee_agreedcount = '',Input_fmla_countviolations = '',Input_fmla_bw_agreedamount = '',Input_fmla_cmp_assessedamount = '',Input_fmla_ee_agreedcount = '',Input_h1a_countviolations = '',Input_h1a_bw_agreedamount = '',Input_h1a_cmp_assessedamount = '',Input_h1a_ee_agreedcount = '',Input_h1b_countviolations = '',Input_h1b_bw_agreedamount = '',Input_h1b_cmp_assessedamount = '',Input_h1b_ee_agreedcount = '',Input_h2a_countviolations = '',Input_h2a_bw_agreedamount = '',Input_h2a_cmp_assessedamount = '',Input_h2a_ee_agreedcount = '',Input_h2b_countviolations = '',Input_h2b_bw_agreedamount = '',Input_h2b_ee_agreedcount = '',Input_mpsa_countviolations = '',Input_mpsa_bw_agreedamount = '',Input_mpsa_cmp_assessedamount = '',Input_mpsa_ee_agreedcount = '',Input_osha_countviolations = '',Input_osha_bw_agreedamount = '',Input_osha_cmp_assessedamount = '',Input_osha_ee_agreedcount = '',Input_pca_countviolations = '',Input_pca_bw_agreedamount = '',Input_pca_ee_agreedcount = '',Input_sca_countviolations = '',Input_sca_bw_agreedamount = '',Input_sca_ee_agreedcount = '',Input_sraw_countviolations = '',Input_sraw_bw_agreedamount = '',Input_sraw_ee_agreedcount = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_LaborActions_WHD;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dartid)='' )
      '' 
    #ELSE
        IF( le.Input_dartid = (TYPEOF(le.Input_dartid))'','',':dartid')
    #END
 
+    #IF( #TEXT(Input_dateadded)='' )
      '' 
    #ELSE
        IF( le.Input_dateadded = (TYPEOF(le.Input_dateadded))'','',':dateadded')
    #END
 
+    #IF( #TEXT(Input_dateupdated)='' )
      '' 
    #ELSE
        IF( le.Input_dateupdated = (TYPEOF(le.Input_dateupdated))'','',':dateupdated')
    #END
 
+    #IF( #TEXT(Input_website)='' )
      '' 
    #ELSE
        IF( le.Input_website = (TYPEOF(le.Input_website))'','',':website')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_caseid)='' )
      '' 
    #ELSE
        IF( le.Input_caseid = (TYPEOF(le.Input_caseid))'','',':caseid')
    #END
 
+    #IF( #TEXT(Input_employername)='' )
      '' 
    #ELSE
        IF( le.Input_employername = (TYPEOF(le.Input_employername))'','',':employername')
    #END
 
+    #IF( #TEXT(Input_address1)='' )
      '' 
    #ELSE
        IF( le.Input_address1 = (TYPEOF(le.Input_address1))'','',':address1')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_employerstate)='' )
      '' 
    #ELSE
        IF( le.Input_employerstate = (TYPEOF(le.Input_employerstate))'','',':employerstate')
    #END
 
+    #IF( #TEXT(Input_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_zipcode = (TYPEOF(le.Input_zipcode))'','',':zipcode')
    #END
 
+    #IF( #TEXT(Input_naicscode)='' )
      '' 
    #ELSE
        IF( le.Input_naicscode = (TYPEOF(le.Input_naicscode))'','',':naicscode')
    #END
 
+    #IF( #TEXT(Input_totalviolations)='' )
      '' 
    #ELSE
        IF( le.Input_totalviolations = (TYPEOF(le.Input_totalviolations))'','',':totalviolations')
    #END
 
+    #IF( #TEXT(Input_bw_totalagreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_bw_totalagreedamount = (TYPEOF(le.Input_bw_totalagreedamount))'','',':bw_totalagreedamount')
    #END
 
+    #IF( #TEXT(Input_cmp_totalassessments)='' )
      '' 
    #ELSE
        IF( le.Input_cmp_totalassessments = (TYPEOF(le.Input_cmp_totalassessments))'','',':cmp_totalassessments')
    #END
 
+    #IF( #TEXT(Input_ee_totalviolations)='' )
      '' 
    #ELSE
        IF( le.Input_ee_totalviolations = (TYPEOF(le.Input_ee_totalviolations))'','',':ee_totalviolations')
    #END
 
+    #IF( #TEXT(Input_ee_totalagreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_ee_totalagreedcount = (TYPEOF(le.Input_ee_totalagreedcount))'','',':ee_totalagreedcount')
    #END
 
+    #IF( #TEXT(Input_ca_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_ca_countviolations = (TYPEOF(le.Input_ca_countviolations))'','',':ca_countviolations')
    #END
 
+    #IF( #TEXT(Input_ca_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_ca_bw_agreedamount = (TYPEOF(le.Input_ca_bw_agreedamount))'','',':ca_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_ca_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_ca_ee_agreedcount = (TYPEOF(le.Input_ca_ee_agreedcount))'','',':ca_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_ccpa_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_ccpa_countviolations = (TYPEOF(le.Input_ccpa_countviolations))'','',':ccpa_countviolations')
    #END
 
+    #IF( #TEXT(Input_ccpa_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_ccpa_bw_agreedamount = (TYPEOF(le.Input_ccpa_bw_agreedamount))'','',':ccpa_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_ccpa_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_ccpa_ee_agreedcount = (TYPEOF(le.Input_ccpa_ee_agreedcount))'','',':ccpa_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_crew_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_crew_countviolations = (TYPEOF(le.Input_crew_countviolations))'','',':crew_countviolations')
    #END
 
+    #IF( #TEXT(Input_crew_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_crew_bw_agreedamount = (TYPEOF(le.Input_crew_bw_agreedamount))'','',':crew_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_crew_cmp_assessedamount)='' )
      '' 
    #ELSE
        IF( le.Input_crew_cmp_assessedamount = (TYPEOF(le.Input_crew_cmp_assessedamount))'','',':crew_cmp_assessedamount')
    #END
 
+    #IF( #TEXT(Input_crew_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_crew_ee_agreedcount = (TYPEOF(le.Input_crew_ee_agreedcount))'','',':crew_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_cwhssa_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_cwhssa_countviolations = (TYPEOF(le.Input_cwhssa_countviolations))'','',':cwhssa_countviolations')
    #END
 
+    #IF( #TEXT(Input_cwhssa_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_cwhssa_bw_agreedamount = (TYPEOF(le.Input_cwhssa_bw_agreedamount))'','',':cwhssa_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_cwhssa_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_cwhssa_ee_agreedcount = (TYPEOF(le.Input_cwhssa_ee_agreedcount))'','',':cwhssa_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_dbra_cl_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_dbra_cl_countviolations = (TYPEOF(le.Input_dbra_cl_countviolations))'','',':dbra_cl_countviolations')
    #END
 
+    #IF( #TEXT(Input_dbra_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_dbra_bw_agreedamount = (TYPEOF(le.Input_dbra_bw_agreedamount))'','',':dbra_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_dbra_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_dbra_ee_agreedcount = (TYPEOF(le.Input_dbra_ee_agreedcount))'','',':dbra_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_eev_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_eev_countviolations = (TYPEOF(le.Input_eev_countviolations))'','',':eev_countviolations')
    #END
 
+    #IF( #TEXT(Input_eppa_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_eppa_countviolations = (TYPEOF(le.Input_eppa_countviolations))'','',':eppa_countviolations')
    #END
 
+    #IF( #TEXT(Input_eppa_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_eppa_bw_agreedamount = (TYPEOF(le.Input_eppa_bw_agreedamount))'','',':eppa_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_eppa_cmp_assessedamount)='' )
      '' 
    #ELSE
        IF( le.Input_eppa_cmp_assessedamount = (TYPEOF(le.Input_eppa_cmp_assessedamount))'','',':eppa_cmp_assessedamount')
    #END
 
+    #IF( #TEXT(Input_eppa_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_eppa_ee_agreedcount = (TYPEOF(le.Input_eppa_ee_agreedcount))'','',':eppa_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_flsa_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_countviolations = (TYPEOF(le.Input_flsa_countviolations))'','',':flsa_countviolations')
    #END
 
+    #IF( #TEXT(Input_flsa_bw_15a3_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_bw_15a3_agreedamount = (TYPEOF(le.Input_flsa_bw_15a3_agreedamount))'','',':flsa_bw_15a3_agreedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_bw_agreedamount = (TYPEOF(le.Input_flsa_bw_agreedamount))'','',':flsa_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_bw_minwage_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_bw_minwage_agreedamount = (TYPEOF(le.Input_flsa_bw_minwage_agreedamount))'','',':flsa_bw_minwage_agreedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_bw_overtime_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_bw_overtime_agreedamount = (TYPEOF(le.Input_flsa_bw_overtime_agreedamount))'','',':flsa_bw_overtime_agreedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_cmp_assessedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_cmp_assessedamount = (TYPEOF(le.Input_flsa_cmp_assessedamount))'','',':flsa_cmp_assessedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_ee_agreedcount = (TYPEOF(le.Input_flsa_ee_agreedcount))'','',':flsa_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_flsa_cl_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_cl_countviolations = (TYPEOF(le.Input_flsa_cl_countviolations))'','',':flsa_cl_countviolations')
    #END
 
+    #IF( #TEXT(Input_flsa_cl_countminorsemployed)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_cl_countminorsemployed = (TYPEOF(le.Input_flsa_cl_countminorsemployed))'','',':flsa_cl_countminorsemployed')
    #END
 
+    #IF( #TEXT(Input_flsa_cl_cmp_assessedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_cl_cmp_assessedamount = (TYPEOF(le.Input_flsa_cl_cmp_assessedamount))'','',':flsa_cl_cmp_assessedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_hmwkr_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_hmwkr_countviolations = (TYPEOF(le.Input_flsa_hmwkr_countviolations))'','',':flsa_hmwkr_countviolations')
    #END
 
+    #IF( #TEXT(Input_flsa_hmwkr_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_hmwkr_bw_agreedamount = (TYPEOF(le.Input_flsa_hmwkr_bw_agreedamount))'','',':flsa_hmwkr_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_hmwkr_cmp_assessedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_hmwkr_cmp_assessedamount = (TYPEOF(le.Input_flsa_hmwkr_cmp_assessedamount))'','',':flsa_hmwkr_cmp_assessedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_hmwkr_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_hmwkr_ee_agreedcount = (TYPEOF(le.Input_flsa_hmwkr_ee_agreedcount))'','',':flsa_hmwkr_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_flsa_smw14_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smw14_bw_agreedamount = (TYPEOF(le.Input_flsa_smw14_bw_agreedamount))'','',':flsa_smw14_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_smw14_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smw14_countviolations = (TYPEOF(le.Input_flsa_smw14_countviolations))'','',':flsa_smw14_countviolations')
    #END
 
+    #IF( #TEXT(Input_flsa_smw14_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smw14_ee_agreedcount = (TYPEOF(le.Input_flsa_smw14_ee_agreedcount))'','',':flsa_smw14_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_flsa_smwap_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwap_countviolations = (TYPEOF(le.Input_flsa_smwap_countviolations))'','',':flsa_smwap_countviolations')
    #END
 
+    #IF( #TEXT(Input_flsa_smwap_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwap_bw_agreedamount = (TYPEOF(le.Input_flsa_smwap_bw_agreedamount))'','',':flsa_smwap_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_smwap_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwap_ee_agreedcount = (TYPEOF(le.Input_flsa_smwap_ee_agreedcount))'','',':flsa_smwap_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_flsa_smwft_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwft_countviolations = (TYPEOF(le.Input_flsa_smwft_countviolations))'','',':flsa_smwft_countviolations')
    #END
 
+    #IF( #TEXT(Input_flsa_smwft_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwft_bw_agreedamount = (TYPEOF(le.Input_flsa_smwft_bw_agreedamount))'','',':flsa_smwft_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_smwft_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwft_ee_agreedcount = (TYPEOF(le.Input_flsa_smwft_ee_agreedcount))'','',':flsa_smwft_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_flsa_smwl_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwl_countviolations = (TYPEOF(le.Input_flsa_smwl_countviolations))'','',':flsa_smwl_countviolations')
    #END
 
+    #IF( #TEXT(Input_flsa_smwl_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwl_bw_agreedamount = (TYPEOF(le.Input_flsa_smwl_bw_agreedamount))'','',':flsa_smwl_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_smwl_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwl_ee_agreedcount = (TYPEOF(le.Input_flsa_smwl_ee_agreedcount))'','',':flsa_smwl_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_flsa_smwmg_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwmg_countviolations = (TYPEOF(le.Input_flsa_smwmg_countviolations))'','',':flsa_smwmg_countviolations')
    #END
 
+    #IF( #TEXT(Input_flsa_smwmg_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwmg_bw_agreedamount = (TYPEOF(le.Input_flsa_smwmg_bw_agreedamount))'','',':flsa_smwmg_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_smwmg_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwmg_ee_agreedcount = (TYPEOF(le.Input_flsa_smwmg_ee_agreedcount))'','',':flsa_smwmg_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_flsa_smwpw_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwpw_countviolations = (TYPEOF(le.Input_flsa_smwpw_countviolations))'','',':flsa_smwpw_countviolations')
    #END
 
+    #IF( #TEXT(Input_flsa_smwpw_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwpw_bw_agreedamount = (TYPEOF(le.Input_flsa_smwpw_bw_agreedamount))'','',':flsa_smwpw_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_smwpw_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwpw_ee_agreedcount = (TYPEOF(le.Input_flsa_smwpw_ee_agreedcount))'','',':flsa_smwpw_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_flsa_smwsl_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwsl_countviolations = (TYPEOF(le.Input_flsa_smwsl_countviolations))'','',':flsa_smwsl_countviolations')
    #END
 
+    #IF( #TEXT(Input_flsa_smwsl_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwsl_bw_agreedamount = (TYPEOF(le.Input_flsa_smwsl_bw_agreedamount))'','',':flsa_smwsl_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_flsa_smwsl_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_flsa_smwsl_ee_agreedcount = (TYPEOF(le.Input_flsa_smwsl_ee_agreedcount))'','',':flsa_smwsl_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_fmla_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_fmla_countviolations = (TYPEOF(le.Input_fmla_countviolations))'','',':fmla_countviolations')
    #END
 
+    #IF( #TEXT(Input_fmla_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_fmla_bw_agreedamount = (TYPEOF(le.Input_fmla_bw_agreedamount))'','',':fmla_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_fmla_cmp_assessedamount)='' )
      '' 
    #ELSE
        IF( le.Input_fmla_cmp_assessedamount = (TYPEOF(le.Input_fmla_cmp_assessedamount))'','',':fmla_cmp_assessedamount')
    #END
 
+    #IF( #TEXT(Input_fmla_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_fmla_ee_agreedcount = (TYPEOF(le.Input_fmla_ee_agreedcount))'','',':fmla_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_h1a_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_h1a_countviolations = (TYPEOF(le.Input_h1a_countviolations))'','',':h1a_countviolations')
    #END
 
+    #IF( #TEXT(Input_h1a_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_h1a_bw_agreedamount = (TYPEOF(le.Input_h1a_bw_agreedamount))'','',':h1a_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_h1a_cmp_assessedamount)='' )
      '' 
    #ELSE
        IF( le.Input_h1a_cmp_assessedamount = (TYPEOF(le.Input_h1a_cmp_assessedamount))'','',':h1a_cmp_assessedamount')
    #END
 
+    #IF( #TEXT(Input_h1a_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_h1a_ee_agreedcount = (TYPEOF(le.Input_h1a_ee_agreedcount))'','',':h1a_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_h1b_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_h1b_countviolations = (TYPEOF(le.Input_h1b_countviolations))'','',':h1b_countviolations')
    #END
 
+    #IF( #TEXT(Input_h1b_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_h1b_bw_agreedamount = (TYPEOF(le.Input_h1b_bw_agreedamount))'','',':h1b_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_h1b_cmp_assessedamount)='' )
      '' 
    #ELSE
        IF( le.Input_h1b_cmp_assessedamount = (TYPEOF(le.Input_h1b_cmp_assessedamount))'','',':h1b_cmp_assessedamount')
    #END
 
+    #IF( #TEXT(Input_h1b_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_h1b_ee_agreedcount = (TYPEOF(le.Input_h1b_ee_agreedcount))'','',':h1b_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_h2a_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_h2a_countviolations = (TYPEOF(le.Input_h2a_countviolations))'','',':h2a_countviolations')
    #END
 
+    #IF( #TEXT(Input_h2a_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_h2a_bw_agreedamount = (TYPEOF(le.Input_h2a_bw_agreedamount))'','',':h2a_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_h2a_cmp_assessedamount)='' )
      '' 
    #ELSE
        IF( le.Input_h2a_cmp_assessedamount = (TYPEOF(le.Input_h2a_cmp_assessedamount))'','',':h2a_cmp_assessedamount')
    #END
 
+    #IF( #TEXT(Input_h2a_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_h2a_ee_agreedcount = (TYPEOF(le.Input_h2a_ee_agreedcount))'','',':h2a_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_h2b_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_h2b_countviolations = (TYPEOF(le.Input_h2b_countviolations))'','',':h2b_countviolations')
    #END
 
+    #IF( #TEXT(Input_h2b_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_h2b_bw_agreedamount = (TYPEOF(le.Input_h2b_bw_agreedamount))'','',':h2b_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_h2b_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_h2b_ee_agreedcount = (TYPEOF(le.Input_h2b_ee_agreedcount))'','',':h2b_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_mpsa_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_mpsa_countviolations = (TYPEOF(le.Input_mpsa_countviolations))'','',':mpsa_countviolations')
    #END
 
+    #IF( #TEXT(Input_mpsa_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_mpsa_bw_agreedamount = (TYPEOF(le.Input_mpsa_bw_agreedamount))'','',':mpsa_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_mpsa_cmp_assessedamount)='' )
      '' 
    #ELSE
        IF( le.Input_mpsa_cmp_assessedamount = (TYPEOF(le.Input_mpsa_cmp_assessedamount))'','',':mpsa_cmp_assessedamount')
    #END
 
+    #IF( #TEXT(Input_mpsa_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_mpsa_ee_agreedcount = (TYPEOF(le.Input_mpsa_ee_agreedcount))'','',':mpsa_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_osha_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_osha_countviolations = (TYPEOF(le.Input_osha_countviolations))'','',':osha_countviolations')
    #END
 
+    #IF( #TEXT(Input_osha_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_osha_bw_agreedamount = (TYPEOF(le.Input_osha_bw_agreedamount))'','',':osha_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_osha_cmp_assessedamount)='' )
      '' 
    #ELSE
        IF( le.Input_osha_cmp_assessedamount = (TYPEOF(le.Input_osha_cmp_assessedamount))'','',':osha_cmp_assessedamount')
    #END
 
+    #IF( #TEXT(Input_osha_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_osha_ee_agreedcount = (TYPEOF(le.Input_osha_ee_agreedcount))'','',':osha_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_pca_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_pca_countviolations = (TYPEOF(le.Input_pca_countviolations))'','',':pca_countviolations')
    #END
 
+    #IF( #TEXT(Input_pca_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_pca_bw_agreedamount = (TYPEOF(le.Input_pca_bw_agreedamount))'','',':pca_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_pca_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_pca_ee_agreedcount = (TYPEOF(le.Input_pca_ee_agreedcount))'','',':pca_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_sca_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_sca_countviolations = (TYPEOF(le.Input_sca_countviolations))'','',':sca_countviolations')
    #END
 
+    #IF( #TEXT(Input_sca_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_sca_bw_agreedamount = (TYPEOF(le.Input_sca_bw_agreedamount))'','',':sca_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_sca_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_sca_ee_agreedcount = (TYPEOF(le.Input_sca_ee_agreedcount))'','',':sca_ee_agreedcount')
    #END
 
+    #IF( #TEXT(Input_sraw_countviolations)='' )
      '' 
    #ELSE
        IF( le.Input_sraw_countviolations = (TYPEOF(le.Input_sraw_countviolations))'','',':sraw_countviolations')
    #END
 
+    #IF( #TEXT(Input_sraw_bw_agreedamount)='' )
      '' 
    #ELSE
        IF( le.Input_sraw_bw_agreedamount = (TYPEOF(le.Input_sraw_bw_agreedamount))'','',':sraw_bw_agreedamount')
    #END
 
+    #IF( #TEXT(Input_sraw_ee_agreedcount)='' )
      '' 
    #ELSE
        IF( le.Input_sraw_ee_agreedcount = (TYPEOF(le.Input_sraw_ee_agreedcount))'','',':sraw_ee_agreedcount')
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
