export MAC__Population_Statistics(infile,Ref='',Input_id = '',Input_fname = '',Input_lname = '',Input_dob = '',Input_Own_Home = '',Input_dlnum = '',Input_State_Of_License = '',Input_addr = '',Input_city = '',Input_st = '',Input_zip = '',Input_Phone_Home = '',Input_Phone_Cell = '',Input_Phone_Work = '',Input_EMAIL = '',Input_ip = '',Input_dt = '',Input_INCOME_MONTHLY = '',Input_Weekly_BiWeekly = '',Input_MONTHSEMPLOYED = '',Input_MonthsAtBank = '',Input_employer = '',Input_Bank = '',OutFile) := MACRO
  #uniquename(of)
  %of% := record
    string512 fields;
  end;
  #uniquename(ot)
  %of% %ot%(infile le) := transform
    self.fields :=
    #IF( #TEXT(Input_id)='' )
      '' 
    #ELSE
        IF( le.Input_id = (typeof(le.Input_id))'','',':id')
    #END
+
    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (typeof(le.Input_fname))'','',':fname')
    #END
+
    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (typeof(le.Input_lname))'','',':lname')
    #END
+
    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (typeof(le.Input_dob))'','',':dob')
    #END
+
    #IF( #TEXT(Input_Own_Home)='' )
      '' 
    #ELSE
        IF( le.Input_Own_Home = (typeof(le.Input_Own_Home))'','',':Own_Home')
    #END
+
    #IF( #TEXT(Input_dlnum)='' )
      '' 
    #ELSE
        IF( le.Input_dlnum = (typeof(le.Input_dlnum))'','',':dlnum')
    #END
+
    #IF( #TEXT(Input_State_Of_License)='' )
      '' 
    #ELSE
        IF( le.Input_State_Of_License = (typeof(le.Input_State_Of_License))'','',':State_Of_License')
    #END
+
    #IF( #TEXT(Input_addr)='' )
      '' 
    #ELSE
        IF( le.Input_addr = (typeof(le.Input_addr))'','',':addr')
    #END
+
    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (typeof(le.Input_city))'','',':city')
    #END
+
    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (typeof(le.Input_st))'','',':st')
    #END
+
    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (typeof(le.Input_zip))'','',':zip')
    #END
+
    #IF( #TEXT(Input_Phone_Home)='' )
      '' 
    #ELSE
        IF( le.Input_Phone_Home = (typeof(le.Input_Phone_Home))'','',':Phone_Home')
    #END
+
    #IF( #TEXT(Input_Phone_Cell)='' )
      '' 
    #ELSE
        IF( le.Input_Phone_Cell = (typeof(le.Input_Phone_Cell))'','',':Phone_Cell')
    #END
+
    #IF( #TEXT(Input_Phone_Work)='' )
      '' 
    #ELSE
        IF( le.Input_Phone_Work = (typeof(le.Input_Phone_Work))'','',':Phone_Work')
    #END
+
    #IF( #TEXT(Input_EMAIL)='' )
      '' 
    #ELSE
        IF( le.Input_EMAIL = (typeof(le.Input_EMAIL))'','',':EMAIL')
    #END
+
    #IF( #TEXT(Input_ip)='' )
      '' 
    #ELSE
        IF( le.Input_ip = (typeof(le.Input_ip))'','',':ip')
    #END
+
    #IF( #TEXT(Input_dt)='' )
      '' 
    #ELSE
        IF( le.Input_dt = (typeof(le.Input_dt))'','',':dt')
    #END
+
    #IF( #TEXT(Input_INCOME_MONTHLY)='' )
      '' 
    #ELSE
        IF( le.Input_INCOME_MONTHLY = (typeof(le.Input_INCOME_MONTHLY))'','',':INCOME_MONTHLY')
    #END
+
    #IF( #TEXT(Input_Weekly_BiWeekly)='' )
      '' 
    #ELSE
        IF( le.Input_Weekly_BiWeekly = (typeof(le.Input_Weekly_BiWeekly))'','',':Weekly_BiWeekly')
    #END
+
    #IF( #TEXT(Input_MONTHSEMPLOYED)='' )
      '' 
    #ELSE
        IF( le.Input_MONTHSEMPLOYED = (typeof(le.Input_MONTHSEMPLOYED))'','',':MONTHSEMPLOYED')
    #END
+
    #IF( #TEXT(Input_MonthsAtBank)='' )
      '' 
    #ELSE
        IF( le.Input_MonthsAtBank = (typeof(le.Input_MonthsAtBank))'','',':MonthsAtBank')
    #END
+
    #IF( #TEXT(Input_employer)='' )
      '' 
    #ELSE
        IF( le.Input_employer = (typeof(le.Input_employer))'','',':employer')
    #END
+
    #IF( #TEXT(Input_Bank)='' )
      '' 
    #ELSE
        IF( le.Input_Bank = (typeof(le.Input_Bank))'','',':Bank')
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
