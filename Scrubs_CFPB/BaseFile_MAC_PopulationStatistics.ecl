 
EXPORT BaseFile_MAC_PopulationStatistics(infile,Ref='',Input_record_sid = '',Input_global_src_id = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_is_latest = '',Input_seqno = '',Input_geoid10_blkgrp = '',Input_state_fips10 = '',Input_county_fips10 = '',Input_tract_fips10 = '',Input_blkgrp_fips10 = '',Input_total_pop = '',Input_hispanic_total = '',Input_non_hispanic_total = '',Input_nh_white_alone = '',Input_nh_black_alone = '',Input_nh_aian_alone = '',Input_nh_api_alone = '',Input_nh_other_alone = '',Input_nh_mult_total = '',Input_nh_white_other = '',Input_nh_black_other = '',Input_nh_aian_other = '',Input_nh_asian_hpi = '',Input_nh_api_other = '',Input_nh_asian_hpi_other = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_CFPB;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_record_sid)='' )
      '' 
    #ELSE
        IF( le.Input_record_sid = (TYPEOF(le.Input_record_sid))'','',':record_sid')
    #END
 
+    #IF( #TEXT(Input_global_src_id)='' )
      '' 
    #ELSE
        IF( le.Input_global_src_id = (TYPEOF(le.Input_global_src_id))'','',':global_src_id')
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
 
+    #IF( #TEXT(Input_is_latest)='' )
      '' 
    #ELSE
        IF( le.Input_is_latest = (TYPEOF(le.Input_is_latest))'','',':is_latest')
    #END
 
+    #IF( #TEXT(Input_seqno)='' )
      '' 
    #ELSE
        IF( le.Input_seqno = (TYPEOF(le.Input_seqno))'','',':seqno')
    #END
 
+    #IF( #TEXT(Input_geoid10_blkgrp)='' )
      '' 
    #ELSE
        IF( le.Input_geoid10_blkgrp = (TYPEOF(le.Input_geoid10_blkgrp))'','',':geoid10_blkgrp')
    #END
 
+    #IF( #TEXT(Input_state_fips10)='' )
      '' 
    #ELSE
        IF( le.Input_state_fips10 = (TYPEOF(le.Input_state_fips10))'','',':state_fips10')
    #END
 
+    #IF( #TEXT(Input_county_fips10)='' )
      '' 
    #ELSE
        IF( le.Input_county_fips10 = (TYPEOF(le.Input_county_fips10))'','',':county_fips10')
    #END
 
+    #IF( #TEXT(Input_tract_fips10)='' )
      '' 
    #ELSE
        IF( le.Input_tract_fips10 = (TYPEOF(le.Input_tract_fips10))'','',':tract_fips10')
    #END
 
+    #IF( #TEXT(Input_blkgrp_fips10)='' )
      '' 
    #ELSE
        IF( le.Input_blkgrp_fips10 = (TYPEOF(le.Input_blkgrp_fips10))'','',':blkgrp_fips10')
    #END
 
+    #IF( #TEXT(Input_total_pop)='' )
      '' 
    #ELSE
        IF( le.Input_total_pop = (TYPEOF(le.Input_total_pop))'','',':total_pop')
    #END
 
+    #IF( #TEXT(Input_hispanic_total)='' )
      '' 
    #ELSE
        IF( le.Input_hispanic_total = (TYPEOF(le.Input_hispanic_total))'','',':hispanic_total')
    #END
 
+    #IF( #TEXT(Input_non_hispanic_total)='' )
      '' 
    #ELSE
        IF( le.Input_non_hispanic_total = (TYPEOF(le.Input_non_hispanic_total))'','',':non_hispanic_total')
    #END
 
+    #IF( #TEXT(Input_nh_white_alone)='' )
      '' 
    #ELSE
        IF( le.Input_nh_white_alone = (TYPEOF(le.Input_nh_white_alone))'','',':nh_white_alone')
    #END
 
+    #IF( #TEXT(Input_nh_black_alone)='' )
      '' 
    #ELSE
        IF( le.Input_nh_black_alone = (TYPEOF(le.Input_nh_black_alone))'','',':nh_black_alone')
    #END
 
+    #IF( #TEXT(Input_nh_aian_alone)='' )
      '' 
    #ELSE
        IF( le.Input_nh_aian_alone = (TYPEOF(le.Input_nh_aian_alone))'','',':nh_aian_alone')
    #END
 
+    #IF( #TEXT(Input_nh_api_alone)='' )
      '' 
    #ELSE
        IF( le.Input_nh_api_alone = (TYPEOF(le.Input_nh_api_alone))'','',':nh_api_alone')
    #END
 
+    #IF( #TEXT(Input_nh_other_alone)='' )
      '' 
    #ELSE
        IF( le.Input_nh_other_alone = (TYPEOF(le.Input_nh_other_alone))'','',':nh_other_alone')
    #END
 
+    #IF( #TEXT(Input_nh_mult_total)='' )
      '' 
    #ELSE
        IF( le.Input_nh_mult_total = (TYPEOF(le.Input_nh_mult_total))'','',':nh_mult_total')
    #END
 
+    #IF( #TEXT(Input_nh_white_other)='' )
      '' 
    #ELSE
        IF( le.Input_nh_white_other = (TYPEOF(le.Input_nh_white_other))'','',':nh_white_other')
    #END
 
+    #IF( #TEXT(Input_nh_black_other)='' )
      '' 
    #ELSE
        IF( le.Input_nh_black_other = (TYPEOF(le.Input_nh_black_other))'','',':nh_black_other')
    #END
 
+    #IF( #TEXT(Input_nh_aian_other)='' )
      '' 
    #ELSE
        IF( le.Input_nh_aian_other = (TYPEOF(le.Input_nh_aian_other))'','',':nh_aian_other')
    #END
 
+    #IF( #TEXT(Input_nh_asian_hpi)='' )
      '' 
    #ELSE
        IF( le.Input_nh_asian_hpi = (TYPEOF(le.Input_nh_asian_hpi))'','',':nh_asian_hpi')
    #END
 
+    #IF( #TEXT(Input_nh_api_other)='' )
      '' 
    #ELSE
        IF( le.Input_nh_api_other = (TYPEOF(le.Input_nh_api_other))'','',':nh_api_other')
    #END
 
+    #IF( #TEXT(Input_nh_asian_hpi_other)='' )
      '' 
    #ELSE
        IF( le.Input_nh_asian_hpi_other = (TYPEOF(le.Input_nh_asian_hpi_other))'','',':nh_asian_hpi_other')
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
