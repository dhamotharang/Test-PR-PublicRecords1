EXPORT MAC_PopulationStatistics(infile,Ref='',state_origin='',Input_iid = '',Input_pid = '',Input_vin = '',Input_make = '',Input_model = '',Input_year = '',Input_class_code = '',Input_fuel_type_code = '',Input_mfg_code = '',Input_style_code = '',Input_mileagecd = '',Input_nbr_vehicles = '',Input_idate = '',Input_odate = '',Input_fname = '',Input_mi = '',Input_lname = '',Input_suffix = '',Input_gender = '',Input_house = '',Input_predir = '',Input_street = '',Input_strtype = '',Input_postdir = '',Input_apttype = '',Input_aptnbr = '',Input_city = '',Input_state = '',Input_zip = '',Input_z4 = '',Input_dpc = '',Input_crte = '',Input_cnty = '',Input_z4type = '',Input_dpv = '',Input_vacant = '',Input_phone = '',Input_dnc = '',Input_internal1 = '',Input_internal2 = '',Input_internal3 = '',Input_county = '',Input_msa = '',Input_cbsa = '',Input_ehi = '',Input_child = '',Input_homeowner = '',Input_pctw = '',Input_pctb = '',Input_pcta = '',Input_pcth = '',Input_pctspe = '',Input_pctsps = '',Input_pctspa = '',Input_mhv = '',Input_mor = '',Input_pctoccw = '',Input_pctoccb = '',Input_pctocco = '',Input_lor = '',Input_sfdu = '',Input_mfdu = '',Input_processdate = '',Input_source_code = '',Input_state_origin = '',Input_append_ownernametypeind = '',Input_fullname = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_VehicleV2_Infutor_VIN;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(state_origin)<>'')
    SALT30.StrType source;
    #END
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_iid)='' )
      '' 
    #ELSE
        IF( le.Input_iid = (TYPEOF(le.Input_iid))'','',':iid')
    #END
+    #IF( #TEXT(Input_pid)='' )
      '' 
    #ELSE
        IF( le.Input_pid = (TYPEOF(le.Input_pid))'','',':pid')
    #END
+    #IF( #TEXT(Input_vin)='' )
      '' 
    #ELSE
        IF( le.Input_vin = (TYPEOF(le.Input_vin))'','',':vin')
    #END
+    #IF( #TEXT(Input_make)='' )
      '' 
    #ELSE
        IF( le.Input_make = (TYPEOF(le.Input_make))'','',':make')
    #END
+    #IF( #TEXT(Input_model)='' )
      '' 
    #ELSE
        IF( le.Input_model = (TYPEOF(le.Input_model))'','',':model')
    #END
+    #IF( #TEXT(Input_year)='' )
      '' 
    #ELSE
        IF( le.Input_year = (TYPEOF(le.Input_year))'','',':year')
    #END
+    #IF( #TEXT(Input_class_code)='' )
      '' 
    #ELSE
        IF( le.Input_class_code = (TYPEOF(le.Input_class_code))'','',':class_code')
    #END
+    #IF( #TEXT(Input_fuel_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_fuel_type_code = (TYPEOF(le.Input_fuel_type_code))'','',':fuel_type_code')
    #END
+    #IF( #TEXT(Input_mfg_code)='' )
      '' 
    #ELSE
        IF( le.Input_mfg_code = (TYPEOF(le.Input_mfg_code))'','',':mfg_code')
    #END
+    #IF( #TEXT(Input_style_code)='' )
      '' 
    #ELSE
        IF( le.Input_style_code = (TYPEOF(le.Input_style_code))'','',':style_code')
    #END
+    #IF( #TEXT(Input_mileagecd)='' )
      '' 
    #ELSE
        IF( le.Input_mileagecd = (TYPEOF(le.Input_mileagecd))'','',':mileagecd')
    #END
+    #IF( #TEXT(Input_nbr_vehicles)='' )
      '' 
    #ELSE
        IF( le.Input_nbr_vehicles = (TYPEOF(le.Input_nbr_vehicles))'','',':nbr_vehicles')
    #END
+    #IF( #TEXT(Input_idate)='' )
      '' 
    #ELSE
        IF( le.Input_idate = (TYPEOF(le.Input_idate))'','',':idate')
    #END
+    #IF( #TEXT(Input_odate)='' )
      '' 
    #ELSE
        IF( le.Input_odate = (TYPEOF(le.Input_odate))'','',':odate')
    #END
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
+    #IF( #TEXT(Input_mi)='' )
      '' 
    #ELSE
        IF( le.Input_mi = (TYPEOF(le.Input_mi))'','',':mi')
    #END
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
+    #IF( #TEXT(Input_house)='' )
      '' 
    #ELSE
        IF( le.Input_house = (TYPEOF(le.Input_house))'','',':house')
    #END
+    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
+    #IF( #TEXT(Input_street)='' )
      '' 
    #ELSE
        IF( le.Input_street = (TYPEOF(le.Input_street))'','',':street')
    #END
+    #IF( #TEXT(Input_strtype)='' )
      '' 
    #ELSE
        IF( le.Input_strtype = (TYPEOF(le.Input_strtype))'','',':strtype')
    #END
+    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
+    #IF( #TEXT(Input_apttype)='' )
      '' 
    #ELSE
        IF( le.Input_apttype = (TYPEOF(le.Input_apttype))'','',':apttype')
    #END
+    #IF( #TEXT(Input_aptnbr)='' )
      '' 
    #ELSE
        IF( le.Input_aptnbr = (TYPEOF(le.Input_aptnbr))'','',':aptnbr')
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
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
+    #IF( #TEXT(Input_z4)='' )
      '' 
    #ELSE
        IF( le.Input_z4 = (TYPEOF(le.Input_z4))'','',':z4')
    #END
+    #IF( #TEXT(Input_dpc)='' )
      '' 
    #ELSE
        IF( le.Input_dpc = (TYPEOF(le.Input_dpc))'','',':dpc')
    #END
+    #IF( #TEXT(Input_crte)='' )
      '' 
    #ELSE
        IF( le.Input_crte = (TYPEOF(le.Input_crte))'','',':crte')
    #END
+    #IF( #TEXT(Input_cnty)='' )
      '' 
    #ELSE
        IF( le.Input_cnty = (TYPEOF(le.Input_cnty))'','',':cnty')
    #END
+    #IF( #TEXT(Input_z4type)='' )
      '' 
    #ELSE
        IF( le.Input_z4type = (TYPEOF(le.Input_z4type))'','',':z4type')
    #END
+    #IF( #TEXT(Input_dpv)='' )
      '' 
    #ELSE
        IF( le.Input_dpv = (TYPEOF(le.Input_dpv))'','',':dpv')
    #END
+    #IF( #TEXT(Input_vacant)='' )
      '' 
    #ELSE
        IF( le.Input_vacant = (TYPEOF(le.Input_vacant))'','',':vacant')
    #END
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
+    #IF( #TEXT(Input_dnc)='' )
      '' 
    #ELSE
        IF( le.Input_dnc = (TYPEOF(le.Input_dnc))'','',':dnc')
    #END
+    #IF( #TEXT(Input_internal1)='' )
      '' 
    #ELSE
        IF( le.Input_internal1 = (TYPEOF(le.Input_internal1))'','',':internal1')
    #END
+    #IF( #TEXT(Input_internal2)='' )
      '' 
    #ELSE
        IF( le.Input_internal2 = (TYPEOF(le.Input_internal2))'','',':internal2')
    #END
+    #IF( #TEXT(Input_internal3)='' )
      '' 
    #ELSE
        IF( le.Input_internal3 = (TYPEOF(le.Input_internal3))'','',':internal3')
    #END
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
+    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
+    #IF( #TEXT(Input_cbsa)='' )
      '' 
    #ELSE
        IF( le.Input_cbsa = (TYPEOF(le.Input_cbsa))'','',':cbsa')
    #END
+    #IF( #TEXT(Input_ehi)='' )
      '' 
    #ELSE
        IF( le.Input_ehi = (TYPEOF(le.Input_ehi))'','',':ehi')
    #END
+    #IF( #TEXT(Input_child)='' )
      '' 
    #ELSE
        IF( le.Input_child = (TYPEOF(le.Input_child))'','',':child')
    #END
+    #IF( #TEXT(Input_homeowner)='' )
      '' 
    #ELSE
        IF( le.Input_homeowner = (TYPEOF(le.Input_homeowner))'','',':homeowner')
    #END
+    #IF( #TEXT(Input_pctw)='' )
      '' 
    #ELSE
        IF( le.Input_pctw = (TYPEOF(le.Input_pctw))'','',':pctw')
    #END
+    #IF( #TEXT(Input_pctb)='' )
      '' 
    #ELSE
        IF( le.Input_pctb = (TYPEOF(le.Input_pctb))'','',':pctb')
    #END
+    #IF( #TEXT(Input_pcta)='' )
      '' 
    #ELSE
        IF( le.Input_pcta = (TYPEOF(le.Input_pcta))'','',':pcta')
    #END
+    #IF( #TEXT(Input_pcth)='' )
      '' 
    #ELSE
        IF( le.Input_pcth = (TYPEOF(le.Input_pcth))'','',':pcth')
    #END
+    #IF( #TEXT(Input_pctspe)='' )
      '' 
    #ELSE
        IF( le.Input_pctspe = (TYPEOF(le.Input_pctspe))'','',':pctspe')
    #END
+    #IF( #TEXT(Input_pctsps)='' )
      '' 
    #ELSE
        IF( le.Input_pctsps = (TYPEOF(le.Input_pctsps))'','',':pctsps')
    #END
+    #IF( #TEXT(Input_pctspa)='' )
      '' 
    #ELSE
        IF( le.Input_pctspa = (TYPEOF(le.Input_pctspa))'','',':pctspa')
    #END
+    #IF( #TEXT(Input_mhv)='' )
      '' 
    #ELSE
        IF( le.Input_mhv = (TYPEOF(le.Input_mhv))'','',':mhv')
    #END
+    #IF( #TEXT(Input_mor)='' )
      '' 
    #ELSE
        IF( le.Input_mor = (TYPEOF(le.Input_mor))'','',':mor')
    #END
+    #IF( #TEXT(Input_pctoccw)='' )
      '' 
    #ELSE
        IF( le.Input_pctoccw = (TYPEOF(le.Input_pctoccw))'','',':pctoccw')
    #END
+    #IF( #TEXT(Input_pctoccb)='' )
      '' 
    #ELSE
        IF( le.Input_pctoccb = (TYPEOF(le.Input_pctoccb))'','',':pctoccb')
    #END
+    #IF( #TEXT(Input_pctocco)='' )
      '' 
    #ELSE
        IF( le.Input_pctocco = (TYPEOF(le.Input_pctocco))'','',':pctocco')
    #END
+    #IF( #TEXT(Input_lor)='' )
      '' 
    #ELSE
        IF( le.Input_lor = (TYPEOF(le.Input_lor))'','',':lor')
    #END
+    #IF( #TEXT(Input_sfdu)='' )
      '' 
    #ELSE
        IF( le.Input_sfdu = (TYPEOF(le.Input_sfdu))'','',':sfdu')
    #END
+    #IF( #TEXT(Input_mfdu)='' )
      '' 
    #ELSE
        IF( le.Input_mfdu = (TYPEOF(le.Input_mfdu))'','',':mfdu')
    #END
+    #IF( #TEXT(Input_processdate)='' )
      '' 
    #ELSE
        IF( le.Input_processdate = (TYPEOF(le.Input_processdate))'','',':processdate')
    #END
+    #IF( #TEXT(Input_source_code)='' )
      '' 
    #ELSE
        IF( le.Input_source_code = (TYPEOF(le.Input_source_code))'','',':source_code')
    #END
+    #IF( #TEXT(Input_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_state_origin = (TYPEOF(le.Input_state_origin))'','',':state_origin')
    #END
+    #IF( #TEXT(Input_append_ownernametypeind)='' )
      '' 
    #ELSE
        IF( le.Input_append_ownernametypeind = (TYPEOF(le.Input_append_ownernametypeind))'','',':append_ownernametypeind')
    #END
+    #IF( #TEXT(Input_fullname)='' )
      '' 
    #ELSE
        IF( le.Input_fullname = (TYPEOF(le.Input_fullname))'','',':fullname')
    #END
;
    #IF (#TEXT(state_origin)<>'')
    SELF.source := le.state_origin;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(state_origin)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(state_origin)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(state_origin)<>'' ) source, #END -cnt );
ENDMACRO;
