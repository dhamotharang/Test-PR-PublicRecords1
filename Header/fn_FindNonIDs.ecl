rec := header.layout_NonIDs;

export fn_FindNonIDs(
	dataset(rec) pm,
	unsigned4 thresh = 100) :=
FUNCTION

hft := 
	dedup(sort(distribute(project(pm(ID <> ''), 	transform({pm.ID, string1 finit, string1 linit}, 
																							self.finit := if(left.fname[1] < left.lname[1], left.fname[1], left.lname[1]), 
																							self.linit := if(left.fname[1] < left.lname[1], left.lname[1], left.fname[1]),
																							self := left))
												 , hash(ID)), 
						 ID, finit, linit, local), 
				ID, finit, linit, local);

r2 := record
	hft.ID;
	cnt := count(group);
end;

t2 := table(hft, r2, ID, local);

bad := dedup(sort(t2(cnt > thresh), ID, local), ID, local);

// output(t2, named('t2'));

return bad;
END;