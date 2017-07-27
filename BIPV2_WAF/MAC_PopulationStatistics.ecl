 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_parent_proxid = '',Input_ultimate_proxid = '',Input_has_lgid = '',Input_empid = '',Input_powid = '',Input_source = '',Input_source_record_id = '',Input_cnp_number = '',Input_cnp_btype = '',Input_cnp_lowv = '',Input_cnp_name = '',Input_company_phone = '',Input_company_fein = '',Input_company_sic_code1 = '',Input_prim_range = '',Input_prim_name = '',Input_sec_range = '',Input_p_city_name = '',Input_st = '',Input_zip = '',Input_company_url = '',Input_isContact = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_contact_email = '',Input_CONTACTNAME = '',Input_STREETADDRESS = '',OutFile) := MACRO
  IMPORT SALT29,BIPV2_WAF;
  #uniquename(of)
  %of% := RECORD
    SALT29.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_parent_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_parent_proxid = (TYPEOF(le.Input_parent_proxid))'','',':parent_proxid')
    #END
 
+    #IF( #TEXT(Input_ultimate_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_ultimate_proxid = (TYPEOF(le.Input_ultimate_proxid))'','',':ultimate_proxid')
    #END
 
+    #IF( #TEXT(Input_has_lgid)='' )
      '' 
    #ELSE
        IF( le.Input_has_lgid = (TYPEOF(le.Input_has_lgid))'','',':has_lgid')
    #END
 
+    #IF( #TEXT(Input_empid)='' )
      '' 
    #ELSE
        IF( le.Input_empid = (TYPEOF(le.Input_empid))'','',':empid')
    #END
 
+    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
 
+    #IF( #TEXT(Input_source_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_record_id = (TYPEOF(le.Input_source_record_id))'','',':source_record_id')
    #END
 
+    #IF( #TEXT(Input_cnp_number)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_number = (TYPEOF(le.Input_cnp_number))'','',':cnp_number')
    #END
 
+    #IF( #TEXT(Input_cnp_btype)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_btype = (TYPEOF(le.Input_cnp_btype))'','',':cnp_btype')
    #END
 
+    #IF( #TEXT(Input_cnp_lowv)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_lowv = (TYPEOF(le.Input_cnp_lowv))'','',':cnp_lowv')
    #END
 
+    #IF( #TEXT(Input_cnp_name)='' )
      '' 
    #ELSE
        IF( le.Input_cnp_name = (TYPEOF(le.Input_cnp_name))'','',':cnp_name')
    #END
 
+    #IF( #TEXT(Input_company_phone)='' )
      '' 
    #ELSE
        IF( le.Input_company_phone = (TYPEOF(le.Input_company_phone))'','',':company_phone')
    #END
 
+    #IF( #TEXT(Input_company_fein)='' )
      '' 
    #ELSE
        IF( le.Input_company_fein = (TYPEOF(le.Input_company_fein))'','',':company_fein')
    #END
 
+    #IF( #TEXT(Input_company_sic_code1)='' )
      '' 
    #ELSE
        IF( le.Input_company_sic_code1 = (TYPEOF(le.Input_company_sic_code1))'','',':company_sic_code1')
    #END
 
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
 
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
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
 
+    #IF( #TEXT(Input_company_url)='' )
      '' 
    #ELSE
        IF( le.Input_company_url = (TYPEOF(le.Input_company_url))'','',':company_url')
    #END
 
+    #IF( #TEXT(Input_isContact)='' )
      '' 
    #ELSE
        IF( le.Input_isContact = (TYPEOF(le.Input_isContact))'','',':isContact')
    #END
 
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
 
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
 
+    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
 
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
 
+    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
    #END
 
+    #IF( #TEXT(Input_contact_email)='' )
      '' 
    #ELSE
        IF( le.Input_contact_email = (TYPEOF(le.Input_contact_email))'','',':contact_email')
    #END
 
+    #IF( #TEXT(Input_CONTACTNAME)='' )
      '' 
    #ELSE
        IF( le.Input_CONTACTNAME = (TYPEOF(le.Input_CONTACTNAME))'','',':CONTACTNAME')
    #END
 
+    #IF( #TEXT(Input_STREETADDRESS)='' )
      '' 
    #ELSE
        IF( le.Input_STREETADDRESS = (TYPEOF(le.Input_STREETADDRESS))'','',':STREETADDRESS')
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
