//**************************************************************
// Address Match using zip, prim_range, prim_name, and sec_range
//**************************************************************

IMPORT ut;

EXPORT BOOLEAN Address_Match(UNSIGNED3 zip1, UNSIGNED3 zip2,
                     STRING10 prim_range1, STRING10 prim_range2,
                     STRING28 prim_name1, STRING28 prim_name2,
                     STRING8 sec_range1,  STRING8 sec_range2) :=
                       IF ((INTEGER)zip1 <> 0 and (INTEGER)zip2 <> 0 and
                           prim_name1 <> '' and prim_name2 <> '' and
                           ((integer)prim_range1<>0 or 
                                 (prim_name1[1..7]='PO BOX ' and
                                 (integer)(prim_name1[8..length(prim_name1)])<>0) or
                                 (prim_name1[1..3]='RR ' and
                                 (integer)(prim_name1[4..length(prim_name1)])<>0)) and
                           ((integer)prim_range2<>0 or 
                                 (prim_name2[1..7]='PO BOX ' and
                                 (integer)(prim_name2[8..length(prim_name2)])<>0) or
                                 (prim_name2[1..3]='RR ' and
                                 (integer)(prim_name2[4..length(prim_name2)])<>0)) and
                           zip1 = zip2 and
                           prim_range1 = prim_range2 and
                           prim_name1 = prim_name2 and
                           ut.NNEQ(sec_range1, sec_range2), TRUE, FALSE);