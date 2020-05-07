 
EXPORT Input_MAC_PopulationStatistics(infile,Ref='',Input_employer_id_number = '',Input_primary_name_of_organization = '',Input_in_care_of_name = '',Input_street_address = '',Input_city = '',Input_state = '',Input_zip_code = '',Input_group_exemption_number = '',Input_subsection_code = '',Input_affiliation_code = '',Input_classification_code = '',Input_ruling_date = '',Input_deductibility_code = '',Input_foundation_code = '',Input_activity_codes = '',Input_organization_code = '',Input_exempt_org_status_code = '',Input_tax_period = '',Input_asset_code = '',Input_income_code = '',Input_filing_requirement_code_part1 = '',Input_filing_requirement_code_part2 = '',Input_accounting_period = '',Input_asset_amount = '',Input_income_amount = '',Input_form_990_revenue_amount = '',Input_national_taxonomy_exempt = '',Input_sort_name = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_IRS_Nonprofit;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_employer_id_number)='' )
      '' 
    #ELSE
        IF( le.Input_employer_id_number = (TYPEOF(le.Input_employer_id_number))'','',':employer_id_number')
    #END
 
+    #IF( #TEXT(Input_primary_name_of_organization)='' )
      '' 
    #ELSE
        IF( le.Input_primary_name_of_organization = (TYPEOF(le.Input_primary_name_of_organization))'','',':primary_name_of_organization')
    #END
 
+    #IF( #TEXT(Input_in_care_of_name)='' )
      '' 
    #ELSE
        IF( le.Input_in_care_of_name = (TYPEOF(le.Input_in_care_of_name))'','',':in_care_of_name')
    #END
 
+    #IF( #TEXT(Input_street_address)='' )
      '' 
    #ELSE
        IF( le.Input_street_address = (TYPEOF(le.Input_street_address))'','',':street_address')
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
 
+    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
 
+    #IF( #TEXT(Input_group_exemption_number)='' )
      '' 
    #ELSE
        IF( le.Input_group_exemption_number = (TYPEOF(le.Input_group_exemption_number))'','',':group_exemption_number')
    #END
 
+    #IF( #TEXT(Input_subsection_code)='' )
      '' 
    #ELSE
        IF( le.Input_subsection_code = (TYPEOF(le.Input_subsection_code))'','',':subsection_code')
    #END
 
+    #IF( #TEXT(Input_affiliation_code)='' )
      '' 
    #ELSE
        IF( le.Input_affiliation_code = (TYPEOF(le.Input_affiliation_code))'','',':affiliation_code')
    #END
 
+    #IF( #TEXT(Input_classification_code)='' )
      '' 
    #ELSE
        IF( le.Input_classification_code = (TYPEOF(le.Input_classification_code))'','',':classification_code')
    #END
 
+    #IF( #TEXT(Input_ruling_date)='' )
      '' 
    #ELSE
        IF( le.Input_ruling_date = (TYPEOF(le.Input_ruling_date))'','',':ruling_date')
    #END
 
+    #IF( #TEXT(Input_deductibility_code)='' )
      '' 
    #ELSE
        IF( le.Input_deductibility_code = (TYPEOF(le.Input_deductibility_code))'','',':deductibility_code')
    #END
 
+    #IF( #TEXT(Input_foundation_code)='' )
      '' 
    #ELSE
        IF( le.Input_foundation_code = (TYPEOF(le.Input_foundation_code))'','',':foundation_code')
    #END
 
+    #IF( #TEXT(Input_activity_codes)='' )
      '' 
    #ELSE
        IF( le.Input_activity_codes = (TYPEOF(le.Input_activity_codes))'','',':activity_codes')
    #END
 
+    #IF( #TEXT(Input_organization_code)='' )
      '' 
    #ELSE
        IF( le.Input_organization_code = (TYPEOF(le.Input_organization_code))'','',':organization_code')
    #END
 
+    #IF( #TEXT(Input_exempt_org_status_code)='' )
      '' 
    #ELSE
        IF( le.Input_exempt_org_status_code = (TYPEOF(le.Input_exempt_org_status_code))'','',':exempt_org_status_code')
    #END
 
+    #IF( #TEXT(Input_tax_period)='' )
      '' 
    #ELSE
        IF( le.Input_tax_period = (TYPEOF(le.Input_tax_period))'','',':tax_period')
    #END
 
+    #IF( #TEXT(Input_asset_code)='' )
      '' 
    #ELSE
        IF( le.Input_asset_code = (TYPEOF(le.Input_asset_code))'','',':asset_code')
    #END
 
+    #IF( #TEXT(Input_income_code)='' )
      '' 
    #ELSE
        IF( le.Input_income_code = (TYPEOF(le.Input_income_code))'','',':income_code')
    #END
 
+    #IF( #TEXT(Input_filing_requirement_code_part1)='' )
      '' 
    #ELSE
        IF( le.Input_filing_requirement_code_part1 = (TYPEOF(le.Input_filing_requirement_code_part1))'','',':filing_requirement_code_part1')
    #END
 
+    #IF( #TEXT(Input_filing_requirement_code_part2)='' )
      '' 
    #ELSE
        IF( le.Input_filing_requirement_code_part2 = (TYPEOF(le.Input_filing_requirement_code_part2))'','',':filing_requirement_code_part2')
    #END
 
+    #IF( #TEXT(Input_accounting_period)='' )
      '' 
    #ELSE
        IF( le.Input_accounting_period = (TYPEOF(le.Input_accounting_period))'','',':accounting_period')
    #END
 
+    #IF( #TEXT(Input_asset_amount)='' )
      '' 
    #ELSE
        IF( le.Input_asset_amount = (TYPEOF(le.Input_asset_amount))'','',':asset_amount')
    #END
 
+    #IF( #TEXT(Input_income_amount)='' )
      '' 
    #ELSE
        IF( le.Input_income_amount = (TYPEOF(le.Input_income_amount))'','',':income_amount')
    #END
 
+    #IF( #TEXT(Input_form_990_revenue_amount)='' )
      '' 
    #ELSE
        IF( le.Input_form_990_revenue_amount = (TYPEOF(le.Input_form_990_revenue_amount))'','',':form_990_revenue_amount')
    #END
 
+    #IF( #TEXT(Input_national_taxonomy_exempt)='' )
      '' 
    #ELSE
        IF( le.Input_national_taxonomy_exempt = (TYPEOF(le.Input_national_taxonomy_exempt))'','',':national_taxonomy_exempt')
    #END
 
+    #IF( #TEXT(Input_sort_name)='' )
      '' 
    #ELSE
        IF( le.Input_sort_name = (TYPEOF(le.Input_sort_name))'','',':sort_name')
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
