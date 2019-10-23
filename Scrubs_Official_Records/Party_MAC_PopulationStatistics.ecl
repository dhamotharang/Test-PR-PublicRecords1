 
EXPORT Party_MAC_PopulationStatistics(infile,Ref='',Input_process_date = '',Input_vendor = '',Input_state_origin = '',Input_county_name = '',Input_official_record_key = '',Input_doc_instrument_or_clerk_filing_num = '',Input_doc_filed_dt = '',Input_doc_type_desc = '',Input_entity_sequence = '',Input_entity_type_cd = '',Input_entity_type_desc = '',Input_entity_nm = '',Input_entity_nm_format = '',Input_entity_dob = '',Input_entity_ssn = '',Input_title1 = '',Input_fname1 = '',Input_mname1 = '',Input_lname1 = '',Input_suffix1 = '',Input_pname1_score = '',Input_cname1 = '',Input_title2 = '',Input_fname2 = '',Input_mname2 = '',Input_lname2 = '',Input_suffix2 = '',Input_pname2_score = '',Input_cname2 = '',Input_title3 = '',Input_fname3 = '',Input_mname3 = '',Input_lname3 = '',Input_suffix3 = '',Input_pname3_score = '',Input_cname3 = '',Input_title4 = '',Input_fname4 = '',Input_mname4 = '',Input_lname4 = '',Input_suffix4 = '',Input_pname4_score = '',Input_cname4 = '',Input_title5 = '',Input_fname5 = '',Input_mname5 = '',Input_lname5 = '',Input_suffix5 = '',Input_pname5_score = '',Input_cname5 = '',Input_master_party_type_cd = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Official_Records;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_vendor = (TYPEOF(le.Input_vendor))'','',':vendor')
    #END
 
+    #IF( #TEXT(Input_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_state_origin = (TYPEOF(le.Input_state_origin))'','',':state_origin')
    #END
 
+    #IF( #TEXT(Input_county_name)='' )
      '' 
    #ELSE
        IF( le.Input_county_name = (TYPEOF(le.Input_county_name))'','',':county_name')
    #END
 
+    #IF( #TEXT(Input_official_record_key)='' )
      '' 
    #ELSE
        IF( le.Input_official_record_key = (TYPEOF(le.Input_official_record_key))'','',':official_record_key')
    #END
 
+    #IF( #TEXT(Input_doc_instrument_or_clerk_filing_num)='' )
      '' 
    #ELSE
        IF( le.Input_doc_instrument_or_clerk_filing_num = (TYPEOF(le.Input_doc_instrument_or_clerk_filing_num))'','',':doc_instrument_or_clerk_filing_num')
    #END
 
+    #IF( #TEXT(Input_doc_filed_dt)='' )
      '' 
    #ELSE
        IF( le.Input_doc_filed_dt = (TYPEOF(le.Input_doc_filed_dt))'','',':doc_filed_dt')
    #END
 
+    #IF( #TEXT(Input_doc_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_doc_type_desc = (TYPEOF(le.Input_doc_type_desc))'','',':doc_type_desc')
    #END
 
+    #IF( #TEXT(Input_entity_sequence)='' )
      '' 
    #ELSE
        IF( le.Input_entity_sequence = (TYPEOF(le.Input_entity_sequence))'','',':entity_sequence')
    #END
 
+    #IF( #TEXT(Input_entity_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_entity_type_cd = (TYPEOF(le.Input_entity_type_cd))'','',':entity_type_cd')
    #END
 
+    #IF( #TEXT(Input_entity_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_entity_type_desc = (TYPEOF(le.Input_entity_type_desc))'','',':entity_type_desc')
    #END
 
+    #IF( #TEXT(Input_entity_nm)='' )
      '' 
    #ELSE
        IF( le.Input_entity_nm = (TYPEOF(le.Input_entity_nm))'','',':entity_nm')
    #END
 
+    #IF( #TEXT(Input_entity_nm_format)='' )
      '' 
    #ELSE
        IF( le.Input_entity_nm_format = (TYPEOF(le.Input_entity_nm_format))'','',':entity_nm_format')
    #END
 
+    #IF( #TEXT(Input_entity_dob)='' )
      '' 
    #ELSE
        IF( le.Input_entity_dob = (TYPEOF(le.Input_entity_dob))'','',':entity_dob')
    #END
 
+    #IF( #TEXT(Input_entity_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_entity_ssn = (TYPEOF(le.Input_entity_ssn))'','',':entity_ssn')
    #END
 
+    #IF( #TEXT(Input_title1)='' )
      '' 
    #ELSE
        IF( le.Input_title1 = (TYPEOF(le.Input_title1))'','',':title1')
    #END
 
+    #IF( #TEXT(Input_fname1)='' )
      '' 
    #ELSE
        IF( le.Input_fname1 = (TYPEOF(le.Input_fname1))'','',':fname1')
    #END
 
+    #IF( #TEXT(Input_mname1)='' )
      '' 
    #ELSE
        IF( le.Input_mname1 = (TYPEOF(le.Input_mname1))'','',':mname1')
    #END
 
+    #IF( #TEXT(Input_lname1)='' )
      '' 
    #ELSE
        IF( le.Input_lname1 = (TYPEOF(le.Input_lname1))'','',':lname1')
    #END
 
+    #IF( #TEXT(Input_suffix1)='' )
      '' 
    #ELSE
        IF( le.Input_suffix1 = (TYPEOF(le.Input_suffix1))'','',':suffix1')
    #END
 
+    #IF( #TEXT(Input_pname1_score)='' )
      '' 
    #ELSE
        IF( le.Input_pname1_score = (TYPEOF(le.Input_pname1_score))'','',':pname1_score')
    #END
 
+    #IF( #TEXT(Input_cname1)='' )
      '' 
    #ELSE
        IF( le.Input_cname1 = (TYPEOF(le.Input_cname1))'','',':cname1')
    #END
 
+    #IF( #TEXT(Input_title2)='' )
      '' 
    #ELSE
        IF( le.Input_title2 = (TYPEOF(le.Input_title2))'','',':title2')
    #END
 
+    #IF( #TEXT(Input_fname2)='' )
      '' 
    #ELSE
        IF( le.Input_fname2 = (TYPEOF(le.Input_fname2))'','',':fname2')
    #END
 
+    #IF( #TEXT(Input_mname2)='' )
      '' 
    #ELSE
        IF( le.Input_mname2 = (TYPEOF(le.Input_mname2))'','',':mname2')
    #END
 
+    #IF( #TEXT(Input_lname2)='' )
      '' 
    #ELSE
        IF( le.Input_lname2 = (TYPEOF(le.Input_lname2))'','',':lname2')
    #END
 
+    #IF( #TEXT(Input_suffix2)='' )
      '' 
    #ELSE
        IF( le.Input_suffix2 = (TYPEOF(le.Input_suffix2))'','',':suffix2')
    #END
 
+    #IF( #TEXT(Input_pname2_score)='' )
      '' 
    #ELSE
        IF( le.Input_pname2_score = (TYPEOF(le.Input_pname2_score))'','',':pname2_score')
    #END
 
+    #IF( #TEXT(Input_cname2)='' )
      '' 
    #ELSE
        IF( le.Input_cname2 = (TYPEOF(le.Input_cname2))'','',':cname2')
    #END
 
+    #IF( #TEXT(Input_title3)='' )
      '' 
    #ELSE
        IF( le.Input_title3 = (TYPEOF(le.Input_title3))'','',':title3')
    #END
 
+    #IF( #TEXT(Input_fname3)='' )
      '' 
    #ELSE
        IF( le.Input_fname3 = (TYPEOF(le.Input_fname3))'','',':fname3')
    #END
 
+    #IF( #TEXT(Input_mname3)='' )
      '' 
    #ELSE
        IF( le.Input_mname3 = (TYPEOF(le.Input_mname3))'','',':mname3')
    #END
 
+    #IF( #TEXT(Input_lname3)='' )
      '' 
    #ELSE
        IF( le.Input_lname3 = (TYPEOF(le.Input_lname3))'','',':lname3')
    #END
 
+    #IF( #TEXT(Input_suffix3)='' )
      '' 
    #ELSE
        IF( le.Input_suffix3 = (TYPEOF(le.Input_suffix3))'','',':suffix3')
    #END
 
+    #IF( #TEXT(Input_pname3_score)='' )
      '' 
    #ELSE
        IF( le.Input_pname3_score = (TYPEOF(le.Input_pname3_score))'','',':pname3_score')
    #END
 
+    #IF( #TEXT(Input_cname3)='' )
      '' 
    #ELSE
        IF( le.Input_cname3 = (TYPEOF(le.Input_cname3))'','',':cname3')
    #END
 
+    #IF( #TEXT(Input_title4)='' )
      '' 
    #ELSE
        IF( le.Input_title4 = (TYPEOF(le.Input_title4))'','',':title4')
    #END
 
+    #IF( #TEXT(Input_fname4)='' )
      '' 
    #ELSE
        IF( le.Input_fname4 = (TYPEOF(le.Input_fname4))'','',':fname4')
    #END
 
+    #IF( #TEXT(Input_mname4)='' )
      '' 
    #ELSE
        IF( le.Input_mname4 = (TYPEOF(le.Input_mname4))'','',':mname4')
    #END
 
+    #IF( #TEXT(Input_lname4)='' )
      '' 
    #ELSE
        IF( le.Input_lname4 = (TYPEOF(le.Input_lname4))'','',':lname4')
    #END
 
+    #IF( #TEXT(Input_suffix4)='' )
      '' 
    #ELSE
        IF( le.Input_suffix4 = (TYPEOF(le.Input_suffix4))'','',':suffix4')
    #END
 
+    #IF( #TEXT(Input_pname4_score)='' )
      '' 
    #ELSE
        IF( le.Input_pname4_score = (TYPEOF(le.Input_pname4_score))'','',':pname4_score')
    #END
 
+    #IF( #TEXT(Input_cname4)='' )
      '' 
    #ELSE
        IF( le.Input_cname4 = (TYPEOF(le.Input_cname4))'','',':cname4')
    #END
 
+    #IF( #TEXT(Input_title5)='' )
      '' 
    #ELSE
        IF( le.Input_title5 = (TYPEOF(le.Input_title5))'','',':title5')
    #END
 
+    #IF( #TEXT(Input_fname5)='' )
      '' 
    #ELSE
        IF( le.Input_fname5 = (TYPEOF(le.Input_fname5))'','',':fname5')
    #END
 
+    #IF( #TEXT(Input_mname5)='' )
      '' 
    #ELSE
        IF( le.Input_mname5 = (TYPEOF(le.Input_mname5))'','',':mname5')
    #END
 
+    #IF( #TEXT(Input_lname5)='' )
      '' 
    #ELSE
        IF( le.Input_lname5 = (TYPEOF(le.Input_lname5))'','',':lname5')
    #END
 
+    #IF( #TEXT(Input_suffix5)='' )
      '' 
    #ELSE
        IF( le.Input_suffix5 = (TYPEOF(le.Input_suffix5))'','',':suffix5')
    #END
 
+    #IF( #TEXT(Input_pname5_score)='' )
      '' 
    #ELSE
        IF( le.Input_pname5_score = (TYPEOF(le.Input_pname5_score))'','',':pname5_score')
    #END
 
+    #IF( #TEXT(Input_cname5)='' )
      '' 
    #ELSE
        IF( le.Input_cname5 = (TYPEOF(le.Input_cname5))'','',':cname5')
    #END
 
+    #IF( #TEXT(Input_master_party_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_master_party_type_cd = (TYPEOF(le.Input_master_party_type_cd))'','',':master_party_type_cd')
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
