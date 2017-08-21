EXPORT MAC_PopulationStatistics(infile,Ref='',source_code='',Input_categorycode = '',Input_vin = '',Input_modelyr = '',Input_titlenum = '',Input_ownercode = '',Input_grossweight = '',Input_ownername = '',Input_ownerstreetaddress = '',Input_ownercity = '',Input_ownerstate = '',Input_ownerzip = '',Input_countynumber = '',Input_vehiclepurchasedt = '',Input_vehicletaxweight = '',Input_vehicletaxcode = '',Input_vehicleunladdenweight = '',Input_additionalownername = '',Input_registrationissuedt = '',Input_vehiclemake = '',Input_vehicletype = '',Input_vehicleexpdt = '',Input_previousplatenum = '',Input_platenum = '',Input_processdate = '',Input_source_code = '',Input_state_origin = '',Input_append_ownernametypeind = '',Input_append_addlownernametypeind = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_VehicleV2_OH_Direct;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source_code)<>'')
    SALT30.StrType source;
    #END
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_categorycode)='' )
      '' 
    #ELSE
        IF( le.Input_categorycode = (TYPEOF(le.Input_categorycode))'','',':categorycode')
    #END
+    #IF( #TEXT(Input_vin)='' )
      '' 
    #ELSE
        IF( le.Input_vin = (TYPEOF(le.Input_vin))'','',':vin')
    #END
+    #IF( #TEXT(Input_modelyr)='' )
      '' 
    #ELSE
        IF( le.Input_modelyr = (TYPEOF(le.Input_modelyr))'','',':modelyr')
    #END
+    #IF( #TEXT(Input_titlenum)='' )
      '' 
    #ELSE
        IF( le.Input_titlenum = (TYPEOF(le.Input_titlenum))'','',':titlenum')
    #END
+    #IF( #TEXT(Input_ownercode)='' )
      '' 
    #ELSE
        IF( le.Input_ownercode = (TYPEOF(le.Input_ownercode))'','',':ownercode')
    #END
+    #IF( #TEXT(Input_grossweight)='' )
      '' 
    #ELSE
        IF( le.Input_grossweight = (TYPEOF(le.Input_grossweight))'','',':grossweight')
    #END
+    #IF( #TEXT(Input_ownername)='' )
      '' 
    #ELSE
        IF( le.Input_ownername = (TYPEOF(le.Input_ownername))'','',':ownername')
    #END
+    #IF( #TEXT(Input_ownerstreetaddress)='' )
      '' 
    #ELSE
        IF( le.Input_ownerstreetaddress = (TYPEOF(le.Input_ownerstreetaddress))'','',':ownerstreetaddress')
    #END
+    #IF( #TEXT(Input_ownercity)='' )
      '' 
    #ELSE
        IF( le.Input_ownercity = (TYPEOF(le.Input_ownercity))'','',':ownercity')
    #END
+    #IF( #TEXT(Input_ownerstate)='' )
      '' 
    #ELSE
        IF( le.Input_ownerstate = (TYPEOF(le.Input_ownerstate))'','',':ownerstate')
    #END
+    #IF( #TEXT(Input_ownerzip)='' )
      '' 
    #ELSE
        IF( le.Input_ownerzip = (TYPEOF(le.Input_ownerzip))'','',':ownerzip')
    #END
+    #IF( #TEXT(Input_countynumber)='' )
      '' 
    #ELSE
        IF( le.Input_countynumber = (TYPEOF(le.Input_countynumber))'','',':countynumber')
    #END
+    #IF( #TEXT(Input_vehiclepurchasedt)='' )
      '' 
    #ELSE
        IF( le.Input_vehiclepurchasedt = (TYPEOF(le.Input_vehiclepurchasedt))'','',':vehiclepurchasedt')
    #END
+    #IF( #TEXT(Input_vehicletaxweight)='' )
      '' 
    #ELSE
        IF( le.Input_vehicletaxweight = (TYPEOF(le.Input_vehicletaxweight))'','',':vehicletaxweight')
    #END
+    #IF( #TEXT(Input_vehicletaxcode)='' )
      '' 
    #ELSE
        IF( le.Input_vehicletaxcode = (TYPEOF(le.Input_vehicletaxcode))'','',':vehicletaxcode')
    #END
+    #IF( #TEXT(Input_vehicleunladdenweight)='' )
      '' 
    #ELSE
        IF( le.Input_vehicleunladdenweight = (TYPEOF(le.Input_vehicleunladdenweight))'','',':vehicleunladdenweight')
    #END
+    #IF( #TEXT(Input_additionalownername)='' )
      '' 
    #ELSE
        IF( le.Input_additionalownername = (TYPEOF(le.Input_additionalownername))'','',':additionalownername')
    #END
+    #IF( #TEXT(Input_registrationissuedt)='' )
      '' 
    #ELSE
        IF( le.Input_registrationissuedt = (TYPEOF(le.Input_registrationissuedt))'','',':registrationissuedt')
    #END
+    #IF( #TEXT(Input_vehiclemake)='' )
      '' 
    #ELSE
        IF( le.Input_vehiclemake = (TYPEOF(le.Input_vehiclemake))'','',':vehiclemake')
    #END
+    #IF( #TEXT(Input_vehicletype)='' )
      '' 
    #ELSE
        IF( le.Input_vehicletype = (TYPEOF(le.Input_vehicletype))'','',':vehicletype')
    #END
+    #IF( #TEXT(Input_vehicleexpdt)='' )
      '' 
    #ELSE
        IF( le.Input_vehicleexpdt = (TYPEOF(le.Input_vehicleexpdt))'','',':vehicleexpdt')
    #END
+    #IF( #TEXT(Input_previousplatenum)='' )
      '' 
    #ELSE
        IF( le.Input_previousplatenum = (TYPEOF(le.Input_previousplatenum))'','',':previousplatenum')
    #END
+    #IF( #TEXT(Input_platenum)='' )
      '' 
    #ELSE
        IF( le.Input_platenum = (TYPEOF(le.Input_platenum))'','',':platenum')
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
+    #IF( #TEXT(Input_append_addlownernametypeind)='' )
      '' 
    #ELSE
        IF( le.Input_append_addlownernametypeind = (TYPEOF(le.Input_append_addlownernametypeind))'','',':append_addlownernametypeind')
    #END
;
    #IF (#TEXT(source_code)<>'')
    SELF.source := le.source_code;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(source_code)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(source_code)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(source_code)<>'' ) source, #END -cnt );
ENDMACRO;
