IMPORT SALT39;
EXPORT NAC_Fields := MODULE
 
EXPORT NumFields := 18;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alphanumeric','invalid_email','invalid_date','invalid_numeric','invalid_zip','invalid_state','invalid_ssn','invalid_phone','invalid_ip','invalid_name');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alphanumeric' => 2,'invalid_email' => 3,'invalid_date' => 4,'invalid_numeric' => 5,'invalid_zip' => 6,'invalid_state' => 7,'invalid_ssn' => 8,'invalid_phone' => 9,'invalid_ip' => 10,'invalid_name' => 11,0);
 
EXPORT MakeFT_invalid_alpha(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT39.HygieneErrors.NotLength('0,4..'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_date(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.NotLength('0,8'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'-0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_zip(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'-0123456789 <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 5));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('-0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.NotLength('0,5..'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_state(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.NotLength('0,2'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ssn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_ssn(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.NotLength('0,9'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_phone(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 <>{}[]-^=\'`!+&,./#()_'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.NotLength('0,10..'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ip(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'.0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_ip(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'.0123456789 <>{}[]-^=\'`!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_ip(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('.0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_name(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz <>{}[]-^=\'`!+&,./#()_'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'SearchAddress1StreetAddress1','SearchAddress1StreetAddress2','SearchAddress1City','SearchAddress1State','SearchAddress1Zip','SearchAddress2StreetAddress1','SearchAddress2StreetAddress2','SearchAddress2City','SearchAddress2State','SearchAddress2Zip','SearchCaseId','enduserip','CaseID','ClientFirstName','ClientMiddleName','ClientLastName','ClientPhone','ClientEmail');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'SearchAddress1StreetAddress1','SearchAddress1StreetAddress2','SearchAddress1City','SearchAddress1State','SearchAddress1Zip','SearchAddress2StreetAddress1','SearchAddress2StreetAddress2','SearchAddress2City','SearchAddress2State','SearchAddress2Zip','SearchCaseId','enduserip','CaseID','ClientFirstName','ClientMiddleName','ClientLastName','ClientPhone','ClientEmail');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'SearchAddress1StreetAddress1' => 0,'SearchAddress1StreetAddress2' => 1,'SearchAddress1City' => 2,'SearchAddress1State' => 3,'SearchAddress1Zip' => 4,'SearchAddress2StreetAddress1' => 5,'SearchAddress2StreetAddress2' => 6,'SearchAddress2City' => 7,'SearchAddress2State' => 8,'SearchAddress2Zip' => 9,'SearchCaseId' => 10,'enduserip' => 11,'CaseID' => 12,'ClientFirstName' => 13,'ClientMiddleName' => 14,'ClientLastName' => 15,'ClientPhone' => 16,'ClientEmail' => 17,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW'],['LEFTTRIM','ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW'],['LEFTTRIM','ALLOW','LENGTHS'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_SearchAddress1StreetAddress1(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_SearchAddress1StreetAddress1(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_SearchAddress1StreetAddress1(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_SearchAddress1StreetAddress2(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_SearchAddress1StreetAddress2(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_SearchAddress1StreetAddress2(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_SearchAddress1City(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_SearchAddress1City(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_SearchAddress1City(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_SearchAddress1State(SALT39.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_SearchAddress1State(SALT39.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_SearchAddress1State(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_SearchAddress1Zip(SALT39.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_SearchAddress1Zip(SALT39.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_SearchAddress1Zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_SearchAddress2StreetAddress1(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_SearchAddress2StreetAddress1(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_SearchAddress2StreetAddress1(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_SearchAddress2StreetAddress2(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_SearchAddress2StreetAddress2(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_SearchAddress2StreetAddress2(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_SearchAddress2City(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_SearchAddress2City(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_SearchAddress2City(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_SearchAddress2State(SALT39.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_SearchAddress2State(SALT39.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_SearchAddress2State(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_SearchAddress2Zip(SALT39.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_SearchAddress2Zip(SALT39.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_SearchAddress2Zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_SearchCaseId(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_SearchCaseId(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_SearchCaseId(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_enduserip(SALT39.StrType s0) := MakeFT_invalid_ip(s0);
EXPORT InValid_enduserip(SALT39.StrType s) := InValidFT_invalid_ip(s);
EXPORT InValidMessage_enduserip(UNSIGNED1 wh) := InValidMessageFT_invalid_ip(wh);
 
EXPORT Make_CaseID(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_CaseID(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_CaseID(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_ClientFirstName(SALT39.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_ClientFirstName(SALT39.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_ClientFirstName(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_ClientMiddleName(SALT39.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_ClientMiddleName(SALT39.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_ClientMiddleName(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_ClientLastName(SALT39.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_ClientLastName(SALT39.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_ClientLastName(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_ClientPhone(SALT39.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_ClientPhone(SALT39.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_ClientPhone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_ClientEmail(SALT39.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_ClientEmail(SALT39.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_ClientEmail(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
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
    BOOLEAN Diff_SearchAddress1StreetAddress1;
    BOOLEAN Diff_SearchAddress1StreetAddress2;
    BOOLEAN Diff_SearchAddress1City;
    BOOLEAN Diff_SearchAddress1State;
    BOOLEAN Diff_SearchAddress1Zip;
    BOOLEAN Diff_SearchAddress2StreetAddress1;
    BOOLEAN Diff_SearchAddress2StreetAddress2;
    BOOLEAN Diff_SearchAddress2City;
    BOOLEAN Diff_SearchAddress2State;
    BOOLEAN Diff_SearchAddress2Zip;
    BOOLEAN Diff_SearchCaseId;
    BOOLEAN Diff_enduserip;
    BOOLEAN Diff_CaseID;
    BOOLEAN Diff_ClientFirstName;
    BOOLEAN Diff_ClientMiddleName;
    BOOLEAN Diff_ClientLastName;
    BOOLEAN Diff_ClientPhone;
    BOOLEAN Diff_ClientEmail;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_SearchAddress1StreetAddress1 := le.SearchAddress1StreetAddress1 <> ri.SearchAddress1StreetAddress1;
    SELF.Diff_SearchAddress1StreetAddress2 := le.SearchAddress1StreetAddress2 <> ri.SearchAddress1StreetAddress2;
    SELF.Diff_SearchAddress1City := le.SearchAddress1City <> ri.SearchAddress1City;
    SELF.Diff_SearchAddress1State := le.SearchAddress1State <> ri.SearchAddress1State;
    SELF.Diff_SearchAddress1Zip := le.SearchAddress1Zip <> ri.SearchAddress1Zip;
    SELF.Diff_SearchAddress2StreetAddress1 := le.SearchAddress2StreetAddress1 <> ri.SearchAddress2StreetAddress1;
    SELF.Diff_SearchAddress2StreetAddress2 := le.SearchAddress2StreetAddress2 <> ri.SearchAddress2StreetAddress2;
    SELF.Diff_SearchAddress2City := le.SearchAddress2City <> ri.SearchAddress2City;
    SELF.Diff_SearchAddress2State := le.SearchAddress2State <> ri.SearchAddress2State;
    SELF.Diff_SearchAddress2Zip := le.SearchAddress2Zip <> ri.SearchAddress2Zip;
    SELF.Diff_SearchCaseId := le.SearchCaseId <> ri.SearchCaseId;
    SELF.Diff_enduserip := le.enduserip <> ri.enduserip;
    SELF.Diff_CaseID := le.CaseID <> ri.CaseID;
    SELF.Diff_ClientFirstName := le.ClientFirstName <> ri.ClientFirstName;
    SELF.Diff_ClientMiddleName := le.ClientMiddleName <> ri.ClientMiddleName;
    SELF.Diff_ClientLastName := le.ClientLastName <> ri.ClientLastName;
    SELF.Diff_ClientPhone := le.ClientPhone <> ri.ClientPhone;
    SELF.Diff_ClientEmail := le.ClientEmail <> ri.ClientEmail;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_SearchAddress1StreetAddress1,1,0)+ IF( SELF.Diff_SearchAddress1StreetAddress2,1,0)+ IF( SELF.Diff_SearchAddress1City,1,0)+ IF( SELF.Diff_SearchAddress1State,1,0)+ IF( SELF.Diff_SearchAddress1Zip,1,0)+ IF( SELF.Diff_SearchAddress2StreetAddress1,1,0)+ IF( SELF.Diff_SearchAddress2StreetAddress2,1,0)+ IF( SELF.Diff_SearchAddress2City,1,0)+ IF( SELF.Diff_SearchAddress2State,1,0)+ IF( SELF.Diff_SearchAddress2Zip,1,0)+ IF( SELF.Diff_SearchCaseId,1,0)+ IF( SELF.Diff_enduserip,1,0)+ IF( SELF.Diff_CaseID,1,0)+ IF( SELF.Diff_ClientFirstName,1,0)+ IF( SELF.Diff_ClientMiddleName,1,0)+ IF( SELF.Diff_ClientLastName,1,0)+ IF( SELF.Diff_ClientPhone,1,0)+ IF( SELF.Diff_ClientEmail,1,0);
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
    Count_Diff_SearchAddress1StreetAddress1 := COUNT(GROUP,%Closest%.Diff_SearchAddress1StreetAddress1);
    Count_Diff_SearchAddress1StreetAddress2 := COUNT(GROUP,%Closest%.Diff_SearchAddress1StreetAddress2);
    Count_Diff_SearchAddress1City := COUNT(GROUP,%Closest%.Diff_SearchAddress1City);
    Count_Diff_SearchAddress1State := COUNT(GROUP,%Closest%.Diff_SearchAddress1State);
    Count_Diff_SearchAddress1Zip := COUNT(GROUP,%Closest%.Diff_SearchAddress1Zip);
    Count_Diff_SearchAddress2StreetAddress1 := COUNT(GROUP,%Closest%.Diff_SearchAddress2StreetAddress1);
    Count_Diff_SearchAddress2StreetAddress2 := COUNT(GROUP,%Closest%.Diff_SearchAddress2StreetAddress2);
    Count_Diff_SearchAddress2City := COUNT(GROUP,%Closest%.Diff_SearchAddress2City);
    Count_Diff_SearchAddress2State := COUNT(GROUP,%Closest%.Diff_SearchAddress2State);
    Count_Diff_SearchAddress2Zip := COUNT(GROUP,%Closest%.Diff_SearchAddress2Zip);
    Count_Diff_SearchCaseId := COUNT(GROUP,%Closest%.Diff_SearchCaseId);
    Count_Diff_enduserip := COUNT(GROUP,%Closest%.Diff_enduserip);
    Count_Diff_CaseID := COUNT(GROUP,%Closest%.Diff_CaseID);
    Count_Diff_ClientFirstName := COUNT(GROUP,%Closest%.Diff_ClientFirstName);
    Count_Diff_ClientMiddleName := COUNT(GROUP,%Closest%.Diff_ClientMiddleName);
    Count_Diff_ClientLastName := COUNT(GROUP,%Closest%.Diff_ClientLastName);
    Count_Diff_ClientPhone := COUNT(GROUP,%Closest%.Diff_ClientPhone);
    Count_Diff_ClientEmail := COUNT(GROUP,%Closest%.Diff_ClientEmail);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
