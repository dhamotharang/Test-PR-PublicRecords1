IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_CA_Santa_Clara_Fields := MODULE
 
EXPORT NumFields := 38;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_past_date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_past_date' => 2,0);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_past_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_past_date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_invalid_past_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'status','process_date','FIlED_DATE','FBN_TYPE','FILING_TYPE','BUSINESS_NAME','BUSINESS_TYPE','ORIG_FILED_DATE','ORIG_FBN_NUM','RECORD_CODE1','FBN_NUM','BUSINESS_ADDR1','RECORD_CODE2','BUSINESS_ADDR2','RECORD_CODE3','BUS_CITY','BUS_ST','BUS_ZIP','RECORD_CODE4','ADDTL_BUSINESS','RECORD_CODE5','owner_name','OWNER_TYPE','RECORD_CODE6','OWNER_ADDR1','OWNER_CITY','OWNER_ST','OWNER_ZIP','Owner_title','Owner_fname','Owner_mname','Owner_lname','Owner_name_suffix','Owner_name_score','prep_addr_line1','prep_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'status','process_date','FIlED_DATE','FBN_TYPE','FILING_TYPE','BUSINESS_NAME','BUSINESS_TYPE','ORIG_FILED_DATE','ORIG_FBN_NUM','RECORD_CODE1','FBN_NUM','BUSINESS_ADDR1','RECORD_CODE2','BUSINESS_ADDR2','RECORD_CODE3','BUS_CITY','BUS_ST','BUS_ZIP','RECORD_CODE4','ADDTL_BUSINESS','RECORD_CODE5','owner_name','OWNER_TYPE','RECORD_CODE6','OWNER_ADDR1','OWNER_CITY','OWNER_ST','OWNER_ZIP','Owner_title','Owner_fname','Owner_mname','Owner_lname','Owner_name_suffix','Owner_name_score','prep_addr_line1','prep_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'status' => 0,'process_date' => 1,'FIlED_DATE' => 2,'FBN_TYPE' => 3,'FILING_TYPE' => 4,'BUSINESS_NAME' => 5,'BUSINESS_TYPE' => 6,'ORIG_FILED_DATE' => 7,'ORIG_FBN_NUM' => 8,'RECORD_CODE1' => 9,'FBN_NUM' => 10,'BUSINESS_ADDR1' => 11,'RECORD_CODE2' => 12,'BUSINESS_ADDR2' => 13,'RECORD_CODE3' => 14,'BUS_CITY' => 15,'BUS_ST' => 16,'BUS_ZIP' => 17,'RECORD_CODE4' => 18,'ADDTL_BUSINESS' => 19,'RECORD_CODE5' => 20,'owner_name' => 21,'OWNER_TYPE' => 22,'RECORD_CODE6' => 23,'OWNER_ADDR1' => 24,'OWNER_CITY' => 25,'OWNER_ST' => 26,'OWNER_ZIP' => 27,'Owner_title' => 28,'Owner_fname' => 29,'Owner_mname' => 30,'Owner_lname' => 31,'Owner_name_suffix' => 32,'Owner_name_score' => 33,'prep_addr_line1' => 34,'prep_addr_line_last' => 35,'prep_owner_addr_line1' => 36,'prep_owner_addr_line_last' => 37,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],['CUSTOM'],[],['LENGTHS'],['LENGTHS'],[],['CUSTOM'],[],[],['LENGTHS'],[],[],[],[],[],[],[],[],[],[],['LENGTHS'],[],[],[],[],[],[],[],[],[],[],[],[],['LENGTHS'],['LENGTHS'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_status(SALT311.StrType s0) := s0;
EXPORT InValid_status(SALT311.StrType s) := 0;
EXPORT InValidMessage_status(UNSIGNED1 wh) := '';
 
EXPORT Make_process_date(SALT311.StrType s0) := s0;
EXPORT InValid_process_date(SALT311.StrType s) := 0;
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := '';
 
EXPORT Make_FIlED_DATE(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_FIlED_DATE(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_FIlED_DATE(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_FBN_TYPE(SALT311.StrType s0) := s0;
EXPORT InValid_FBN_TYPE(SALT311.StrType s) := 0;
EXPORT InValidMessage_FBN_TYPE(UNSIGNED1 wh) := '';
 
EXPORT Make_FILING_TYPE(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_FILING_TYPE(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_FILING_TYPE(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_BUSINESS_NAME(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_BUSINESS_NAME(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_BUSINESS_NAME(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_BUSINESS_TYPE(SALT311.StrType s0) := s0;
EXPORT InValid_BUSINESS_TYPE(SALT311.StrType s) := 0;
EXPORT InValidMessage_BUSINESS_TYPE(UNSIGNED1 wh) := '';
 
EXPORT Make_ORIG_FILED_DATE(SALT311.StrType s0) := MakeFT_invalid_past_date(s0);
EXPORT InValid_ORIG_FILED_DATE(SALT311.StrType s) := InValidFT_invalid_past_date(s);
EXPORT InValidMessage_ORIG_FILED_DATE(UNSIGNED1 wh) := InValidMessageFT_invalid_past_date(wh);
 
EXPORT Make_ORIG_FBN_NUM(SALT311.StrType s0) := s0;
EXPORT InValid_ORIG_FBN_NUM(SALT311.StrType s) := 0;
EXPORT InValidMessage_ORIG_FBN_NUM(UNSIGNED1 wh) := '';
 
EXPORT Make_RECORD_CODE1(SALT311.StrType s0) := s0;
EXPORT InValid_RECORD_CODE1(SALT311.StrType s) := 0;
EXPORT InValidMessage_RECORD_CODE1(UNSIGNED1 wh) := '';
 
EXPORT Make_FBN_NUM(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_FBN_NUM(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_FBN_NUM(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_BUSINESS_ADDR1(SALT311.StrType s0) := s0;
EXPORT InValid_BUSINESS_ADDR1(SALT311.StrType s) := 0;
EXPORT InValidMessage_BUSINESS_ADDR1(UNSIGNED1 wh) := '';
 
EXPORT Make_RECORD_CODE2(SALT311.StrType s0) := s0;
EXPORT InValid_RECORD_CODE2(SALT311.StrType s) := 0;
EXPORT InValidMessage_RECORD_CODE2(UNSIGNED1 wh) := '';
 
EXPORT Make_BUSINESS_ADDR2(SALT311.StrType s0) := s0;
EXPORT InValid_BUSINESS_ADDR2(SALT311.StrType s) := 0;
EXPORT InValidMessage_BUSINESS_ADDR2(UNSIGNED1 wh) := '';
 
EXPORT Make_RECORD_CODE3(SALT311.StrType s0) := s0;
EXPORT InValid_RECORD_CODE3(SALT311.StrType s) := 0;
EXPORT InValidMessage_RECORD_CODE3(UNSIGNED1 wh) := '';
 
EXPORT Make_BUS_CITY(SALT311.StrType s0) := s0;
EXPORT InValid_BUS_CITY(SALT311.StrType s) := 0;
EXPORT InValidMessage_BUS_CITY(UNSIGNED1 wh) := '';
 
EXPORT Make_BUS_ST(SALT311.StrType s0) := s0;
EXPORT InValid_BUS_ST(SALT311.StrType s) := 0;
EXPORT InValidMessage_BUS_ST(UNSIGNED1 wh) := '';
 
EXPORT Make_BUS_ZIP(SALT311.StrType s0) := s0;
EXPORT InValid_BUS_ZIP(SALT311.StrType s) := 0;
EXPORT InValidMessage_BUS_ZIP(UNSIGNED1 wh) := '';
 
EXPORT Make_RECORD_CODE4(SALT311.StrType s0) := s0;
EXPORT InValid_RECORD_CODE4(SALT311.StrType s) := 0;
EXPORT InValidMessage_RECORD_CODE4(UNSIGNED1 wh) := '';
 
EXPORT Make_ADDTL_BUSINESS(SALT311.StrType s0) := s0;
EXPORT InValid_ADDTL_BUSINESS(SALT311.StrType s) := 0;
EXPORT InValidMessage_ADDTL_BUSINESS(UNSIGNED1 wh) := '';
 
EXPORT Make_RECORD_CODE5(SALT311.StrType s0) := s0;
EXPORT InValid_RECORD_CODE5(SALT311.StrType s) := 0;
EXPORT InValidMessage_RECORD_CODE5(UNSIGNED1 wh) := '';
 
EXPORT Make_owner_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_owner_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_owner_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_OWNER_TYPE(SALT311.StrType s0) := s0;
EXPORT InValid_OWNER_TYPE(SALT311.StrType s) := 0;
EXPORT InValidMessage_OWNER_TYPE(UNSIGNED1 wh) := '';
 
EXPORT Make_RECORD_CODE6(SALT311.StrType s0) := s0;
EXPORT InValid_RECORD_CODE6(SALT311.StrType s) := 0;
EXPORT InValidMessage_RECORD_CODE6(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_ADDR1(SALT311.StrType s0) := s0;
EXPORT InValid_OWNER_ADDR1(SALT311.StrType s) := 0;
EXPORT InValidMessage_OWNER_ADDR1(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_CITY(SALT311.StrType s0) := s0;
EXPORT InValid_OWNER_CITY(SALT311.StrType s) := 0;
EXPORT InValidMessage_OWNER_CITY(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_ST(SALT311.StrType s0) := s0;
EXPORT InValid_OWNER_ST(SALT311.StrType s) := 0;
EXPORT InValidMessage_OWNER_ST(UNSIGNED1 wh) := '';
 
EXPORT Make_OWNER_ZIP(SALT311.StrType s0) := s0;
EXPORT InValid_OWNER_ZIP(SALT311.StrType s) := 0;
EXPORT InValidMessage_OWNER_ZIP(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_title(SALT311.StrType s0) := s0;
EXPORT InValid_Owner_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_Owner_title(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_fname(SALT311.StrType s0) := s0;
EXPORT InValid_Owner_fname(SALT311.StrType s) := 0;
EXPORT InValidMessage_Owner_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_mname(SALT311.StrType s0) := s0;
EXPORT InValid_Owner_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_Owner_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_lname(SALT311.StrType s0) := s0;
EXPORT InValid_Owner_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_Owner_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_name_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_Owner_name_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_Owner_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_Owner_name_score(SALT311.StrType s0) := s0;
EXPORT InValid_Owner_name_score(SALT311.StrType s) := 0;
EXPORT InValidMessage_Owner_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_addr_line1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line_last(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line_last(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_owner_addr_line1(SALT311.StrType s0) := s0;
EXPORT InValid_prep_owner_addr_line1(SALT311.StrType s) := 0;
EXPORT InValidMessage_prep_owner_addr_line1(UNSIGNED1 wh) := '';
 
EXPORT Make_prep_owner_addr_line_last(SALT311.StrType s0) := s0;
EXPORT InValid_prep_owner_addr_line_last(SALT311.StrType s) := 0;
EXPORT InValidMessage_prep_owner_addr_line_last(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_FBNV2;
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
    BOOLEAN Diff_status;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_FIlED_DATE;
    BOOLEAN Diff_FBN_TYPE;
    BOOLEAN Diff_FILING_TYPE;
    BOOLEAN Diff_BUSINESS_NAME;
    BOOLEAN Diff_BUSINESS_TYPE;
    BOOLEAN Diff_ORIG_FILED_DATE;
    BOOLEAN Diff_ORIG_FBN_NUM;
    BOOLEAN Diff_RECORD_CODE1;
    BOOLEAN Diff_FBN_NUM;
    BOOLEAN Diff_BUSINESS_ADDR1;
    BOOLEAN Diff_RECORD_CODE2;
    BOOLEAN Diff_BUSINESS_ADDR2;
    BOOLEAN Diff_RECORD_CODE3;
    BOOLEAN Diff_BUS_CITY;
    BOOLEAN Diff_BUS_ST;
    BOOLEAN Diff_BUS_ZIP;
    BOOLEAN Diff_RECORD_CODE4;
    BOOLEAN Diff_ADDTL_BUSINESS;
    BOOLEAN Diff_RECORD_CODE5;
    BOOLEAN Diff_owner_name;
    BOOLEAN Diff_OWNER_TYPE;
    BOOLEAN Diff_RECORD_CODE6;
    BOOLEAN Diff_OWNER_ADDR1;
    BOOLEAN Diff_OWNER_CITY;
    BOOLEAN Diff_OWNER_ST;
    BOOLEAN Diff_OWNER_ZIP;
    BOOLEAN Diff_Owner_title;
    BOOLEAN Diff_Owner_fname;
    BOOLEAN Diff_Owner_mname;
    BOOLEAN Diff_Owner_lname;
    BOOLEAN Diff_Owner_name_suffix;
    BOOLEAN Diff_Owner_name_score;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_line_last;
    BOOLEAN Diff_prep_owner_addr_line1;
    BOOLEAN Diff_prep_owner_addr_line_last;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_FIlED_DATE := le.FIlED_DATE <> ri.FIlED_DATE;
    SELF.Diff_FBN_TYPE := le.FBN_TYPE <> ri.FBN_TYPE;
    SELF.Diff_FILING_TYPE := le.FILING_TYPE <> ri.FILING_TYPE;
    SELF.Diff_BUSINESS_NAME := le.BUSINESS_NAME <> ri.BUSINESS_NAME;
    SELF.Diff_BUSINESS_TYPE := le.BUSINESS_TYPE <> ri.BUSINESS_TYPE;
    SELF.Diff_ORIG_FILED_DATE := le.ORIG_FILED_DATE <> ri.ORIG_FILED_DATE;
    SELF.Diff_ORIG_FBN_NUM := le.ORIG_FBN_NUM <> ri.ORIG_FBN_NUM;
    SELF.Diff_RECORD_CODE1 := le.RECORD_CODE1 <> ri.RECORD_CODE1;
    SELF.Diff_FBN_NUM := le.FBN_NUM <> ri.FBN_NUM;
    SELF.Diff_BUSINESS_ADDR1 := le.BUSINESS_ADDR1 <> ri.BUSINESS_ADDR1;
    SELF.Diff_RECORD_CODE2 := le.RECORD_CODE2 <> ri.RECORD_CODE2;
    SELF.Diff_BUSINESS_ADDR2 := le.BUSINESS_ADDR2 <> ri.BUSINESS_ADDR2;
    SELF.Diff_RECORD_CODE3 := le.RECORD_CODE3 <> ri.RECORD_CODE3;
    SELF.Diff_BUS_CITY := le.BUS_CITY <> ri.BUS_CITY;
    SELF.Diff_BUS_ST := le.BUS_ST <> ri.BUS_ST;
    SELF.Diff_BUS_ZIP := le.BUS_ZIP <> ri.BUS_ZIP;
    SELF.Diff_RECORD_CODE4 := le.RECORD_CODE4 <> ri.RECORD_CODE4;
    SELF.Diff_ADDTL_BUSINESS := le.ADDTL_BUSINESS <> ri.ADDTL_BUSINESS;
    SELF.Diff_RECORD_CODE5 := le.RECORD_CODE5 <> ri.RECORD_CODE5;
    SELF.Diff_owner_name := le.owner_name <> ri.owner_name;
    SELF.Diff_OWNER_TYPE := le.OWNER_TYPE <> ri.OWNER_TYPE;
    SELF.Diff_RECORD_CODE6 := le.RECORD_CODE6 <> ri.RECORD_CODE6;
    SELF.Diff_OWNER_ADDR1 := le.OWNER_ADDR1 <> ri.OWNER_ADDR1;
    SELF.Diff_OWNER_CITY := le.OWNER_CITY <> ri.OWNER_CITY;
    SELF.Diff_OWNER_ST := le.OWNER_ST <> ri.OWNER_ST;
    SELF.Diff_OWNER_ZIP := le.OWNER_ZIP <> ri.OWNER_ZIP;
    SELF.Diff_Owner_title := le.Owner_title <> ri.Owner_title;
    SELF.Diff_Owner_fname := le.Owner_fname <> ri.Owner_fname;
    SELF.Diff_Owner_mname := le.Owner_mname <> ri.Owner_mname;
    SELF.Diff_Owner_lname := le.Owner_lname <> ri.Owner_lname;
    SELF.Diff_Owner_name_suffix := le.Owner_name_suffix <> ri.Owner_name_suffix;
    SELF.Diff_Owner_name_score := le.Owner_name_score <> ri.Owner_name_score;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_line_last := le.prep_addr_line_last <> ri.prep_addr_line_last;
    SELF.Diff_prep_owner_addr_line1 := le.prep_owner_addr_line1 <> ri.prep_owner_addr_line1;
    SELF.Diff_prep_owner_addr_line_last := le.prep_owner_addr_line_last <> ri.prep_owner_addr_line_last;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_FIlED_DATE,1,0)+ IF( SELF.Diff_FBN_TYPE,1,0)+ IF( SELF.Diff_FILING_TYPE,1,0)+ IF( SELF.Diff_BUSINESS_NAME,1,0)+ IF( SELF.Diff_BUSINESS_TYPE,1,0)+ IF( SELF.Diff_ORIG_FILED_DATE,1,0)+ IF( SELF.Diff_ORIG_FBN_NUM,1,0)+ IF( SELF.Diff_RECORD_CODE1,1,0)+ IF( SELF.Diff_FBN_NUM,1,0)+ IF( SELF.Diff_BUSINESS_ADDR1,1,0)+ IF( SELF.Diff_RECORD_CODE2,1,0)+ IF( SELF.Diff_BUSINESS_ADDR2,1,0)+ IF( SELF.Diff_RECORD_CODE3,1,0)+ IF( SELF.Diff_BUS_CITY,1,0)+ IF( SELF.Diff_BUS_ST,1,0)+ IF( SELF.Diff_BUS_ZIP,1,0)+ IF( SELF.Diff_RECORD_CODE4,1,0)+ IF( SELF.Diff_ADDTL_BUSINESS,1,0)+ IF( SELF.Diff_RECORD_CODE5,1,0)+ IF( SELF.Diff_owner_name,1,0)+ IF( SELF.Diff_OWNER_TYPE,1,0)+ IF( SELF.Diff_RECORD_CODE6,1,0)+ IF( SELF.Diff_OWNER_ADDR1,1,0)+ IF( SELF.Diff_OWNER_CITY,1,0)+ IF( SELF.Diff_OWNER_ST,1,0)+ IF( SELF.Diff_OWNER_ZIP,1,0)+ IF( SELF.Diff_Owner_title,1,0)+ IF( SELF.Diff_Owner_fname,1,0)+ IF( SELF.Diff_Owner_mname,1,0)+ IF( SELF.Diff_Owner_lname,1,0)+ IF( SELF.Diff_Owner_name_suffix,1,0)+ IF( SELF.Diff_Owner_name_score,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_line_last,1,0)+ IF( SELF.Diff_prep_owner_addr_line1,1,0)+ IF( SELF.Diff_prep_owner_addr_line_last,1,0);
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
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_FIlED_DATE := COUNT(GROUP,%Closest%.Diff_FIlED_DATE);
    Count_Diff_FBN_TYPE := COUNT(GROUP,%Closest%.Diff_FBN_TYPE);
    Count_Diff_FILING_TYPE := COUNT(GROUP,%Closest%.Diff_FILING_TYPE);
    Count_Diff_BUSINESS_NAME := COUNT(GROUP,%Closest%.Diff_BUSINESS_NAME);
    Count_Diff_BUSINESS_TYPE := COUNT(GROUP,%Closest%.Diff_BUSINESS_TYPE);
    Count_Diff_ORIG_FILED_DATE := COUNT(GROUP,%Closest%.Diff_ORIG_FILED_DATE);
    Count_Diff_ORIG_FBN_NUM := COUNT(GROUP,%Closest%.Diff_ORIG_FBN_NUM);
    Count_Diff_RECORD_CODE1 := COUNT(GROUP,%Closest%.Diff_RECORD_CODE1);
    Count_Diff_FBN_NUM := COUNT(GROUP,%Closest%.Diff_FBN_NUM);
    Count_Diff_BUSINESS_ADDR1 := COUNT(GROUP,%Closest%.Diff_BUSINESS_ADDR1);
    Count_Diff_RECORD_CODE2 := COUNT(GROUP,%Closest%.Diff_RECORD_CODE2);
    Count_Diff_BUSINESS_ADDR2 := COUNT(GROUP,%Closest%.Diff_BUSINESS_ADDR2);
    Count_Diff_RECORD_CODE3 := COUNT(GROUP,%Closest%.Diff_RECORD_CODE3);
    Count_Diff_BUS_CITY := COUNT(GROUP,%Closest%.Diff_BUS_CITY);
    Count_Diff_BUS_ST := COUNT(GROUP,%Closest%.Diff_BUS_ST);
    Count_Diff_BUS_ZIP := COUNT(GROUP,%Closest%.Diff_BUS_ZIP);
    Count_Diff_RECORD_CODE4 := COUNT(GROUP,%Closest%.Diff_RECORD_CODE4);
    Count_Diff_ADDTL_BUSINESS := COUNT(GROUP,%Closest%.Diff_ADDTL_BUSINESS);
    Count_Diff_RECORD_CODE5 := COUNT(GROUP,%Closest%.Diff_RECORD_CODE5);
    Count_Diff_owner_name := COUNT(GROUP,%Closest%.Diff_owner_name);
    Count_Diff_OWNER_TYPE := COUNT(GROUP,%Closest%.Diff_OWNER_TYPE);
    Count_Diff_RECORD_CODE6 := COUNT(GROUP,%Closest%.Diff_RECORD_CODE6);
    Count_Diff_OWNER_ADDR1 := COUNT(GROUP,%Closest%.Diff_OWNER_ADDR1);
    Count_Diff_OWNER_CITY := COUNT(GROUP,%Closest%.Diff_OWNER_CITY);
    Count_Diff_OWNER_ST := COUNT(GROUP,%Closest%.Diff_OWNER_ST);
    Count_Diff_OWNER_ZIP := COUNT(GROUP,%Closest%.Diff_OWNER_ZIP);
    Count_Diff_Owner_title := COUNT(GROUP,%Closest%.Diff_Owner_title);
    Count_Diff_Owner_fname := COUNT(GROUP,%Closest%.Diff_Owner_fname);
    Count_Diff_Owner_mname := COUNT(GROUP,%Closest%.Diff_Owner_mname);
    Count_Diff_Owner_lname := COUNT(GROUP,%Closest%.Diff_Owner_lname);
    Count_Diff_Owner_name_suffix := COUNT(GROUP,%Closest%.Diff_Owner_name_suffix);
    Count_Diff_Owner_name_score := COUNT(GROUP,%Closest%.Diff_Owner_name_score);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_addr_line_last);
    Count_Diff_prep_owner_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line1);
    Count_Diff_prep_owner_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_owner_addr_line_last);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
