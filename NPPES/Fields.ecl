import ut;
export Fields := MODULE
//Individual field level validation
export InValid_did(string s) := WHICH();
export InValidMessage_did(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_did(string s0) := FUNCTION
return s0;
end;
export InValid_src(string s) := WHICH();
export InValidMessage_src(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_src(string s0) := FUNCTION
return s0;
end;
export InValid_dt_first_seen(string s) := WHICH();
export InValidMessage_dt_first_seen(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_dt_first_seen(string s0) := FUNCTION
return s0;
end;
export InValid_dt_last_seen(string s) := WHICH();
export InValidMessage_dt_last_seen(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_dt_last_seen(string s0) := FUNCTION
return s0;
end;
export InValid_dt_vendor_first_reported(string s) := WHICH();
export InValidMessage_dt_vendor_first_reported(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_dt_vendor_first_reported(string s0) := FUNCTION
return s0;
end;
export InValid_dt_vendor_last_reported(string s) := WHICH();
export InValidMessage_dt_vendor_last_reported(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_dt_vendor_last_reported(string s0) := FUNCTION
return s0;
end;
export InValid_vendor_id(string s) := WHICH();
export InValidMessage_vendor_id(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_vendor_id(string s0) := FUNCTION
return s0;
end;
export InValid_phone(string s) := WHICH();
export InValidMessage_phone(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_phone(string s0) := FUNCTION
return s0;
end;
export InValid_title(string s) := WHICH();
export InValidMessage_title(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_title(string s0) := FUNCTION
return s0;
end;
export InValid_fname(string s) := WHICH();
export InValidMessage_fname(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_fname(string s0) := FUNCTION
return s0;
end;
export InValid_mname(string s) := WHICH();
export InValidMessage_mname(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_mname(string s0) := FUNCTION
return s0;
end;
export InValid_lname(string s) := WHICH();
export InValidMessage_lname(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_lname(string s0) := FUNCTION
return s0;
end;
export InValid_name_suffix(string s) := WHICH();
export InValidMessage_name_suffix(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_name_suffix(string s0) := FUNCTION
return s0;
end;
export InValid_prim_range(string s) := WHICH();
export InValidMessage_prim_range(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_prim_range(string s0) := FUNCTION
return s0;
end;
export InValid_predir(string s) := WHICH();
export InValidMessage_predir(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_predir(string s0) := FUNCTION
return s0;
end;
export InValid_prim_name(string s) := WHICH();
export InValidMessage_prim_name(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_prim_name(string s0) := FUNCTION
return s0;
end;
export InValid_suffix(string s) := WHICH();
export InValidMessage_suffix(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_suffix(string s0) := FUNCTION
return s0;
end;
export InValid_postdir(string s) := WHICH();
export InValidMessage_postdir(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_postdir(string s0) := FUNCTION
return s0;
end;
export InValid_unit_desig(string s) := WHICH();
export InValidMessage_unit_desig(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_unit_desig(string s0) := FUNCTION
return s0;
end;
export InValid_sec_range(string s) := WHICH();
export InValidMessage_sec_range(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_sec_range(string s0) := FUNCTION
return s0;
end;
export InValid_city_name(string s) := WHICH();
export InValidMessage_city_name(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_city_name(string s0) := FUNCTION
return s0;
end;
export InValid_st(string s) := WHICH();
export InValidMessage_st(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_st(string s0) := FUNCTION
return s0;
end;
export InValid_zip(string s) := WHICH();
export InValidMessage_zip(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_zip(string s0) := FUNCTION
return s0;
end;
export InValid_zip4(string s) := WHICH();
export InValidMessage_zip4(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_zip4(string s0) := FUNCTION
return s0;
end;
export InValid_county(string s) := WHICH();
export InValidMessage_county(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_county(string s0) := FUNCTION
return s0;
end;
export InValid_msa(string s) := WHICH();
export InValidMessage_msa(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_msa(string s0) := FUNCTION
return s0;
end;
export InValid_geo_blk(string s) := WHICH();
export InValidMessage_geo_blk(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_geo_blk(string s0) := FUNCTION
return s0;
end;
export InValid_RawAID(string s) := WHICH();
export InValidMessage_RawAID(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_RawAID(string s0) := FUNCTION
return s0;
end;
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
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
    BOOLEAN Diff_did;
    BOOLEAN Diff_src;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_vendor_id;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_county;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_RawAID;
    UNSIGNED Num_Diffs;
    STRING Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := transform
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_src := le.src <> ri.src;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_vendor_id := le.vendor_id <> ri.vendor_id;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_city_name := le.city_name <> ri.city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_RawAID := le.RawAID <> ri.RawAID;
    SELF.Val := (STRING)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_src,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_vendor_id,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_RawAID,1,0);
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
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_src := COUNT(GROUP,%Closest%.Diff_src);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_vendor_id := COUNT(GROUP,%Closest%.Diff_vendor_id);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_city_name := COUNT(GROUP,%Closest%.Diff_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_RawAID := COUNT(GROUP,%Closest%.Diff_RawAID);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
end;
