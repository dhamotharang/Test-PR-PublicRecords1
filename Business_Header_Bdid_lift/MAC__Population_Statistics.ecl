export MAC__Population_Statistics(infile,Ref='',Input_fein = '',Input_phone = '',Input_vendor_id = '',Input_company_name = '',Input_prim_range = '',Input_zip = '',Input_sec_range = '',Input_zip4 = '',Input_CITY = '',Input_unit_desig = '',Input_county = '',Input_prim_name = '',Input_state = '',Input_msa = '',Input_SOURCE = '',Input_addr_suffix = '',OutFile) := MACRO
  #uniquename(of)
  %of% := record
    string512 fields;
  end;
  #uniquename(ot)
  %of% %ot%(infile le) := transform
    self.fields :=
    #IF( #TEXT(Input_fein)='' )
      '' 
    #ELSE
        IF( le.Input_fein = (typeof(le.Input_fein))'','',':fein')
    #END
+
    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (typeof(le.Input_phone))'','',':phone')
    #END
+
    #IF( #TEXT(Input_vendor_id)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_id = (typeof(le.Input_vendor_id))'','',':vendor_id')
    #END
+
    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (typeof(le.Input_company_name))'','',':company_name')
    #END
+
    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (typeof(le.Input_prim_range))'','',':prim_range')
    #END
+
    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (typeof(le.Input_zip))'','',':zip')
    #END
+
    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (typeof(le.Input_sec_range))'','',':sec_range')
    #END
+
    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (typeof(le.Input_zip4))'','',':zip4')
    #END
+
    #IF( #TEXT(Input_CITY)='' )
      '' 
    #ELSE
        IF( le.Input_CITY = (typeof(le.Input_CITY))'','',':CITY')
    #END
+
    #IF( #TEXT(Input_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desig = (typeof(le.Input_unit_desig))'','',':unit_desig')
    #END
+
    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (typeof(le.Input_county))'','',':county')
    #END
+
    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (typeof(le.Input_prim_name))'','',':prim_name')
    #END
+
    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (typeof(le.Input_state))'','',':state')
    #END
+
    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (typeof(le.Input_msa))'','',':msa')
    #END
+
    #IF( #TEXT(Input_SOURCE)='' )
      '' 
    #ELSE
        IF( le.Input_SOURCE = (typeof(le.Input_SOURCE))'','',':SOURCE')
    #END
+
    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (typeof(le.Input_addr_suffix))'','',':addr_suffix')
    #END
;
  end;
  #uniquename(op)
  %op% := project(infile,%ot%(left));
  #uniquename(ort)
  %ort% := record
    %op%.fields;
    unsigned cnt := count(group);
  end;
  outfile := topn( table( %op%, %ort%, fields, few ), 1000, -cnt );
ENDMACRO;
