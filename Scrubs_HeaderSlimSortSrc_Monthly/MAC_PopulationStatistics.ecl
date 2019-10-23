 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_src = '',Input_did = '',Input_fname = '',Input_lname = '',Input_prim_range = '',Input_prim_name = '',Input_zip = '',Input_mname = '',Input_sec_range = '',Input_name_suffix = '',Input_ssn = '',Input_dob = '',Input_dids_with_this_nm_addr = '',Input_suffix_cnt_with_this_nm_addr = '',Input_sec_range_cnt_with_this_nm_addr = '',Input_ssn_cnt_with_this_nm_addr = '',Input_dob_cnt_with_this_nm_addr = '',Input_mname_cnt_with_this_nm_addr = '',Input_dids_with_this_nm_ssn = '',Input_dob_cnt_with_this_nm_ssn = '',Input_dids_with_this_nm_dob = '',Input_zip_cnt_with_this_nm_dob = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_HeaderSlimSortSrc_Monthly;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_src)='' )
      '' 
    #ELSE
        IF( le.Input_src = (TYPEOF(le.Input_src))'','',':src')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
 
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
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
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
 
+    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
 
+    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_dids_with_this_nm_addr)='' )
      '' 
    #ELSE
        IF( le.Input_dids_with_this_nm_addr = (TYPEOF(le.Input_dids_with_this_nm_addr))'','',':dids_with_this_nm_addr')
    #END
 
+    #IF( #TEXT(Input_suffix_cnt_with_this_nm_addr)='' )
      '' 
    #ELSE
        IF( le.Input_suffix_cnt_with_this_nm_addr = (TYPEOF(le.Input_suffix_cnt_with_this_nm_addr))'','',':suffix_cnt_with_this_nm_addr')
    #END
 
+    #IF( #TEXT(Input_sec_range_cnt_with_this_nm_addr)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range_cnt_with_this_nm_addr = (TYPEOF(le.Input_sec_range_cnt_with_this_nm_addr))'','',':sec_range_cnt_with_this_nm_addr')
    #END
 
+    #IF( #TEXT(Input_ssn_cnt_with_this_nm_addr)='' )
      '' 
    #ELSE
        IF( le.Input_ssn_cnt_with_this_nm_addr = (TYPEOF(le.Input_ssn_cnt_with_this_nm_addr))'','',':ssn_cnt_with_this_nm_addr')
    #END
 
+    #IF( #TEXT(Input_dob_cnt_with_this_nm_addr)='' )
      '' 
    #ELSE
        IF( le.Input_dob_cnt_with_this_nm_addr = (TYPEOF(le.Input_dob_cnt_with_this_nm_addr))'','',':dob_cnt_with_this_nm_addr')
    #END
 
+    #IF( #TEXT(Input_mname_cnt_with_this_nm_addr)='' )
      '' 
    #ELSE
        IF( le.Input_mname_cnt_with_this_nm_addr = (TYPEOF(le.Input_mname_cnt_with_this_nm_addr))'','',':mname_cnt_with_this_nm_addr')
    #END
 
+    #IF( #TEXT(Input_dids_with_this_nm_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_dids_with_this_nm_ssn = (TYPEOF(le.Input_dids_with_this_nm_ssn))'','',':dids_with_this_nm_ssn')
    #END
 
+    #IF( #TEXT(Input_dob_cnt_with_this_nm_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_dob_cnt_with_this_nm_ssn = (TYPEOF(le.Input_dob_cnt_with_this_nm_ssn))'','',':dob_cnt_with_this_nm_ssn')
    #END
 
+    #IF( #TEXT(Input_dids_with_this_nm_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dids_with_this_nm_dob = (TYPEOF(le.Input_dids_with_this_nm_dob))'','',':dids_with_this_nm_dob')
    #END
 
+    #IF( #TEXT(Input_zip_cnt_with_this_nm_dob)='' )
      '' 
    #ELSE
        IF( le.Input_zip_cnt_with_this_nm_dob = (TYPEOF(le.Input_zip_cnt_with_this_nm_dob))'','',':zip_cnt_with_this_nm_dob')
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
