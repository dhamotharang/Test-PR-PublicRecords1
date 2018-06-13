IMPORT SALT39;
EXPORT NAC_Fields := MODULE
 
EXPORT NumFields := 17;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alphanumeric','invalid_date','invalid_numeric');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alphanumeric' => 2,'invalid_date' => 3,'invalid_numeric' => 4,0);
 
EXPORT MakeFT_invalid_alpha(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT39.HygieneErrors.NotLength('0,4..'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'!+&,./#()_'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 -:'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' -:',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_date(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 -:'))));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 -:'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'Customer_Account_Number','Customer_County','Customer_State','Customer_Agency_Vertical_Type','Customer_Program','LexID','raw_Full_Name','raw_First_name','raw_Last_Name','SSN','Drivers_License_State','Drivers_License_Number','Street_1','City','State','Zip','did');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'Customer_Account_Number','Customer_County','Customer_State','Customer_Agency_Vertical_Type','Customer_Program','LexID','raw_Full_Name','raw_First_name','raw_Last_Name','SSN','Drivers_License_State','Drivers_License_Number','Street_1','City','State','Zip','did');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'Customer_Account_Number' => 0,'Customer_County' => 1,'Customer_State' => 2,'Customer_Agency_Vertical_Type' => 3,'Customer_Program' => 4,'LexID' => 5,'raw_Full_Name' => 6,'raw_First_name' => 7,'raw_Last_Name' => 8,'SSN' => 9,'Drivers_License_State' => 10,'Drivers_License_Number' => 11,'Street_1' => 12,'City' => 13,'State' => 14,'Zip' => 15,'did' => 16,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_Customer_Account_Number(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_Customer_Account_Number(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_Customer_Account_Number(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_Customer_County(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_Customer_County(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_Customer_County(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_Customer_State(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_Customer_State(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_Customer_State(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_Customer_Agency_Vertical_Type(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_Customer_Agency_Vertical_Type(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_Customer_Agency_Vertical_Type(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_Customer_Program(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_Customer_Program(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_Customer_Program(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_LexID(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_LexID(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_LexID(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_raw_Full_Name(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_raw_Full_Name(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_raw_Full_Name(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_raw_First_name(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_raw_First_name(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_raw_First_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_raw_Last_Name(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_raw_Last_Name(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_raw_Last_Name(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_SSN(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_SSN(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_SSN(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_Drivers_License_State(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_Drivers_License_State(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_Drivers_License_State(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_Drivers_License_Number(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_Drivers_License_Number(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_Drivers_License_Number(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_Street_1(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_Street_1(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_Street_1(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_City(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_City(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_City(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_State(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_State(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_State(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_Zip(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_Zip(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_Zip(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_did(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_did(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_FraudGov;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_Customer_Account_Number;
    BOOLEAN Diff_Customer_County;
    BOOLEAN Diff_Customer_State;
    BOOLEAN Diff_Customer_Agency_Vertical_Type;
    BOOLEAN Diff_Customer_Program;
    BOOLEAN Diff_LexID;
    BOOLEAN Diff_raw_Full_Name;
    BOOLEAN Diff_raw_First_name;
    BOOLEAN Diff_raw_Last_Name;
    BOOLEAN Diff_SSN;
    BOOLEAN Diff_Drivers_License_State;
    BOOLEAN Diff_Drivers_License_Number;
    BOOLEAN Diff_Street_1;
    BOOLEAN Diff_City;
    BOOLEAN Diff_State;
    BOOLEAN Diff_Zip;
    BOOLEAN Diff_did;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_Customer_Account_Number := le.Customer_Account_Number <> ri.Customer_Account_Number;
    SELF.Diff_Customer_County := le.Customer_County <> ri.Customer_County;
    SELF.Diff_Customer_State := le.Customer_State <> ri.Customer_State;
    SELF.Diff_Customer_Agency_Vertical_Type := le.Customer_Agency_Vertical_Type <> ri.Customer_Agency_Vertical_Type;
    SELF.Diff_Customer_Program := le.Customer_Program <> ri.Customer_Program;
    SELF.Diff_LexID := le.LexID <> ri.LexID;
    SELF.Diff_raw_Full_Name := le.raw_Full_Name <> ri.raw_Full_Name;
    SELF.Diff_raw_First_name := le.raw_First_name <> ri.raw_First_name;
    SELF.Diff_raw_Last_Name := le.raw_Last_Name <> ri.raw_Last_Name;
    SELF.Diff_SSN := le.SSN <> ri.SSN;
    SELF.Diff_Drivers_License_State := le.Drivers_License_State <> ri.Drivers_License_State;
    SELF.Diff_Drivers_License_Number := le.Drivers_License_Number <> ri.Drivers_License_Number;
    SELF.Diff_Street_1 := le.Street_1 <> ri.Street_1;
    SELF.Diff_City := le.City <> ri.City;
    SELF.Diff_State := le.State <> ri.State;
    SELF.Diff_Zip := le.Zip <> ri.Zip;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_Customer_Account_Number,1,0)+ IF( SELF.Diff_Customer_County,1,0)+ IF( SELF.Diff_Customer_State,1,0)+ IF( SELF.Diff_Customer_Agency_Vertical_Type,1,0)+ IF( SELF.Diff_Customer_Program,1,0)+ IF( SELF.Diff_LexID,1,0)+ IF( SELF.Diff_raw_Full_Name,1,0)+ IF( SELF.Diff_raw_First_name,1,0)+ IF( SELF.Diff_raw_Last_Name,1,0)+ IF( SELF.Diff_SSN,1,0)+ IF( SELF.Diff_Drivers_License_State,1,0)+ IF( SELF.Diff_Drivers_License_Number,1,0)+ IF( SELF.Diff_Street_1,1,0)+ IF( SELF.Diff_City,1,0)+ IF( SELF.Diff_State,1,0)+ IF( SELF.Diff_Zip,1,0)+ IF( SELF.Diff_did,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_Customer_Account_Number := COUNT(GROUP,%Closest%.Diff_Customer_Account_Number);
    Count_Diff_Customer_County := COUNT(GROUP,%Closest%.Diff_Customer_County);
    Count_Diff_Customer_State := COUNT(GROUP,%Closest%.Diff_Customer_State);
    Count_Diff_Customer_Agency_Vertical_Type := COUNT(GROUP,%Closest%.Diff_Customer_Agency_Vertical_Type);
    Count_Diff_Customer_Program := COUNT(GROUP,%Closest%.Diff_Customer_Program);
    Count_Diff_LexID := COUNT(GROUP,%Closest%.Diff_LexID);
    Count_Diff_raw_Full_Name := COUNT(GROUP,%Closest%.Diff_raw_Full_Name);
    Count_Diff_raw_First_name := COUNT(GROUP,%Closest%.Diff_raw_First_name);
    Count_Diff_raw_Last_Name := COUNT(GROUP,%Closest%.Diff_raw_Last_Name);
    Count_Diff_SSN := COUNT(GROUP,%Closest%.Diff_SSN);
    Count_Diff_Drivers_License_State := COUNT(GROUP,%Closest%.Diff_Drivers_License_State);
    Count_Diff_Drivers_License_Number := COUNT(GROUP,%Closest%.Diff_Drivers_License_Number);
    Count_Diff_Street_1 := COUNT(GROUP,%Closest%.Diff_Street_1);
    Count_Diff_City := COUNT(GROUP,%Closest%.Diff_City);
    Count_Diff_State := COUNT(GROUP,%Closest%.Diff_State);
    Count_Diff_Zip := COUNT(GROUP,%Closest%.Diff_Zip);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
