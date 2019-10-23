
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_name_score = '',Input_filedate = '',Input_dod = '',Input_dob = '',Input_masterid = '',Input_debtorfirstname = '',Input_debtorlastname = '',Input_debtoraddress1 = '',Input_debtoraddress2 = '',Input_debtoraddresscity = '',Input_debtoraddressstate = '',Input_debtoraddresszipcode = '',Input_dateofdeath = '',Input_dateofbirth = '',Input_isprobatelocated = '',Input_casenumber = '',Input_filingdate = '',Input_lastdatetofileclaim = '',Input_issubjecttocreditorsclaim = '',Input_publicationstartdate = '',Input_isestateopen = '',Input_executorfirstname = '',Input_executorlastname = '',Input_executoraddress1 = '',Input_executoraddress2 = '',Input_executoraddresscity = '',Input_executoraddressstate = '',Input_executoraddresszipcode = '',Input_executorphone = '',Input_attorneyfirstname = '',Input_attorneylastname = '',Input_firm = '',Input_attorneyaddress1 = '',Input_attorneyaddress2 = '',Input_attorneyaddresscity = '',Input_attorneyaddressstate = '',Input_attorneyaddresszipcode = '',Input_attorneyphone = '',Input_attorneyemail = '',Input_documenttypes = '',Input_corr_dateofdeath = '',Input_pdid = '',Input_pfrd_address_ind = '',Input_nid = '',Input_cln_title = '',Input_cln_fname = '',Input_cln_mname = '',Input_cln_lname = '',Input_cln_suffix = '',Input_cln_title2 = '',Input_cln_fname2 = '',Input_cln_mname2 = '',Input_cln_lname2 = '',Input_cln_suffix2 = '',Input_persistent_record_id = '',Input_cname = '',Input_cleanaid = '',Input_addresstype = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_rawaid = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_OKC_Probate;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_name_score = (TYPEOF(le.Input_name_score))'','',':name_score')
    #END

+    #IF( #TEXT(Input_filedate)='' )
      '' 
    #ELSE
        IF( le.Input_filedate = (TYPEOF(le.Input_filedate))'','',':filedate')
    #END

+    #IF( #TEXT(Input_dod)='' )
      '' 
    #ELSE
        IF( le.Input_dod = (TYPEOF(le.Input_dod))'','',':dod')
    #END

+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END

+    #IF( #TEXT(Input_masterid)='' )
      '' 
    #ELSE
        IF( le.Input_masterid = (TYPEOF(le.Input_masterid))'','',':masterid')
    #END

+    #IF( #TEXT(Input_debtorfirstname)='' )
      '' 
    #ELSE
        IF( le.Input_debtorfirstname = (TYPEOF(le.Input_debtorfirstname))'','',':debtorfirstname')
    #END

+    #IF( #TEXT(Input_debtorlastname)='' )
      '' 
    #ELSE
        IF( le.Input_debtorlastname = (TYPEOF(le.Input_debtorlastname))'','',':debtorlastname')
    #END

+    #IF( #TEXT(Input_debtoraddress1)='' )
      '' 
    #ELSE
        IF( le.Input_debtoraddress1 = (TYPEOF(le.Input_debtoraddress1))'','',':debtoraddress1')
    #END

+    #IF( #TEXT(Input_debtoraddress2)='' )
      '' 
    #ELSE
        IF( le.Input_debtoraddress2 = (TYPEOF(le.Input_debtoraddress2))'','',':debtoraddress2')
    #END

+    #IF( #TEXT(Input_debtoraddresscity)='' )
      '' 
    #ELSE
        IF( le.Input_debtoraddresscity = (TYPEOF(le.Input_debtoraddresscity))'','',':debtoraddresscity')
    #END

+    #IF( #TEXT(Input_debtoraddressstate)='' )
      '' 
    #ELSE
        IF( le.Input_debtoraddressstate = (TYPEOF(le.Input_debtoraddressstate))'','',':debtoraddressstate')
    #END

+    #IF( #TEXT(Input_debtoraddresszipcode)='' )
      '' 
    #ELSE
        IF( le.Input_debtoraddresszipcode = (TYPEOF(le.Input_debtoraddresszipcode))'','',':debtoraddresszipcode')
    #END

+    #IF( #TEXT(Input_dateofdeath)='' )
      '' 
    #ELSE
        IF( le.Input_dateofdeath = (TYPEOF(le.Input_dateofdeath))'','',':dateofdeath')
    #END

+    #IF( #TEXT(Input_dateofbirth)='' )
      '' 
    #ELSE
        IF( le.Input_dateofbirth = (TYPEOF(le.Input_dateofbirth))'','',':dateofbirth')
    #END

+    #IF( #TEXT(Input_isprobatelocated)='' )
      '' 
    #ELSE
        IF( le.Input_isprobatelocated = (TYPEOF(le.Input_isprobatelocated))'','',':isprobatelocated')
    #END

+    #IF( #TEXT(Input_casenumber)='' )
      '' 
    #ELSE
        IF( le.Input_casenumber = (TYPEOF(le.Input_casenumber))'','',':casenumber')
    #END

+    #IF( #TEXT(Input_filingdate)='' )
      '' 
    #ELSE
        IF( le.Input_filingdate = (TYPEOF(le.Input_filingdate))'','',':filingdate')
    #END

+    #IF( #TEXT(Input_lastdatetofileclaim)='' )
      '' 
    #ELSE
        IF( le.Input_lastdatetofileclaim = (TYPEOF(le.Input_lastdatetofileclaim))'','',':lastdatetofileclaim')
    #END

+    #IF( #TEXT(Input_issubjecttocreditorsclaim)='' )
      '' 
    #ELSE
        IF( le.Input_issubjecttocreditorsclaim = (TYPEOF(le.Input_issubjecttocreditorsclaim))'','',':issubjecttocreditorsclaim')
    #END

+    #IF( #TEXT(Input_publicationstartdate)='' )
      '' 
    #ELSE
        IF( le.Input_publicationstartdate = (TYPEOF(le.Input_publicationstartdate))'','',':publicationstartdate')
    #END

+    #IF( #TEXT(Input_isestateopen)='' )
      '' 
    #ELSE
        IF( le.Input_isestateopen = (TYPEOF(le.Input_isestateopen))'','',':isestateopen')
    #END

+    #IF( #TEXT(Input_executorfirstname)='' )
      '' 
    #ELSE
        IF( le.Input_executorfirstname = (TYPEOF(le.Input_executorfirstname))'','',':executorfirstname')
    #END

+    #IF( #TEXT(Input_executorlastname)='' )
      '' 
    #ELSE
        IF( le.Input_executorlastname = (TYPEOF(le.Input_executorlastname))'','',':executorlastname')
    #END

+    #IF( #TEXT(Input_executoraddress1)='' )
      '' 
    #ELSE
        IF( le.Input_executoraddress1 = (TYPEOF(le.Input_executoraddress1))'','',':executoraddress1')
    #END

+    #IF( #TEXT(Input_executoraddress2)='' )
      '' 
    #ELSE
        IF( le.Input_executoraddress2 = (TYPEOF(le.Input_executoraddress2))'','',':executoraddress2')
    #END

+    #IF( #TEXT(Input_executoraddresscity)='' )
      '' 
    #ELSE
        IF( le.Input_executoraddresscity = (TYPEOF(le.Input_executoraddresscity))'','',':executoraddresscity')
    #END

+    #IF( #TEXT(Input_executoraddressstate)='' )
      '' 
    #ELSE
        IF( le.Input_executoraddressstate = (TYPEOF(le.Input_executoraddressstate))'','',':executoraddressstate')
    #END

+    #IF( #TEXT(Input_executoraddresszipcode)='' )
      '' 
    #ELSE
        IF( le.Input_executoraddresszipcode = (TYPEOF(le.Input_executoraddresszipcode))'','',':executoraddresszipcode')
    #END

+    #IF( #TEXT(Input_executorphone)='' )
      '' 
    #ELSE
        IF( le.Input_executorphone = (TYPEOF(le.Input_executorphone))'','',':executorphone')
    #END

+    #IF( #TEXT(Input_attorneyfirstname)='' )
      '' 
    #ELSE
        IF( le.Input_attorneyfirstname = (TYPEOF(le.Input_attorneyfirstname))'','',':attorneyfirstname')
    #END

+    #IF( #TEXT(Input_attorneylastname)='' )
      '' 
    #ELSE
        IF( le.Input_attorneylastname = (TYPEOF(le.Input_attorneylastname))'','',':attorneylastname')
    #END

+    #IF( #TEXT(Input_firm)='' )
      '' 
    #ELSE
        IF( le.Input_firm = (TYPEOF(le.Input_firm))'','',':firm')
    #END

+    #IF( #TEXT(Input_attorneyaddress1)='' )
      '' 
    #ELSE
        IF( le.Input_attorneyaddress1 = (TYPEOF(le.Input_attorneyaddress1))'','',':attorneyaddress1')
    #END

+    #IF( #TEXT(Input_attorneyaddress2)='' )
      '' 
    #ELSE
        IF( le.Input_attorneyaddress2 = (TYPEOF(le.Input_attorneyaddress2))'','',':attorneyaddress2')
    #END

+    #IF( #TEXT(Input_attorneyaddresscity)='' )
      '' 
    #ELSE
        IF( le.Input_attorneyaddresscity = (TYPEOF(le.Input_attorneyaddresscity))'','',':attorneyaddresscity')
    #END

+    #IF( #TEXT(Input_attorneyaddressstate)='' )
      '' 
    #ELSE
        IF( le.Input_attorneyaddressstate = (TYPEOF(le.Input_attorneyaddressstate))'','',':attorneyaddressstate')
    #END

+    #IF( #TEXT(Input_attorneyaddresszipcode)='' )
      '' 
    #ELSE
        IF( le.Input_attorneyaddresszipcode = (TYPEOF(le.Input_attorneyaddresszipcode))'','',':attorneyaddresszipcode')
    #END

+    #IF( #TEXT(Input_attorneyphone)='' )
      '' 
    #ELSE
        IF( le.Input_attorneyphone = (TYPEOF(le.Input_attorneyphone))'','',':attorneyphone')
    #END

+    #IF( #TEXT(Input_attorneyemail)='' )
      '' 
    #ELSE
        IF( le.Input_attorneyemail = (TYPEOF(le.Input_attorneyemail))'','',':attorneyemail')
    #END

+    #IF( #TEXT(Input_documenttypes)='' )
      '' 
    #ELSE
        IF( le.Input_documenttypes = (TYPEOF(le.Input_documenttypes))'','',':documenttypes')
    #END

+    #IF( #TEXT(Input_corr_dateofdeath)='' )
      '' 
    #ELSE
        IF( le.Input_corr_dateofdeath = (TYPEOF(le.Input_corr_dateofdeath))'','',':corr_dateofdeath')
    #END

+    #IF( #TEXT(Input_pdid)='' )
      '' 
    #ELSE
        IF( le.Input_pdid = (TYPEOF(le.Input_pdid))'','',':pdid')
    #END

+    #IF( #TEXT(Input_pfrd_address_ind)='' )
      '' 
    #ELSE
        IF( le.Input_pfrd_address_ind = (TYPEOF(le.Input_pfrd_address_ind))'','',':pfrd_address_ind')
    #END

+    #IF( #TEXT(Input_nid)='' )
      '' 
    #ELSE
        IF( le.Input_nid = (TYPEOF(le.Input_nid))'','',':nid')
    #END

+    #IF( #TEXT(Input_cln_title)='' )
      '' 
    #ELSE
        IF( le.Input_cln_title = (TYPEOF(le.Input_cln_title))'','',':cln_title')
    #END

+    #IF( #TEXT(Input_cln_fname)='' )
      '' 
    #ELSE
        IF( le.Input_cln_fname = (TYPEOF(le.Input_cln_fname))'','',':cln_fname')
    #END

+    #IF( #TEXT(Input_cln_mname)='' )
      '' 
    #ELSE
        IF( le.Input_cln_mname = (TYPEOF(le.Input_cln_mname))'','',':cln_mname')
    #END

+    #IF( #TEXT(Input_cln_lname)='' )
      '' 
    #ELSE
        IF( le.Input_cln_lname = (TYPEOF(le.Input_cln_lname))'','',':cln_lname')
    #END

+    #IF( #TEXT(Input_cln_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_cln_suffix = (TYPEOF(le.Input_cln_suffix))'','',':cln_suffix')
    #END

+    #IF( #TEXT(Input_cln_title2)='' )
      '' 
    #ELSE
        IF( le.Input_cln_title2 = (TYPEOF(le.Input_cln_title2))'','',':cln_title2')
    #END

+    #IF( #TEXT(Input_cln_fname2)='' )
      '' 
    #ELSE
        IF( le.Input_cln_fname2 = (TYPEOF(le.Input_cln_fname2))'','',':cln_fname2')
    #END

+    #IF( #TEXT(Input_cln_mname2)='' )
      '' 
    #ELSE
        IF( le.Input_cln_mname2 = (TYPEOF(le.Input_cln_mname2))'','',':cln_mname2')
    #END

+    #IF( #TEXT(Input_cln_lname2)='' )
      '' 
    #ELSE
        IF( le.Input_cln_lname2 = (TYPEOF(le.Input_cln_lname2))'','',':cln_lname2')
    #END

+    #IF( #TEXT(Input_cln_suffix2)='' )
      '' 
    #ELSE
        IF( le.Input_cln_suffix2 = (TYPEOF(le.Input_cln_suffix2))'','',':cln_suffix2')
    #END

+    #IF( #TEXT(Input_persistent_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_persistent_record_id = (TYPEOF(le.Input_persistent_record_id))'','',':persistent_record_id')
    #END

+    #IF( #TEXT(Input_cname)='' )
      '' 
    #ELSE
        IF( le.Input_cname = (TYPEOF(le.Input_cname))'','',':cname')
    #END

+    #IF( #TEXT(Input_cleanaid)='' )
      '' 
    #ELSE
        IF( le.Input_cleanaid = (TYPEOF(le.Input_cleanaid))'','',':cleanaid')
    #END

+    #IF( #TEXT(Input_addresstype)='' )
      '' 
    #ELSE
        IF( le.Input_addresstype = (TYPEOF(le.Input_addresstype))'','',':addresstype')
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

+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
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
