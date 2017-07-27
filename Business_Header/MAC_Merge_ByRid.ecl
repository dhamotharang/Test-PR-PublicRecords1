EXPORT MAC_Merge_ByRid(infile,outfile) := MACRO
//-- Function that returns 0 if no zip4, otherwise 1
MAC_BR_hasz4 := IF(infile.zip4=0, 0, 3) + IF(infile.sec_range='', 1, 2);

#uniquename(dinfile)
dinfile := DISTRIBUTE(infile, HASH(rcid));

//****** Sort each group of rids by rcid, descending MAC_BR_hasz4,
//		 descending vendor last reported date, ascending vendor first reported date
//       The local is ok because of the preceeding distribute
#uniquename(dinfile_sort)
dinfile_sort := SORT(dinfile, rcid,-MAC_BR_hasz4, dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);

//****** Rollup the records with matching rcid.  Keep the one first in sort order above.
//		 If the first record has a blank field, info will be taken from the second.
outfile := ROLLUP(dinfile_sort,
                  LEFT.rcid = RIGHT.rcid,
                  Business_Header.TRA_Merge_Business_Headers(LEFT, RIGHT),
                  LOCAL);

ENDMACRO;