 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_file_key = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_date_updated = '',Input_type_instituon_code = '',Input_head_office_branch_codes = '',Input_routing_number_micr = '',Input_routing_number_fractional = '',Input_institution_name_full = '',Input_institution_name_abbreviated = '',Input_street_address = '',Input_city_town = '',Input_state = '',Input_zip_code = '',Input_zip_4 = '',Input_mail_address = '',Input_mail_city_town = '',Input_mail_state = '',Input_mail_zip_code = '',Input_mail_zip_4 = '',Input_branch_office_name = '',Input_head_office_routing_number = '',Input_phone_number_area_code = '',Input_phone_number = '',Input_phone_number_extension = '',Input_fax_area_code = '',Input_fax_number = '',Input_fax_extension = '',Input_head_office_asset_size = '',Input_federal_reserve_district_code = '',Input_year_2000_date_last_updated = '',Input_head_office_file_key = '',Input_routing_number_type = '',Input_routing_number_status = '',Input_employer_tax_id = '',Input_institution_identifier = '',OutFile) := MACRO
  IMPORT SALT38,scrubs_bank_routing;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_file_key)='' )
      '' 
    #ELSE
        IF( le.Input_file_key = (TYPEOF(le.Input_file_key))'','',':file_key')
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
 
+    #IF( #TEXT(Input_date_updated)='' )
      '' 
    #ELSE
        IF( le.Input_date_updated = (TYPEOF(le.Input_date_updated))'','',':date_updated')
    #END
 
+    #IF( #TEXT(Input_type_instituon_code)='' )
      '' 
    #ELSE
        IF( le.Input_type_instituon_code = (TYPEOF(le.Input_type_instituon_code))'','',':type_instituon_code')
    #END
 
+    #IF( #TEXT(Input_head_office_branch_codes)='' )
      '' 
    #ELSE
        IF( le.Input_head_office_branch_codes = (TYPEOF(le.Input_head_office_branch_codes))'','',':head_office_branch_codes')
    #END
 
+    #IF( #TEXT(Input_routing_number_micr)='' )
      '' 
    #ELSE
        IF( le.Input_routing_number_micr = (TYPEOF(le.Input_routing_number_micr))'','',':routing_number_micr')
    #END
 
+    #IF( #TEXT(Input_routing_number_fractional)='' )
      '' 
    #ELSE
        IF( le.Input_routing_number_fractional = (TYPEOF(le.Input_routing_number_fractional))'','',':routing_number_fractional')
    #END
 
+    #IF( #TEXT(Input_institution_name_full)='' )
      '' 
    #ELSE
        IF( le.Input_institution_name_full = (TYPEOF(le.Input_institution_name_full))'','',':institution_name_full')
    #END
 
+    #IF( #TEXT(Input_institution_name_abbreviated)='' )
      '' 
    #ELSE
        IF( le.Input_institution_name_abbreviated = (TYPEOF(le.Input_institution_name_abbreviated))'','',':institution_name_abbreviated')
    #END
 
+    #IF( #TEXT(Input_street_address)='' )
      '' 
    #ELSE
        IF( le.Input_street_address = (TYPEOF(le.Input_street_address))'','',':street_address')
    #END
 
+    #IF( #TEXT(Input_city_town)='' )
      '' 
    #ELSE
        IF( le.Input_city_town = (TYPEOF(le.Input_city_town))'','',':city_town')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
 
+    #IF( #TEXT(Input_zip_4)='' )
      '' 
    #ELSE
        IF( le.Input_zip_4 = (TYPEOF(le.Input_zip_4))'','',':zip_4')
    #END
 
+    #IF( #TEXT(Input_mail_address)='' )
      '' 
    #ELSE
        IF( le.Input_mail_address = (TYPEOF(le.Input_mail_address))'','',':mail_address')
    #END
 
+    #IF( #TEXT(Input_mail_city_town)='' )
      '' 
    #ELSE
        IF( le.Input_mail_city_town = (TYPEOF(le.Input_mail_city_town))'','',':mail_city_town')
    #END
 
+    #IF( #TEXT(Input_mail_state)='' )
      '' 
    #ELSE
        IF( le.Input_mail_state = (TYPEOF(le.Input_mail_state))'','',':mail_state')
    #END
 
+    #IF( #TEXT(Input_mail_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_mail_zip_code = (TYPEOF(le.Input_mail_zip_code))'','',':mail_zip_code')
    #END
 
+    #IF( #TEXT(Input_mail_zip_4)='' )
      '' 
    #ELSE
        IF( le.Input_mail_zip_4 = (TYPEOF(le.Input_mail_zip_4))'','',':mail_zip_4')
    #END
 
+    #IF( #TEXT(Input_branch_office_name)='' )
      '' 
    #ELSE
        IF( le.Input_branch_office_name = (TYPEOF(le.Input_branch_office_name))'','',':branch_office_name')
    #END
 
+    #IF( #TEXT(Input_head_office_routing_number)='' )
      '' 
    #ELSE
        IF( le.Input_head_office_routing_number = (TYPEOF(le.Input_head_office_routing_number))'','',':head_office_routing_number')
    #END
 
+    #IF( #TEXT(Input_phone_number_area_code)='' )
      '' 
    #ELSE
        IF( le.Input_phone_number_area_code = (TYPEOF(le.Input_phone_number_area_code))'','',':phone_number_area_code')
    #END
 
+    #IF( #TEXT(Input_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_phone_number = (TYPEOF(le.Input_phone_number))'','',':phone_number')
    #END
 
+    #IF( #TEXT(Input_phone_number_extension)='' )
      '' 
    #ELSE
        IF( le.Input_phone_number_extension = (TYPEOF(le.Input_phone_number_extension))'','',':phone_number_extension')
    #END
 
+    #IF( #TEXT(Input_fax_area_code)='' )
      '' 
    #ELSE
        IF( le.Input_fax_area_code = (TYPEOF(le.Input_fax_area_code))'','',':fax_area_code')
    #END
 
+    #IF( #TEXT(Input_fax_number)='' )
      '' 
    #ELSE
        IF( le.Input_fax_number = (TYPEOF(le.Input_fax_number))'','',':fax_number')
    #END
 
+    #IF( #TEXT(Input_fax_extension)='' )
      '' 
    #ELSE
        IF( le.Input_fax_extension = (TYPEOF(le.Input_fax_extension))'','',':fax_extension')
    #END
 
+    #IF( #TEXT(Input_head_office_asset_size)='' )
      '' 
    #ELSE
        IF( le.Input_head_office_asset_size = (TYPEOF(le.Input_head_office_asset_size))'','',':head_office_asset_size')
    #END
 
+    #IF( #TEXT(Input_federal_reserve_district_code)='' )
      '' 
    #ELSE
        IF( le.Input_federal_reserve_district_code = (TYPEOF(le.Input_federal_reserve_district_code))'','',':federal_reserve_district_code')
    #END
 
+    #IF( #TEXT(Input_year_2000_date_last_updated)='' )
      '' 
    #ELSE
        IF( le.Input_year_2000_date_last_updated = (TYPEOF(le.Input_year_2000_date_last_updated))'','',':year_2000_date_last_updated')
    #END
 
+    #IF( #TEXT(Input_head_office_file_key)='' )
      '' 
    #ELSE
        IF( le.Input_head_office_file_key = (TYPEOF(le.Input_head_office_file_key))'','',':head_office_file_key')
    #END
 
+    #IF( #TEXT(Input_routing_number_type)='' )
      '' 
    #ELSE
        IF( le.Input_routing_number_type = (TYPEOF(le.Input_routing_number_type))'','',':routing_number_type')
    #END
 
+    #IF( #TEXT(Input_routing_number_status)='' )
      '' 
    #ELSE
        IF( le.Input_routing_number_status = (TYPEOF(le.Input_routing_number_status))'','',':routing_number_status')
    #END
 
+    #IF( #TEXT(Input_employer_tax_id)='' )
      '' 
    #ELSE
        IF( le.Input_employer_tax_id = (TYPEOF(le.Input_employer_tax_id))'','',':employer_tax_id')
    #END
 
+    #IF( #TEXT(Input_institution_identifier)='' )
      '' 
    #ELSE
        IF( le.Input_institution_identifier = (TYPEOF(le.Input_institution_identifier))'','',':institution_identifier')
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
