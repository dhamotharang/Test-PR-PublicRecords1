IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT charge_arrests_Fields := MODULE
 
EXPORT NumFields := 31;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Record_ID','Invalid_State','Invalid_Case_ID','Invalid_Current_Date','Invalid_Future_Date','Invalid_Source_ID');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Record_ID' => 1,'Invalid_State' => 2,'Invalid_Case_ID' => 3,'Invalid_Current_Date' => 4,'Invalid_Future_Date' => 5,'Invalid_Source_ID' => 6,0);
 
EXPORT MakeFT_Invalid_Record_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Record_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_Invalid_Record_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Case_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Case_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))));
EXPORT InValidMessageFT_Invalid_Case_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Current_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Current_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Current_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Future_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Future_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s,'future')>0);
EXPORT InValidMessageFT_Invalid_Future_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Source_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Source_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '))));
EXPORT InValidMessageFT_Invalid_Source_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ '),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'recordid','statecode','caseid','warrantnumber','warrantdate','warrantdesc','warrantissuedate','warrantissuingagency','warrantstatus','citationnumber','bookingnumber','arrestdate','arrestingagency','bookingdate','custodydate','custodylocation','initialcharge','initialchargedate','initialchargecancelleddate','chargedisposed','chargedisposeddate','chargeseverity','chargedisposition','amendedcharge','amendedchargedate','bondsman','bondamount','bondtype','sourcename','sourceid','vendor');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'recordid','statecode','caseid','warrantnumber','warrantdate','warrantdesc','warrantissuedate','warrantissuingagency','warrantstatus','citationnumber','bookingnumber','arrestdate','arrestingagency','bookingdate','custodydate','custodylocation','initialcharge','initialchargedate','initialchargecancelleddate','chargedisposed','chargedisposeddate','chargeseverity','chargedisposition','amendedcharge','amendedchargedate','bondsman','bondamount','bondtype','sourcename','sourceid','vendor');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'recordid' => 0,'statecode' => 1,'caseid' => 2,'warrantnumber' => 3,'warrantdate' => 4,'warrantdesc' => 5,'warrantissuedate' => 6,'warrantissuingagency' => 7,'warrantstatus' => 8,'citationnumber' => 9,'bookingnumber' => 10,'arrestdate' => 11,'arrestingagency' => 12,'bookingdate' => 13,'custodydate' => 14,'custodylocation' => 15,'initialcharge' => 16,'initialchargedate' => 17,'initialchargecancelleddate' => 18,'chargedisposed' => 19,'chargedisposeddate' => 20,'chargeseverity' => 21,'chargedisposition' => 22,'amendedcharge' => 23,'amendedchargedate' => 24,'bondsman' => 25,'bondamount' => 26,'bondtype' => 27,'sourcename' => 28,'sourceid' => 29,'vendor' => 30,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],[],[],['CUSTOM'],[],[],[],['CUSTOM'],[],[],[],[],['ALLOW'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_recordid(SALT311.StrType s0) := MakeFT_Invalid_Record_ID(s0);
EXPORT InValid_recordid(SALT311.StrType s) := InValidFT_Invalid_Record_ID(s);
EXPORT InValidMessage_recordid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Record_ID(wh);
 
EXPORT Make_statecode(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_statecode(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_statecode(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_caseid(SALT311.StrType s0) := MakeFT_Invalid_Case_ID(s0);
EXPORT InValid_caseid(SALT311.StrType s) := InValidFT_Invalid_Case_ID(s);
EXPORT InValidMessage_caseid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Case_ID(wh);
 
EXPORT Make_warrantnumber(SALT311.StrType s0) := s0;
EXPORT InValid_warrantnumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_warrantnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_warrantdate(SALT311.StrType s0) := s0;
EXPORT InValid_warrantdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_warrantdate(UNSIGNED1 wh) := '';
 
EXPORT Make_warrantdesc(SALT311.StrType s0) := s0;
EXPORT InValid_warrantdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_warrantdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_warrantissuedate(SALT311.StrType s0) := s0;
EXPORT InValid_warrantissuedate(SALT311.StrType s) := 0;
EXPORT InValidMessage_warrantissuedate(UNSIGNED1 wh) := '';
 
EXPORT Make_warrantissuingagency(SALT311.StrType s0) := s0;
EXPORT InValid_warrantissuingagency(SALT311.StrType s) := 0;
EXPORT InValidMessage_warrantissuingagency(UNSIGNED1 wh) := '';
 
EXPORT Make_warrantstatus(SALT311.StrType s0) := s0;
EXPORT InValid_warrantstatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_warrantstatus(UNSIGNED1 wh) := '';
 
EXPORT Make_citationnumber(SALT311.StrType s0) := s0;
EXPORT InValid_citationnumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_citationnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_bookingnumber(SALT311.StrType s0) := s0;
EXPORT InValid_bookingnumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_bookingnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_arrestdate(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_arrestdate(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_arrestdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_arrestingagency(SALT311.StrType s0) := s0;
EXPORT InValid_arrestingagency(SALT311.StrType s) := 0;
EXPORT InValidMessage_arrestingagency(UNSIGNED1 wh) := '';
 
EXPORT Make_bookingdate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_bookingdate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_bookingdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_custodydate(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_custodydate(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_custodydate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_custodylocation(SALT311.StrType s0) := s0;
EXPORT InValid_custodylocation(SALT311.StrType s) := 0;
EXPORT InValidMessage_custodylocation(UNSIGNED1 wh) := '';
 
EXPORT Make_initialcharge(SALT311.StrType s0) := s0;
EXPORT InValid_initialcharge(SALT311.StrType s) := 0;
EXPORT InValidMessage_initialcharge(UNSIGNED1 wh) := '';
 
EXPORT Make_initialchargedate(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_initialchargedate(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_initialchargedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_initialchargecancelleddate(SALT311.StrType s0) := s0;
EXPORT InValid_initialchargecancelleddate(SALT311.StrType s) := 0;
EXPORT InValidMessage_initialchargecancelleddate(UNSIGNED1 wh) := '';
 
EXPORT Make_chargedisposed(SALT311.StrType s0) := s0;
EXPORT InValid_chargedisposed(SALT311.StrType s) := 0;
EXPORT InValidMessage_chargedisposed(UNSIGNED1 wh) := '';
 
EXPORT Make_chargedisposeddate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_chargedisposeddate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_chargedisposeddate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_chargeseverity(SALT311.StrType s0) := s0;
EXPORT InValid_chargeseverity(SALT311.StrType s) := 0;
EXPORT InValidMessage_chargeseverity(UNSIGNED1 wh) := '';
 
EXPORT Make_chargedisposition(SALT311.StrType s0) := s0;
EXPORT InValid_chargedisposition(SALT311.StrType s) := 0;
EXPORT InValidMessage_chargedisposition(UNSIGNED1 wh) := '';
 
EXPORT Make_amendedcharge(SALT311.StrType s0) := s0;
EXPORT InValid_amendedcharge(SALT311.StrType s) := 0;
EXPORT InValidMessage_amendedcharge(UNSIGNED1 wh) := '';
 
EXPORT Make_amendedchargedate(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_amendedchargedate(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_amendedchargedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_bondsman(SALT311.StrType s0) := s0;
EXPORT InValid_bondsman(SALT311.StrType s) := 0;
EXPORT InValidMessage_bondsman(UNSIGNED1 wh) := '';
 
EXPORT Make_bondamount(SALT311.StrType s0) := s0;
EXPORT InValid_bondamount(SALT311.StrType s) := 0;
EXPORT InValidMessage_bondamount(UNSIGNED1 wh) := '';
 
EXPORT Make_bondtype(SALT311.StrType s0) := s0;
EXPORT InValid_bondtype(SALT311.StrType s) := 0;
EXPORT InValidMessage_bondtype(UNSIGNED1 wh) := '';
 
EXPORT Make_sourcename(SALT311.StrType s0) := s0;
EXPORT InValid_sourcename(SALT311.StrType s) := 0;
EXPORT InValidMessage_sourcename(UNSIGNED1 wh) := '';
 
EXPORT Make_sourceid(SALT311.StrType s0) := MakeFT_Invalid_Source_ID(s0);
EXPORT InValid_sourceid(SALT311.StrType s) := InValidFT_Invalid_Source_ID(s);
EXPORT InValidMessage_sourceid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Source_ID(wh);
 
EXPORT Make_vendor(SALT311.StrType s0) := s0;
EXPORT InValid_vendor(SALT311.StrType s) := 0;
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Crim;
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
    BOOLEAN Diff_recordid;
    BOOLEAN Diff_statecode;
    BOOLEAN Diff_caseid;
    BOOLEAN Diff_warrantnumber;
    BOOLEAN Diff_warrantdate;
    BOOLEAN Diff_warrantdesc;
    BOOLEAN Diff_warrantissuedate;
    BOOLEAN Diff_warrantissuingagency;
    BOOLEAN Diff_warrantstatus;
    BOOLEAN Diff_citationnumber;
    BOOLEAN Diff_bookingnumber;
    BOOLEAN Diff_arrestdate;
    BOOLEAN Diff_arrestingagency;
    BOOLEAN Diff_bookingdate;
    BOOLEAN Diff_custodydate;
    BOOLEAN Diff_custodylocation;
    BOOLEAN Diff_initialcharge;
    BOOLEAN Diff_initialchargedate;
    BOOLEAN Diff_initialchargecancelleddate;
    BOOLEAN Diff_chargedisposed;
    BOOLEAN Diff_chargedisposeddate;
    BOOLEAN Diff_chargeseverity;
    BOOLEAN Diff_chargedisposition;
    BOOLEAN Diff_amendedcharge;
    BOOLEAN Diff_amendedchargedate;
    BOOLEAN Diff_bondsman;
    BOOLEAN Diff_bondamount;
    BOOLEAN Diff_bondtype;
    BOOLEAN Diff_sourcename;
    BOOLEAN Diff_sourceid;
    BOOLEAN Diff_vendor;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_recordid := le.recordid <> ri.recordid;
    SELF.Diff_statecode := le.statecode <> ri.statecode;
    SELF.Diff_caseid := le.caseid <> ri.caseid;
    SELF.Diff_warrantnumber := le.warrantnumber <> ri.warrantnumber;
    SELF.Diff_warrantdate := le.warrantdate <> ri.warrantdate;
    SELF.Diff_warrantdesc := le.warrantdesc <> ri.warrantdesc;
    SELF.Diff_warrantissuedate := le.warrantissuedate <> ri.warrantissuedate;
    SELF.Diff_warrantissuingagency := le.warrantissuingagency <> ri.warrantissuingagency;
    SELF.Diff_warrantstatus := le.warrantstatus <> ri.warrantstatus;
    SELF.Diff_citationnumber := le.citationnumber <> ri.citationnumber;
    SELF.Diff_bookingnumber := le.bookingnumber <> ri.bookingnumber;
    SELF.Diff_arrestdate := le.arrestdate <> ri.arrestdate;
    SELF.Diff_arrestingagency := le.arrestingagency <> ri.arrestingagency;
    SELF.Diff_bookingdate := le.bookingdate <> ri.bookingdate;
    SELF.Diff_custodydate := le.custodydate <> ri.custodydate;
    SELF.Diff_custodylocation := le.custodylocation <> ri.custodylocation;
    SELF.Diff_initialcharge := le.initialcharge <> ri.initialcharge;
    SELF.Diff_initialchargedate := le.initialchargedate <> ri.initialchargedate;
    SELF.Diff_initialchargecancelleddate := le.initialchargecancelleddate <> ri.initialchargecancelleddate;
    SELF.Diff_chargedisposed := le.chargedisposed <> ri.chargedisposed;
    SELF.Diff_chargedisposeddate := le.chargedisposeddate <> ri.chargedisposeddate;
    SELF.Diff_chargeseverity := le.chargeseverity <> ri.chargeseverity;
    SELF.Diff_chargedisposition := le.chargedisposition <> ri.chargedisposition;
    SELF.Diff_amendedcharge := le.amendedcharge <> ri.amendedcharge;
    SELF.Diff_amendedchargedate := le.amendedchargedate <> ri.amendedchargedate;
    SELF.Diff_bondsman := le.bondsman <> ri.bondsman;
    SELF.Diff_bondamount := le.bondamount <> ri.bondamount;
    SELF.Diff_bondtype := le.bondtype <> ri.bondtype;
    SELF.Diff_sourcename := le.sourcename <> ri.sourcename;
    SELF.Diff_sourceid := le.sourceid <> ri.sourceid;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.vendor;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_recordid,1,0)+ IF( SELF.Diff_statecode,1,0)+ IF( SELF.Diff_caseid,1,0)+ IF( SELF.Diff_warrantnumber,1,0)+ IF( SELF.Diff_warrantdate,1,0)+ IF( SELF.Diff_warrantdesc,1,0)+ IF( SELF.Diff_warrantissuedate,1,0)+ IF( SELF.Diff_warrantissuingagency,1,0)+ IF( SELF.Diff_warrantstatus,1,0)+ IF( SELF.Diff_citationnumber,1,0)+ IF( SELF.Diff_bookingnumber,1,0)+ IF( SELF.Diff_arrestdate,1,0)+ IF( SELF.Diff_arrestingagency,1,0)+ IF( SELF.Diff_bookingdate,1,0)+ IF( SELF.Diff_custodydate,1,0)+ IF( SELF.Diff_custodylocation,1,0)+ IF( SELF.Diff_initialcharge,1,0)+ IF( SELF.Diff_initialchargedate,1,0)+ IF( SELF.Diff_initialchargecancelleddate,1,0)+ IF( SELF.Diff_chargedisposed,1,0)+ IF( SELF.Diff_chargedisposeddate,1,0)+ IF( SELF.Diff_chargeseverity,1,0)+ IF( SELF.Diff_chargedisposition,1,0)+ IF( SELF.Diff_amendedcharge,1,0)+ IF( SELF.Diff_amendedchargedate,1,0)+ IF( SELF.Diff_bondsman,1,0)+ IF( SELF.Diff_bondamount,1,0)+ IF( SELF.Diff_bondtype,1,0)+ IF( SELF.Diff_sourcename,1,0)+ IF( SELF.Diff_sourceid,1,0)+ IF( SELF.Diff_vendor,1,0);
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
    Count_Diff_recordid := COUNT(GROUP,%Closest%.Diff_recordid);
    Count_Diff_statecode := COUNT(GROUP,%Closest%.Diff_statecode);
    Count_Diff_caseid := COUNT(GROUP,%Closest%.Diff_caseid);
    Count_Diff_warrantnumber := COUNT(GROUP,%Closest%.Diff_warrantnumber);
    Count_Diff_warrantdate := COUNT(GROUP,%Closest%.Diff_warrantdate);
    Count_Diff_warrantdesc := COUNT(GROUP,%Closest%.Diff_warrantdesc);
    Count_Diff_warrantissuedate := COUNT(GROUP,%Closest%.Diff_warrantissuedate);
    Count_Diff_warrantissuingagency := COUNT(GROUP,%Closest%.Diff_warrantissuingagency);
    Count_Diff_warrantstatus := COUNT(GROUP,%Closest%.Diff_warrantstatus);
    Count_Diff_citationnumber := COUNT(GROUP,%Closest%.Diff_citationnumber);
    Count_Diff_bookingnumber := COUNT(GROUP,%Closest%.Diff_bookingnumber);
    Count_Diff_arrestdate := COUNT(GROUP,%Closest%.Diff_arrestdate);
    Count_Diff_arrestingagency := COUNT(GROUP,%Closest%.Diff_arrestingagency);
    Count_Diff_bookingdate := COUNT(GROUP,%Closest%.Diff_bookingdate);
    Count_Diff_custodydate := COUNT(GROUP,%Closest%.Diff_custodydate);
    Count_Diff_custodylocation := COUNT(GROUP,%Closest%.Diff_custodylocation);
    Count_Diff_initialcharge := COUNT(GROUP,%Closest%.Diff_initialcharge);
    Count_Diff_initialchargedate := COUNT(GROUP,%Closest%.Diff_initialchargedate);
    Count_Diff_initialchargecancelleddate := COUNT(GROUP,%Closest%.Diff_initialchargecancelleddate);
    Count_Diff_chargedisposed := COUNT(GROUP,%Closest%.Diff_chargedisposed);
    Count_Diff_chargedisposeddate := COUNT(GROUP,%Closest%.Diff_chargedisposeddate);
    Count_Diff_chargeseverity := COUNT(GROUP,%Closest%.Diff_chargeseverity);
    Count_Diff_chargedisposition := COUNT(GROUP,%Closest%.Diff_chargedisposition);
    Count_Diff_amendedcharge := COUNT(GROUP,%Closest%.Diff_amendedcharge);
    Count_Diff_amendedchargedate := COUNT(GROUP,%Closest%.Diff_amendedchargedate);
    Count_Diff_bondsman := COUNT(GROUP,%Closest%.Diff_bondsman);
    Count_Diff_bondamount := COUNT(GROUP,%Closest%.Diff_bondamount);
    Count_Diff_bondtype := COUNT(GROUP,%Closest%.Diff_bondtype);
    Count_Diff_sourcename := COUNT(GROUP,%Closest%.Diff_sourcename);
    Count_Diff_sourceid := COUNT(GROUP,%Closest%.Diff_sourceid);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
