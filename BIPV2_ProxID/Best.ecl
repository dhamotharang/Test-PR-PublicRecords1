// Begin code to BEST data for each basis
import SALT30,ut;
EXPORT Best(DATASET(layout_DOT_Base) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
  h00 := Cleave(ih,s,RoxieService).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00)(SALT_Partition<>'*');
 
//Create those fields with BestType: SINGLEPRIMRANGE
// First step is to get all of the data slimmed and row-reduced
EXPORT SINGLEPRIMRANGE_tab_ := DISTRIBUTE(TABLE(h(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name),prim_name_derived NOT IN SET(s.nulls_prim_name_derived,prim_name_derived),v_city_name NOT IN SET(s.nulls_v_city_name,v_city_name),st NOT IN SET(s.nulls_st,st),zip NOT IN SET(s.nulls_zip,zip)),{cnp_name,prim_name_derived,v_city_name,st,zip,prim_range_derived,UNSIGNED Row_Cnt := COUNT(GROUP)},cnp_name,prim_name_derived,v_city_name,st,zip,prim_range_derived,MERGE),HASH(cnp_name,prim_name_derived,v_city_name,st,zip)); // Slim and reduce row-count
  Slim := TABLE(SINGLEPRIMRANGE_tab_(prim_range_derived NOT IN SET(s.nulls_prim_range_derived,prim_range_derived)),{cnp_name,prim_name_derived,v_city_name,st,zip,prim_range_derived,Row_Cnt});
  Slim TR(Slim le, Slim ri) := TRANSFORM
    SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
    SELF := le;
  END;
EXPORT SINGLEPRIMRANGE_tab_prim_range_derived := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
//Now actually find the best value
  grp := GROUP( SINGLEPRIMRANGE_tab_prim_range_derived,cnp_name,prim_name_derived,v_city_name,st,zip,ALL,LOCAL);
  srt := SORT( grp,-Row_Cnt);
  cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the row_cnts.
  Totals := TABLE(GROUP(grp),{cnp_name,prim_name_derived,v_city_name,st,zip,Tot := SUM(GROUP,Row_Cnt)},cnp_name,prim_name_derived,v_city_name,st,zip);
export SINGLEPRIMRANGE_method_prim_range_derived := JOIN( cmn,Totals,LEFT.cnp_name = RIGHT.cnp_name AND LEFT.prim_name_derived = RIGHT.prim_name_derived AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND LEFT.st = RIGHT.st AND LEFT.zip = RIGHT.zip AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
// Start to gather together all records with basis:cnp_name,prim_name_derived,v_city_name,st,zip
// 0 - Gathering type:SINGLEPRIMRANGE Entries:1
  R0 := RECORD
    TYPEOF(SINGLEPRIMRANGE_method_prim_range_derived.cnp_name) cnp_name;
    TYPEOF(SINGLEPRIMRANGE_method_prim_range_derived.prim_name_derived) prim_name_derived;
    TYPEOF(SINGLEPRIMRANGE_method_prim_range_derived.v_city_name) v_city_name;
    TYPEOF(SINGLEPRIMRANGE_method_prim_range_derived.st) st;
    TYPEOF(SINGLEPRIMRANGE_method_prim_range_derived.zip) zip;
    TYPEOF(SINGLEPRIMRANGE_method_prim_range_derived.prim_range_derived) SINGLEPRIMRANGE_prim_range_derived;
    UNSIGNED prim_range_derived_SINGLEPRIMRANGE_Row_Cnt;
  END;
  R0 T0(SINGLEPRIMRANGE_method_prim_range_derived ri) := TRANSFORM
    SELF.SINGLEPRIMRANGE_prim_range_derived := ri.prim_range_derived;
    SELF.prim_range_derived_SINGLEPRIMRANGE_Row_Cnt := ri.Row_Cnt;
    SELF := ri;
  END;
  J0 := PROJECT(SINGLEPRIMRANGE_method_prim_range_derived,T0(left));
EXPORT BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_np := J0;
EXPORT BestBy_cnp_name_prim_name_derived_v_city_name_st_zip := BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_np : PERSIST('~temp::Proxid::BIPV2_ProxID::best::BestBy_cnp_name_prim_name_derived_v_city_name_st_zip',EXPIRE(Config.PersistExpire));
// Now gather some statistics to see how we did
  R := RECORD
    NumberOfBasis := COUNT(GROUP);
    REAL8 SINGLEPRIMRANGE_prim_range_derived_pcnt := AVE(GROUP,IF(BestBy_cnp_name_prim_name_derived_v_city_name_st_zip.SINGLEPRIMRANGE_prim_range_derived=(typeof(BestBy_cnp_name_prim_name_derived_v_city_name_st_zip.SINGLEPRIMRANGE_prim_range_derived))'',0,100));
  END;
EXPORT BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_population := TABLE(BestBy_cnp_name_prim_name_derived_v_city_name_st_zip,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_cnp_name_prim_name_derived_v_city_name_st_zip(DATASET({BestBy_cnp_name_prim_name_derived_v_city_name_st_zip}) d) := FUNCTION
  R := RECORD
    TYPEOF(h.cnp_name) cnp_name;
    TYPEOF(h.prim_name_derived) prim_name_derived;
    TYPEOF(h.v_city_name) v_city_name;
    TYPEOF(h.st) st;
    TYPEOF(h.zip) zip;
    TYPEOF(h.prim_range_derived) prim_range_derived;
  END;
  R T(BestBy_cnp_name_prim_name_derived_v_city_name_st_zip le) := TRANSFORM
    SELF.prim_range_derived := le.SINGLEPRIMRANGE_prim_range_derived;
    SELF := le; // Copy BASIS
  END;
  P1 := PROJECT(d,T(LEFT));
  RETURN P1;
END;
EXPORT BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_child := F_BestBy_cnp_name_prim_name_derived_v_city_name_st_zip(BestBy_cnp_name_prim_name_derived_v_city_name_st_zip);
EXPORT BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_child_np := F_BestBy_cnp_name_prim_name_derived_v_city_name_st_zip(BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_np);
// Now to produce the slimmed down 'best propagation we can do for this basis'
SHARED Flatten_BestBy_cnp_name_prim_name_derived_v_city_name_st_zip(DATASET({BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_child}) d) := FUNCTION
  R := RECORD
    TYPEOF(h.cnp_name) cnp_name;
    TYPEOF(h.prim_name_derived) prim_name_derived;
    TYPEOF(h.v_city_name) v_city_name;
    TYPEOF(h.st) st;
    TYPEOF(h.zip) zip;
    TYPEOF(h.prim_range_derived) prim_range_derived;
  END;
  R T(BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_child le) := TRANSFORM
    SELF := le; // Copy all non-multi fields
  END;
  P1 := PROJECT(d,T(LEFT));
  RETURN P1;
END;
EXPORT BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_best := Flatten_BestBy_cnp_name_prim_name_derived_v_city_name_st_zip(BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_child);
EXPORT BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_best_np := Flatten_BestBy_cnp_name_prim_name_derived_v_city_name_st_zip(BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_child_np);
EXPORT Stats := PARALLEL(OUTPUT(BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_population,NAMED('BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_Population')));
END;
