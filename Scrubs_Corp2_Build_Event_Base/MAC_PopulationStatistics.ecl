 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_bdid = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_corp_key = '',Input_corp_supp_key = '',Input_corp_vendor = '',Input_corp_vendor_county = '',Input_corp_vendor_subcode = '',Input_corp_state_origin = '',Input_corp_process_date = '',Input_corp_sos_charter_nbr = '',Input_event_filing_reference_nbr = '',Input_event_amendment_nbr = '',Input_event_filing_date = '',Input_event_date_type_cd = '',Input_event_date_type_desc = '',Input_event_filing_cd = '',Input_event_filing_desc = '',Input_event_corp_nbr = '',Input_event_corp_nbr_cd = '',Input_event_corp_nbr_desc = '',Input_event_roll = '',Input_event_frame = '',Input_event_start = '',Input_event_end = '',Input_event_microfilm_nbr = '',Input_event_desc = '',Input_record_type = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_Corp2_Build_Event_Base;
  #uniquename(of)
  %of% := RECORD
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
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
 
+    #IF( #TEXT(Input_corp_key)='' )
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
        IF( le.Input_corp_process_date = (TYPEOF(le.Input_corp_process_date))'','',':corp_process_date')
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
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
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
