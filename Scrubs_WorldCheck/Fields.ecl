IMPORT SALT311;
IMPORT Scrubs_WorldCheck; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 24;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_Alpha','Invalid_AlphaCaps','Invalid_AlphaChar','Invalid_Keywords','Invalid_Ind','Invalid_SSN','Invalid_Date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_Alpha' => 2,'Invalid_AlphaCaps' => 3,'Invalid_AlphaChar' => 4,'Invalid_Keywords' => 5,'Invalid_Ind' => 6,'Invalid_SSN' => 7,'Invalid_Date' => 8,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaCaps(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaCaps(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_Invalid_AlphaCaps(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(~Scrubs_WorldCheck.Fn_Valid.Chars(s,'AlphaChar')>0);
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_WorldCheck.Fn_Valid.Chars'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Keywords(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -~0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Keywords(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -~0123456789'))));
EXPORT InValidMessageFT_Invalid_Keywords(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -~0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Ind(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Ind(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['I','E','']);
EXPORT InValidMessageFT_Invalid_Ind(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('I|E|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_SSN(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_SSN(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 11));
EXPORT InValidMessageFT_Invalid_SSN(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789-'),SALT311.HygieneErrors.NotLength('0,9,11'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs_WorldCheck.Fn_Valid.Date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_WorldCheck.Fn_Valid.Date'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'uid','key','name_orig','name_type','last_name','first_name','category','title','sub_category','position','age','date_of_birth','places_of_birth','date_of_death','passports','social_security_number','location','countries','e_i_ind','keywords','entered','updated','editor','age_as_of_date');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'uid','key','name_orig','name_type','last_name','first_name','category','title','sub_category','position','age','date_of_birth','places_of_birth','date_of_death','passports','social_security_number','location','countries','e_i_ind','keywords','entered','updated','editor','age_as_of_date');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'uid' => 0,'key' => 1,'name_orig' => 2,'name_type' => 3,'last_name' => 4,'first_name' => 5,'category' => 6,'title' => 7,'sub_category' => 8,'position' => 9,'age' => 10,'date_of_birth' => 11,'places_of_birth' => 12,'date_of_death' => 13,'passports' => 14,'social_security_number' => 15,'location' => 16,'countries' => 17,'e_i_ind' => 18,'keywords' => 19,'entered' => 20,'updated' => 21,'editor' => 22,'age_as_of_date' => 23,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],[],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW','LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_uid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_uid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_uid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_key(SALT311.StrType s0) := s0;
EXPORT InValid_key(SALT311.StrType s) := 0;
EXPORT InValidMessage_key(UNSIGNED1 wh) := '';
 
EXPORT Make_name_orig(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_name_orig(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_name_orig(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_name_type(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_name_type(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_name_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_last_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_last_name(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_first_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_first_name(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_category(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_category(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_category(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_title(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_title(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_sub_category(SALT311.StrType s0) := MakeFT_Invalid_AlphaCaps(s0);
EXPORT InValid_sub_category(SALT311.StrType s) := InValidFT_Invalid_AlphaCaps(s);
EXPORT InValidMessage_sub_category(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaCaps(wh);
 
EXPORT Make_position(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_position(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_position(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_age(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_age(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_age(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_date_of_birth(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_of_birth(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_of_birth(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_places_of_birth(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_places_of_birth(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_places_of_birth(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_date_of_death(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_of_death(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_of_death(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_passports(SALT311.StrType s0) := s0;
EXPORT InValid_passports(SALT311.StrType s) := 0;
EXPORT InValidMessage_passports(UNSIGNED1 wh) := '';
 
EXPORT Make_social_security_number(SALT311.StrType s0) := MakeFT_Invalid_SSN(s0);
EXPORT InValid_social_security_number(SALT311.StrType s) := InValidFT_Invalid_SSN(s);
EXPORT InValidMessage_social_security_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_SSN(wh);
 
EXPORT Make_location(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_location(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_location(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_countries(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_countries(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_countries(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_e_i_ind(SALT311.StrType s0) := MakeFT_Invalid_Ind(s0);
EXPORT InValid_e_i_ind(SALT311.StrType s) := InValidFT_Invalid_Ind(s);
EXPORT InValidMessage_e_i_ind(UNSIGNED1 wh) := InValidMessageFT_Invalid_Ind(wh);
 
EXPORT Make_keywords(SALT311.StrType s0) := MakeFT_Invalid_Keywords(s0);
EXPORT InValid_keywords(SALT311.StrType s) := InValidFT_Invalid_Keywords(s);
EXPORT InValidMessage_keywords(UNSIGNED1 wh) := InValidMessageFT_Invalid_Keywords(wh);
 
EXPORT Make_entered(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_entered(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_entered(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_updated(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_updated(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_updated(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_editor(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_editor(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_editor(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_age_as_of_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_age_as_of_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_age_as_of_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_WorldCheck;
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
    BOOLEAN Diff_uid;
    BOOLEAN Diff_key;
    BOOLEAN Diff_name_orig;
    BOOLEAN Diff_name_type;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_category;
    BOOLEAN Diff_title;
    BOOLEAN Diff_sub_category;
    BOOLEAN Diff_position;
    BOOLEAN Diff_age;
    BOOLEAN Diff_date_of_birth;
    BOOLEAN Diff_places_of_birth;
    BOOLEAN Diff_date_of_death;
    BOOLEAN Diff_passports;
    BOOLEAN Diff_social_security_number;
    BOOLEAN Diff_location;
    BOOLEAN Diff_countries;
    BOOLEAN Diff_e_i_ind;
    BOOLEAN Diff_keywords;
    BOOLEAN Diff_entered;
    BOOLEAN Diff_updated;
    BOOLEAN Diff_editor;
    BOOLEAN Diff_age_as_of_date;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_uid := le.uid <> ri.uid;
    SELF.Diff_key := le.key <> ri.key;
    SELF.Diff_name_orig := le.name_orig <> ri.name_orig;
    SELF.Diff_name_type := le.name_type <> ri.name_type;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_category := le.category <> ri.category;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_sub_category := le.sub_category <> ri.sub_category;
    SELF.Diff_position := le.position <> ri.position;
    SELF.Diff_age := le.age <> ri.age;
    SELF.Diff_date_of_birth := le.date_of_birth <> ri.date_of_birth;
    SELF.Diff_places_of_birth := le.places_of_birth <> ri.places_of_birth;
    SELF.Diff_date_of_death := le.date_of_death <> ri.date_of_death;
    SELF.Diff_passports := le.passports <> ri.passports;
    SELF.Diff_social_security_number := le.social_security_number <> ri.social_security_number;
    SELF.Diff_location := le.location <> ri.location;
    SELF.Diff_countries := le.countries <> ri.countries;
    SELF.Diff_e_i_ind := le.e_i_ind <> ri.e_i_ind;
    SELF.Diff_keywords := le.keywords <> ri.keywords;
    SELF.Diff_entered := le.entered <> ri.entered;
    SELF.Diff_updated := le.updated <> ri.updated;
    SELF.Diff_editor := le.editor <> ri.editor;
    SELF.Diff_age_as_of_date := le.age_as_of_date <> ri.age_as_of_date;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_uid,1,0)+ IF( SELF.Diff_key,1,0)+ IF( SELF.Diff_name_orig,1,0)+ IF( SELF.Diff_name_type,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_category,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_sub_category,1,0)+ IF( SELF.Diff_position,1,0)+ IF( SELF.Diff_age,1,0)+ IF( SELF.Diff_date_of_birth,1,0)+ IF( SELF.Diff_places_of_birth,1,0)+ IF( SELF.Diff_date_of_death,1,0)+ IF( SELF.Diff_passports,1,0)+ IF( SELF.Diff_social_security_number,1,0)+ IF( SELF.Diff_location,1,0)+ IF( SELF.Diff_countries,1,0)+ IF( SELF.Diff_e_i_ind,1,0)+ IF( SELF.Diff_keywords,1,0)+ IF( SELF.Diff_entered,1,0)+ IF( SELF.Diff_updated,1,0)+ IF( SELF.Diff_editor,1,0)+ IF( SELF.Diff_age_as_of_date,1,0);
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
    Count_Diff_uid := COUNT(GROUP,%Closest%.Diff_uid);
    Count_Diff_key := COUNT(GROUP,%Closest%.Diff_key);
    Count_Diff_name_orig := COUNT(GROUP,%Closest%.Diff_name_orig);
    Count_Diff_name_type := COUNT(GROUP,%Closest%.Diff_name_type);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_category := COUNT(GROUP,%Closest%.Diff_category);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_sub_category := COUNT(GROUP,%Closest%.Diff_sub_category);
    Count_Diff_position := COUNT(GROUP,%Closest%.Diff_position);
    Count_Diff_age := COUNT(GROUP,%Closest%.Diff_age);
    Count_Diff_date_of_birth := COUNT(GROUP,%Closest%.Diff_date_of_birth);
    Count_Diff_places_of_birth := COUNT(GROUP,%Closest%.Diff_places_of_birth);
    Count_Diff_date_of_death := COUNT(GROUP,%Closest%.Diff_date_of_death);
    Count_Diff_passports := COUNT(GROUP,%Closest%.Diff_passports);
    Count_Diff_social_security_number := COUNT(GROUP,%Closest%.Diff_social_security_number);
    Count_Diff_location := COUNT(GROUP,%Closest%.Diff_location);
    Count_Diff_countries := COUNT(GROUP,%Closest%.Diff_countries);
    Count_Diff_e_i_ind := COUNT(GROUP,%Closest%.Diff_e_i_ind);
    Count_Diff_keywords := COUNT(GROUP,%Closest%.Diff_keywords);
    Count_Diff_entered := COUNT(GROUP,%Closest%.Diff_entered);
    Count_Diff_updated := COUNT(GROUP,%Closest%.Diff_updated);
    Count_Diff_editor := COUNT(GROUP,%Closest%.Diff_editor);
    Count_Diff_age_as_of_date := COUNT(GROUP,%Closest%.Diff_age_as_of_date);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
