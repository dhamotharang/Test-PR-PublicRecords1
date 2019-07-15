 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_datetime = '',Input_customer_id = '',Input_search_function_name = '',Input_entity_type = '',Input_field1 = '',Input_field2 = '',Input_field3 = '',Input_field4 = '',Input_field5 = '',Input_field6 = '',Input_field7 = '',Input_field8 = '',Input_field9 = '',Input_field10 = '',Input_field11 = '',Input_field12 = '',Input_field13 = '',Input_field14 = '',Input_field15 = '',Input_field16 = '',Input_id_ = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_Inql_Nfcra_Bridger;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_datetime)='' )
      '' 
    #ELSE
        IF( le.Input_datetime = (TYPEOF(le.Input_datetime))'','',':datetime')
    #END
 
+    #IF( #TEXT(Input_customer_id)='' )
      '' 
    #ELSE
        IF( le.Input_customer_id = (TYPEOF(le.Input_customer_id))'','',':customer_id')
    #END
 
+    #IF( #TEXT(Input_search_function_name)='' )
      '' 
    #ELSE
        IF( le.Input_search_function_name = (TYPEOF(le.Input_search_function_name))'','',':search_function_name')
    #END
 
+    #IF( #TEXT(Input_entity_type)='' )
      '' 
    #ELSE
        IF( le.Input_entity_type = (TYPEOF(le.Input_entity_type))'','',':entity_type')
    #END
 
+    #IF( #TEXT(Input_field1)='' )
      '' 
    #ELSE
        IF( le.Input_field1 = (TYPEOF(le.Input_field1))'','',':field1')
    #END
 
+    #IF( #TEXT(Input_field2)='' )
      '' 
    #ELSE
        IF( le.Input_field2 = (TYPEOF(le.Input_field2))'','',':field2')
    #END
 
+    #IF( #TEXT(Input_field3)='' )
      '' 
    #ELSE
        IF( le.Input_field3 = (TYPEOF(le.Input_field3))'','',':field3')
    #END
 
+    #IF( #TEXT(Input_field4)='' )
      '' 
    #ELSE
        IF( le.Input_field4 = (TYPEOF(le.Input_field4))'','',':field4')
    #END
 
+    #IF( #TEXT(Input_field5)='' )
      '' 
    #ELSE
        IF( le.Input_field5 = (TYPEOF(le.Input_field5))'','',':field5')
    #END
 
+    #IF( #TEXT(Input_field6)='' )
      '' 
    #ELSE
        IF( le.Input_field6 = (TYPEOF(le.Input_field6))'','',':field6')
    #END
 
+    #IF( #TEXT(Input_field7)='' )
      '' 
    #ELSE
        IF( le.Input_field7 = (TYPEOF(le.Input_field7))'','',':field7')
    #END
 
+    #IF( #TEXT(Input_field8)='' )
      '' 
    #ELSE
        IF( le.Input_field8 = (TYPEOF(le.Input_field8))'','',':field8')
    #END
 
+    #IF( #TEXT(Input_field9)='' )
      '' 
    #ELSE
        IF( le.Input_field9 = (TYPEOF(le.Input_field9))'','',':field9')
    #END
 
+    #IF( #TEXT(Input_field10)='' )
      '' 
    #ELSE
        IF( le.Input_field10 = (TYPEOF(le.Input_field10))'','',':field10')
    #END
 
+    #IF( #TEXT(Input_field11)='' )
      '' 
    #ELSE
        IF( le.Input_field11 = (TYPEOF(le.Input_field11))'','',':field11')
    #END
 
+    #IF( #TEXT(Input_field12)='' )
      '' 
    #ELSE
        IF( le.Input_field12 = (TYPEOF(le.Input_field12))'','',':field12')
    #END
 
+    #IF( #TEXT(Input_field13)='' )
      '' 
    #ELSE
        IF( le.Input_field13 = (TYPEOF(le.Input_field13))'','',':field13')
    #END
 
+    #IF( #TEXT(Input_field14)='' )
      '' 
    #ELSE
        IF( le.Input_field14 = (TYPEOF(le.Input_field14))'','',':field14')
    #END
 
+    #IF( #TEXT(Input_field15)='' )
      '' 
    #ELSE
        IF( le.Input_field15 = (TYPEOF(le.Input_field15))'','',':field15')
    #END
 
+    #IF( #TEXT(Input_field16)='' )
      '' 
    #ELSE
        IF( le.Input_field16 = (TYPEOF(le.Input_field16))'','',':field16')
    #END
 
+    #IF( #TEXT(Input_id_)='' )
      '' 
    #ELSE
        IF( le.Input_id_ = (TYPEOF(le.Input_id_))'','',':id_')
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
