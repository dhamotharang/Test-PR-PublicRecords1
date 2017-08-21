IMPORT ut,SALT34;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'WORDBAG');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'WORDBAG' => 1,0);
EXPORT MakeFT_WORDBAG(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringtouppercase(s0); // Force to upper case
  s2 := SALT34.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_WORDBAG(SALT34.StrType s) := WHICH(SALT34.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotCaps,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT34.HygieneErrors.Good);
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'recording_date','SourceType','did','apnt_or_pin_number','recorder_book_number','primname','zip','sales_price','first_td_loan_amount','primrange','secrange','contract_date','document_number','recorder_page_number','prim_range_alpha','sec_range_alpha','name','prim_name_num','prim_name_alpha','sec_range_num','fips_code','county_name','lender_name','prim_range_num','city','st','ln_fares_id','prim_range','prim_name','sec_range','document_type_code','locale','address');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'recording_date' => 0,'SourceType' => 1,'did' => 2,'apnt_or_pin_number' => 3,'recorder_book_number' => 4,'primname' => 5,'zip' => 6,'sales_price' => 7,'first_td_loan_amount' => 8,'primrange' => 9,'secrange' => 10,'contract_date' => 11,'document_number' => 12,'recorder_page_number' => 13,'prim_range_alpha' => 14,'sec_range_alpha' => 15,'name' => 16,'prim_name_num' => 17,'prim_name_alpha' => 18,'sec_range_num' => 19,'fips_code' => 20,'county_name' => 21,'lender_name' => 22,'prim_range_num' => 23,'city' => 24,'st' => 25,'ln_fares_id' => 26,'prim_range' => 27,'prim_name' => 28,'sec_range' => 29,'document_type_code' => 30,'locale' => 31,'address' => 32,0);
//Individual field level validation
EXPORT Make_recording_date(SALT34.StrType s0) := s0;
EXPORT InValid_recording_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_recording_date(UNSIGNED1 wh) := '';
EXPORT Make_SourceType(SALT34.StrType s0) := s0;
EXPORT InValid_SourceType(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_SourceType(UNSIGNED1 wh) := '';
EXPORT Make_did(SALT34.StrType s0) := s0;
EXPORT InValid_did(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
EXPORT Make_apnt_or_pin_number(SALT34.StrType s0) := s0;
EXPORT InValid_apnt_or_pin_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_apnt_or_pin_number(UNSIGNED1 wh) := '';
EXPORT Make_recorder_book_number(SALT34.StrType s0) := s0;
EXPORT InValid_recorder_book_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_recorder_book_number(UNSIGNED1 wh) := '';
EXPORT Make_primname(SALT34.StrType s0) := s0;
EXPORT InValid_primname(SALT34.StrType prim_name_alpha,SALT34.StrType prim_name_num) := FALSE;
EXPORT InValidMessage_primname(UNSIGNED1 wh) := '';
EXPORT Make_zip(SALT34.StrType s0) := s0;
EXPORT InValid_zip(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
EXPORT Make_sales_price(SALT34.StrType s0) := s0;
EXPORT InValid_sales_price(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sales_price(UNSIGNED1 wh) := '';
EXPORT Make_first_td_loan_amount(SALT34.StrType s0) := s0;
EXPORT InValid_first_td_loan_amount(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_first_td_loan_amount(UNSIGNED1 wh) := '';
EXPORT Make_primrange(SALT34.StrType s0) := s0;
EXPORT InValid_primrange(SALT34.StrType prim_range_alpha,SALT34.StrType prim_range_num) := FALSE;
EXPORT InValidMessage_primrange(UNSIGNED1 wh) := '';
EXPORT Make_secrange(SALT34.StrType s0) := s0;
EXPORT InValid_secrange(SALT34.StrType sec_range_alpha,SALT34.StrType sec_range_num) := FALSE;
EXPORT InValidMessage_secrange(UNSIGNED1 wh) := '';
EXPORT Make_contract_date(SALT34.StrType s0) := s0;
EXPORT InValid_contract_date(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_contract_date(UNSIGNED1 wh) := '';
EXPORT Make_document_number(SALT34.StrType s0) := s0;
EXPORT InValid_document_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_document_number(UNSIGNED1 wh) := '';
EXPORT Make_recorder_page_number(SALT34.StrType s0) := s0;
EXPORT InValid_recorder_page_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_recorder_page_number(UNSIGNED1 wh) := '';
EXPORT Make_prim_range_alpha(SALT34.StrType s0) := s0;
EXPORT InValid_prim_range_alpha(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_prim_range_alpha(UNSIGNED1 wh) := '';
EXPORT Make_sec_range_alpha(SALT34.StrType s0) := s0;
EXPORT InValid_sec_range_alpha(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sec_range_alpha(UNSIGNED1 wh) := '';
EXPORT Make_name(SALT34.StrType s0) := s0;
EXPORT InValid_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_name(UNSIGNED1 wh) := '';
EXPORT Make_prim_name_num(SALT34.StrType s0) := s0;
EXPORT InValid_prim_name_num(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_prim_name_num(UNSIGNED1 wh) := '';
EXPORT Make_prim_name_alpha(SALT34.StrType s0) := s0;
EXPORT InValid_prim_name_alpha(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_prim_name_alpha(UNSIGNED1 wh) := '';
EXPORT Make_sec_range_num(SALT34.StrType s0) := s0;
EXPORT InValid_sec_range_num(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sec_range_num(UNSIGNED1 wh) := '';
EXPORT Make_fips_code(SALT34.StrType s0) := s0;
EXPORT InValid_fips_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_fips_code(UNSIGNED1 wh) := '';
EXPORT Make_county_name(SALT34.StrType s0) := s0;
EXPORT InValid_county_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_county_name(UNSIGNED1 wh) := '';
EXPORT Make_lender_name(SALT34.StrType s0) := s0;
EXPORT InValid_lender_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_lender_name(UNSIGNED1 wh) := '';
EXPORT Make_prim_range_num(SALT34.StrType s0) := s0;
EXPORT InValid_prim_range_num(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_prim_range_num(UNSIGNED1 wh) := '';
EXPORT Make_city(SALT34.StrType s0) := s0;
EXPORT InValid_city(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
EXPORT Make_st(SALT34.StrType s0) := s0;
EXPORT InValid_st(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
EXPORT Make_ln_fares_id(SALT34.StrType s0) := s0;
EXPORT InValid_ln_fares_id(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ln_fares_id(UNSIGNED1 wh) := '';
EXPORT Make_prim_range(SALT34.StrType s0) := s0;
EXPORT InValid_prim_range(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
EXPORT Make_prim_name(SALT34.StrType s0) := s0;
EXPORT InValid_prim_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
EXPORT Make_sec_range(SALT34.StrType s0) := s0;
EXPORT InValid_sec_range(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
EXPORT Make_document_type_code(SALT34.StrType s0) := s0;
EXPORT InValid_document_type_code(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_document_type_code(UNSIGNED1 wh) := '';
EXPORT Make_locale(SALT34.StrType s0) := s0;
EXPORT InValid_locale(SALT34.StrType city,SALT34.StrType st,SALT34.StrType zip) := FALSE;
EXPORT InValidMessage_locale(UNSIGNED1 wh) := '';
EXPORT Make_address(SALT34.StrType s0) := s0;
EXPORT InValid_address(SALT34.StrType primrange,SALT34.StrType primname,SALT34.StrType secrange,SALT34.StrType locale) := FALSE;
EXPORT InValidMessage_address(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,InsuranceHeader_Property_Transactions_DeedsMortgages;
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
    BOOLEAN Diff_recording_date;
    BOOLEAN Diff_SourceType;
    BOOLEAN Diff_did;
    BOOLEAN Diff_apnt_or_pin_number;
    BOOLEAN Diff_recorder_book_number;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_sales_price;
    BOOLEAN Diff_first_td_loan_amount;
    BOOLEAN Diff_contract_date;
    BOOLEAN Diff_document_number;
    BOOLEAN Diff_recorder_page_number;
    BOOLEAN Diff_prim_range_alpha;
    BOOLEAN Diff_sec_range_alpha;
    BOOLEAN Diff_name;
    BOOLEAN Diff_prim_name_num;
    BOOLEAN Diff_prim_name_alpha;
    BOOLEAN Diff_sec_range_num;
    BOOLEAN Diff_fips_code;
    BOOLEAN Diff_county_name;
    BOOLEAN Diff_lender_name;
    BOOLEAN Diff_prim_range_num;
    BOOLEAN Diff_city;
    BOOLEAN Diff_st;
    BOOLEAN Diff_ln_fares_id;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_document_type_code;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_recording_date := le.recording_date <> ri.recording_date;
    SELF.Diff_SourceType := le.SourceType <> ri.SourceType;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_apnt_or_pin_number := le.apnt_or_pin_number <> ri.apnt_or_pin_number;
    SELF.Diff_recorder_book_number := le.recorder_book_number <> ri.recorder_book_number;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_sales_price := le.sales_price <> ri.sales_price;
    SELF.Diff_first_td_loan_amount := le.first_td_loan_amount <> ri.first_td_loan_amount;
    SELF.Diff_contract_date := le.contract_date <> ri.contract_date;
    SELF.Diff_document_number := le.document_number <> ri.document_number;
    SELF.Diff_recorder_page_number := le.recorder_page_number <> ri.recorder_page_number;
    SELF.Diff_prim_range_alpha := le.prim_range_alpha <> ri.prim_range_alpha;
    SELF.Diff_sec_range_alpha := le.sec_range_alpha <> ri.sec_range_alpha;
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_prim_name_num := le.prim_name_num <> ri.prim_name_num;
    SELF.Diff_prim_name_alpha := le.prim_name_alpha <> ri.prim_name_alpha;
    SELF.Diff_sec_range_num := le.sec_range_num <> ri.sec_range_num;
    SELF.Diff_fips_code := le.fips_code <> ri.fips_code;
    SELF.Diff_county_name := le.county_name <> ri.county_name;
    SELF.Diff_lender_name := le.lender_name <> ri.lender_name;
    SELF.Diff_prim_range_num := le.prim_range_num <> ri.prim_range_num;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_ln_fares_id := le.ln_fares_id <> ri.ln_fares_id;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_document_type_code := le.document_type_code <> ri.document_type_code;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_recording_date,1,0)+ IF( SELF.Diff_SourceType,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_apnt_or_pin_number,1,0)+ IF( SELF.Diff_recorder_book_number,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_sales_price,1,0)+ IF( SELF.Diff_first_td_loan_amount,1,0)+ IF( SELF.Diff_contract_date,1,0)+ IF( SELF.Diff_document_number,1,0)+ IF( SELF.Diff_recorder_page_number,1,0)+ IF( SELF.Diff_prim_range_alpha,1,0)+ IF( SELF.Diff_sec_range_alpha,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_prim_name_num,1,0)+ IF( SELF.Diff_prim_name_alpha,1,0)+ IF( SELF.Diff_sec_range_num,1,0)+ IF( SELF.Diff_fips_code,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_lender_name,1,0)+ IF( SELF.Diff_prim_range_num,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_ln_fares_id,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_document_type_code,1,0);
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
    Count_Diff_recording_date := COUNT(GROUP,%Closest%.Diff_recording_date);
    Count_Diff_SourceType := COUNT(GROUP,%Closest%.Diff_SourceType);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_apnt_or_pin_number := COUNT(GROUP,%Closest%.Diff_apnt_or_pin_number);
    Count_Diff_recorder_book_number := COUNT(GROUP,%Closest%.Diff_recorder_book_number);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_sales_price := COUNT(GROUP,%Closest%.Diff_sales_price);
    Count_Diff_first_td_loan_amount := COUNT(GROUP,%Closest%.Diff_first_td_loan_amount);
    Count_Diff_contract_date := COUNT(GROUP,%Closest%.Diff_contract_date);
    Count_Diff_document_number := COUNT(GROUP,%Closest%.Diff_document_number);
    Count_Diff_recorder_page_number := COUNT(GROUP,%Closest%.Diff_recorder_page_number);
    Count_Diff_prim_range_alpha := COUNT(GROUP,%Closest%.Diff_prim_range_alpha);
    Count_Diff_sec_range_alpha := COUNT(GROUP,%Closest%.Diff_sec_range_alpha);
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_prim_name_num := COUNT(GROUP,%Closest%.Diff_prim_name_num);
    Count_Diff_prim_name_alpha := COUNT(GROUP,%Closest%.Diff_prim_name_alpha);
    Count_Diff_sec_range_num := COUNT(GROUP,%Closest%.Diff_sec_range_num);
    Count_Diff_fips_code := COUNT(GROUP,%Closest%.Diff_fips_code);
    Count_Diff_county_name := COUNT(GROUP,%Closest%.Diff_county_name);
    Count_Diff_lender_name := COUNT(GROUP,%Closest%.Diff_lender_name);
    Count_Diff_prim_range_num := COUNT(GROUP,%Closest%.Diff_prim_range_num);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_ln_fares_id := COUNT(GROUP,%Closest%.Diff_ln_fares_id);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_document_type_code := COUNT(GROUP,%Closest%.Diff_document_type_code);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{rid,DPROPTXID}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rid_null0 := COUNT(GROUP,(UNSIGNED)f.rid=0);
      UNSIGNED rid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rid<(UNSIGNED)f.DPROPTXID);
      UNSIGNED rid_atparent := COUNT(GROUP,(UNSIGNED)f.DPROPTXID=(UNSIGNED)f.rid);
      UNSIGNED DPROPTXID_null0 := COUNT(GROUP,(UNSIGNED)f.DPROPTXID=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT rid_Clusters := SALT34.MOD_ClusterStats.Counts(f,rid);
  EXPORT DPROPTXID_Clusters := SALT34.MOD_ClusterStats.Counts(f,DPROPTXID);
  EXPORT IdCounts := DATASET([{'rid_Cnt', SUM(rid_Clusters,NumberOfClusters)},{'DPROPTXID_Cnt', SUM(DPROPTXID_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)DPROPTXID=(UNSIGNED)rid); // Get the bases
  EXPORT DPROPTXID_Unbased := JOIN(f(DPROPTXID<>0),bases,LEFT.DPROPTXID=RIGHT.DPROPTXID,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    f_thin := TABLE(f(rid<>0,DPROPTXID<>0),{rid,DPROPTXID},rid,DPROPTXID,MERGE);
  EXPORT rid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rid=RIGHT.rid AND LEFT.DPROPTXID>RIGHT.DPROPTXID,TRANSFORM({SALT34.UIDType DPROPTXID1,SALT34.UIDType rid,SALT34.UIDType DPROPTXID2},SELF.DPROPTXID1:=LEFT.DPROPTXID,SELF.DPROPTXID2:=RIGHT.DPROPTXID,SELF.rid:=LEFT.rid),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rid_atparent];
      INTEGER DPROPTXID_unbased0 := IdCounts[2].Cnt-Basic0.rid_atparent-IF(Basic0.DPROPTXID_null0>0,1,0);
      INTEGER rid_Twoparents0 := COUNT(rid_Twoparents);
    END;
  Advanced00 := TABLE(Basic0,r);
  Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
  EXPORT Advanced0 := SORT(SALT34.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rid'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
