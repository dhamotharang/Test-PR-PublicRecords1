IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 9;
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'lnfilecategory','lnsourcetcode','vendorname','address1','address2','city','state','zipcode','phone');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'lnfilecategory','lnsourcetcode','vendorname','address1','address2','city','state','zipcode','phone');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'lnfilecategory' => 0,'lnsourcetcode' => 1,'vendorname' => 2,'address1' => 3,'address2' => 4,'city' => 5,'state' => 6,'zipcode' => 7,'phone' => 8,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_lnfilecategory(SALT311.StrType s0) := s0;
EXPORT InValid_lnfilecategory(SALT311.StrType s) := 0;
EXPORT InValidMessage_lnfilecategory(UNSIGNED1 wh) := '';
 
EXPORT Make_lnsourcetcode(SALT311.StrType s0) := s0;
EXPORT InValid_lnsourcetcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_lnsourcetcode(UNSIGNED1 wh) := '';
 
EXPORT Make_vendorname(SALT311.StrType s0) := s0;
EXPORT InValid_vendorname(SALT311.StrType s) := 0;
EXPORT InValidMessage_vendorname(UNSIGNED1 wh) := '';
 
EXPORT Make_address1(SALT311.StrType s0) := s0;
EXPORT InValid_address1(SALT311.StrType s) := 0;
EXPORT InValidMessage_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_address2(SALT311.StrType s0) := s0;
EXPORT InValid_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT311.StrType s0) := s0;
EXPORT InValid_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT311.StrType s0) := s0;
EXPORT InValid_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
 
EXPORT Make_zipcode(SALT311.StrType s0) := s0;
EXPORT InValid_zipcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_zipcode(UNSIGNED1 wh) := '';
 
EXPORT Make_phone(SALT311.StrType s0) := s0;
EXPORT InValid_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_phone(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,_Scrubs_VendorSrc_CollegeLocator;
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
    BOOLEAN Diff_lnfilecategory;
    BOOLEAN Diff_lnsourcetcode;
    BOOLEAN Diff_vendorname;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zipcode;
    BOOLEAN Diff_phone;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_lnfilecategory := le.lnfilecategory <> ri.lnfilecategory;
    SELF.Diff_lnsourcetcode := le.lnsourcetcode <> ri.lnsourcetcode;
    SELF.Diff_vendorname := le.vendorname <> ri.vendorname;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zipcode := le.zipcode <> ri.zipcode;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_lnfilecategory,1,0)+ IF( SELF.Diff_lnsourcetcode,1,0)+ IF( SELF.Diff_vendorname,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zipcode,1,0)+ IF( SELF.Diff_phone,1,0);
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
    Count_Diff_lnfilecategory := COUNT(GROUP,%Closest%.Diff_lnfilecategory);
    Count_Diff_lnsourcetcode := COUNT(GROUP,%Closest%.Diff_lnsourcetcode);
    Count_Diff_vendorname := COUNT(GROUP,%Closest%.Diff_vendorname);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zipcode := COUNT(GROUP,%Closest%.Diff_zipcode);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
