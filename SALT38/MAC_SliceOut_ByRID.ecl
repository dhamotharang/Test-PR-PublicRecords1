/*
 All of the Rids listed in ToSlice (deemed small enough to fit in memory) are to isolated into their own clusters
*/
export MAC_SliceOut_ByRID(infile,rid,did,toslice,rid_l,outfile) := MACRO
#uniquename(r)
%r% := RECORD
  infile;
	UNSIGNED1 ProcessF; // 0 = pass-thru, 1 = did-reset, 2 = is base, 3 = needs reset
  END;
#uniquename(reset_did)
%r% %reset_did%(infile le,toslice ri) := transform
  self.processf := MAP ( ri.rid_l = (typeof(ri.rid_l))'' => 0,
												le.rid = le.did => 2,
												1 );
  self.did := IF ( self.processf = 1, le.rid, le.did );
  self := le;
  end;
// Flag those RIDs that now wish to be on their own
#uniquename(i_recs)
%i_recs% := JOIN(infile,toslice,left.rid=right.rid_l,%reset_did%(left,right),lookup, left outer);
//output(count(%i_recs%(processf=1)),named('irec_1'),overwrite);
//output(count(%i_recs%(processf=2)),named('irec_2'),overwrite);
#uniquename(note_needs)
%r% %note_needs%(%r% le,%r% ri) := transform
  self.processf := IF ( ri.processf = 0, le.processf, 3 );
  self := le;
  end;
// Those 'innocent' RIDs that belong to a DID that now wants to be alone have to be flagged
#uniquename(need_reset)
%need_reset% := JOIN(%i_recs%,%i_recs%(processf=2),left.did = right.did and left.rid<>right.rid, %note_needs%(left,right), left outer, hash);
//output(count(dedup(%need_reset%,did,all)),named('reset_dids'),overwrite);
//output(count(dedup(%need_reset%(processf=3),did,all)),named('reset_dids_todo'),overwrite);
#uniquename(staterec)
%staterec% := RECORD
  SALT38.UIDType Compare_did := 0;
  SALT38.UIDType Copy_did := 0;
  END;
#uniquename(slide_newdid)
%r% %slide_newdid%(%r% le,%staterec% ri) := TRANSFORM
  SELF.DID := IF ( le.did = ri.Compare_did, ri.Copy_Did, le.rid );
  SELF := le;
  END;
#uniquename(newstate)	
%staterec% %newstate%(%r% le,%staterec% ri) := TRANSFORM
  SELF.Compare_Did := le.Did;
	SELF.Copy_Did := IF ( le.did = ri.Compare_did, ri.Copy_Did, le.rid );
  END;
 // This rather painful process is used to copy the lowest RID to a set of DIDs
 // Use process to avoid adding yet another field to the process file
#uniquename(to_change)
%to_change% := PROCESS( SORT( DISTRIBUTE( %need_reset%(processf=3), DID ), DID, RID, LOCAL ),ROW({0,0},%staterec%),%slide_newdid%(LEFT,RIGHT), %newstate%(left,right), LOCAL );
//output(count(dedup(%to_change%,did,all)),named('reset_dids_done'),overwrite);
#uniquename(slim)
typeof(infile) %slim%(%r% le) := TRANSFORM
  SELF := le;
  END;
// Carry forward the 'normal' records and the orphans that had to be renumbered.	
outfile := PROJECT(%to_change%+%need_reset%(processf<>3),%slim%(left));
  ENDMACRO;
