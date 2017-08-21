import ut,header;

export Fn_ApplyDodgyDIDs(
	dataset(header.Layout_Header) head,
	dataset(header.layout_DodgyDids) dodgies) :=
FUNCTION

merged := head;

r1 := record
 boolean is_dodgy;
 head;
end;

//typeof(merged) fix_did(merged le,dodgies ri) := transform
r1 fix_did(merged le,dodgies ri) := transform
  
  self.is_dodgy := le.did=ri.did;
  
  self.did := if ( ri.did=0, le.did, le.rid ); // Patch did back to rid if dodgy
  self.pflag1 := IF( ri.did=0, le.pflag1, 'D' );
  self.name_suffix := IF(ut.is_unk(le.name_suffix) AND ri.did<>0,
													// increase UN# if it already had a UNK, but is dodgy again
													header.unk_add(le.name_suffix),
													// otherwise, do the same as always
													IF(~le.name_suffix IN ['','BOO'] or ri.did=0,le.name_suffix,'UNK'));
  self := le;
  end;

neg_dids := join(merged,dodgies,left.did=right.did,fix_did(left,right),left outer,lookup);
return neg_dids;

/*
THIS FUNCTION USES A LOOKUP JOIN AND DOES NOT AFFECT DISTRIBUTION OF THE HEADER FILE
THIS SHOULD REMAIN TRUE
*/
END;