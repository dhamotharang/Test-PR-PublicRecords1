IMPORT SALT311;
IMPORT Scrubs,Scrubs_Debt_Settlement; // Import modules for FieldTypes attribute definitions
EXPORT CC_Fields := MODULE
 
EXPORT NumFields := 19;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_id','Invalid_mandatory','Invalid_mandatory_alpha','Invalid_alpha','Invalid_St','Invalid_zip','Invalid_zip4','Invalid_Phone','Invalid_Status','Invalid_Date','Invalid_Future_Date','Invalid_OrgType');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_id' => 1,'Invalid_mandatory' => 2,'Invalid_mandatory_alpha' => 3,'Invalid_alpha' => 4,'Invalid_St' => 5,'Invalid_zip' => 6,'Invalid_zip4' => 7,'Invalid_Phone' => 8,'Invalid_Status' => 9,'Invalid_Date' => 10,'Invalid_Future_Date' => 11,'Invalid_OrgType' => 12,0);
 
EXPORT MakeFT_Invalid_id(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_id(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_Invalid_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_mandatory_alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_mandatory_alpha(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_ASCII_printable(s)>0,~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_mandatory_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_ASCII_printable'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_alpha(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_ASCII_printable(s)>0);
EXPORT InValidMessageFT_Invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_ASCII_printable'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_St(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_St(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_valid_StateAbbrev(s)>0);
EXPORT InValidMessageFT_Invalid_St(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_valid_StateAbbrev'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_zip(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_numeric_optional(s,5)>0);
EXPORT InValidMessageFT_Invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_zip4(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_zip4(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_numeric_optional(s,4)>0);
EXPORT InValidMessageFT_Invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Status(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Status(SALT311.StrType s) := WHICH(~Scrubs_Debt_Settlement.functions.fn_valid_status(s)>0);
EXPORT InValidMessageFT_Invalid_Status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Debt_Settlement.functions.fn_valid_status'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Future_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Future_Date(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_valid_date(s,'future')>0);
EXPORT InValidMessageFT_Invalid_Future_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_OrgType(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_OrgType(SALT311.StrType s) := WHICH(~Scrubs_Debt_Settlement.functions.fn_valid_orgtype(s)>0);
EXPORT InValidMessageFT_Invalid_OrgType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Debt_Settlement.functions.fn_valid_orgtype'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'idnum','businessname','dba','orgid','address1','address2','city','state','zip','zip4','phone','fax','email','url','status','licensedatefrom','licensedateto','orgtype','source');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'idnum','businessname','dba','orgid','address1','address2','city','state','zip','zip4','phone','fax','email','url','status','licensedatefrom','licensedateto','orgtype','source');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'idnum' => 0,'businessname' => 1,'dba' => 2,'orgid' => 3,'address1' => 4,'address2' => 5,'city' => 6,'state' => 7,'zip' => 8,'zip4' => 9,'phone' => 10,'fax' => 11,'email' => 12,'url' => 13,'status' => 14,'licensedatefrom' => 15,'licensedateto' => 16,'orgtype' => 17,'source' => 18,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_idnum(SALT311.StrType s0) := MakeFT_Invalid_id(s0);
EXPORT InValid_idnum(SALT311.StrType s) := InValidFT_Invalid_id(s);
EXPORT InValidMessage_idnum(UNSIGNED1 wh) := InValidMessageFT_Invalid_id(wh);
 
EXPORT Make_businessname(SALT311.StrType s0) := MakeFT_Invalid_mandatory_alpha(s0);
EXPORT InValid_businessname(SALT311.StrType s) := InValidFT_Invalid_mandatory_alpha(s);
EXPORT InValidMessage_businessname(UNSIGNED1 wh) := InValidMessageFT_Invalid_mandatory_alpha(wh);
 
EXPORT Make_dba(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_dba(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_dba(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_orgid(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_orgid(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_address1(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_address1(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_address1(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_address2(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_address2(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_address2(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_St(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_St(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_St(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_Invalid_zip(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_Invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_zip(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_Invalid_zip4(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_Invalid_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_zip4(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_fax(SALT311.StrType s0) := s0;
EXPORT InValid_fax(SALT311.StrType s) := 0;
EXPORT InValidMessage_fax(UNSIGNED1 wh) := '';
 
EXPORT Make_email(SALT311.StrType s0) := s0;
EXPORT InValid_email(SALT311.StrType s) := 0;
EXPORT InValidMessage_email(UNSIGNED1 wh) := '';
 
EXPORT Make_url(SALT311.StrType s0) := MakeFT_Invalid_alpha(s0);
EXPORT InValid_url(SALT311.StrType s) := InValidFT_Invalid_alpha(s);
EXPORT InValidMessage_url(UNSIGNED1 wh) := InValidMessageFT_Invalid_alpha(wh);
 
EXPORT Make_status(SALT311.StrType s0) := MakeFT_Invalid_Status(s0);
EXPORT InValid_status(SALT311.StrType s) := InValidFT_Invalid_Status(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_Invalid_Status(wh);
 
EXPORT Make_licensedatefrom(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_licensedatefrom(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_licensedatefrom(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_licensedateto(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_licensedateto(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_licensedateto(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_orgtype(SALT311.StrType s0) := MakeFT_Invalid_OrgType(s0);
EXPORT InValid_orgtype(SALT311.StrType s) := InValidFT_Invalid_OrgType(s);
EXPORT InValidMessage_orgtype(UNSIGNED1 wh) := InValidMessageFT_Invalid_OrgType(wh);
 
EXPORT Make_source(SALT311.StrType s0) := MakeFT_Invalid_mandatory(s0);
EXPORT InValid_source(SALT311.StrType s) := InValidFT_Invalid_mandatory(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_mandatory(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Debt_Settlement;
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
    BOOLEAN Diff_idnum;
    BOOLEAN Diff_businessname;
    BOOLEAN Diff_dba;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_fax;
    BOOLEAN Diff_email;
    BOOLEAN Diff_url;
    BOOLEAN Diff_status;
    BOOLEAN Diff_licensedatefrom;
    BOOLEAN Diff_licensedateto;
    BOOLEAN Diff_orgtype;
    BOOLEAN Diff_source;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_idnum := le.idnum <> ri.idnum;
    SELF.Diff_businessname := le.businessname <> ri.businessname;
    SELF.Diff_dba := le.dba <> ri.dba;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_fax := le.fax <> ri.fax;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_url := le.url <> ri.url;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_licensedatefrom := le.licensedatefrom <> ri.licensedatefrom;
    SELF.Diff_licensedateto := le.licensedateto <> ri.licensedateto;
    SELF.Diff_orgtype := le.orgtype <> ri.orgtype;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_idnum,1,0)+ IF( SELF.Diff_businessname,1,0)+ IF( SELF.Diff_dba,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_fax,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_url,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_licensedatefrom,1,0)+ IF( SELF.Diff_licensedateto,1,0)+ IF( SELF.Diff_orgtype,1,0)+ IF( SELF.Diff_source,1,0);
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
    Count_Diff_idnum := COUNT(GROUP,%Closest%.Diff_idnum);
    Count_Diff_businessname := COUNT(GROUP,%Closest%.Diff_businessname);
    Count_Diff_dba := COUNT(GROUP,%Closest%.Diff_dba);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_fax := COUNT(GROUP,%Closest%.Diff_fax);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_url := COUNT(GROUP,%Closest%.Diff_url);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_licensedatefrom := COUNT(GROUP,%Closest%.Diff_licensedatefrom);
    Count_Diff_licensedateto := COUNT(GROUP,%Closest%.Diff_licensedateto);
    Count_Diff_orgtype := COUNT(GROUP,%Closest%.Diff_orgtype);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
