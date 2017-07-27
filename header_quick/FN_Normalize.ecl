import header,ut;
export FN_Normalize(dataset(header.Layout_In_Header) header_in) := 
FUNCTION

Header.MAC_Normalize_Header(header_in, new_month)

fat_rec := header.Layout_Header;


fat_rec trans(new_month le) := TRANSFORM
    // Need to blank last seen for non rec_type_1
	self.src := 'QH';
    self.dt_last_seen := IF (le.rec_type='1',le.dt_last_seen,0);
    self := le;

end;

ids := project(new_month,trans(left));
ut.MAC_Sequence_Records(ids, rid, rids)

return rids;

END;