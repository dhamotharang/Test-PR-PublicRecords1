// Begin code to BEST data for each basis
import SALT24,ut;
EXPORT Best(DATASET(layout_DOT) ih,layout_specificities.R s = Specificities(ih).specificities[1],BOOLEAN RoxieService=FALSE) := MODULE
h00 := Specificities(ih).input_file;
SHARED h := IF(RoxieService,Specificities(ih).input_file_np,h00);

//Create those fields with BestType: UniqueSingleValue
// First step is to get all of the data slimmed and row-reduced
EXPORT UniqueSingleValue_tab_ := DISTRIBUTE(TABLE(h(DOTid <> 0),{DOTid,active_duns_number,active_enterprise_number,active_domestic_corp_key,UNSIGNED Row_Cnt := COUNT(GROUP)},DOTid,active_duns_number,active_enterprise_number,active_domestic_corp_key,MERGE),HASH(DOTid)); // Slim and reduce row-count
Slim := TABLE(UniqueSingleValue_tab_(active_duns_number NOT IN SET(s.nulls_active_duns_number,active_duns_number)),{DOTid,active_duns_number,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT UniqueSingleValue_tab_active_duns_number := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
Slim := TABLE(UniqueSingleValue_tab_(active_enterprise_number NOT IN SET(s.nulls_active_enterprise_number,active_enterprise_number)),{DOTid,active_enterprise_number,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT UniqueSingleValue_tab_active_enterprise_number := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
Slim := TABLE(UniqueSingleValue_tab_(active_domestic_corp_key NOT IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key)),{DOTid,active_domestic_corp_key,Row_Cnt});
Slim TR(Slim le, Slim ri) := TRANSFORM
SELF.Row_Cnt := le.Row_Cnt+ri.Row_Cnt;
SELF := le;
END;
EXPORT UniqueSingleValue_tab_active_domestic_corp_key := ROLLUP( SORT(Slim,EXCEPT Row_Cnt,LOCAL),TR(LEFT,RIGHT), EXCEPT Row_Cnt,LOCAL);
//Now actually find the best value
grp := GROUP( UniqueSingleValue_tab_active_duns_number,DOTid,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the row_cnts.
Totals := TABLE(grp,{DOTid,Tot := SUM(GROUP,Row_Cnt)},DOTid);
export UniqueSingleValue_method_active_duns_number := JOIN( cmn,Totals,left.DOTid = right.DOTid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Now actually find the best value
grp := GROUP( UniqueSingleValue_tab_active_enterprise_number,DOTid,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the row_cnts.
Totals := TABLE(grp,{DOTid,Tot := SUM(GROUP,Row_Cnt)},DOTid);
export UniqueSingleValue_method_active_enterprise_number := JOIN( cmn,Totals,left.DOTid = right.DOTid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
//Now actually find the best value
grp := GROUP( UniqueSingleValue_tab_active_domestic_corp_key,DOTid,ALL,LOCAL);
srt := SORT( grp,-Row_Cnt);
cmn := GROUP( DEDUP( srt, true ) ); // Find the commonest value for a given basis
// A best solution is unique if its Row_Cnt is the same as the sum of the row_cnts.
Totals := TABLE(grp,{DOTid,Tot := SUM(GROUP,Row_Cnt)},DOTid);
export UniqueSingleValue_method_active_domestic_corp_key := JOIN( cmn,Totals,left.DOTid = right.DOTid AND LEFT.Row_Cnt = RIGHT.Tot,TRANSFORM(LEFT),LOCAL);
// Start to gather together all records with basis:DOTid
// 0 - Gathering type:UniqueSingleValue Entries:3
R0 := RECORD
typeof(UniqueSingleValue_method_active_duns_number.DOTid) DOTid; // Need to copy in basis
typeof(UniqueSingleValue_method_active_duns_number.active_duns_number) UniqueSingleValue_active_duns_number;
UNSIGNED active_duns_number_UniqueSingleValue_Row_Cnt;
END;
R0 T0(UniqueSingleValue_method_active_duns_number ri) := TRANSFORM
SELF.UniqueSingleValue_active_duns_number := ri.active_duns_number;
SELF.active_duns_number_UniqueSingleValue_Row_Cnt := ri.Row_Cnt;
SELF := ri;
END;
J0 := PROJECT(UniqueSingleValue_method_active_duns_number,T0(left));
R1 := RECORD
J0; // The data so far
typeof(UniqueSingleValue_method_active_enterprise_number.active_enterprise_number) UniqueSingleValue_active_enterprise_number;
UNSIGNED active_enterprise_number_UniqueSingleValue_Row_Cnt;
END;
R1 T1(J0 le,UniqueSingleValue_method_active_enterprise_number ri) := TRANSFORM
SELF.UniqueSingleValue_active_enterprise_number := ri.active_enterprise_number;
SELF.active_enterprise_number_UniqueSingleValue_Row_Cnt := ri.Row_Cnt;
BOOLEAN has_left := le.DOTid <> (TYPEOF(le.DOTid))''; // See if LHS is null
SELF.DOTid := IF( has_left, le.DOTid, ri.DOTid );
SELF := le;
END;
J1 := JOIN(J0,UniqueSingleValue_method_active_enterprise_number,LEFT.DOTid = RIGHT.DOTid,T1(LEFT,RIGHT),FULL OUTER,LOCAL);
R2 := RECORD
J1; // The data so far
typeof(UniqueSingleValue_method_active_domestic_corp_key.active_domestic_corp_key) UniqueSingleValue_active_domestic_corp_key;
UNSIGNED active_domestic_corp_key_UniqueSingleValue_Row_Cnt;
END;
R2 T2(J1 le,UniqueSingleValue_method_active_domestic_corp_key ri) := TRANSFORM
SELF.UniqueSingleValue_active_domestic_corp_key := ri.active_domestic_corp_key;
SELF.active_domestic_corp_key_UniqueSingleValue_Row_Cnt := ri.Row_Cnt;
BOOLEAN has_left := le.DOTid <> (TYPEOF(le.DOTid))''; // See if LHS is null
SELF.DOTid := IF( has_left, le.DOTid, ri.DOTid );
SELF := le;
END;
J2 := JOIN(J1,UniqueSingleValue_method_active_domestic_corp_key,LEFT.DOTid = RIGHT.DOTid,T2(LEFT,RIGHT),FULL OUTER,LOCAL);
EXPORT BestBy_DOTid_np := J2;
EXPORT BestBy_DOTid := BestBy_DOTid_np;
// Now gather some statistics to see how we did
R := RECORD
NumberOfBasis := COUNT(GROUP);
REAL8 UniqueSingleValue_active_duns_number_pcnt := AVE(GROUP,IF(BestBy_DOTid.UniqueSingleValue_active_duns_number=(typeof(BestBy_DOTid.UniqueSingleValue_active_duns_number))'',0,100));
REAL8 UniqueSingleValue_active_enterprise_number_pcnt := AVE(GROUP,IF(BestBy_DOTid.UniqueSingleValue_active_enterprise_number=(typeof(BestBy_DOTid.UniqueSingleValue_active_enterprise_number))'',0,100));
REAL8 UniqueSingleValue_active_domestic_corp_key_pcnt := AVE(GROUP,IF(BestBy_DOTid.UniqueSingleValue_active_domestic_corp_key=(typeof(BestBy_DOTid.UniqueSingleValue_active_domestic_corp_key))'',0,100));
END;
EXPORT BestBy_DOTid_population := TABLE(BestBy_DOTid,R);
// Take the wide table and turn it into a child-dataset version
SHARED F_BestBy_DOTid(DATASET({BestBy_DOTid}) d) := FUNCTION
R := RECORD
typeof(h.DOTid) DOTid := 0;
typeof(h.active_duns_number) active_duns_number;
typeof(h.active_enterprise_number) active_enterprise_number;
typeof(h.active_domestic_corp_key) active_domestic_corp_key;
END;
R T(BestBy_DOTid le) := TRANSFORM
SELF.active_duns_number := le.UniqueSingleValue_active_duns_number;
SELF.active_enterprise_number := le.UniqueSingleValue_active_enterprise_number;
SELF.active_domestic_corp_key := le.UniqueSingleValue_active_domestic_corp_key;
SELF := le; // Copy BASIS
END;
P1 := PROJECT(d,T(LEFT));
RETURN P1;
END;
EXPORT BestBy_DOTid_child := F_BestBy_DOTid(BestBy_DOTid);
EXPORT BestBy_DOTid_child_np := F_BestBy_DOTid(BestBy_DOTid_np);
// Now to produce the slimmed down 'best propagation we can do for this basis'
// Additionally apply OWN processing
SHARED Flatten_BestBy_DOTid(DATASET({BestBy_DOTid_child}) d) := FUNCTION
R := RECORD
typeof(h.DOTid) DOTid := 0;
typeof(h.active_duns_number) active_duns_number;
typeof(h.active_enterprise_number) active_enterprise_number;
typeof(h.active_domestic_corp_key) active_domestic_corp_key;
END;
R T(BestBy_DOTid_child le) := TRANSFORM
SELF := le; // Copy all non-multi fields
END;
P1 := PROJECT(d,T(LEFT));
RETURN P1;
END;
EXPORT BestBy_DOTid_best := Flatten_BestBy_DOTid(BestBy_DOTid_child);
EXPORT BestBy_DOTid_best_np := Flatten_BestBy_DOTid(BestBy_DOTid_child_np);
EXPORT Stats := PARALLEL(OUTPUT(BestBy_DOTid_population,NAMED('BestBy_DOTid_Population')));
END;
