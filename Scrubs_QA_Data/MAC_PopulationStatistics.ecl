 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_did = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_record_type = '',Input_rawtrans_masteraddressid = '',Input_rawtrans_date = '',Input_rawtrans_category = '',Input_rawaddr_databasematchcode = '',Input_rawaddr_homebusinessflag = '',Input_rawaddr_masteraddressid = '',Input_prep_trans_line1 = '',Input_prep_trans_line_last = '',Input_prep_addr_line1 = '',Input_prep_addr_line_last = '',Input_trans_address_prim_name = '',Input_trans_address_p_city_name = '',Input_trans_address_v_city_name = '',Input_trans_address_st = '',Input_trans_address_zip = '',Input_addr_address_prim_name = '',Input_addr_address_p_city_name = '',Input_addr_address_v_city_name = '',Input_addr_address_st = '',Input_addr_address_zip = '',Input_clean_person_type = '',Input_clean_person_name_fname = '',Input_clean_person_name_lname = '',Input_clean_phone = '',Input_clean_company = '',Input_nametype = '',Input_source_rec_id = '',OutFile) := MACRO
  IMPORT SALT34,Scrubs_QA_Data;
  #uniquename(of)
  %of% := RECORD
    SALT34.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
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
 
+    #IF( #TEXT(Input_rawtrans_masteraddressid)='' )
      '' 
    #ELSE
        IF( le.Input_rawtrans_masteraddressid = (TYPEOF(le.Input_rawtrans_masteraddressid))'','',':rawtrans_masteraddressid')
    #END
 
+    #IF( #TEXT(Input_rawtrans_date)='' )
      '' 
    #ELSE
        IF( le.Input_rawtrans_date = (TYPEOF(le.Input_rawtrans_date))'','',':rawtrans_date')
    #END
 
+    #IF( #TEXT(Input_rawtrans_category)='' )
      '' 
    #ELSE
        IF( le.Input_rawtrans_category = (TYPEOF(le.Input_rawtrans_category))'','',':rawtrans_category')
    #END
 
+    #IF( #TEXT(Input_rawaddr_databasematchcode)='' )
      '' 
    #ELSE
        IF( le.Input_rawaddr_databasematchcode = (TYPEOF(le.Input_rawaddr_databasematchcode))'','',':rawaddr_databasematchcode')
    #END
 
+    #IF( #TEXT(Input_rawaddr_homebusinessflag)='' )
      '' 
    #ELSE
        IF( le.Input_rawaddr_homebusinessflag = (TYPEOF(le.Input_rawaddr_homebusinessflag))'','',':rawaddr_homebusinessflag')
    #END
 
+    #IF( #TEXT(Input_rawaddr_masteraddressid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaddr_masteraddressid = (TYPEOF(le.Input_rawaddr_masteraddressid))'','',':rawaddr_masteraddressid')
    #END
 
+    #IF( #TEXT(Input_prep_trans_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_trans_line1 = (TYPEOF(le.Input_prep_trans_line1))'','',':prep_trans_line1')
    #END
 
+    #IF( #TEXT(Input_prep_trans_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_trans_line_last = (TYPEOF(le.Input_prep_trans_line_last))'','',':prep_trans_line_last')
    #END
 
+    #IF( #TEXT(Input_prep_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_line1 = (TYPEOF(le.Input_prep_addr_line1))'','',':prep_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_addr_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_line_last = (TYPEOF(le.Input_prep_addr_line_last))'','',':prep_addr_line_last')
    #END
 
+    #IF( #TEXT(Input_trans_address_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_trans_address_prim_name = (TYPEOF(le.Input_trans_address_prim_name))'','',':trans_address_prim_name')
    #END
 
+    #IF( #TEXT(Input_trans_address_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_trans_address_p_city_name = (TYPEOF(le.Input_trans_address_p_city_name))'','',':trans_address_p_city_name')
    #END
 
+    #IF( #TEXT(Input_trans_address_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_trans_address_v_city_name = (TYPEOF(le.Input_trans_address_v_city_name))'','',':trans_address_v_city_name')
    #END
 
+    #IF( #TEXT(Input_trans_address_st)='' )
      '' 
    #ELSE
        IF( le.Input_trans_address_st = (TYPEOF(le.Input_trans_address_st))'','',':trans_address_st')
    #END
 
+    #IF( #TEXT(Input_trans_address_zip)='' )
      '' 
    #ELSE
        IF( le.Input_trans_address_zip = (TYPEOF(le.Input_trans_address_zip))'','',':trans_address_zip')
    #END
 
+    #IF( #TEXT(Input_addr_address_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_addr_address_prim_name = (TYPEOF(le.Input_addr_address_prim_name))'','',':addr_address_prim_name')
    #END
 
+    #IF( #TEXT(Input_addr_address_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_addr_address_p_city_name = (TYPEOF(le.Input_addr_address_p_city_name))'','',':addr_address_p_city_name')
    #END
 
+    #IF( #TEXT(Input_addr_address_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_addr_address_v_city_name = (TYPEOF(le.Input_addr_address_v_city_name))'','',':addr_address_v_city_name')
    #END
 
+    #IF( #TEXT(Input_addr_address_st)='' )
      '' 
    #ELSE
        IF( le.Input_addr_address_st = (TYPEOF(le.Input_addr_address_st))'','',':addr_address_st')
    #END
 
+    #IF( #TEXT(Input_addr_address_zip)='' )
      '' 
    #ELSE
        IF( le.Input_addr_address_zip = (TYPEOF(le.Input_addr_address_zip))'','',':addr_address_zip')
    #END
 
+    #IF( #TEXT(Input_clean_person_type)='' )
      '' 
    #ELSE
        IF( le.Input_clean_person_type = (TYPEOF(le.Input_clean_person_type))'','',':clean_person_type')
    #END
 
+    #IF( #TEXT(Input_clean_person_name_fname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_person_name_fname = (TYPEOF(le.Input_clean_person_name_fname))'','',':clean_person_name_fname')
    #END
 
+    #IF( #TEXT(Input_clean_person_name_lname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_person_name_lname = (TYPEOF(le.Input_clean_person_name_lname))'','',':clean_person_name_lname')
    #END
 
+    #IF( #TEXT(Input_clean_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone = (TYPEOF(le.Input_clean_phone))'','',':clean_phone')
    #END
 
+    #IF( #TEXT(Input_clean_company)='' )
      '' 
    #ELSE
        IF( le.Input_clean_company = (TYPEOF(le.Input_clean_company))'','',':clean_company')
    #END
 
+    #IF( #TEXT(Input_nametype)='' )
      '' 
    #ELSE
        IF( le.Input_nametype = (TYPEOF(le.Input_nametype))'','',':nametype')
    #END
 
+    #IF( #TEXT(Input_source_rec_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_rec_id = (TYPEOF(le.Input_source_rec_id))'','',':source_rec_id')
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
