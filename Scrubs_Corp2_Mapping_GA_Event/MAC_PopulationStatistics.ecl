 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_corp_key = '',Input_corp_supp_key = '',Input_corp_vendor = '',Input_corp_vendor_county = '',Input_corp_vendor_subcode = '',Input_corp_state_origin = '',Input_corp_process_date = '',Input_corp_sos_charter_nbr = '',Input_event_filing_reference_nbr = '',Input_event_amendment_nbr = '',Input_event_filing_date = '',Input_event_date_type_cd = '',Input_event_date_type_desc = '',Input_event_filing_cd = '',Input_event_filing_desc = '',Input_event_corp_nbr = '',Input_event_corp_nbr_cd = '',Input_event_corp_nbr_desc = '',Input_event_roll = '',Input_event_frame = '',Input_event_start = '',Input_event_end = '',Input_event_microfilm_nbr = '',Input_event_desc = '',Input_event_revocation_comment1 = '',Input_event_revocation_comment2 = '',Input_event_book_nbr = '',Input_event_page_nbr = '',Input_event_certification_nbr = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_Corp2_Mapping_GA_Event;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_corp_key = (TYPEOF(le.Input_corp_key))'','',':corp_key')
    #END
 
+    #IF( #TEXT(Input_corp_supp_key)='' )
      '' 
    #ELSE
        IF( le.Input_corp_supp_key = (TYPEOF(le.Input_corp_supp_key))'','',':corp_supp_key')
    #END
 
+    #IF( #TEXT(Input_corp_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor = (TYPEOF(le.Input_corp_vendor))'','',':corp_vendor')
    #END
 
+    #IF( #TEXT(Input_corp_vendor_county)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor_county = (TYPEOF(le.Input_corp_vendor_county))'','',':corp_vendor_county')
    #END
 
+    #IF( #TEXT(Input_corp_vendor_subcode)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor_subcode = (TYPEOF(le.Input_corp_vendor_subcode))'','',':corp_vendor_subcode')
    #END
 
+    #IF( #TEXT(Input_corp_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_corp_state_origin = (TYPEOF(le.Input_corp_state_origin))'','',':corp_state_origin')
    #END
 
+    #IF( #TEXT(Input_corp_process_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_corp_process_date = 0,'', ':corp_process_date(' + SALT38.fn_date_valid_as_text((unsigned)le.Input_corp_process_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_corp_sos_charter_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_sos_charter_nbr = (TYPEOF(le.Input_corp_sos_charter_nbr))'','',':corp_sos_charter_nbr')
    #END
 
+    #IF( #TEXT(Input_event_filing_reference_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_event_filing_reference_nbr = (TYPEOF(le.Input_event_filing_reference_nbr))'','',':event_filing_reference_nbr')
    #END
 
+    #IF( #TEXT(Input_event_amendment_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_event_amendment_nbr = (TYPEOF(le.Input_event_amendment_nbr))'','',':event_amendment_nbr')
    #END
 
+    #IF( #TEXT(Input_event_filing_date)='' )
      '' 
    #ELSE
        IF( le.Input_event_filing_date = (TYPEOF(le.Input_event_filing_date))'','',':event_filing_date')
    #END
 
+    #IF( #TEXT(Input_event_date_type_cd)='' )
      '' 
    #ELSE
        IF( le.Input_event_date_type_cd = (TYPEOF(le.Input_event_date_type_cd))'','',':event_date_type_cd')
    #END
 
+    #IF( #TEXT(Input_event_date_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_event_date_type_desc = (TYPEOF(le.Input_event_date_type_desc))'','',':event_date_type_desc')
    #END
 
+    #IF( #TEXT(Input_event_filing_cd)='' )
      '' 
    #ELSE
        IF( le.Input_event_filing_cd = (TYPEOF(le.Input_event_filing_cd))'','',':event_filing_cd')
    #END
 
+    #IF( #TEXT(Input_event_filing_desc)='' )
      '' 
    #ELSE
        IF( le.Input_event_filing_desc = (TYPEOF(le.Input_event_filing_desc))'','',':event_filing_desc')
    #END
 
+    #IF( #TEXT(Input_event_corp_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_event_corp_nbr = (TYPEOF(le.Input_event_corp_nbr))'','',':event_corp_nbr')
    #END
 
+    #IF( #TEXT(Input_event_corp_nbr_cd)='' )
      '' 
    #ELSE
        IF( le.Input_event_corp_nbr_cd = (TYPEOF(le.Input_event_corp_nbr_cd))'','',':event_corp_nbr_cd')
    #END
 
+    #IF( #TEXT(Input_event_corp_nbr_desc)='' )
      '' 
    #ELSE
        IF( le.Input_event_corp_nbr_desc = (TYPEOF(le.Input_event_corp_nbr_desc))'','',':event_corp_nbr_desc')
    #END
 
+    #IF( #TEXT(Input_event_roll)='' )
      '' 
    #ELSE
        IF( le.Input_event_roll = (TYPEOF(le.Input_event_roll))'','',':event_roll')
    #END
 
+    #IF( #TEXT(Input_event_frame)='' )
      '' 
    #ELSE
        IF( le.Input_event_frame = (TYPEOF(le.Input_event_frame))'','',':event_frame')
    #END
 
+    #IF( #TEXT(Input_event_start)='' )
      '' 
    #ELSE
        IF( le.Input_event_start = (TYPEOF(le.Input_event_start))'','',':event_start')
    #END
 
+    #IF( #TEXT(Input_event_end)='' )
      '' 
    #ELSE
        IF( le.Input_event_end = (TYPEOF(le.Input_event_end))'','',':event_end')
    #END
 
+    #IF( #TEXT(Input_event_microfilm_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_event_microfilm_nbr = (TYPEOF(le.Input_event_microfilm_nbr))'','',':event_microfilm_nbr')
    #END
 
+    #IF( #TEXT(Input_event_desc)='' )
      '' 
    #ELSE
        IF( le.Input_event_desc = (TYPEOF(le.Input_event_desc))'','',':event_desc')
    #END
 
+    #IF( #TEXT(Input_event_revocation_comment1)='' )
      '' 
    #ELSE
        IF( le.Input_event_revocation_comment1 = (TYPEOF(le.Input_event_revocation_comment1))'','',':event_revocation_comment1')
    #END
 
+    #IF( #TEXT(Input_event_revocation_comment2)='' )
      '' 
    #ELSE
        IF( le.Input_event_revocation_comment2 = (TYPEOF(le.Input_event_revocation_comment2))'','',':event_revocation_comment2')
    #END
 
+    #IF( #TEXT(Input_event_book_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_event_book_nbr = (TYPEOF(le.Input_event_book_nbr))'','',':event_book_nbr')
    #END
 
+    #IF( #TEXT(Input_event_page_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_event_page_nbr = (TYPEOF(le.Input_event_page_nbr))'','',':event_page_nbr')
    #END
 
+    #IF( #TEXT(Input_event_certification_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_event_certification_nbr = (TYPEOF(le.Input_event_certification_nbr))'','',':event_certification_nbr')
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
