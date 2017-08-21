//Import:BDL2_Test.MAC__Population_Statistics

export MAC__Population_Statistics(infile,Ref='',Input_GROUP_ID = '',Input_COMPANY_NAME = '',OutFile) := MACRO
  #uniquename(of)
  %of% := record
    string512 fields;
  end;
  #uniquename(ot)
  %of% %ot%(infile le) := transform
    self.fields :=
    #IF( #TEXT(Input_GROUP_ID)='' )
      '' 
    #ELSE
        IF( le.Input_GROUP_ID = (typeof(le.Input_GROUP_ID))'','',':GROUP_ID')
    #END
+
    #IF( #TEXT(Input_COMPANY_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_COMPANY_NAME = (typeof(le.Input_COMPANY_NAME))'','',':COMPANY_NAME')
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