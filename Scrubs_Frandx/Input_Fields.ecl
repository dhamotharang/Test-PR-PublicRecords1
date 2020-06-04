IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
EXPORT NumFields := 21;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_company_name','invalid_franchisee_id','invalid_fruns','invalid_industry_type','invalid_nonempty_number','invalid_numeric','invalid_phone','invalid_relationship_code','invalid_secondary_phone','invalid_sic_code','invalid_state','invalid_unit_flag','invalid_zip_code','invalid_zip_code4');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_company_name' => 2,'invalid_franchisee_id' => 3,'invalid_fruns' => 4,'invalid_industry_type' => 5,'invalid_nonempty_number' => 6,'invalid_numeric' => 7,'invalid_phone' => 8,'invalid_relationship_code' => 9,'invalid_secondary_phone' => 10,'invalid_sic_code' => 11,'invalid_state' => 12,'invalid_unit_flag' => 13,'invalid_zip_code' => 14,'invalid_zip_code4' => 15,0);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_ASCII_printable(s)>0);
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_ASCII_printable'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_name(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_ASCII_printable(s)>0);
EXPORT InValidMessageFT_invalid_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_ASCII_printable'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_franchisee_id(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_franchisee_id(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s,6)>0);
EXPORT InValidMessageFT_invalid_franchisee_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fruns(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fruns(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_fruns(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_industry_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_industry_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['NON-FOOD','FOOD']);
EXPORT InValidMessageFT_invalid_industry_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('NON-FOOD|FOOD'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_nonempty_number(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_nonempty_number(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_nonempty_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_relationship_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_relationship_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['ST','AD','AR']);
EXPORT InValidMessageFT_invalid_relationship_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('ST|AD|AR'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_secondary_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_secondary_phone(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_secondary_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic_code(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_valid_SicCode(s)>0);
EXPORT InValidMessageFT_invalid_sic_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_valid_SicCode'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_unit_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_unit_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['U','H','UN','HQ']);
EXPORT InValidMessageFT_invalid_unit_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('U|H|UN|HQ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip_code(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_zip_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip_code4(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip_code4(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric_optional(s,4)>0);
EXPORT InValidMessageFT_invalid_zip_code4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'address1','address2','brand_name','city','company_name','exec_full_name','franchisee_id','fruns','industry','industry_type','phone','phone_extension','record_id','relationship_code','secondary_phone','sector','sic_code','state','unit_flag','zip_code','zip_code4');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'address1','address2','brand_name','city','company_name','exec_full_name','franchisee_id','fruns','industry','industry_type','phone','phone_extension','record_id','relationship_code','secondary_phone','sector','sic_code','state','unit_flag','zip_code','zip_code4');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'address1' => 0,'address2' => 1,'brand_name' => 2,'city' => 3,'company_name' => 4,'exec_full_name' => 5,'franchisee_id' => 6,'fruns' => 7,'industry' => 8,'industry_type' => 9,'phone' => 10,'phone_extension' => 11,'record_id' => 12,'relationship_code' => 13,'secondary_phone' => 14,'sector' => 15,'sic_code' => 16,'state' => 17,'unit_flag' => 18,'zip_code' => 19,'zip_code4' => 20,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_address1(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_address1(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_address2(SALT311.StrType s0) := s0;
EXPORT InValid_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_brand_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_brand_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_brand_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_company_name(SALT311.StrType s0) := MakeFT_invalid_company_name(s0);
EXPORT InValid_company_name(SALT311.StrType s) := InValidFT_invalid_company_name(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_company_name(wh);
 
EXPORT Make_exec_full_name(SALT311.StrType s0) := s0;
EXPORT InValid_exec_full_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_exec_full_name(UNSIGNED1 wh) := '';
 
EXPORT Make_franchisee_id(SALT311.StrType s0) := MakeFT_invalid_franchisee_id(s0);
EXPORT InValid_franchisee_id(SALT311.StrType s) := InValidFT_invalid_franchisee_id(s);
EXPORT InValidMessage_franchisee_id(UNSIGNED1 wh) := InValidMessageFT_invalid_franchisee_id(wh);
 
EXPORT Make_fruns(SALT311.StrType s0) := MakeFT_invalid_fruns(s0);
EXPORT InValid_fruns(SALT311.StrType s) := InValidFT_invalid_fruns(s);
EXPORT InValidMessage_fruns(UNSIGNED1 wh) := InValidMessageFT_invalid_fruns(wh);
 
EXPORT Make_industry(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_industry(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_industry(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_industry_type(SALT311.StrType s0) := MakeFT_invalid_industry_type(s0);
EXPORT InValid_industry_type(SALT311.StrType s) := InValidFT_invalid_industry_type(s);
EXPORT InValidMessage_industry_type(UNSIGNED1 wh) := InValidMessageFT_invalid_industry_type(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_phone_extension(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_phone_extension(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_phone_extension(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_record_id(SALT311.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_record_id(SALT311.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_record_id(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_relationship_code(SALT311.StrType s0) := MakeFT_invalid_relationship_code(s0);
EXPORT InValid_relationship_code(SALT311.StrType s) := InValidFT_invalid_relationship_code(s);
EXPORT InValidMessage_relationship_code(UNSIGNED1 wh) := InValidMessageFT_invalid_relationship_code(wh);
 
EXPORT Make_secondary_phone(SALT311.StrType s0) := MakeFT_invalid_secondary_phone(s0);
EXPORT InValid_secondary_phone(SALT311.StrType s) := InValidFT_invalid_secondary_phone(s);
EXPORT InValidMessage_secondary_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_secondary_phone(wh);
 
EXPORT Make_sector(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_sector(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_sector(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_sic_code(SALT311.StrType s0) := MakeFT_invalid_sic_code(s0);
EXPORT InValid_sic_code(SALT311.StrType s) := InValidFT_invalid_sic_code(s);
EXPORT InValidMessage_sic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_code(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_unit_flag(SALT311.StrType s0) := MakeFT_invalid_unit_flag(s0);
EXPORT InValid_unit_flag(SALT311.StrType s) := InValidFT_invalid_unit_flag(s);
EXPORT InValidMessage_unit_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_unit_flag(wh);
 
EXPORT Make_zip_code(SALT311.StrType s0) := MakeFT_invalid_zip_code(s0);
EXPORT InValid_zip_code(SALT311.StrType s) := InValidFT_invalid_zip_code(s);
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_code(wh);
 
EXPORT Make_zip_code4(SALT311.StrType s0) := MakeFT_invalid_zip_code4(s0);
EXPORT InValid_zip_code4(SALT311.StrType s) := InValidFT_invalid_zip_code4(s);
EXPORT InValidMessage_zip_code4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_code4(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Frandx;
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
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_brand_name;
    BOOLEAN Diff_city;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_exec_full_name;
    BOOLEAN Diff_franchisee_id;
    BOOLEAN Diff_fruns;
    BOOLEAN Diff_industry;
    BOOLEAN Diff_industry_type;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_phone_extension;
    BOOLEAN Diff_record_id;
    BOOLEAN Diff_relationship_code;
    BOOLEAN Diff_secondary_phone;
    BOOLEAN Diff_sector;
    BOOLEAN Diff_sic_code;
    BOOLEAN Diff_state;
    BOOLEAN Diff_unit_flag;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_zip_code4;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_brand_name := le.brand_name <> ri.brand_name;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_exec_full_name := le.exec_full_name <> ri.exec_full_name;
    SELF.Diff_franchisee_id := le.franchisee_id <> ri.franchisee_id;
    SELF.Diff_fruns := le.fruns <> ri.fruns;
    SELF.Diff_industry := le.industry <> ri.industry;
    SELF.Diff_industry_type := le.industry_type <> ri.industry_type;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_phone_extension := le.phone_extension <> ri.phone_extension;
    SELF.Diff_record_id := le.record_id <> ri.record_id;
    SELF.Diff_relationship_code := le.relationship_code <> ri.relationship_code;
    SELF.Diff_secondary_phone := le.secondary_phone <> ri.secondary_phone;
    SELF.Diff_sector := le.sector <> ri.sector;
    SELF.Diff_sic_code := le.sic_code <> ri.sic_code;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_unit_flag := le.unit_flag <> ri.unit_flag;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_zip_code4 := le.zip_code4 <> ri.zip_code4;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_brand_name,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_exec_full_name,1,0)+ IF( SELF.Diff_franchisee_id,1,0)+ IF( SELF.Diff_fruns,1,0)+ IF( SELF.Diff_industry,1,0)+ IF( SELF.Diff_industry_type,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phone_extension,1,0)+ IF( SELF.Diff_record_id,1,0)+ IF( SELF.Diff_relationship_code,1,0)+ IF( SELF.Diff_secondary_phone,1,0)+ IF( SELF.Diff_sector,1,0)+ IF( SELF.Diff_sic_code,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_unit_flag,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_zip_code4,1,0);
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
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_brand_name := COUNT(GROUP,%Closest%.Diff_brand_name);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_exec_full_name := COUNT(GROUP,%Closest%.Diff_exec_full_name);
    Count_Diff_franchisee_id := COUNT(GROUP,%Closest%.Diff_franchisee_id);
    Count_Diff_fruns := COUNT(GROUP,%Closest%.Diff_fruns);
    Count_Diff_industry := COUNT(GROUP,%Closest%.Diff_industry);
    Count_Diff_industry_type := COUNT(GROUP,%Closest%.Diff_industry_type);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_phone_extension := COUNT(GROUP,%Closest%.Diff_phone_extension);
    Count_Diff_record_id := COUNT(GROUP,%Closest%.Diff_record_id);
    Count_Diff_relationship_code := COUNT(GROUP,%Closest%.Diff_relationship_code);
    Count_Diff_secondary_phone := COUNT(GROUP,%Closest%.Diff_secondary_phone);
    Count_Diff_sector := COUNT(GROUP,%Closest%.Diff_sector);
    Count_Diff_sic_code := COUNT(GROUP,%Closest%.Diff_sic_code);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_unit_flag := COUNT(GROUP,%Closest%.Diff_unit_flag);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_zip_code4 := COUNT(GROUP,%Closest%.Diff_zip_code4);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
