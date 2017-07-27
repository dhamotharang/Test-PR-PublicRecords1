export MAC_DID_Diff(old, new, did_field, outfile, rid = 'rid', did_score = 'did_score', mythreshold = '75') := macro

#uniquename(old_dist)
%old_dist% := distribute(old, hash(rid));
#uniquename(new_dist)
%new_dist% := distribute(new, hash(rid));

#uniquename(diff_rec)
%diff_rec% := did_regression.Layout_DID_Diff;

#uniquename(sig)
%sig%(integer2 a, integer2 b) := (a < mythreshold and b >= mythreshold) or
								 (a >= mythreshold and b < mythreshold);

#uniquename(make_diff)
%diff_rec% %make_diff%(old l, new r) := transform
	self.what_happened := 
		map(l.did_field = r.did_field and l.did_score = r.did_score => 'DID same - score same',
		    l.did_field = r.did_field and l.did_score < r.did_score and ~%sig%(l.did_score, r.did_score) 
				=> 'DID same - score up',
		    l.did_field = r.did_field and l.did_score > r.did_score and ~%sig%(l.did_score, r.did_score) 
				=> 'DID same - score down',

		    l.did_field = 0 or (l.did_score < r.did_score and %sig%(l.did_score, r.did_score)) 
				=> 'gained',
		    r.did_field = 0 and l.did_score < mythreshold 
				=> 'lost insig',
		    r.did_field = 0 or (l.did_score > r.did_score and %sig%(l.did_score, r.did_score)) 
				=> 'lost',

			l.did_field <> r.did_field and l.did_score < mythreshold => 'shift insig',
			l.did_field <> r.did_field and l.did_score >= mythreshold => 'shift sig',
			'error in mac_did_diff');

	self.diff_rid := l.rid;
	self.old_did := l.did_field;
	self.old_score := l.did_score;
	self.new_did := r.did_field;
end;

#uniquename(diff)
%diff% := join(%old_dist%, %new_dist%,
			 left.rid = right.rid,
			 %make_diff%(left, right),
			 local);

#uniquename(full_rec)
%full_rec% := record
	%diff_rec%;
	new;
end;

#uniquename(make_full)
%full_rec% %make_full%(new l, %diff% r) := transform
	self := r;
	self := l;
end;

#uniquename(pre_outfile)
%pre_outfile% := join(%new_dist%, %diff%,
				  left.rid = right.diff_rid,
				  %make_full%(left, right),
				  local);

if(count(old) <> count(new), 'Counts Differ! old = ' + (string)count(old) + ', new = ' + (string)count(new), 'Good, counts equal');
ut.MAC_Field_Count(%pre_outfile%, %pre_outfile%.what_happened,'what_happened',true)

outfile := %pre_outfile%(what_happened <> 'DID same - score same');

endmacro;