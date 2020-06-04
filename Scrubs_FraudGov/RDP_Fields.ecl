IMPORT SALT311;
EXPORT RDP_Fields := MODULE
 
EXPORT NumFields := 20;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alphanumeric','invalid_email','invalid_date','invalid_numeric','invalid_zip','invalid_state','invalid_ssn','invalid_phone','invalid_ip','invalid_name');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alphanumeric' => 2,'invalid_email' => 3,'invalid_date' => 4,'invalid_numeric' => 5,'invalid_zip' => 6,'invalid_state' => 7,'invalid_ssn' => 8,'invalid_phone' => 9,'invalid_ip' => 10,'invalid_name' => 11,0);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.NotLength('0,4..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 ./:- '); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ./:- ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 ./:- '))));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 ./:- '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-0123456789 <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 5));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('-0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT311.HygieneErrors.NotLength('0,5..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ssn(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_ssn(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT311.HygieneErrors.NotLength('0,9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT311.HygieneErrors.NotLength('0,10..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'.0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_ip(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'.0123456789 <>{}[]-^=\'`!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_ip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('.0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'Transaction_ID','TransactionDate','FirstName','LastName','MiddleName','Suffix','BirthDate','SSN','Lexid_Input','Street1','Street2','Suite','City','State','Zip5','Phone','Lexid_Discovered','RemoteIPAddress','ConsumerIPAddress','Email_Address');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'Transaction_ID','TransactionDate','FirstName','LastName','MiddleName','Suffix','BirthDate','SSN','Lexid_Input','Street1','Street2','Suite','City','State','Zip5','Phone','Lexid_Discovered','RemoteIPAddress','ConsumerIPAddress','Email_Address');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'Transaction_ID' => 0,'TransactionDate' => 1,'FirstName' => 2,'LastName' => 3,'MiddleName' => 4,'Suffix' => 5,'BirthDate' => 6,'SSN' => 7,'Lexid_Input' => 8,'Street1' => 9,'Street2' => 10,'Suite' => 11,'City' => 12,'State' => 13,'Zip5' => 14,'Phone' => 15,'Lexid_Discovered' => 16,'RemoteIPAddress' => 17,'ConsumerIPAddress' => 18,'Email_Address' => 19,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['LEFTTRIM','ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_Transaction_ID(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_Transaction_ID(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_Transaction_ID(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_TransactionDate(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_TransactionDate(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_TransactionDate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_FirstName(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_FirstName(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_FirstName(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_LastName(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_LastName(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_LastName(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_MiddleName(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_MiddleName(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_MiddleName(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_Suffix(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_Suffix(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_Suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_BirthDate(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_BirthDate(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_BirthDate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_SSN(SALT311.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_SSN(SALT311.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_SSN(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);
 
EXPORT Make_Lexid_Input(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_Lexid_Input(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_Lexid_Input(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_Street1(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_Street1(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_Street1(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_Street2(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_Street2(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_Street2(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_Suite(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_Suite(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_Suite(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_City(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_City(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_City(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_State(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_State(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_State(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_Zip5(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_Zip5(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_Zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_Phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_Phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_Phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_Lexid_Discovered(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_Lexid_Discovered(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_Lexid_Discovered(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_RemoteIPAddress(SALT311.StrType s0) := MakeFT_invalid_ip(s0);
EXPORT InValid_RemoteIPAddress(SALT311.StrType s) := InValidFT_invalid_ip(s);
EXPORT InValidMessage_RemoteIPAddress(UNSIGNED1 wh) := InValidMessageFT_invalid_ip(wh);
 
EXPORT Make_ConsumerIPAddress(SALT311.StrType s0) := MakeFT_invalid_ip(s0);
EXPORT InValid_ConsumerIPAddress(SALT311.StrType s) := InValidFT_invalid_ip(s);
EXPORT InValidMessage_ConsumerIPAddress(UNSIGNED1 wh) := InValidMessageFT_invalid_ip(wh);
 
EXPORT Make_Email_Address(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_Email_Address(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_Email_Address(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_FraudGov;
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
    BOOLEAN Diff_Transaction_ID;
    BOOLEAN Diff_TransactionDate;
    BOOLEAN Diff_FirstName;
    BOOLEAN Diff_LastName;
    BOOLEAN Diff_MiddleName;
    BOOLEAN Diff_Suffix;
    BOOLEAN Diff_BirthDate;
    BOOLEAN Diff_SSN;
    BOOLEAN Diff_Lexid_Input;
    BOOLEAN Diff_Street1;
    BOOLEAN Diff_Street2;
    BOOLEAN Diff_Suite;
    BOOLEAN Diff_City;
    BOOLEAN Diff_State;
    BOOLEAN Diff_Zip5;
    BOOLEAN Diff_Phone;
    BOOLEAN Diff_Lexid_Discovered;
    BOOLEAN Diff_RemoteIPAddress;
    BOOLEAN Diff_ConsumerIPAddress;
    BOOLEAN Diff_Email_Address;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_Transaction_ID := le.Transaction_ID <> ri.Transaction_ID;
    SELF.Diff_TransactionDate := le.TransactionDate <> ri.TransactionDate;
    SELF.Diff_FirstName := le.FirstName <> ri.FirstName;
    SELF.Diff_LastName := le.LastName <> ri.LastName;
    SELF.Diff_MiddleName := le.MiddleName <> ri.MiddleName;
    SELF.Diff_Suffix := le.Suffix <> ri.Suffix;
    SELF.Diff_BirthDate := le.BirthDate <> ri.BirthDate;
    SELF.Diff_SSN := le.SSN <> ri.SSN;
    SELF.Diff_Lexid_Input := le.Lexid_Input <> ri.Lexid_Input;
    SELF.Diff_Street1 := le.Street1 <> ri.Street1;
    SELF.Diff_Street2 := le.Street2 <> ri.Street2;
    SELF.Diff_Suite := le.Suite <> ri.Suite;
    SELF.Diff_City := le.City <> ri.City;
    SELF.Diff_State := le.State <> ri.State;
    SELF.Diff_Zip5 := le.Zip5 <> ri.Zip5;
    SELF.Diff_Phone := le.Phone <> ri.Phone;
    SELF.Diff_Lexid_Discovered := le.Lexid_Discovered <> ri.Lexid_Discovered;
    SELF.Diff_RemoteIPAddress := le.RemoteIPAddress <> ri.RemoteIPAddress;
    SELF.Diff_ConsumerIPAddress := le.ConsumerIPAddress <> ri.ConsumerIPAddress;
    SELF.Diff_Email_Address := le.Email_Address <> ri.Email_Address;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_Transaction_ID,1,0)+ IF( SELF.Diff_TransactionDate,1,0)+ IF( SELF.Diff_FirstName,1,0)+ IF( SELF.Diff_LastName,1,0)+ IF( SELF.Diff_MiddleName,1,0)+ IF( SELF.Diff_Suffix,1,0)+ IF( SELF.Diff_BirthDate,1,0)+ IF( SELF.Diff_SSN,1,0)+ IF( SELF.Diff_Lexid_Input,1,0)+ IF( SELF.Diff_Street1,1,0)+ IF( SELF.Diff_Street2,1,0)+ IF( SELF.Diff_Suite,1,0)+ IF( SELF.Diff_City,1,0)+ IF( SELF.Diff_State,1,0)+ IF( SELF.Diff_Zip5,1,0)+ IF( SELF.Diff_Phone,1,0)+ IF( SELF.Diff_Lexid_Discovered,1,0)+ IF( SELF.Diff_RemoteIPAddress,1,0)+ IF( SELF.Diff_ConsumerIPAddress,1,0)+ IF( SELF.Diff_Email_Address,1,0);
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
    Count_Diff_Transaction_ID := COUNT(GROUP,%Closest%.Diff_Transaction_ID);
    Count_Diff_TransactionDate := COUNT(GROUP,%Closest%.Diff_TransactionDate);
    Count_Diff_FirstName := COUNT(GROUP,%Closest%.Diff_FirstName);
    Count_Diff_LastName := COUNT(GROUP,%Closest%.Diff_LastName);
    Count_Diff_MiddleName := COUNT(GROUP,%Closest%.Diff_MiddleName);
    Count_Diff_Suffix := COUNT(GROUP,%Closest%.Diff_Suffix);
    Count_Diff_BirthDate := COUNT(GROUP,%Closest%.Diff_BirthDate);
    Count_Diff_SSN := COUNT(GROUP,%Closest%.Diff_SSN);
    Count_Diff_Lexid_Input := COUNT(GROUP,%Closest%.Diff_Lexid_Input);
    Count_Diff_Street1 := COUNT(GROUP,%Closest%.Diff_Street1);
    Count_Diff_Street2 := COUNT(GROUP,%Closest%.Diff_Street2);
    Count_Diff_Suite := COUNT(GROUP,%Closest%.Diff_Suite);
    Count_Diff_City := COUNT(GROUP,%Closest%.Diff_City);
    Count_Diff_State := COUNT(GROUP,%Closest%.Diff_State);
    Count_Diff_Zip5 := COUNT(GROUP,%Closest%.Diff_Zip5);
    Count_Diff_Phone := COUNT(GROUP,%Closest%.Diff_Phone);
    Count_Diff_Lexid_Discovered := COUNT(GROUP,%Closest%.Diff_Lexid_Discovered);
    Count_Diff_RemoteIPAddress := COUNT(GROUP,%Closest%.Diff_RemoteIPAddress);
    Count_Diff_ConsumerIPAddress := COUNT(GROUP,%Closest%.Diff_ConsumerIPAddress);
    Count_Diff_Email_Address := COUNT(GROUP,%Closest%.Diff_Email_Address);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
