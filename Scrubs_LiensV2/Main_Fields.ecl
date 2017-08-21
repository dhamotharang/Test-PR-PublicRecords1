IMPORT ut,SALT33;
IMPORT Scrubs_LiensV2; // Import modules for FieldTypes attribute definitions
EXPORT Main_Fields := MODULE
// Processing for each FieldType
EXPORT SALT33.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'number','invalid_alpha','invalid_date','invalid_amount','invalid_number','invalid_record_code','invalid_eviction_ind','invalid_filing_type','invalid_filing_desc','invalid_name');
EXPORT FieldTypeNum(SALT33.StrType fn) := CASE(fn,'number' => 1,'invalid_alpha' => 2,'invalid_date' => 3,'invalid_amount' => 4,'invalid_number' => 5,'invalid_record_code' => 6,'invalid_eviction_ind' => 7,'invalid_filing_type' => 8,'invalid_filing_desc' => 9,'invalid_name' => 10,0);
EXPORT MakeFT_number(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := if ( SALT33.StringFind('"\'',s1[1],1)>0 and SALT33.StringFind('"\'',s1[LENGTH(TRIM(s1))],1)>0,s1[2..LENGTH(TRIM(s1))-1],s1 );// Remove quotes if required
  RETURN  s2;
END;
EXPORT InValidFT_number(SALT33.StrType s) := WHICH(SALT33.StringFind('"\'',s[1],1)<>0 and SALT33.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.Inquotes('"\''),SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_alpha(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' <>{}[]-^=!+&,./#()'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' <>{}[]-^=!+&,./#()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ\' <>{}[]-^=!+&,./#()'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ\' <>{}[]-^=!+&,./#()'),SALT33.HygieneErrors.NotLength('0,1..'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789'); // Only allow valid symbols
  s2 := if ( SALT33.StringFind('"\'',s1[1],1)>0 and SALT33.StringFind('"\'',s1[LENGTH(TRIM(s1))],1)>0,s1[2..LENGTH(TRIM(s1))-1],s1 );// Remove quotes if required
  RETURN  MakeFT_number(s2);
END;
EXPORT InValidFT_invalid_date(SALT33.StrType s) := WHICH(SALT33.StringFind('"\'',s[1],1)<>0 and SALT33.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.Inquotes('"\''),SALT33.HygieneErrors.NotInChars('0123456789'),SALT33.HygieneErrors.NotLength('0,4,6,8'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_amount(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'0123456789 <>{}[]-^=!+&,./#()'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' <>{}[]-^=!+&,./#()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_amount(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'0123456789 <>{}[]-^=!+&,./#()'))));
EXPORT InValidMessageFT_invalid_amount(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('0123456789 <>{}[]-^=!+&,./#()'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_number(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]-^=!+&,./#()'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' <>{}[]-^=!+&,./#()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_number(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]-^=!+&,./#()'))));
EXPORT InValidMessageFT_invalid_number(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]-^=!+&,./#()'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_record_code(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_code(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['1','2','3','6','C','E','']);
EXPORT InValidMessageFT_invalid_record_code(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('1|2|3|6|C|E|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_eviction_ind(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_eviction_ind(SALT33.StrType s) := WHICH(((SALT33.StrType) s) NOT IN ['Y','N','0','1','2','3','4','5','6','7','8','9','']);
EXPORT InValidMessageFT_invalid_eviction_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInEnum('Y|N|0|1|2|3|4|5|6|7|8|9|'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_filing_type(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_filing_type(SALT33.StrType s) := WHICH(~Scrubs_LiensV2.fn_filing_type(s,'filing_type')>0);
EXPORT InValidMessageFT_invalid_filing_type(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.CustomFail('Scrubs_LiensV2.fn_filing_type'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_filing_desc(SALT33.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_filing_desc(SALT33.StrType s) := WHICH(~Scrubs_LiensV2.fn_filing_type(s,'filing_desc')>0);
EXPORT InValidMessageFT_invalid_filing_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.CustomFail('Scrubs_LiensV2.fn_filing_type'),SALT33.HygieneErrors.Good);
EXPORT MakeFT_invalid_name(SALT33.StrType s0) := FUNCTION
  s1 := SALT33.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,.()'); // Only allow valid symbols
  s2 := SALT33.stringcleanspaces( SALT33.stringsubstituteout(s1,' -,.()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT33.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT33.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,.()'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 3));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT33.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,.()'),SALT33.HygieneErrors.NotLength('0,3..'),SALT33.HygieneErrors.Good);
EXPORT SALT33.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'tmsid','rmsid','orig_rmsid','process_date','record_code','date_vendor_removed','filing_jurisdiction','filing_state','orig_filing_number','orig_filing_type','orig_filing_date','orig_filing_time','case_number','filing_number','filing_type_desc','filing_date','filing_time','vendor_entry_date','judge','case_title','filing_book','filing_page','release_date','amount','eviction','satisifaction_type','judg_satisfied_date','judg_vacated_date','tax_code','irs_serial_number','effective_date','lapse_date','accident_date','sherrif_indc','expiration_date','agency','agency_city','agency_state','agency_county','legal_lot','legal_block','legal_borough','certificate_number','persistent_record_id','source_file');
EXPORT FieldNum(SALT33.StrType fn) := CASE(fn,'tmsid' => 0,'rmsid' => 1,'orig_rmsid' => 2,'process_date' => 3,'record_code' => 4,'date_vendor_removed' => 5,'filing_jurisdiction' => 6,'filing_state' => 7,'orig_filing_number' => 8,'orig_filing_type' => 9,'orig_filing_date' => 10,'orig_filing_time' => 11,'case_number' => 12,'filing_number' => 13,'filing_type_desc' => 14,'filing_date' => 15,'filing_time' => 16,'vendor_entry_date' => 17,'judge' => 18,'case_title' => 19,'filing_book' => 20,'filing_page' => 21,'release_date' => 22,'amount' => 23,'eviction' => 24,'satisifaction_type' => 25,'judg_satisfied_date' => 26,'judg_vacated_date' => 27,'tax_code' => 28,'irs_serial_number' => 29,'effective_date' => 30,'lapse_date' => 31,'accident_date' => 32,'sherrif_indc' => 33,'expiration_date' => 34,'agency' => 35,'agency_city' => 36,'agency_state' => 37,'agency_county' => 38,'legal_lot' => 39,'legal_block' => 40,'legal_borough' => 41,'certificate_number' => 42,'persistent_record_id' => 43,'source_file' => 44,0);
//Individual field level validation
EXPORT Make_tmsid(SALT33.StrType s0) := s0;
EXPORT InValid_tmsid(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_tmsid(UNSIGNED1 wh) := '';
EXPORT Make_rmsid(SALT33.StrType s0) := s0;
EXPORT InValid_rmsid(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_rmsid(UNSIGNED1 wh) := '';
EXPORT Make_orig_rmsid(SALT33.StrType s0) := s0;
EXPORT InValid_orig_rmsid(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_orig_rmsid(UNSIGNED1 wh) := '';
EXPORT Make_process_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_process_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_record_code(SALT33.StrType s0) := MakeFT_invalid_record_code(s0);
EXPORT InValid_record_code(SALT33.StrType s) := InValidFT_invalid_record_code(s);
EXPORT InValidMessage_record_code(UNSIGNED1 wh) := InValidMessageFT_invalid_record_code(wh);
EXPORT Make_date_vendor_removed(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_vendor_removed(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_vendor_removed(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_filing_jurisdiction(SALT33.StrType s0) := s0;
EXPORT InValid_filing_jurisdiction(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_filing_jurisdiction(UNSIGNED1 wh) := '';
EXPORT Make_filing_state(SALT33.StrType s0) := s0;
EXPORT InValid_filing_state(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_filing_state(UNSIGNED1 wh) := '';
EXPORT Make_orig_filing_number(SALT33.StrType s0) := s0;
EXPORT InValid_orig_filing_number(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_orig_filing_number(UNSIGNED1 wh) := '';
EXPORT Make_orig_filing_type(SALT33.StrType s0) := MakeFT_invalid_filing_type(s0);
EXPORT InValid_orig_filing_type(SALT33.StrType s) := InValidFT_invalid_filing_type(s);
EXPORT InValidMessage_orig_filing_type(UNSIGNED1 wh) := InValidMessageFT_invalid_filing_type(wh);
EXPORT Make_orig_filing_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_filing_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_orig_filing_time(SALT33.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_orig_filing_time(SALT33.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_orig_filing_time(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
EXPORT Make_case_number(SALT33.StrType s0) := s0;
EXPORT InValid_case_number(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_case_number(UNSIGNED1 wh) := '';
EXPORT Make_filing_number(SALT33.StrType s0) := s0;
EXPORT InValid_filing_number(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_filing_number(UNSIGNED1 wh) := '';
EXPORT Make_filing_type_desc(SALT33.StrType s0) := MakeFT_invalid_filing_desc(s0);
EXPORT InValid_filing_type_desc(SALT33.StrType s) := InValidFT_invalid_filing_desc(s);
EXPORT InValidMessage_filing_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_filing_desc(wh);
EXPORT Make_filing_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_filing_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_filing_time(SALT33.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_filing_time(SALT33.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_filing_time(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
EXPORT Make_vendor_entry_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_vendor_entry_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_vendor_entry_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_judge(SALT33.StrType s0) := s0;
EXPORT InValid_judge(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_judge(UNSIGNED1 wh) := '';
EXPORT Make_case_title(SALT33.StrType s0) := s0;
EXPORT InValid_case_title(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_case_title(UNSIGNED1 wh) := '';
EXPORT Make_filing_book(SALT33.StrType s0) := s0;
EXPORT InValid_filing_book(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_filing_book(UNSIGNED1 wh) := '';
EXPORT Make_filing_page(SALT33.StrType s0) := s0;
EXPORT InValid_filing_page(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_filing_page(UNSIGNED1 wh) := '';
EXPORT Make_release_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_release_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_release_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_amount(SALT33.StrType s0) := s0;
EXPORT InValid_amount(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_amount(UNSIGNED1 wh) := '';
EXPORT Make_eviction(SALT33.StrType s0) := MakeFT_invalid_eviction_ind(s0);
EXPORT InValid_eviction(SALT33.StrType s) := InValidFT_invalid_eviction_ind(s);
EXPORT InValidMessage_eviction(UNSIGNED1 wh) := InValidMessageFT_invalid_eviction_ind(wh);
EXPORT Make_satisifaction_type(SALT33.StrType s0) := s0;
EXPORT InValid_satisifaction_type(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_satisifaction_type(UNSIGNED1 wh) := '';
EXPORT Make_judg_satisfied_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_judg_satisfied_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_judg_satisfied_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_judg_vacated_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_judg_vacated_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_judg_vacated_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_tax_code(SALT33.StrType s0) := s0;
EXPORT InValid_tax_code(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_tax_code(UNSIGNED1 wh) := '';
EXPORT Make_irs_serial_number(SALT33.StrType s0) := s0;
EXPORT InValid_irs_serial_number(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_irs_serial_number(UNSIGNED1 wh) := '';
EXPORT Make_effective_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_effective_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_effective_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_lapse_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_lapse_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_lapse_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_accident_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_accident_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_accident_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_sherrif_indc(SALT33.StrType s0) := s0;
EXPORT InValid_sherrif_indc(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_sherrif_indc(UNSIGNED1 wh) := '';
EXPORT Make_expiration_date(SALT33.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_expiration_date(SALT33.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_expiration_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_agency(SALT33.StrType s0) := s0;
EXPORT InValid_agency(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_agency(UNSIGNED1 wh) := '';
EXPORT Make_agency_city(SALT33.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_agency_city(SALT33.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_agency_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_agency_state(SALT33.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_agency_state(SALT33.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_agency_state(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_agency_county(SALT33.StrType s0) := s0;
EXPORT InValid_agency_county(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_agency_county(UNSIGNED1 wh) := '';
EXPORT Make_legal_lot(SALT33.StrType s0) := s0;
EXPORT InValid_legal_lot(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_legal_lot(UNSIGNED1 wh) := '';
EXPORT Make_legal_block(SALT33.StrType s0) := s0;
EXPORT InValid_legal_block(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_legal_block(UNSIGNED1 wh) := '';
EXPORT Make_legal_borough(SALT33.StrType s0) := s0;
EXPORT InValid_legal_borough(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_legal_borough(UNSIGNED1 wh) := '';
EXPORT Make_certificate_number(SALT33.StrType s0) := s0;
EXPORT InValid_certificate_number(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_certificate_number(UNSIGNED1 wh) := '';
EXPORT Make_persistent_record_id(SALT33.StrType s0) := s0;
EXPORT InValid_persistent_record_id(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := '';
EXPORT Make_source_file(SALT33.StrType s0) := s0;
EXPORT InValid_source_file(SALT33.StrType s) := FALSE;
EXPORT InValidMessage_source_file(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT33,Scrubs_LiensV2;
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
    BOOLEAN Diff_tmsid;
    BOOLEAN Diff_rmsid;
    BOOLEAN Diff_orig_rmsid;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_record_code;
    BOOLEAN Diff_date_vendor_removed;
    BOOLEAN Diff_filing_jurisdiction;
    BOOLEAN Diff_filing_state;
    BOOLEAN Diff_orig_filing_number;
    BOOLEAN Diff_orig_filing_type;
    BOOLEAN Diff_orig_filing_date;
    BOOLEAN Diff_orig_filing_time;
    BOOLEAN Diff_case_number;
    BOOLEAN Diff_filing_number;
    BOOLEAN Diff_filing_type_desc;
    BOOLEAN Diff_filing_date;
    BOOLEAN Diff_filing_time;
    BOOLEAN Diff_vendor_entry_date;
    BOOLEAN Diff_judge;
    BOOLEAN Diff_case_title;
    BOOLEAN Diff_filing_book;
    BOOLEAN Diff_filing_page;
    BOOLEAN Diff_release_date;
    BOOLEAN Diff_amount;
    BOOLEAN Diff_eviction;
    BOOLEAN Diff_satisifaction_type;
    BOOLEAN Diff_judg_satisfied_date;
    BOOLEAN Diff_judg_vacated_date;
    BOOLEAN Diff_tax_code;
    BOOLEAN Diff_irs_serial_number;
    BOOLEAN Diff_effective_date;
    BOOLEAN Diff_lapse_date;
    BOOLEAN Diff_accident_date;
    BOOLEAN Diff_sherrif_indc;
    BOOLEAN Diff_expiration_date;
    BOOLEAN Diff_agency;
    BOOLEAN Diff_agency_city;
    BOOLEAN Diff_agency_state;
    BOOLEAN Diff_agency_county;
    BOOLEAN Diff_legal_lot;
    BOOLEAN Diff_legal_block;
    BOOLEAN Diff_legal_borough;
    BOOLEAN Diff_certificate_number;
    BOOLEAN Diff_persistent_record_id;
    BOOLEAN Diff_source_file;
    SALT33.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT33.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_tmsid := le.tmsid <> ri.tmsid;
    SELF.Diff_rmsid := le.rmsid <> ri.rmsid;
    SELF.Diff_orig_rmsid := le.orig_rmsid <> ri.orig_rmsid;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_record_code := le.record_code <> ri.record_code;
    SELF.Diff_date_vendor_removed := le.date_vendor_removed <> ri.date_vendor_removed;
    SELF.Diff_filing_jurisdiction := le.filing_jurisdiction <> ri.filing_jurisdiction;
    SELF.Diff_filing_state := le.filing_state <> ri.filing_state;
    SELF.Diff_orig_filing_number := le.orig_filing_number <> ri.orig_filing_number;
    SELF.Diff_orig_filing_type := le.orig_filing_type <> ri.orig_filing_type;
    SELF.Diff_orig_filing_date := le.orig_filing_date <> ri.orig_filing_date;
    SELF.Diff_orig_filing_time := le.orig_filing_time <> ri.orig_filing_time;
    SELF.Diff_case_number := le.case_number <> ri.case_number;
    SELF.Diff_filing_number := le.filing_number <> ri.filing_number;
    SELF.Diff_filing_type_desc := le.filing_type_desc <> ri.filing_type_desc;
    SELF.Diff_filing_date := le.filing_date <> ri.filing_date;
    SELF.Diff_filing_time := le.filing_time <> ri.filing_time;
    SELF.Diff_vendor_entry_date := le.vendor_entry_date <> ri.vendor_entry_date;
    SELF.Diff_judge := le.judge <> ri.judge;
    SELF.Diff_case_title := le.case_title <> ri.case_title;
    SELF.Diff_filing_book := le.filing_book <> ri.filing_book;
    SELF.Diff_filing_page := le.filing_page <> ri.filing_page;
    SELF.Diff_release_date := le.release_date <> ri.release_date;
    SELF.Diff_amount := le.amount <> ri.amount;
    SELF.Diff_eviction := le.eviction <> ri.eviction;
    SELF.Diff_satisifaction_type := le.satisifaction_type <> ri.satisifaction_type;
    SELF.Diff_judg_satisfied_date := le.judg_satisfied_date <> ri.judg_satisfied_date;
    SELF.Diff_judg_vacated_date := le.judg_vacated_date <> ri.judg_vacated_date;
    SELF.Diff_tax_code := le.tax_code <> ri.tax_code;
    SELF.Diff_irs_serial_number := le.irs_serial_number <> ri.irs_serial_number;
    SELF.Diff_effective_date := le.effective_date <> ri.effective_date;
    SELF.Diff_lapse_date := le.lapse_date <> ri.lapse_date;
    SELF.Diff_accident_date := le.accident_date <> ri.accident_date;
    SELF.Diff_sherrif_indc := le.sherrif_indc <> ri.sherrif_indc;
    SELF.Diff_expiration_date := le.expiration_date <> ri.expiration_date;
    SELF.Diff_agency := le.agency <> ri.agency;
    SELF.Diff_agency_city := le.agency_city <> ri.agency_city;
    SELF.Diff_agency_state := le.agency_state <> ri.agency_state;
    SELF.Diff_agency_county := le.agency_county <> ri.agency_county;
    SELF.Diff_legal_lot := le.legal_lot <> ri.legal_lot;
    SELF.Diff_legal_block := le.legal_block <> ri.legal_block;
    SELF.Diff_legal_borough := le.legal_borough <> ri.legal_borough;
    SELF.Diff_certificate_number := le.certificate_number <> ri.certificate_number;
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Diff_source_file := le.source_file <> ri.source_file;
    SELF.Val := (SALT33.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source_file;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_tmsid,1,0)+ IF( SELF.Diff_rmsid,1,0)+ IF( SELF.Diff_orig_rmsid,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_record_code,1,0)+ IF( SELF.Diff_date_vendor_removed,1,0)+ IF( SELF.Diff_filing_jurisdiction,1,0)+ IF( SELF.Diff_filing_state,1,0)+ IF( SELF.Diff_orig_filing_number,1,0)+ IF( SELF.Diff_orig_filing_type,1,0)+ IF( SELF.Diff_orig_filing_date,1,0)+ IF( SELF.Diff_orig_filing_time,1,0)+ IF( SELF.Diff_case_number,1,0)+ IF( SELF.Diff_filing_number,1,0)+ IF( SELF.Diff_filing_type_desc,1,0)+ IF( SELF.Diff_filing_date,1,0)+ IF( SELF.Diff_filing_time,1,0)+ IF( SELF.Diff_vendor_entry_date,1,0)+ IF( SELF.Diff_judge,1,0)+ IF( SELF.Diff_case_title,1,0)+ IF( SELF.Diff_filing_book,1,0)+ IF( SELF.Diff_filing_page,1,0)+ IF( SELF.Diff_release_date,1,0)+ IF( SELF.Diff_amount,1,0)+ IF( SELF.Diff_eviction,1,0)+ IF( SELF.Diff_satisifaction_type,1,0)+ IF( SELF.Diff_judg_satisfied_date,1,0)+ IF( SELF.Diff_judg_vacated_date,1,0)+ IF( SELF.Diff_tax_code,1,0)+ IF( SELF.Diff_irs_serial_number,1,0)+ IF( SELF.Diff_effective_date,1,0)+ IF( SELF.Diff_lapse_date,1,0)+ IF( SELF.Diff_accident_date,1,0)+ IF( SELF.Diff_sherrif_indc,1,0)+ IF( SELF.Diff_expiration_date,1,0)+ IF( SELF.Diff_agency,1,0)+ IF( SELF.Diff_agency_city,1,0)+ IF( SELF.Diff_agency_state,1,0)+ IF( SELF.Diff_agency_county,1,0)+ IF( SELF.Diff_legal_lot,1,0)+ IF( SELF.Diff_legal_block,1,0)+ IF( SELF.Diff_legal_borough,1,0)+ IF( SELF.Diff_certificate_number,1,0)+ IF( SELF.Diff_persistent_record_id,1,0)+ IF( SELF.Diff_source_file,1,0);
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
    Count_Diff_tmsid := COUNT(GROUP,%Closest%.Diff_tmsid);
    Count_Diff_rmsid := COUNT(GROUP,%Closest%.Diff_rmsid);
    Count_Diff_orig_rmsid := COUNT(GROUP,%Closest%.Diff_orig_rmsid);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_record_code := COUNT(GROUP,%Closest%.Diff_record_code);
    Count_Diff_date_vendor_removed := COUNT(GROUP,%Closest%.Diff_date_vendor_removed);
    Count_Diff_filing_jurisdiction := COUNT(GROUP,%Closest%.Diff_filing_jurisdiction);
    Count_Diff_filing_state := COUNT(GROUP,%Closest%.Diff_filing_state);
    Count_Diff_orig_filing_number := COUNT(GROUP,%Closest%.Diff_orig_filing_number);
    Count_Diff_orig_filing_type := COUNT(GROUP,%Closest%.Diff_orig_filing_type);
    Count_Diff_orig_filing_date := COUNT(GROUP,%Closest%.Diff_orig_filing_date);
    Count_Diff_orig_filing_time := COUNT(GROUP,%Closest%.Diff_orig_filing_time);
    Count_Diff_case_number := COUNT(GROUP,%Closest%.Diff_case_number);
    Count_Diff_filing_number := COUNT(GROUP,%Closest%.Diff_filing_number);
    Count_Diff_filing_type_desc := COUNT(GROUP,%Closest%.Diff_filing_type_desc);
    Count_Diff_filing_date := COUNT(GROUP,%Closest%.Diff_filing_date);
    Count_Diff_filing_time := COUNT(GROUP,%Closest%.Diff_filing_time);
    Count_Diff_vendor_entry_date := COUNT(GROUP,%Closest%.Diff_vendor_entry_date);
    Count_Diff_judge := COUNT(GROUP,%Closest%.Diff_judge);
    Count_Diff_case_title := COUNT(GROUP,%Closest%.Diff_case_title);
    Count_Diff_filing_book := COUNT(GROUP,%Closest%.Diff_filing_book);
    Count_Diff_filing_page := COUNT(GROUP,%Closest%.Diff_filing_page);
    Count_Diff_release_date := COUNT(GROUP,%Closest%.Diff_release_date);
    Count_Diff_amount := COUNT(GROUP,%Closest%.Diff_amount);
    Count_Diff_eviction := COUNT(GROUP,%Closest%.Diff_eviction);
    Count_Diff_satisifaction_type := COUNT(GROUP,%Closest%.Diff_satisifaction_type);
    Count_Diff_judg_satisfied_date := COUNT(GROUP,%Closest%.Diff_judg_satisfied_date);
    Count_Diff_judg_vacated_date := COUNT(GROUP,%Closest%.Diff_judg_vacated_date);
    Count_Diff_tax_code := COUNT(GROUP,%Closest%.Diff_tax_code);
    Count_Diff_irs_serial_number := COUNT(GROUP,%Closest%.Diff_irs_serial_number);
    Count_Diff_effective_date := COUNT(GROUP,%Closest%.Diff_effective_date);
    Count_Diff_lapse_date := COUNT(GROUP,%Closest%.Diff_lapse_date);
    Count_Diff_accident_date := COUNT(GROUP,%Closest%.Diff_accident_date);
    Count_Diff_sherrif_indc := COUNT(GROUP,%Closest%.Diff_sherrif_indc);
    Count_Diff_expiration_date := COUNT(GROUP,%Closest%.Diff_expiration_date);
    Count_Diff_agency := COUNT(GROUP,%Closest%.Diff_agency);
    Count_Diff_agency_city := COUNT(GROUP,%Closest%.Diff_agency_city);
    Count_Diff_agency_state := COUNT(GROUP,%Closest%.Diff_agency_state);
    Count_Diff_agency_county := COUNT(GROUP,%Closest%.Diff_agency_county);
    Count_Diff_legal_lot := COUNT(GROUP,%Closest%.Diff_legal_lot);
    Count_Diff_legal_block := COUNT(GROUP,%Closest%.Diff_legal_block);
    Count_Diff_legal_borough := COUNT(GROUP,%Closest%.Diff_legal_borough);
    Count_Diff_certificate_number := COUNT(GROUP,%Closest%.Diff_certificate_number);
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
    Count_Diff_source_file := COUNT(GROUP,%Closest%.Diff_source_file);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
