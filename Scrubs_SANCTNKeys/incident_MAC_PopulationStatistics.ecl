 
EXPORT incident_MAC_PopulationStatistics(infile,Ref='',Input_batch_number = '',Input_incident_number = '',Input_party_number = '',Input_record_type = '',Input_order_number = '',Input_ag_code = '',Input_case_number = '',Input_incident_date = '',Input_jurisdiction = '',Input_source_document = '',Input_additional_info = '',Input_agency = '',Input_alleged_amount = '',Input_estimated_loss = '',Input_fcr_date = '',Input_ok_for_fcr = '',Input_modified_date = '',Input_load_date = '',Input_incident_text = '',Input_incident_date_clean = '',Input_fcr_date_clean = '',Input_cln_modified_date = '',Input_cln_load_date = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_SANCTNKeys;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_batch_number)='' )
      '' 
    #ELSE
        IF( le.Input_batch_number = (TYPEOF(le.Input_batch_number))'','',':batch_number')
    #END
 
+    #IF( #TEXT(Input_incident_number)='' )
      '' 
    #ELSE
        IF( le.Input_incident_number = (TYPEOF(le.Input_incident_number))'','',':incident_number')
    #END
 
+    #IF( #TEXT(Input_party_number)='' )
      '' 
    #ELSE
        IF( le.Input_party_number = (TYPEOF(le.Input_party_number))'','',':party_number')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_order_number)='' )
      '' 
    #ELSE
        IF( le.Input_order_number = (TYPEOF(le.Input_order_number))'','',':order_number')
    #END
 
+    #IF( #TEXT(Input_ag_code)='' )
      '' 
    #ELSE
        IF( le.Input_ag_code = (TYPEOF(le.Input_ag_code))'','',':ag_code')
    #END
 
+    #IF( #TEXT(Input_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_case_number = (TYPEOF(le.Input_case_number))'','',':case_number')
    #END
 
+    #IF( #TEXT(Input_incident_date)='' )
      '' 
    #ELSE
        IF( le.Input_incident_date = (TYPEOF(le.Input_incident_date))'','',':incident_date')
    #END
 
+    #IF( #TEXT(Input_jurisdiction)='' )
      '' 
    #ELSE
        IF( le.Input_jurisdiction = (TYPEOF(le.Input_jurisdiction))'','',':jurisdiction')
    #END
 
+    #IF( #TEXT(Input_source_document)='' )
      '' 
    #ELSE
        IF( le.Input_source_document = (TYPEOF(le.Input_source_document))'','',':source_document')
    #END
 
+    #IF( #TEXT(Input_additional_info)='' )
      '' 
    #ELSE
        IF( le.Input_additional_info = (TYPEOF(le.Input_additional_info))'','',':additional_info')
    #END
 
+    #IF( #TEXT(Input_agency)='' )
      '' 
    #ELSE
        IF( le.Input_agency = (TYPEOF(le.Input_agency))'','',':agency')
    #END
 
+    #IF( #TEXT(Input_alleged_amount)='' )
      '' 
    #ELSE
        IF( le.Input_alleged_amount = (TYPEOF(le.Input_alleged_amount))'','',':alleged_amount')
    #END
 
+    #IF( #TEXT(Input_estimated_loss)='' )
      '' 
    #ELSE
        IF( le.Input_estimated_loss = (TYPEOF(le.Input_estimated_loss))'','',':estimated_loss')
    #END
 
+    #IF( #TEXT(Input_fcr_date)='' )
      '' 
    #ELSE
        IF( le.Input_fcr_date = (TYPEOF(le.Input_fcr_date))'','',':fcr_date')
    #END
 
+    #IF( #TEXT(Input_ok_for_fcr)='' )
      '' 
    #ELSE
        IF( le.Input_ok_for_fcr = (TYPEOF(le.Input_ok_for_fcr))'','',':ok_for_fcr')
    #END
 
+    #IF( #TEXT(Input_modified_date)='' )
      '' 
    #ELSE
        IF( le.Input_modified_date = (TYPEOF(le.Input_modified_date))'','',':modified_date')
    #END
 
+    #IF( #TEXT(Input_load_date)='' )
      '' 
    #ELSE
        IF( le.Input_load_date = (TYPEOF(le.Input_load_date))'','',':load_date')
    #END
 
+    #IF( #TEXT(Input_incident_text)='' )
      '' 
    #ELSE
        IF( le.Input_incident_text = (TYPEOF(le.Input_incident_text))'','',':incident_text')
    #END
 
+    #IF( #TEXT(Input_incident_date_clean)='' )
      '' 
    #ELSE
        IF( le.Input_incident_date_clean = (TYPEOF(le.Input_incident_date_clean))'','',':incident_date_clean')
    #END
 
+    #IF( #TEXT(Input_fcr_date_clean)='' )
      '' 
    #ELSE
        IF( le.Input_fcr_date_clean = (TYPEOF(le.Input_fcr_date_clean))'','',':fcr_date_clean')
    #END
 
+    #IF( #TEXT(Input_cln_modified_date)='' )
      '' 
    #ELSE
        IF( le.Input_cln_modified_date = (TYPEOF(le.Input_cln_modified_date))'','',':cln_modified_date')
    #END
 
+    #IF( #TEXT(Input_cln_load_date)='' )
      '' 
    #ELSE
        IF( le.Input_cln_load_date = (TYPEOF(le.Input_cln_load_date))'','',':cln_load_date')
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
