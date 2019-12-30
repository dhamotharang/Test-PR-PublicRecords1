IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 26;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_no','invalid_id','invalid_date','invalid_seqno','invalid_geoid10_blkgrp','invalid_state_fips10','invalid_county_fips10','invalid_tract_fips10','invalid_blkgrp_fips10');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_no' => 1,'invalid_id' => 2,'invalid_date' => 3,'invalid_seqno' => 4,'invalid_geoid10_blkgrp' => 5,'invalid_state_fips10' => 6,'invalid_county_fips10' => 7,'invalid_tract_fips10' => 8,'invalid_blkgrp_fips10' => 9,0);
 
EXPORT MakeFT_invalid_no(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_no(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_no(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_id(SALT311.StrType s0) := FUNCTION
  s1 := TRIM(s0,LEFT); // Left trim
  RETURN  s1;
END;
EXPORT InValidFT_invalid_id(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) >= 1 AND LENGTH(TRIM(s)) <= 5));
EXPORT InValidMessageFT_invalid_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('1..5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  MakeFT_invalid_no(s2);
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_seqno(SALT311.StrType s0) := FUNCTION
  s1 := TRIM(s0,LEFT); // Left trim
  RETURN  s1;
END;
EXPORT InValidFT_invalid_seqno(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) >= 1 AND LENGTH(TRIM(s)) <= 4));
EXPORT InValidMessageFT_invalid_seqno(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('1..4'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geoid10_blkgrp(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  MakeFT_invalid_no(s2);
END;
EXPORT InValidFT_invalid_geoid10_blkgrp(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 12));
EXPORT InValidMessageFT_invalid_geoid10_blkgrp(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('12'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_fips10(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  MakeFT_invalid_no(s2);
END;
EXPORT InValidFT_invalid_state_fips10(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 2));
EXPORT InValidMessageFT_invalid_state_fips10(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('2..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_county_fips10(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  MakeFT_invalid_no(s2);
END;
EXPORT InValidFT_invalid_county_fips10(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 3));
EXPORT InValidMessageFT_invalid_county_fips10(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('3..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_tract_fips10(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  MakeFT_invalid_no(s2);
END;
EXPORT InValidFT_invalid_tract_fips10(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1 AND LENGTH(TRIM(s)) <= 3));
EXPORT InValidMessageFT_invalid_tract_fips10(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('1..3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_blkgrp_fips10(SALT311.StrType s0) := FUNCTION
  s1 := TRIM(s0,LEFT); // Left trim
  RETURN  s1;
END;
EXPORT InValidFT_invalid_blkgrp_fips10(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,~(LENGTH(TRIM(s)) >= 1 AND LENGTH(TRIM(s)) <= 3));
EXPORT InValidMessageFT_invalid_blkgrp_fips10(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotLength('1..3'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'record_sid','global_src_id','dt_vendor_first_reported','dt_vendor_last_reported','is_latest','seqno','geoid10_blkgrp','state_fips10','county_fips10','tract_fips10','blkgrp_fips10','total_pop','hispanic_total','non_hispanic_total','nh_white_alone','nh_black_alone','nh_aian_alone','nh_api_alone','nh_other_alone','nh_mult_total','nh_white_other','nh_black_other','nh_aian_other','nh_asian_hpi','nh_api_other','nh_asian_hpi_other');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'record_sid','global_src_id','dt_vendor_first_reported','dt_vendor_last_reported','is_latest','seqno','geoid10_blkgrp','state_fips10','county_fips10','tract_fips10','blkgrp_fips10','total_pop','hispanic_total','non_hispanic_total','nh_white_alone','nh_black_alone','nh_aian_alone','nh_api_alone','nh_other_alone','nh_mult_total','nh_white_other','nh_black_other','nh_aian_other','nh_asian_hpi','nh_api_other','nh_asian_hpi_other');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'record_sid' => 0,'global_src_id' => 1,'dt_vendor_first_reported' => 2,'dt_vendor_last_reported' => 3,'is_latest' => 4,'seqno' => 5,'geoid10_blkgrp' => 6,'state_fips10' => 7,'county_fips10' => 8,'tract_fips10' => 9,'blkgrp_fips10' => 10,'total_pop' => 11,'hispanic_total' => 12,'non_hispanic_total' => 13,'nh_white_alone' => 14,'nh_black_alone' => 15,'nh_aian_alone' => 16,'nh_api_alone' => 17,'nh_other_alone' => 18,'nh_mult_total' => 19,'nh_white_other' => 20,'nh_black_other' => 21,'nh_aian_other' => 22,'nh_asian_hpi' => 23,'nh_api_other' => 24,'nh_asian_hpi_other' => 25,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LEFTTRIM','LENGTHS'],['LEFTTRIM','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],[],['LEFTTRIM','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','ALLOW','LENGTHS'],['LEFTTRIM','LENGTHS'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_record_sid(SALT311.StrType s0) := MakeFT_invalid_id(s0);
EXPORT InValid_record_sid(SALT311.StrType s) := InValidFT_invalid_id(s);
EXPORT InValidMessage_record_sid(UNSIGNED1 wh) := InValidMessageFT_invalid_id(wh);
 
EXPORT Make_global_src_id(SALT311.StrType s0) := MakeFT_invalid_id(s0);
EXPORT InValid_global_src_id(SALT311.StrType s) := InValidFT_invalid_id(s);
EXPORT InValidMessage_global_src_id(UNSIGNED1 wh) := InValidMessageFT_invalid_id(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_is_latest(SALT311.StrType s0) := s0;
EXPORT InValid_is_latest(SALT311.StrType s) := 0;
EXPORT InValidMessage_is_latest(UNSIGNED1 wh) := '';
 
EXPORT Make_seqno(SALT311.StrType s0) := MakeFT_invalid_seqno(s0);
EXPORT InValid_seqno(SALT311.StrType s) := InValidFT_invalid_seqno(s);
EXPORT InValidMessage_seqno(UNSIGNED1 wh) := InValidMessageFT_invalid_seqno(wh);
 
EXPORT Make_geoid10_blkgrp(SALT311.StrType s0) := MakeFT_invalid_geoid10_blkgrp(s0);
EXPORT InValid_geoid10_blkgrp(SALT311.StrType s) := InValidFT_invalid_geoid10_blkgrp(s);
EXPORT InValidMessage_geoid10_blkgrp(UNSIGNED1 wh) := InValidMessageFT_invalid_geoid10_blkgrp(wh);
 
EXPORT Make_state_fips10(SALT311.StrType s0) := MakeFT_invalid_state_fips10(s0);
EXPORT InValid_state_fips10(SALT311.StrType s) := InValidFT_invalid_state_fips10(s);
EXPORT InValidMessage_state_fips10(UNSIGNED1 wh) := InValidMessageFT_invalid_state_fips10(wh);
 
EXPORT Make_county_fips10(SALT311.StrType s0) := MakeFT_invalid_county_fips10(s0);
EXPORT InValid_county_fips10(SALT311.StrType s) := InValidFT_invalid_county_fips10(s);
EXPORT InValidMessage_county_fips10(UNSIGNED1 wh) := InValidMessageFT_invalid_county_fips10(wh);
 
EXPORT Make_tract_fips10(SALT311.StrType s0) := MakeFT_invalid_tract_fips10(s0);
EXPORT InValid_tract_fips10(SALT311.StrType s) := InValidFT_invalid_tract_fips10(s);
EXPORT InValidMessage_tract_fips10(UNSIGNED1 wh) := InValidMessageFT_invalid_tract_fips10(wh);
 
EXPORT Make_blkgrp_fips10(SALT311.StrType s0) := MakeFT_invalid_blkgrp_fips10(s0);
EXPORT InValid_blkgrp_fips10(SALT311.StrType s) := InValidFT_invalid_blkgrp_fips10(s);
EXPORT InValidMessage_blkgrp_fips10(UNSIGNED1 wh) := InValidMessageFT_invalid_blkgrp_fips10(wh);
 
EXPORT Make_total_pop(SALT311.StrType s0) := s0;
EXPORT InValid_total_pop(SALT311.StrType s) := 0;
EXPORT InValidMessage_total_pop(UNSIGNED1 wh) := '';
 
EXPORT Make_hispanic_total(SALT311.StrType s0) := s0;
EXPORT InValid_hispanic_total(SALT311.StrType s) := 0;
EXPORT InValidMessage_hispanic_total(UNSIGNED1 wh) := '';
 
EXPORT Make_non_hispanic_total(SALT311.StrType s0) := s0;
EXPORT InValid_non_hispanic_total(SALT311.StrType s) := 0;
EXPORT InValidMessage_non_hispanic_total(UNSIGNED1 wh) := '';
 
EXPORT Make_nh_white_alone(SALT311.StrType s0) := s0;
EXPORT InValid_nh_white_alone(SALT311.StrType s) := 0;
EXPORT InValidMessage_nh_white_alone(UNSIGNED1 wh) := '';
 
EXPORT Make_nh_black_alone(SALT311.StrType s0) := s0;
EXPORT InValid_nh_black_alone(SALT311.StrType s) := 0;
EXPORT InValidMessage_nh_black_alone(UNSIGNED1 wh) := '';
 
EXPORT Make_nh_aian_alone(SALT311.StrType s0) := s0;
EXPORT InValid_nh_aian_alone(SALT311.StrType s) := 0;
EXPORT InValidMessage_nh_aian_alone(UNSIGNED1 wh) := '';
 
EXPORT Make_nh_api_alone(SALT311.StrType s0) := s0;
EXPORT InValid_nh_api_alone(SALT311.StrType s) := 0;
EXPORT InValidMessage_nh_api_alone(UNSIGNED1 wh) := '';
 
EXPORT Make_nh_other_alone(SALT311.StrType s0) := s0;
EXPORT InValid_nh_other_alone(SALT311.StrType s) := 0;
EXPORT InValidMessage_nh_other_alone(UNSIGNED1 wh) := '';
 
EXPORT Make_nh_mult_total(SALT311.StrType s0) := s0;
EXPORT InValid_nh_mult_total(SALT311.StrType s) := 0;
EXPORT InValidMessage_nh_mult_total(UNSIGNED1 wh) := '';
 
EXPORT Make_nh_white_other(SALT311.StrType s0) := s0;
EXPORT InValid_nh_white_other(SALT311.StrType s) := 0;
EXPORT InValidMessage_nh_white_other(UNSIGNED1 wh) := '';
 
EXPORT Make_nh_black_other(SALT311.StrType s0) := s0;
EXPORT InValid_nh_black_other(SALT311.StrType s) := 0;
EXPORT InValidMessage_nh_black_other(UNSIGNED1 wh) := '';
 
EXPORT Make_nh_aian_other(SALT311.StrType s0) := s0;
EXPORT InValid_nh_aian_other(SALT311.StrType s) := 0;
EXPORT InValidMessage_nh_aian_other(UNSIGNED1 wh) := '';
 
EXPORT Make_nh_asian_hpi(SALT311.StrType s0) := s0;
EXPORT InValid_nh_asian_hpi(SALT311.StrType s) := 0;
EXPORT InValidMessage_nh_asian_hpi(UNSIGNED1 wh) := '';
 
EXPORT Make_nh_api_other(SALT311.StrType s0) := s0;
EXPORT InValid_nh_api_other(SALT311.StrType s) := 0;
EXPORT InValidMessage_nh_api_other(UNSIGNED1 wh) := '';
 
EXPORT Make_nh_asian_hpi_other(SALT311.StrType s0) := s0;
EXPORT InValid_nh_asian_hpi_other(SALT311.StrType s) := 0;
EXPORT InValidMessage_nh_asian_hpi_other(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_CFPB;
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
    BOOLEAN Diff_record_sid;
    BOOLEAN Diff_global_src_id;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_is_latest;
    BOOLEAN Diff_seqno;
    BOOLEAN Diff_geoid10_blkgrp;
    BOOLEAN Diff_state_fips10;
    BOOLEAN Diff_county_fips10;
    BOOLEAN Diff_tract_fips10;
    BOOLEAN Diff_blkgrp_fips10;
    BOOLEAN Diff_total_pop;
    BOOLEAN Diff_hispanic_total;
    BOOLEAN Diff_non_hispanic_total;
    BOOLEAN Diff_nh_white_alone;
    BOOLEAN Diff_nh_black_alone;
    BOOLEAN Diff_nh_aian_alone;
    BOOLEAN Diff_nh_api_alone;
    BOOLEAN Diff_nh_other_alone;
    BOOLEAN Diff_nh_mult_total;
    BOOLEAN Diff_nh_white_other;
    BOOLEAN Diff_nh_black_other;
    BOOLEAN Diff_nh_aian_other;
    BOOLEAN Diff_nh_asian_hpi;
    BOOLEAN Diff_nh_api_other;
    BOOLEAN Diff_nh_asian_hpi_other;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_record_sid := le.record_sid <> ri.record_sid;
    SELF.Diff_global_src_id := le.global_src_id <> ri.global_src_id;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_is_latest := le.is_latest <> ri.is_latest;
    SELF.Diff_seqno := le.seqno <> ri.seqno;
    SELF.Diff_geoid10_blkgrp := le.geoid10_blkgrp <> ri.geoid10_blkgrp;
    SELF.Diff_state_fips10 := le.state_fips10 <> ri.state_fips10;
    SELF.Diff_county_fips10 := le.county_fips10 <> ri.county_fips10;
    SELF.Diff_tract_fips10 := le.tract_fips10 <> ri.tract_fips10;
    SELF.Diff_blkgrp_fips10 := le.blkgrp_fips10 <> ri.blkgrp_fips10;
    SELF.Diff_total_pop := le.total_pop <> ri.total_pop;
    SELF.Diff_hispanic_total := le.hispanic_total <> ri.hispanic_total;
    SELF.Diff_non_hispanic_total := le.non_hispanic_total <> ri.non_hispanic_total;
    SELF.Diff_nh_white_alone := le.nh_white_alone <> ri.nh_white_alone;
    SELF.Diff_nh_black_alone := le.nh_black_alone <> ri.nh_black_alone;
    SELF.Diff_nh_aian_alone := le.nh_aian_alone <> ri.nh_aian_alone;
    SELF.Diff_nh_api_alone := le.nh_api_alone <> ri.nh_api_alone;
    SELF.Diff_nh_other_alone := le.nh_other_alone <> ri.nh_other_alone;
    SELF.Diff_nh_mult_total := le.nh_mult_total <> ri.nh_mult_total;
    SELF.Diff_nh_white_other := le.nh_white_other <> ri.nh_white_other;
    SELF.Diff_nh_black_other := le.nh_black_other <> ri.nh_black_other;
    SELF.Diff_nh_aian_other := le.nh_aian_other <> ri.nh_aian_other;
    SELF.Diff_nh_asian_hpi := le.nh_asian_hpi <> ri.nh_asian_hpi;
    SELF.Diff_nh_api_other := le.nh_api_other <> ri.nh_api_other;
    SELF.Diff_nh_asian_hpi_other := le.nh_asian_hpi_other <> ri.nh_asian_hpi_other;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_record_sid,1,0)+ IF( SELF.Diff_global_src_id,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_is_latest,1,0)+ IF( SELF.Diff_seqno,1,0)+ IF( SELF.Diff_geoid10_blkgrp,1,0)+ IF( SELF.Diff_state_fips10,1,0)+ IF( SELF.Diff_county_fips10,1,0)+ IF( SELF.Diff_tract_fips10,1,0)+ IF( SELF.Diff_blkgrp_fips10,1,0)+ IF( SELF.Diff_total_pop,1,0)+ IF( SELF.Diff_hispanic_total,1,0)+ IF( SELF.Diff_non_hispanic_total,1,0)+ IF( SELF.Diff_nh_white_alone,1,0)+ IF( SELF.Diff_nh_black_alone,1,0)+ IF( SELF.Diff_nh_aian_alone,1,0)+ IF( SELF.Diff_nh_api_alone,1,0)+ IF( SELF.Diff_nh_other_alone,1,0)+ IF( SELF.Diff_nh_mult_total,1,0)+ IF( SELF.Diff_nh_white_other,1,0)+ IF( SELF.Diff_nh_black_other,1,0)+ IF( SELF.Diff_nh_aian_other,1,0)+ IF( SELF.Diff_nh_asian_hpi,1,0)+ IF( SELF.Diff_nh_api_other,1,0)+ IF( SELF.Diff_nh_asian_hpi_other,1,0);
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
    Count_Diff_record_sid := COUNT(GROUP,%Closest%.Diff_record_sid);
    Count_Diff_global_src_id := COUNT(GROUP,%Closest%.Diff_global_src_id);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_is_latest := COUNT(GROUP,%Closest%.Diff_is_latest);
    Count_Diff_seqno := COUNT(GROUP,%Closest%.Diff_seqno);
    Count_Diff_geoid10_blkgrp := COUNT(GROUP,%Closest%.Diff_geoid10_blkgrp);
    Count_Diff_state_fips10 := COUNT(GROUP,%Closest%.Diff_state_fips10);
    Count_Diff_county_fips10 := COUNT(GROUP,%Closest%.Diff_county_fips10);
    Count_Diff_tract_fips10 := COUNT(GROUP,%Closest%.Diff_tract_fips10);
    Count_Diff_blkgrp_fips10 := COUNT(GROUP,%Closest%.Diff_blkgrp_fips10);
    Count_Diff_total_pop := COUNT(GROUP,%Closest%.Diff_total_pop);
    Count_Diff_hispanic_total := COUNT(GROUP,%Closest%.Diff_hispanic_total);
    Count_Diff_non_hispanic_total := COUNT(GROUP,%Closest%.Diff_non_hispanic_total);
    Count_Diff_nh_white_alone := COUNT(GROUP,%Closest%.Diff_nh_white_alone);
    Count_Diff_nh_black_alone := COUNT(GROUP,%Closest%.Diff_nh_black_alone);
    Count_Diff_nh_aian_alone := COUNT(GROUP,%Closest%.Diff_nh_aian_alone);
    Count_Diff_nh_api_alone := COUNT(GROUP,%Closest%.Diff_nh_api_alone);
    Count_Diff_nh_other_alone := COUNT(GROUP,%Closest%.Diff_nh_other_alone);
    Count_Diff_nh_mult_total := COUNT(GROUP,%Closest%.Diff_nh_mult_total);
    Count_Diff_nh_white_other := COUNT(GROUP,%Closest%.Diff_nh_white_other);
    Count_Diff_nh_black_other := COUNT(GROUP,%Closest%.Diff_nh_black_other);
    Count_Diff_nh_aian_other := COUNT(GROUP,%Closest%.Diff_nh_aian_other);
    Count_Diff_nh_asian_hpi := COUNT(GROUP,%Closest%.Diff_nh_asian_hpi);
    Count_Diff_nh_api_other := COUNT(GROUP,%Closest%.Diff_nh_api_other);
    Count_Diff_nh_asian_hpi_other := COUNT(GROUP,%Closest%.Diff_nh_asian_hpi_other);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
