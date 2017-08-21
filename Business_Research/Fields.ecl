import ut,SALT20;
export Fields := MODULE
//Individual field level validation
export InValid_rcid(string s) := WHICH();
export InValidMessage_rcid(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_rcid(string s0) := FUNCTION
return s0;
end;
export InValid_bdid(string s) := WHICH();
export InValidMessage_bdid(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_bdid(string s0) := FUNCTION
return s0;
end;
export InValid_source(string s) := WHICH();
export InValidMessage_source(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_source(string s0) := FUNCTION
return s0;
end;
export InValid_source_group(string s) := WHICH();
export InValidMessage_source_group(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_source_group(string s0) := FUNCTION
return s0;
end;
export InValid_pflag(string s) := WHICH();
export InValidMessage_pflag(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_pflag(string s0) := FUNCTION
return s0;
end;
export InValid_group1_id(string s) := WHICH();
export InValidMessage_group1_id(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_group1_id(string s0) := FUNCTION
return s0;
end;
export InValid_vendor_id(string s) := WHICH();
export InValidMessage_vendor_id(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_vendor_id(string s0) := FUNCTION
return s0;
end;
export InValid_dt_first_seen(string s) := WHICH();
export InValidMessage_dt_first_seen(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_dt_first_seen(string s0) := FUNCTION
return s0;
end;
export InValid_dt_last_seen(string s) := WHICH();
export InValidMessage_dt_last_seen(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_dt_last_seen(string s0) := FUNCTION
return s0;
end;
export InValid_dt_vendor_first_reported(string s) := WHICH();
export InValidMessage_dt_vendor_first_reported(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_dt_vendor_first_reported(string s0) := FUNCTION
return s0;
end;
export InValid_dt_vendor_last_reported(string s) := WHICH();
export InValidMessage_dt_vendor_last_reported(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_dt_vendor_last_reported(string s0) := FUNCTION
return s0;
end;
export InValid_company_name(string s) := WHICH();
export InValidMessage_company_name(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_company_name(string s0) := FUNCTION
return s0;
end;
export InValid_prim_range(string s) := WHICH();
export InValidMessage_prim_range(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_prim_range(string s0) := FUNCTION
return s0;
end;
export InValid_predir(string s) := WHICH();
export InValidMessage_predir(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_predir(string s0) := FUNCTION
return s0;
end;
export InValid_prim_name(string s) := WHICH();
export InValidMessage_prim_name(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_prim_name(string s0) := FUNCTION
return s0;
end;
export InValid_addr_suffix(string s) := WHICH();
export InValidMessage_addr_suffix(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_addr_suffix(string s0) := FUNCTION
return s0;
end;
export InValid_postdir(string s) := WHICH();
export InValidMessage_postdir(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_postdir(string s0) := FUNCTION
return s0;
end;
export InValid_unit_desig(string s) := WHICH();
export InValidMessage_unit_desig(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_unit_desig(string s0) := FUNCTION
return s0;
end;
export InValid_sec_range(string s) := WHICH();
export InValidMessage_sec_range(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_sec_range(string s0) := FUNCTION
return s0;
end;
export InValid_city(string s) := WHICH();
export InValidMessage_city(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_city(string s0) := FUNCTION
return s0;
end;
export InValid_state(string s) := WHICH();
export InValidMessage_state(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_state(string s0) := FUNCTION
return s0;
end;
export InValid_zip(string s) := WHICH();
export InValidMessage_zip(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_zip(string s0) := FUNCTION
return s0;
end;
export InValid_zip4(string s) := WHICH();
export InValidMessage_zip4(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_zip4(string s0) := FUNCTION
return s0;
end;
export InValid_county(string s) := WHICH();
export InValidMessage_county(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_county(string s0) := FUNCTION
return s0;
end;
export InValid_msa(string s) := WHICH();
export InValidMessage_msa(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_msa(string s0) := FUNCTION
return s0;
end;
export InValid_geo_lat(string s) := WHICH();
export InValidMessage_geo_lat(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_geo_lat(string s0) := FUNCTION
return s0;
end;
export InValid_geo_long(string s) := WHICH();
export InValidMessage_geo_long(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_geo_long(string s0) := FUNCTION
return s0;
end;
export InValid_phone(string s) := WHICH();
export InValidMessage_phone(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_phone(string s0) := FUNCTION
return s0;
end;
export InValid_phone_score(string s) := WHICH();
export InValidMessage_phone_score(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_phone_score(string s0) := FUNCTION
return s0;
end;
export InValid_fein(string s) := WHICH();
export InValidMessage_fein(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_fein(string s0) := FUNCTION
return s0;
end;
export InValid_current(string s) := WHICH();
export InValidMessage_current(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_current(string s0) := FUNCTION
return s0;
end;
export InValid_dppa(string s) := WHICH();
export InValidMessage_dppa(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_dppa(string s0) := FUNCTION
return s0;
end;
export InValid_vl_id(string s) := WHICH();
export InValidMessage_vl_id(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_vl_id(string s0) := FUNCTION
return s0;
end;
export InValid_RawAID(string s) := WHICH();
export InValidMessage_RawAID(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
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
    BOOLEAN Diff_rcid;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_source;
    BOOLEAN Diff_source_group;
    BOOLEAN Diff_pflag;
    BOOLEAN Diff_group1_id;
    BOOLEAN Diff_vendor_id;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_county;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_phone_score;
    BOOLEAN Diff_fein;
    BOOLEAN Diff_current;
    BOOLEAN Diff_dppa;
    BOOLEAN Diff_vl_id;
    BOOLEAN Diff_RawAID;
    UNSIGNED Num_Diffs;
    STRING Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := transform
    SELF.Diff_rcid := le.rcid <> ri.rcid;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_source_group := le.source_group <> ri.source_group;
    SELF.Diff_pflag := le.pflag <> ri.pflag;
    SELF.Diff_group1_id := le.group1_id <> ri.group1_id;
    SELF.Diff_vendor_id := le.vendor_id <> ri.vendor_id;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_phone_score := le.phone_score <> ri.phone_score;
    SELF.Diff_fein := le.fein <> ri.fein;
    SELF.Diff_current := le.current <> ri.current;
    SELF.Diff_dppa := le.dppa <> ri.dppa;
    SELF.Diff_vl_id := le.vl_id <> ri.vl_id;
    SELF.Diff_RawAID := le.RawAID <> ri.RawAID;
    SELF.Val := (STRING)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_rcid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_source_group,1,0)+ IF( SELF.Diff_pflag,1,0)+ IF( SELF.Diff_group1_id,1,0)+ IF( SELF.Diff_vendor_id,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phone_score,1,0)+ IF( SELF.Diff_fein,1,0)+ IF( SELF.Diff_current,1,0)+ IF( SELF.Diff_dppa,1,0)+ IF( SELF.Diff_vl_id,1,0)+ IF( SELF.Diff_RawAID,1,0);
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
    Count_Diff_rcid := COUNT(GROUP,%Closest%.Diff_rcid);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_source_group := COUNT(GROUP,%Closest%.Diff_source_group);
    Count_Diff_pflag := COUNT(GROUP,%Closest%.Diff_pflag);
    Count_Diff_group1_id := COUNT(GROUP,%Closest%.Diff_group1_id);
    Count_Diff_vendor_id := COUNT(GROUP,%Closest%.Diff_vendor_id);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_phone_score := COUNT(GROUP,%Closest%.Diff_phone_score);
    Count_Diff_fein := COUNT(GROUP,%Closest%.Diff_fein);
    Count_Diff_current := COUNT(GROUP,%Closest%.Diff_current);
    Count_Diff_dppa := COUNT(GROUP,%Closest%.Diff_dppa);
    Count_Diff_vl_id := COUNT(GROUP,%Closest%.Diff_vl_id);
    Count_Diff_RawAID := COUNT(GROUP,%Closest%.Diff_RawAID);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
end;
