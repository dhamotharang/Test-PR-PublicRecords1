export MAC__Population_Statistics(infile,Ref='',Input_fname = '',Input_lname = '',Input_addr = '',Input_city = '',Input_state = '',Input_zip = '',Input_zip4 = '',Input_EMAIL = '',Input_phone = '',Input_LoanType = '',Input_BESTTIME = '',Input_MortRate = '',Input_PROPERTYTYPE = '',Input_RateType = '',Input_LTV = '',Input_YrsThere = '',Input_employer = '',Input_credit = '',Input_Income = '',Input_LoanAmt = '',Input_dt = '',Input_ip = '',OutFile) := MACRO
  #uniquename(of)
  %of% := record
    string512 fields;
  end;
  #uniquename(ot)
  %of% %ot%(infile le) := transform
    self.fields :=
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
    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (typeof(le.Input_state))'','',':state')
    #END
+
    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (typeof(le.Input_zip))'','',':zip')
    #END
+
    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (typeof(le.Input_zip4))'','',':zip4')
    #END
+
    #IF( #TEXT(Input_EMAIL)='' )
      '' 
    #ELSE
        IF( le.Input_EMAIL = (typeof(le.Input_EMAIL))'','',':EMAIL')
    #END
+
    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (typeof(le.Input_phone))'','',':phone')
    #END
+
    #IF( #TEXT(Input_LoanType)='' )
      '' 
    #ELSE
        IF( le.Input_LoanType = (typeof(le.Input_LoanType))'','',':LoanType')
    #END
+
    #IF( #TEXT(Input_BESTTIME)='' )
      '' 
    #ELSE
        IF( le.Input_BESTTIME = (typeof(le.Input_BESTTIME))'','',':BESTTIME')
    #END
+
    #IF( #TEXT(Input_MortRate)='' )
      '' 
    #ELSE
        IF( le.Input_MortRate = (typeof(le.Input_MortRate))'','',':MortRate')
    #END
+
    #IF( #TEXT(Input_PROPERTYTYPE)='' )
      '' 
    #ELSE
        IF( le.Input_PROPERTYTYPE = (typeof(le.Input_PROPERTYTYPE))'','',':PROPERTYTYPE')
    #END
+
    #IF( #TEXT(Input_RateType)='' )
      '' 
    #ELSE
        IF( le.Input_RateType = (typeof(le.Input_RateType))'','',':RateType')
    #END
+
    #IF( #TEXT(Input_LTV)='' )
      '' 
    #ELSE
        IF( le.Input_LTV = (typeof(le.Input_LTV))'','',':LTV')
    #END
+
    #IF( #TEXT(Input_YrsThere)='' )
      '' 
    #ELSE
        IF( le.Input_YrsThere = (typeof(le.Input_YrsThere))'','',':YrsThere')
    #END
+
    #IF( #TEXT(Input_employer)='' )
      '' 
    #ELSE
        IF( le.Input_employer = (typeof(le.Input_employer))'','',':employer')
    #END
+
    #IF( #TEXT(Input_credit)='' )
      '' 
    #ELSE
        IF( le.Input_credit = (typeof(le.Input_credit))'','',':credit')
    #END
+
    #IF( #TEXT(Input_Income)='' )
      '' 
    #ELSE
        IF( le.Input_Income = (typeof(le.Input_Income))'','',':Income')
    #END
+
    #IF( #TEXT(Input_LoanAmt)='' )
      '' 
    #ELSE
        IF( le.Input_LoanAmt = (typeof(le.Input_LoanAmt))'','',':LoanAmt')
    #END
+
    #IF( #TEXT(Input_dt)='' )
      '' 
    #ELSE
        IF( le.Input_dt = (typeof(le.Input_dt))'','',':dt')
    #END
+
    #IF( #TEXT(Input_ip)='' )
      '' 
    #ELSE
        IF( le.Input_ip = (typeof(le.Input_ip))'','',':ip')
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
