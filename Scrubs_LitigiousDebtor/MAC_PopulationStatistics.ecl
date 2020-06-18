 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_record_type = '',Input_recid = '',Input_courtstate = '',Input_courtid = '',Input_courtname = '',Input_docketnumber = '',Input_officename = '',Input_asofdate = '',Input_classcode = '',Input_casecaption = '',Input_datefiled = '',Input_judgetitle = '',Input_judgename = '',Input_referredtojudgetitle = '',Input_referredtojudge = '',Input_jurydemand = '',Input_demandamount = '',Input_suitnaturecode = '',Input_suitnaturedesc = '',Input_leaddocketnumber = '',Input_jurisdiction = '',Input_cause = '',Input_statute = '',Input_ca = '',Input_caseclosed = '',Input_dateretrieved = '',Input_otherdocketnumber = '',Input_litigantname = '',Input_litigantlabel = '',Input_layoutcode = '',Input_terminationdate = '',Input_attorneyname = '',Input_attorneylabel = '',Input_firmname = '',Input_address = '',Input_city = '',Input_state = '',Input_zipcode = '',Input_country = '',Input_addtlinfo = '',Input_termdate = '',Input_bdid = '',Input_did = '',Input_causecode = '',Input_judge_title = '',Input_judge_fname = '',Input_judge_mname = '',Input_judge_lname = '',Input_judge_suffix = '',Input_judge_score = '',Input_business_person = '',Input_debtor = '',Input_debtor_title = '',Input_debtor_fname = '',Input_debtor_mname = '',Input_debtor_lname = '',Input_debtor_suffix = '',Input_debtor_score = '',Input_attorney_title = '',Input_attorney_fname = '',Input_attorney_mname = '',Input_attorney_lname = '',Input_attorney_suffix = '',Input_attorney_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_state = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_LitigiousDebtor;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_recid)='' )
      '' 
    #ELSE
        IF( le.Input_recid = (TYPEOF(le.Input_recid))'','',':recid')
    #END
 
+    #IF( #TEXT(Input_courtstate)='' )
      '' 
    #ELSE
        IF( le.Input_courtstate = (TYPEOF(le.Input_courtstate))'','',':courtstate')
    #END
 
+    #IF( #TEXT(Input_courtid)='' )
      '' 
    #ELSE
        IF( le.Input_courtid = (TYPEOF(le.Input_courtid))'','',':courtid')
    #END
 
+    #IF( #TEXT(Input_courtname)='' )
      '' 
    #ELSE
        IF( le.Input_courtname = (TYPEOF(le.Input_courtname))'','',':courtname')
    #END
 
+    #IF( #TEXT(Input_docketnumber)='' )
      '' 
    #ELSE
        IF( le.Input_docketnumber = (TYPEOF(le.Input_docketnumber))'','',':docketnumber')
    #END
 
+    #IF( #TEXT(Input_officename)='' )
      '' 
    #ELSE
        IF( le.Input_officename = (TYPEOF(le.Input_officename))'','',':officename')
    #END
 
+    #IF( #TEXT(Input_asofdate)='' )
      '' 
    #ELSE
        IF( le.Input_asofdate = (TYPEOF(le.Input_asofdate))'','',':asofdate')
    #END
 
+    #IF( #TEXT(Input_classcode)='' )
      '' 
    #ELSE
        IF( le.Input_classcode = (TYPEOF(le.Input_classcode))'','',':classcode')
    #END
 
+    #IF( #TEXT(Input_casecaption)='' )
      '' 
    #ELSE
        IF( le.Input_casecaption = (TYPEOF(le.Input_casecaption))'','',':casecaption')
    #END
 
+    #IF( #TEXT(Input_datefiled)='' )
      '' 
    #ELSE
        IF( le.Input_datefiled = (TYPEOF(le.Input_datefiled))'','',':datefiled')
    #END
 
+    #IF( #TEXT(Input_judgetitle)='' )
      '' 
    #ELSE
        IF( le.Input_judgetitle = (TYPEOF(le.Input_judgetitle))'','',':judgetitle')
    #END
 
+    #IF( #TEXT(Input_judgename)='' )
      '' 
    #ELSE
        IF( le.Input_judgename = (TYPEOF(le.Input_judgename))'','',':judgename')
    #END
 
+    #IF( #TEXT(Input_referredtojudgetitle)='' )
      '' 
    #ELSE
        IF( le.Input_referredtojudgetitle = (TYPEOF(le.Input_referredtojudgetitle))'','',':referredtojudgetitle')
    #END
 
+    #IF( #TEXT(Input_referredtojudge)='' )
      '' 
    #ELSE
        IF( le.Input_referredtojudge = (TYPEOF(le.Input_referredtojudge))'','',':referredtojudge')
    #END
 
+    #IF( #TEXT(Input_jurydemand)='' )
      '' 
    #ELSE
        IF( le.Input_jurydemand = (TYPEOF(le.Input_jurydemand))'','',':jurydemand')
    #END
 
+    #IF( #TEXT(Input_demandamount)='' )
      '' 
    #ELSE
        IF( le.Input_demandamount = (TYPEOF(le.Input_demandamount))'','',':demandamount')
    #END
 
+    #IF( #TEXT(Input_suitnaturecode)='' )
      '' 
    #ELSE
        IF( le.Input_suitnaturecode = (TYPEOF(le.Input_suitnaturecode))'','',':suitnaturecode')
    #END
 
+    #IF( #TEXT(Input_suitnaturedesc)='' )
      '' 
    #ELSE
        IF( le.Input_suitnaturedesc = (TYPEOF(le.Input_suitnaturedesc))'','',':suitnaturedesc')
    #END
 
+    #IF( #TEXT(Input_leaddocketnumber)='' )
      '' 
    #ELSE
        IF( le.Input_leaddocketnumber = (TYPEOF(le.Input_leaddocketnumber))'','',':leaddocketnumber')
    #END
 
+    #IF( #TEXT(Input_jurisdiction)='' )
      '' 
    #ELSE
        IF( le.Input_jurisdiction = (TYPEOF(le.Input_jurisdiction))'','',':jurisdiction')
    #END
 
+    #IF( #TEXT(Input_cause)='' )
      '' 
    #ELSE
        IF( le.Input_cause = (TYPEOF(le.Input_cause))'','',':cause')
    #END
 
+    #IF( #TEXT(Input_statute)='' )
      '' 
    #ELSE
        IF( le.Input_statute = (TYPEOF(le.Input_statute))'','',':statute')
    #END
 
+    #IF( #TEXT(Input_ca)='' )
      '' 
    #ELSE
        IF( le.Input_ca = (TYPEOF(le.Input_ca))'','',':ca')
    #END
 
+    #IF( #TEXT(Input_caseclosed)='' )
      '' 
    #ELSE
        IF( le.Input_caseclosed = (TYPEOF(le.Input_caseclosed))'','',':caseclosed')
    #END
 
+    #IF( #TEXT(Input_dateretrieved)='' )
      '' 
    #ELSE
        IF( le.Input_dateretrieved = (TYPEOF(le.Input_dateretrieved))'','',':dateretrieved')
    #END
 
+    #IF( #TEXT(Input_otherdocketnumber)='' )
      '' 
    #ELSE
        IF( le.Input_otherdocketnumber = (TYPEOF(le.Input_otherdocketnumber))'','',':otherdocketnumber')
    #END
 
+    #IF( #TEXT(Input_litigantname)='' )
      '' 
    #ELSE
        IF( le.Input_litigantname = (TYPEOF(le.Input_litigantname))'','',':litigantname')
    #END
 
+    #IF( #TEXT(Input_litigantlabel)='' )
      '' 
    #ELSE
        IF( le.Input_litigantlabel = (TYPEOF(le.Input_litigantlabel))'','',':litigantlabel')
    #END
 
+    #IF( #TEXT(Input_layoutcode)='' )
      '' 
    #ELSE
        IF( le.Input_layoutcode = (TYPEOF(le.Input_layoutcode))'','',':layoutcode')
    #END
 
+    #IF( #TEXT(Input_terminationdate)='' )
      '' 
    #ELSE
        IF( le.Input_terminationdate = (TYPEOF(le.Input_terminationdate))'','',':terminationdate')
    #END
 
+    #IF( #TEXT(Input_attorneyname)='' )
      '' 
    #ELSE
        IF( le.Input_attorneyname = (TYPEOF(le.Input_attorneyname))'','',':attorneyname')
    #END
 
+    #IF( #TEXT(Input_attorneylabel)='' )
      '' 
    #ELSE
        IF( le.Input_attorneylabel = (TYPEOF(le.Input_attorneylabel))'','',':attorneylabel')
    #END
 
+    #IF( #TEXT(Input_firmname)='' )
      '' 
    #ELSE
        IF( le.Input_firmname = (TYPEOF(le.Input_firmname))'','',':firmname')
    #END
 
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_zipcode = (TYPEOF(le.Input_zipcode))'','',':zipcode')
    #END
 
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
 
+    #IF( #TEXT(Input_addtlinfo)='' )
      '' 
    #ELSE
        IF( le.Input_addtlinfo = (TYPEOF(le.Input_addtlinfo))'','',':addtlinfo')
    #END
 
+    #IF( #TEXT(Input_termdate)='' )
      '' 
    #ELSE
        IF( le.Input_termdate = (TYPEOF(le.Input_termdate))'','',':termdate')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_causecode)='' )
      '' 
    #ELSE
        IF( le.Input_causecode = (TYPEOF(le.Input_causecode))'','',':causecode')
    #END
 
+    #IF( #TEXT(Input_judge_title)='' )
      '' 
    #ELSE
        IF( le.Input_judge_title = (TYPEOF(le.Input_judge_title))'','',':judge_title')
    #END
 
+    #IF( #TEXT(Input_judge_fname)='' )
      '' 
    #ELSE
        IF( le.Input_judge_fname = (TYPEOF(le.Input_judge_fname))'','',':judge_fname')
    #END
 
+    #IF( #TEXT(Input_judge_mname)='' )
      '' 
    #ELSE
        IF( le.Input_judge_mname = (TYPEOF(le.Input_judge_mname))'','',':judge_mname')
    #END
 
+    #IF( #TEXT(Input_judge_lname)='' )
      '' 
    #ELSE
        IF( le.Input_judge_lname = (TYPEOF(le.Input_judge_lname))'','',':judge_lname')
    #END
 
+    #IF( #TEXT(Input_judge_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_judge_suffix = (TYPEOF(le.Input_judge_suffix))'','',':judge_suffix')
    #END
 
+    #IF( #TEXT(Input_judge_score)='' )
      '' 
    #ELSE
        IF( le.Input_judge_score = (TYPEOF(le.Input_judge_score))'','',':judge_score')
    #END
 
+    #IF( #TEXT(Input_business_person)='' )
      '' 
    #ELSE
        IF( le.Input_business_person = (TYPEOF(le.Input_business_person))'','',':business_person')
    #END
 
+    #IF( #TEXT(Input_debtor)='' )
      '' 
    #ELSE
        IF( le.Input_debtor = (TYPEOF(le.Input_debtor))'','',':debtor')
    #END
 
+    #IF( #TEXT(Input_debtor_title)='' )
      '' 
    #ELSE
        IF( le.Input_debtor_title = (TYPEOF(le.Input_debtor_title))'','',':debtor_title')
    #END
 
+    #IF( #TEXT(Input_debtor_fname)='' )
      '' 
    #ELSE
        IF( le.Input_debtor_fname = (TYPEOF(le.Input_debtor_fname))'','',':debtor_fname')
    #END
 
+    #IF( #TEXT(Input_debtor_mname)='' )
      '' 
    #ELSE
        IF( le.Input_debtor_mname = (TYPEOF(le.Input_debtor_mname))'','',':debtor_mname')
    #END
 
+    #IF( #TEXT(Input_debtor_lname)='' )
      '' 
    #ELSE
        IF( le.Input_debtor_lname = (TYPEOF(le.Input_debtor_lname))'','',':debtor_lname')
    #END
 
+    #IF( #TEXT(Input_debtor_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_debtor_suffix = (TYPEOF(le.Input_debtor_suffix))'','',':debtor_suffix')
    #END
 
+    #IF( #TEXT(Input_debtor_score)='' )
      '' 
    #ELSE
        IF( le.Input_debtor_score = (TYPEOF(le.Input_debtor_score))'','',':debtor_score')
    #END
 
+    #IF( #TEXT(Input_attorney_title)='' )
      '' 
    #ELSE
        IF( le.Input_attorney_title = (TYPEOF(le.Input_attorney_title))'','',':attorney_title')
    #END
 
+    #IF( #TEXT(Input_attorney_fname)='' )
      '' 
    #ELSE
        IF( le.Input_attorney_fname = (TYPEOF(le.Input_attorney_fname))'','',':attorney_fname')
    #END
 
+    #IF( #TEXT(Input_attorney_mname)='' )
      '' 
    #ELSE
        IF( le.Input_attorney_mname = (TYPEOF(le.Input_attorney_mname))'','',':attorney_mname')
    #END
 
+    #IF( #TEXT(Input_attorney_lname)='' )
      '' 
    #ELSE
        IF( le.Input_attorney_lname = (TYPEOF(le.Input_attorney_lname))'','',':attorney_lname')
    #END
 
+    #IF( #TEXT(Input_attorney_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_attorney_suffix = (TYPEOF(le.Input_attorney_suffix))'','',':attorney_suffix')
    #END
 
+    #IF( #TEXT(Input_attorney_score)='' )
      '' 
    #ELSE
        IF( le.Input_attorney_score = (TYPEOF(le.Input_attorney_score))'','',':attorney_score')
    #END
 
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
 
+    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
 
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
 
+    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (TYPEOF(le.Input_addr_suffix))'','',':addr_suffix')
    #END
 
+    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
 
+    #IF( #TEXT(Input_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desig = (TYPEOF(le.Input_unit_desig))'','',':unit_desig')
    #END
 
+    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
 
+    #IF( #TEXT(Input_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_p_city_name = (TYPEOF(le.Input_p_city_name))'','',':p_city_name')
    #END
 
+    #IF( #TEXT(Input_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
    #END
 
+    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_cart)='' )
      '' 
    #ELSE
        IF( le.Input_cart = (TYPEOF(le.Input_cart))'','',':cart')
    #END
 
+    #IF( #TEXT(Input_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_cr_sort_sz = (TYPEOF(le.Input_cr_sort_sz))'','',':cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_lot)='' )
      '' 
    #ELSE
        IF( le.Input_lot = (TYPEOF(le.Input_lot))'','',':lot')
    #END
 
+    #IF( #TEXT(Input_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_lot_order = (TYPEOF(le.Input_lot_order))'','',':lot_order')
    #END
 
+    #IF( #TEXT(Input_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_dbpc = (TYPEOF(le.Input_dbpc))'','',':dbpc')
    #END
 
+    #IF( #TEXT(Input_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_chk_digit = (TYPEOF(le.Input_chk_digit))'','',':chk_digit')
    #END
 
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
 
+    #IF( #TEXT(Input_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_fips_state = (TYPEOF(le.Input_fips_state))'','',':fips_state')
    #END
 
+    #IF( #TEXT(Input_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_fips_county = (TYPEOF(le.Input_fips_county))'','',':fips_county')
    #END
 
+    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (TYPEOF(le.Input_geo_lat))'','',':geo_lat')
    #END
 
+    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (TYPEOF(le.Input_geo_long))'','',':geo_long')
    #END
 
+    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
 
+    #IF( #TEXT(Input_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_geo_blk = (TYPEOF(le.Input_geo_blk))'','',':geo_blk')
    #END
 
+    #IF( #TEXT(Input_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_geo_match = (TYPEOF(le.Input_geo_match))'','',':geo_match')
    #END
 
+    #IF( #TEXT(Input_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_err_stat = (TYPEOF(le.Input_err_stat))'','',':err_stat')
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
