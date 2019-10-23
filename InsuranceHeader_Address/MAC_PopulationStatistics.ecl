
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_DID = '',Input_src = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_prim_range = '',Input_prim_range_alpha = '',Input_prim_range_num = '',Input_prim_range_fract = '',Input_predir = '',Input_prim_name = '',Input_prim_name_num = '',Input_prim_name_alpha = '',Input_addr_suffix = '',Input_addr_ind = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_sec_range_alpha = '',Input_sec_range_num = '',Input_city = '',Input_st = '',Input_zip = '',Input_rec_cnt = '',Input_src_cnt = '',Input_addr = '',Input_locale = '',OutFile) := MACRO
  IMPORT SALT311,InsuranceHeader_Address;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_DID)='' )
      '' 
    #ELSE
        IF( le.Input_DID = (TYPEOF(le.Input_DID))'','',':DID')
    #END
 
+    #IF( #TEXT(Input_src)='' )
      '' 
    #ELSE
        IF( le.Input_src = (TYPEOF(le.Input_src))'','',':src')
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
 
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
 
+    #IF( #TEXT(Input_prim_range_alpha)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range_alpha = (TYPEOF(le.Input_prim_range_alpha))'','',':prim_range_alpha')
    #END
 
+    #IF( #TEXT(Input_prim_range_num)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range_num = (TYPEOF(le.Input_prim_range_num))'','',':prim_range_num')
    #END
 
+    #IF( #TEXT(Input_prim_range_fract)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range_fract = (TYPEOF(le.Input_prim_range_fract))'','',':prim_range_fract')
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
 
+    #IF( #TEXT(Input_prim_name_num)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name_num = (TYPEOF(le.Input_prim_name_num))'','',':prim_name_num')
    #END
 
+    #IF( #TEXT(Input_prim_name_alpha)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name_alpha = (TYPEOF(le.Input_prim_name_alpha))'','',':prim_name_alpha')
    #END
 
+    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (TYPEOF(le.Input_addr_suffix))'','',':addr_suffix')
    #END
 
+    #IF( #TEXT(Input_addr_ind)='' )
      '' 
    #ELSE
        IF( le.Input_addr_ind = (TYPEOF(le.Input_addr_ind))'','',':addr_ind')
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
 
+    #IF( #TEXT(Input_sec_range_alpha)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range_alpha = (TYPEOF(le.Input_sec_range_alpha))'','',':sec_range_alpha')
    #END
 
+    #IF( #TEXT(Input_sec_range_num)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range_num = (TYPEOF(le.Input_sec_range_num))'','',':sec_range_num')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
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
 
+    #IF( #TEXT(Input_rec_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_rec_cnt = (TYPEOF(le.Input_rec_cnt))'','',':rec_cnt')
    #END
 
+    #IF( #TEXT(Input_src_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_src_cnt = (TYPEOF(le.Input_src_cnt))'','',':src_cnt')
    #END
 
+    #IF( #TEXT(Input_addr)='' )
      '' 
    #ELSE
        IF( le.Input_addr = (TYPEOF(le.Input_addr))'','',':addr')
    #END
 
+    #IF( #TEXT(Input_locale)='' )
      '' 
    #ELSE
        IF( le.Input_locale = (TYPEOF(le.Input_locale))'','',':locale')
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
