EXPORT MAC_UniqueDIDs(out_recs, in_recs) := MACRO

#UNIQUENAME(tmp)
%tmp% := PROJECT(in_recs, { in_recs.did });
out_recs := DEDUP(SORT(%tmp%, RECORD), RECORD);

ENDMACRO;
