IMPORT SALT38;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 29;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_date','invalid_corp_key','invalid_charter','invalid_corp_vendor','invalid_state_origin','invalid_reference_nbr');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_date' => 1,'invalid_corp_key' => 2,'invalid_charter' => 3,'invalid_corp_vendor' => 4,'invalid_state_origin' => 5,'invalid_reference_nbr' => 6,0);
 
EXPORT MakeFT_invalid_date(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT38.HygieneErrors.NotLength('0..8'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_key(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_key(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))),~(LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT38.HygieneErrors.NotLength('4..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_charter(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_charter(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_charter(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_vendor(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_vendor(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['13']);
EXPORT InValidMessageFT_invalid_corp_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('13'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_origin(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_origin(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN  ['GA']);
EXPORT InValidMessageFT_invalid_state_origin(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('GA'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_reference_nbr(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_reference_nbr(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '))));
EXPORT InValidMessageFT_invalid_reference_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'corp_key','corp_supp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','event_filing_reference_nbr','event_amendment_nbr','event_filing_date','event_date_type_cd','event_date_type_desc','event_filing_cd','event_filing_desc','event_corp_nbr','event_corp_nbr_cd','event_corp_nbr_desc','event_roll','event_frame','event_start','event_end','event_microfilm_nbr','event_desc','event_revocation_comment1','event_revocation_comment2','event_book_nbr','event_page_nbr','event_certification_nbr');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'corp_key','corp_supp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','event_filing_reference_nbr','event_amendment_nbr','event_filing_date','event_date_type_cd','event_date_type_desc','event_filing_cd','event_filing_desc','event_corp_nbr','event_corp_nbr_cd','event_corp_nbr_desc','event_roll','event_frame','event_start','event_end','event_microfilm_nbr','event_desc','event_revocation_comment1','event_revocation_comment2','event_book_nbr','event_page_nbr','event_certification_nbr');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'corp_key' => 0,'corp_supp_key' => 1,'corp_vendor' => 2,'corp_vendor_county' => 3,'corp_vendor_subcode' => 4,'corp_state_origin' => 5,'corp_process_date' => 6,'corp_sos_charter_nbr' => 7,'event_filing_reference_nbr' => 8,'event_amendment_nbr' => 9,'event_filing_date' => 10,'event_date_type_cd' => 11,'event_date_type_desc' => 12,'event_filing_cd' => 13,'event_filing_desc' => 14,'event_corp_nbr' => 15,'event_corp_nbr_cd' => 16,'event_corp_nbr_desc' => 17,'event_roll' => 18,'event_frame' => 19,'event_start' => 20,'event_end' => 21,'event_microfilm_nbr' => 22,'event_desc' => 23,'event_revocation_comment1' => 24,'event_revocation_comment2' => 25,'event_book_nbr' => 26,'event_page_nbr' => 27,'event_certification_nbr' => 28,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTH'],[],['ENUM'],[],[],['ENUM'],['ALLOW','CUSTOM','LENGTH'],['ALLOW','LENGTH'],['ALLOW'],[],['ALLOW','CUSTOM','LENGTH'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_corp_key(SALT38.StrType s0) := MakeFT_invalid_corp_key(s0);
EXPORT InValid_corp_key(SALT38.StrType s) := InValidFT_invalid_corp_key(s);
EXPORT InValidMessage_corp_key(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_key(wh);
 
EXPORT Make_corp_supp_key(SALT38.StrType s0) := s0;
EXPORT InValid_corp_supp_key(SALT38.StrType s) := 0;
EXPORT InValidMessage_corp_supp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_vendor(SALT38.StrType s0) := MakeFT_invalid_corp_vendor(s0);
EXPORT InValid_corp_vendor(SALT38.StrType s) := InValidFT_invalid_corp_vendor(s);
EXPORT InValidMessage_corp_vendor(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_vendor(wh);
 
EXPORT Make_corp_vendor_county(SALT38.StrType s0) := s0;
EXPORT InValid_corp_vendor_county(SALT38.StrType s) := 0;
EXPORT InValidMessage_corp_vendor_county(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_vendor_subcode(SALT38.StrType s0) := s0;
EXPORT InValid_corp_vendor_subcode(SALT38.StrType s) := 0;
EXPORT InValidMessage_corp_vendor_subcode(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_state_origin(SALT38.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_state_origin(SALT38.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_process_date(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_process_date(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_sos_charter_nbr(SALT38.StrType s0) := MakeFT_invalid_charter(s0);
EXPORT InValid_corp_sos_charter_nbr(SALT38.StrType s) := InValidFT_invalid_charter(s);
EXPORT InValidMessage_corp_sos_charter_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_charter(wh);
 
EXPORT Make_event_filing_reference_nbr(SALT38.StrType s0) := MakeFT_invalid_reference_nbr(s0);
EXPORT InValid_event_filing_reference_nbr(SALT38.StrType s) := InValidFT_invalid_reference_nbr(s);
EXPORT InValidMessage_event_filing_reference_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_reference_nbr(wh);
 
EXPORT Make_event_amendment_nbr(SALT38.StrType s0) := s0;
EXPORT InValid_event_amendment_nbr(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_amendment_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_event_filing_date(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_event_filing_date(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_event_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_event_date_type_cd(SALT38.StrType s0) := s0;
EXPORT InValid_event_date_type_cd(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_date_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_event_date_type_desc(SALT38.StrType s0) := s0;
EXPORT InValid_event_date_type_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_date_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_event_filing_cd(SALT38.StrType s0) := s0;
EXPORT InValid_event_filing_cd(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_filing_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_event_filing_desc(SALT38.StrType s0) := s0;
EXPORT InValid_event_filing_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_filing_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_event_corp_nbr(SALT38.StrType s0) := s0;
EXPORT InValid_event_corp_nbr(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_corp_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_event_corp_nbr_cd(SALT38.StrType s0) := s0;
EXPORT InValid_event_corp_nbr_cd(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_corp_nbr_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_event_corp_nbr_desc(SALT38.StrType s0) := s0;
EXPORT InValid_event_corp_nbr_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_corp_nbr_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_event_roll(SALT38.StrType s0) := s0;
EXPORT InValid_event_roll(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_roll(UNSIGNED1 wh) := '';
 
EXPORT Make_event_frame(SALT38.StrType s0) := s0;
EXPORT InValid_event_frame(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_frame(UNSIGNED1 wh) := '';
 
EXPORT Make_event_start(SALT38.StrType s0) := s0;
EXPORT InValid_event_start(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_start(UNSIGNED1 wh) := '';
 
EXPORT Make_event_end(SALT38.StrType s0) := s0;
EXPORT InValid_event_end(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_end(UNSIGNED1 wh) := '';
 
EXPORT Make_event_microfilm_nbr(SALT38.StrType s0) := s0;
EXPORT InValid_event_microfilm_nbr(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_microfilm_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_event_desc(SALT38.StrType s0) := s0;
EXPORT InValid_event_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_event_revocation_comment1(SALT38.StrType s0) := s0;
EXPORT InValid_event_revocation_comment1(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_revocation_comment1(UNSIGNED1 wh) := '';
 
EXPORT Make_event_revocation_comment2(SALT38.StrType s0) := s0;
EXPORT InValid_event_revocation_comment2(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_revocation_comment2(UNSIGNED1 wh) := '';
 
EXPORT Make_event_book_nbr(SALT38.StrType s0) := s0;
EXPORT InValid_event_book_nbr(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_book_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_event_page_nbr(SALT38.StrType s0) := s0;
EXPORT InValid_event_page_nbr(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_page_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_event_certification_nbr(SALT38.StrType s0) := s0;
EXPORT InValid_event_certification_nbr(SALT38.StrType s) := 0;
EXPORT InValidMessage_event_certification_nbr(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_Corp2_Mapping_GA_Event;
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
    BOOLEAN Diff_corp_key;
    BOOLEAN Diff_corp_supp_key;
    BOOLEAN Diff_corp_vendor;
    BOOLEAN Diff_corp_vendor_county;
    BOOLEAN Diff_corp_vendor_subcode;
    BOOLEAN Diff_corp_state_origin;
    BOOLEAN Diff_corp_process_date;
    BOOLEAN Diff_corp_sos_charter_nbr;
    BOOLEAN Diff_event_filing_reference_nbr;
    BOOLEAN Diff_event_amendment_nbr;
    BOOLEAN Diff_event_filing_date;
    BOOLEAN Diff_event_date_type_cd;
    BOOLEAN Diff_event_date_type_desc;
    BOOLEAN Diff_event_filing_cd;
    BOOLEAN Diff_event_filing_desc;
    BOOLEAN Diff_event_corp_nbr;
    BOOLEAN Diff_event_corp_nbr_cd;
    BOOLEAN Diff_event_corp_nbr_desc;
    BOOLEAN Diff_event_roll;
    BOOLEAN Diff_event_frame;
    BOOLEAN Diff_event_start;
    BOOLEAN Diff_event_end;
    BOOLEAN Diff_event_microfilm_nbr;
    BOOLEAN Diff_event_desc;
    BOOLEAN Diff_event_revocation_comment1;
    BOOLEAN Diff_event_revocation_comment2;
    BOOLEAN Diff_event_book_nbr;
    BOOLEAN Diff_event_page_nbr;
    BOOLEAN Diff_event_certification_nbr;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_corp_key := le.corp_key <> ri.corp_key;
    SELF.Diff_corp_supp_key := le.corp_supp_key <> ri.corp_supp_key;
    SELF.Diff_corp_vendor := le.corp_vendor <> ri.corp_vendor;
    SELF.Diff_corp_vendor_county := le.corp_vendor_county <> ri.corp_vendor_county;
    SELF.Diff_corp_vendor_subcode := le.corp_vendor_subcode <> ri.corp_vendor_subcode;
    SELF.Diff_corp_state_origin := le.corp_state_origin <> ri.corp_state_origin;
    SELF.Diff_corp_process_date := le.corp_process_date <> ri.corp_process_date;
    SELF.Diff_corp_sos_charter_nbr := le.corp_sos_charter_nbr <> ri.corp_sos_charter_nbr;
    SELF.Diff_event_filing_reference_nbr := le.event_filing_reference_nbr <> ri.event_filing_reference_nbr;
    SELF.Diff_event_amendment_nbr := le.event_amendment_nbr <> ri.event_amendment_nbr;
    SELF.Diff_event_filing_date := le.event_filing_date <> ri.event_filing_date;
    SELF.Diff_event_date_type_cd := le.event_date_type_cd <> ri.event_date_type_cd;
    SELF.Diff_event_date_type_desc := le.event_date_type_desc <> ri.event_date_type_desc;
    SELF.Diff_event_filing_cd := le.event_filing_cd <> ri.event_filing_cd;
    SELF.Diff_event_filing_desc := le.event_filing_desc <> ri.event_filing_desc;
    SELF.Diff_event_corp_nbr := le.event_corp_nbr <> ri.event_corp_nbr;
    SELF.Diff_event_corp_nbr_cd := le.event_corp_nbr_cd <> ri.event_corp_nbr_cd;
    SELF.Diff_event_corp_nbr_desc := le.event_corp_nbr_desc <> ri.event_corp_nbr_desc;
    SELF.Diff_event_roll := le.event_roll <> ri.event_roll;
    SELF.Diff_event_frame := le.event_frame <> ri.event_frame;
    SELF.Diff_event_start := le.event_start <> ri.event_start;
    SELF.Diff_event_end := le.event_end <> ri.event_end;
    SELF.Diff_event_microfilm_nbr := le.event_microfilm_nbr <> ri.event_microfilm_nbr;
    SELF.Diff_event_desc := le.event_desc <> ri.event_desc;
    SELF.Diff_event_revocation_comment1 := le.event_revocation_comment1 <> ri.event_revocation_comment1;
    SELF.Diff_event_revocation_comment2 := le.event_revocation_comment2 <> ri.event_revocation_comment2;
    SELF.Diff_event_book_nbr := le.event_book_nbr <> ri.event_book_nbr;
    SELF.Diff_event_page_nbr := le.event_page_nbr <> ri.event_page_nbr;
    SELF.Diff_event_certification_nbr := le.event_certification_nbr <> ri.event_certification_nbr;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_supp_key,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_vendor_county,1,0)+ IF( SELF.Diff_corp_vendor_subcode,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_sos_charter_nbr,1,0)+ IF( SELF.Diff_event_filing_reference_nbr,1,0)+ IF( SELF.Diff_event_amendment_nbr,1,0)+ IF( SELF.Diff_event_filing_date,1,0)+ IF( SELF.Diff_event_date_type_cd,1,0)+ IF( SELF.Diff_event_date_type_desc,1,0)+ IF( SELF.Diff_event_filing_cd,1,0)+ IF( SELF.Diff_event_filing_desc,1,0)+ IF( SELF.Diff_event_corp_nbr,1,0)+ IF( SELF.Diff_event_corp_nbr_cd,1,0)+ IF( SELF.Diff_event_corp_nbr_desc,1,0)+ IF( SELF.Diff_event_roll,1,0)+ IF( SELF.Diff_event_frame,1,0)+ IF( SELF.Diff_event_start,1,0)+ IF( SELF.Diff_event_end,1,0)+ IF( SELF.Diff_event_microfilm_nbr,1,0)+ IF( SELF.Diff_event_desc,1,0)+ IF( SELF.Diff_event_revocation_comment1,1,0)+ IF( SELF.Diff_event_revocation_comment2,1,0)+ IF( SELF.Diff_event_book_nbr,1,0)+ IF( SELF.Diff_event_page_nbr,1,0)+ IF( SELF.Diff_event_certification_nbr,1,0);
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
    Count_Diff_corp_key := COUNT(GROUP,%Closest%.Diff_corp_key);
    Count_Diff_corp_supp_key := COUNT(GROUP,%Closest%.Diff_corp_supp_key);
    Count_Diff_corp_vendor := COUNT(GROUP,%Closest%.Diff_corp_vendor);
    Count_Diff_corp_vendor_county := COUNT(GROUP,%Closest%.Diff_corp_vendor_county);
    Count_Diff_corp_vendor_subcode := COUNT(GROUP,%Closest%.Diff_corp_vendor_subcode);
    Count_Diff_corp_state_origin := COUNT(GROUP,%Closest%.Diff_corp_state_origin);
    Count_Diff_corp_process_date := COUNT(GROUP,%Closest%.Diff_corp_process_date);
    Count_Diff_corp_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_sos_charter_nbr);
    Count_Diff_event_filing_reference_nbr := COUNT(GROUP,%Closest%.Diff_event_filing_reference_nbr);
    Count_Diff_event_amendment_nbr := COUNT(GROUP,%Closest%.Diff_event_amendment_nbr);
    Count_Diff_event_filing_date := COUNT(GROUP,%Closest%.Diff_event_filing_date);
    Count_Diff_event_date_type_cd := COUNT(GROUP,%Closest%.Diff_event_date_type_cd);
    Count_Diff_event_date_type_desc := COUNT(GROUP,%Closest%.Diff_event_date_type_desc);
    Count_Diff_event_filing_cd := COUNT(GROUP,%Closest%.Diff_event_filing_cd);
    Count_Diff_event_filing_desc := COUNT(GROUP,%Closest%.Diff_event_filing_desc);
    Count_Diff_event_corp_nbr := COUNT(GROUP,%Closest%.Diff_event_corp_nbr);
    Count_Diff_event_corp_nbr_cd := COUNT(GROUP,%Closest%.Diff_event_corp_nbr_cd);
    Count_Diff_event_corp_nbr_desc := COUNT(GROUP,%Closest%.Diff_event_corp_nbr_desc);
    Count_Diff_event_roll := COUNT(GROUP,%Closest%.Diff_event_roll);
    Count_Diff_event_frame := COUNT(GROUP,%Closest%.Diff_event_frame);
    Count_Diff_event_start := COUNT(GROUP,%Closest%.Diff_event_start);
    Count_Diff_event_end := COUNT(GROUP,%Closest%.Diff_event_end);
    Count_Diff_event_microfilm_nbr := COUNT(GROUP,%Closest%.Diff_event_microfilm_nbr);
    Count_Diff_event_desc := COUNT(GROUP,%Closest%.Diff_event_desc);
    Count_Diff_event_revocation_comment1 := COUNT(GROUP,%Closest%.Diff_event_revocation_comment1);
    Count_Diff_event_revocation_comment2 := COUNT(GROUP,%Closest%.Diff_event_revocation_comment2);
    Count_Diff_event_book_nbr := COUNT(GROUP,%Closest%.Diff_event_book_nbr);
    Count_Diff_event_page_nbr := COUNT(GROUP,%Closest%.Diff_event_page_nbr);
    Count_Diff_event_certification_nbr := COUNT(GROUP,%Closest%.Diff_event_certification_nbr);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
