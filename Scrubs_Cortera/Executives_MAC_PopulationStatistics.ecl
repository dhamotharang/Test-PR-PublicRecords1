 
EXPORT Executives_MAC_PopulationStatistics(infile,Ref='',Input_link_id = '',Input_name = '',Input_alternate_business_name = '',Input_address = '',Input_address2 = '',Input_city = '',Input_state = '',Input_country = '',Input_postalcode = '',Input_phone = '',Input_fax = '',Input_latitude = '',Input_longitude = '',Input_url = '',Input_fein = '',Input_position_type = '',Input_ultimate_linkid = '',Input_ultimate_name = '',Input_loc_date_last_seen = '',Input_primary_sic = '',Input_sic_desc = '',Input_primary_naics = '',Input_naics_desc = '',Input_segment_id = '',Input_segment_desc = '',Input_year_start = '',Input_ownership = '',Input_total_employees = '',Input_employee_range = '',Input_total_sales = '',Input_sales_range = '',Input_executive_name1 = '',Input_title1 = '',Input_executive_name2 = '',Input_title2 = '',Input_executive_name3 = '',Input_title3 = '',Input_executive_name4 = '',Input_title4 = '',Input_executive_name5 = '',Input_title5 = '',Input_executive_name6 = '',Input_title6 = '',Input_executive_name7 = '',Input_title7 = '',Input_executive_name8 = '',Input_title8 = '',Input_executive_name9 = '',Input_title9 = '',Input_executive_name10 = '',Input_title10 = '',Input_status = '',Input_is_closed = '',Input_closed_date = '',Input_processdate = '',Input_version = '',Input_persistent_record_id = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_prim_name = '',Input_p_city_name = '',Input_v_city_name = '',Input_executive_name = '',Input_executive_title = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Cortera;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_link_id)='' )
      '' 
    #ELSE
        IF( le.Input_link_id = (TYPEOF(le.Input_link_id))'','',':link_id')
    #END
 
+    #IF( #TEXT(Input_name)='' )
      '' 
    #ELSE
        IF( le.Input_name = (TYPEOF(le.Input_name))'','',':name')
    #END
 
+    #IF( #TEXT(Input_alternate_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_alternate_business_name = (TYPEOF(le.Input_alternate_business_name))'','',':alternate_business_name')
    #END
 
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
    #END
 
+    #IF( #TEXT(Input_address2)='' )
      '' 
    #ELSE
        IF( le.Input_address2 = (TYPEOF(le.Input_address2))'','',':address2')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
 
+    #IF( #TEXT(Input_postalcode)='' )
      '' 
    #ELSE
        IF( le.Input_postalcode = (TYPEOF(le.Input_postalcode))'','',':postalcode')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_fax)='' )
      '' 
    #ELSE
        IF( le.Input_fax = (TYPEOF(le.Input_fax))'','',':fax')
    #END
 
+    #IF( #TEXT(Input_latitude)='' )
      '' 
    #ELSE
        IF( le.Input_latitude = (TYPEOF(le.Input_latitude))'','',':latitude')
    #END
 
+    #IF( #TEXT(Input_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_longitude = (TYPEOF(le.Input_longitude))'','',':longitude')
    #END
 
+    #IF( #TEXT(Input_url)='' )
      '' 
    #ELSE
        IF( le.Input_url = (TYPEOF(le.Input_url))'','',':url')
    #END
 
+    #IF( #TEXT(Input_fein)='' )
      '' 
    #ELSE
        IF( le.Input_fein = (TYPEOF(le.Input_fein))'','',':fein')
    #END
 
+    #IF( #TEXT(Input_position_type)='' )
      '' 
    #ELSE
        IF( le.Input_position_type = (TYPEOF(le.Input_position_type))'','',':position_type')
    #END
 
+    #IF( #TEXT(Input_ultimate_linkid)='' )
      '' 
    #ELSE
        IF( le.Input_ultimate_linkid = (TYPEOF(le.Input_ultimate_linkid))'','',':ultimate_linkid')
    #END
 
+    #IF( #TEXT(Input_ultimate_name)='' )
      '' 
    #ELSE
        IF( le.Input_ultimate_name = (TYPEOF(le.Input_ultimate_name))'','',':ultimate_name')
    #END
 
+    #IF( #TEXT(Input_loc_date_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_loc_date_last_seen = (TYPEOF(le.Input_loc_date_last_seen))'','',':loc_date_last_seen')
    #END
 
+    #IF( #TEXT(Input_primary_sic)='' )
      '' 
    #ELSE
        IF( le.Input_primary_sic = (TYPEOF(le.Input_primary_sic))'','',':primary_sic')
    #END
 
+    #IF( #TEXT(Input_sic_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sic_desc = (TYPEOF(le.Input_sic_desc))'','',':sic_desc')
    #END
 
+    #IF( #TEXT(Input_primary_naics)='' )
      '' 
    #ELSE
        IF( le.Input_primary_naics = (TYPEOF(le.Input_primary_naics))'','',':primary_naics')
    #END
 
+    #IF( #TEXT(Input_naics_desc)='' )
      '' 
    #ELSE
        IF( le.Input_naics_desc = (TYPEOF(le.Input_naics_desc))'','',':naics_desc')
    #END
 
+    #IF( #TEXT(Input_segment_id)='' )
      '' 
    #ELSE
        IF( le.Input_segment_id = (TYPEOF(le.Input_segment_id))'','',':segment_id')
    #END
 
+    #IF( #TEXT(Input_segment_desc)='' )
      '' 
    #ELSE
        IF( le.Input_segment_desc = (TYPEOF(le.Input_segment_desc))'','',':segment_desc')
    #END
 
+    #IF( #TEXT(Input_year_start)='' )
      '' 
    #ELSE
        IF( le.Input_year_start = (TYPEOF(le.Input_year_start))'','',':year_start')
    #END
 
+    #IF( #TEXT(Input_ownership)='' )
      '' 
    #ELSE
        IF( le.Input_ownership = (TYPEOF(le.Input_ownership))'','',':ownership')
    #END
 
+    #IF( #TEXT(Input_total_employees)='' )
      '' 
    #ELSE
        IF( le.Input_total_employees = (TYPEOF(le.Input_total_employees))'','',':total_employees')
    #END
 
+    #IF( #TEXT(Input_employee_range)='' )
      '' 
    #ELSE
        IF( le.Input_employee_range = (TYPEOF(le.Input_employee_range))'','',':employee_range')
    #END
 
+    #IF( #TEXT(Input_total_sales)='' )
      '' 
    #ELSE
        IF( le.Input_total_sales = (TYPEOF(le.Input_total_sales))'','',':total_sales')
    #END
 
+    #IF( #TEXT(Input_sales_range)='' )
      '' 
    #ELSE
        IF( le.Input_sales_range = (TYPEOF(le.Input_sales_range))'','',':sales_range')
    #END
 
+    #IF( #TEXT(Input_executive_name1)='' )
      '' 
    #ELSE
        IF( le.Input_executive_name1 = (TYPEOF(le.Input_executive_name1))'','',':executive_name1')
    #END
 
+    #IF( #TEXT(Input_title1)='' )
      '' 
    #ELSE
        IF( le.Input_title1 = (TYPEOF(le.Input_title1))'','',':title1')
    #END
 
+    #IF( #TEXT(Input_executive_name2)='' )
      '' 
    #ELSE
        IF( le.Input_executive_name2 = (TYPEOF(le.Input_executive_name2))'','',':executive_name2')
    #END
 
+    #IF( #TEXT(Input_title2)='' )
      '' 
    #ELSE
        IF( le.Input_title2 = (TYPEOF(le.Input_title2))'','',':title2')
    #END
 
+    #IF( #TEXT(Input_executive_name3)='' )
      '' 
    #ELSE
        IF( le.Input_executive_name3 = (TYPEOF(le.Input_executive_name3))'','',':executive_name3')
    #END
 
+    #IF( #TEXT(Input_title3)='' )
      '' 
    #ELSE
        IF( le.Input_title3 = (TYPEOF(le.Input_title3))'','',':title3')
    #END
 
+    #IF( #TEXT(Input_executive_name4)='' )
      '' 
    #ELSE
        IF( le.Input_executive_name4 = (TYPEOF(le.Input_executive_name4))'','',':executive_name4')
    #END
 
+    #IF( #TEXT(Input_title4)='' )
      '' 
    #ELSE
        IF( le.Input_title4 = (TYPEOF(le.Input_title4))'','',':title4')
    #END
 
+    #IF( #TEXT(Input_executive_name5)='' )
      '' 
    #ELSE
        IF( le.Input_executive_name5 = (TYPEOF(le.Input_executive_name5))'','',':executive_name5')
    #END
 
+    #IF( #TEXT(Input_title5)='' )
      '' 
    #ELSE
        IF( le.Input_title5 = (TYPEOF(le.Input_title5))'','',':title5')
    #END
 
+    #IF( #TEXT(Input_executive_name6)='' )
      '' 
    #ELSE
        IF( le.Input_executive_name6 = (TYPEOF(le.Input_executive_name6))'','',':executive_name6')
    #END
 
+    #IF( #TEXT(Input_title6)='' )
      '' 
    #ELSE
        IF( le.Input_title6 = (TYPEOF(le.Input_title6))'','',':title6')
    #END
 
+    #IF( #TEXT(Input_executive_name7)='' )
      '' 
    #ELSE
        IF( le.Input_executive_name7 = (TYPEOF(le.Input_executive_name7))'','',':executive_name7')
    #END
 
+    #IF( #TEXT(Input_title7)='' )
      '' 
    #ELSE
        IF( le.Input_title7 = (TYPEOF(le.Input_title7))'','',':title7')
    #END
 
+    #IF( #TEXT(Input_executive_name8)='' )
      '' 
    #ELSE
        IF( le.Input_executive_name8 = (TYPEOF(le.Input_executive_name8))'','',':executive_name8')
    #END
 
+    #IF( #TEXT(Input_title8)='' )
      '' 
    #ELSE
        IF( le.Input_title8 = (TYPEOF(le.Input_title8))'','',':title8')
    #END
 
+    #IF( #TEXT(Input_executive_name9)='' )
      '' 
    #ELSE
        IF( le.Input_executive_name9 = (TYPEOF(le.Input_executive_name9))'','',':executive_name9')
    #END
 
+    #IF( #TEXT(Input_title9)='' )
      '' 
    #ELSE
        IF( le.Input_title9 = (TYPEOF(le.Input_title9))'','',':title9')
    #END
 
+    #IF( #TEXT(Input_executive_name10)='' )
      '' 
    #ELSE
        IF( le.Input_executive_name10 = (TYPEOF(le.Input_executive_name10))'','',':executive_name10')
    #END
 
+    #IF( #TEXT(Input_title10)='' )
      '' 
    #ELSE
        IF( le.Input_title10 = (TYPEOF(le.Input_title10))'','',':title10')
    #END
 
+    #IF( #TEXT(Input_status)='' )
      '' 
    #ELSE
        IF( le.Input_status = (TYPEOF(le.Input_status))'','',':status')
    #END
 
+    #IF( #TEXT(Input_is_closed)='' )
      '' 
    #ELSE
        IF( le.Input_is_closed = (TYPEOF(le.Input_is_closed))'','',':is_closed')
    #END
 
+    #IF( #TEXT(Input_closed_date)='' )
      '' 
    #ELSE
        IF( le.Input_closed_date = (TYPEOF(le.Input_closed_date))'','',':closed_date')
    #END
 
+    #IF( #TEXT(Input_processdate)='' )
      '' 
    #ELSE
        IF( le.Input_processdate = (TYPEOF(le.Input_processdate))'','',':processdate')
    #END
 
+    #IF( #TEXT(Input_version)='' )
      '' 
    #ELSE
        IF( le.Input_version = (TYPEOF(le.Input_version))'','',':version')
    #END
 
+    #IF( #TEXT(Input_persistent_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_persistent_record_id = (TYPEOF(le.Input_persistent_record_id))'','',':persistent_record_id')
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
 
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
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
 
+    #IF( #TEXT(Input_executive_name)='' )
      '' 
    #ELSE
        IF( le.Input_executive_name = (TYPEOF(le.Input_executive_name))'','',':executive_name')
    #END
 
+    #IF( #TEXT(Input_executive_title)='' )
      '' 
    #ELSE
        IF( le.Input_executive_title = (TYPEOF(le.Input_executive_title))'','',':executive_title')
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
