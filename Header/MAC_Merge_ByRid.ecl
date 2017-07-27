export MAC_Merge_ByRid(infile,outfile) := macro
//-- Function that returns 0 if no zip4, otherwise 1
MAC_BR_hasz4 := if ( (integer)infile.zip4=0,0, 3) + IF(infile.sec_range='',1,2);

dinfile := distribute(infile,hash(rid));

//****** Sort each group of rids by rid, descending MAC_BR_hasz4,
//		 descending vendor last reported date, ascending vendor first reported date
//       The local is ok because of the preceeding distribute
MAC_BR_s := sort(dinfile, rid,-MAC_BR_hasz4,dt_vendor_last_reported,dt_vendor_first_reported,dt_last_seen,local);

//****** Rollup the records with matching rid.  Keep the one first in sort order above.
//		 If the first record has a blank field, info will be taken from the second.
outfile := rollup(MAC_BR_s,left.rid=right.rid,header.tra_merge_headers(left,right),local);

  endmacro;