import header,doxie;


// at runtime, should be NEW header, not same as
// current one, which should be head2 below....
// we want 3 versions of the header file here.

slimrec := record
	unsigned6	rid;
	unsigned6	did;
end;

slimrec into_slim1(header.layout_header L) := transform
	self := L;
end;

head := project(header.file_headers,into_slim1(LEFT));	  
head2 := project(header.file_header_previous,into_slim1(LEFT));	 
head3 := project(header.file_header_prev_prev,into_slim1(LEFT));	  

doxie.KeyType_Rid_Did into_parent(head L) := transform
	self.rid := L.rid;
	self.did := L.did;
	self.stable := true;
end;

par1 := distribute(project(head,into_parent(LEFT)),hash(rid));

par1 into_two(par1 L, head2 R) := transform
	self.stable := if (r.did = 0, l.stable,L.did = R.did);
	self := L;
end;

par2 := join(par1,distribute(head2,hash(rid)),
			 left.rid=right.rid,
			 into_two(LEFT,RIGHT),local,left outer);

par2 into_three(par2 L, head3 R) := transform
	self.stable := if(r.did = 0, L.stable,L.did = R.did);
	self := L;
end;

par3 := join(par2(stable),distribute(head3,hash(rid)),
		left.rid = right.rid,
		into_three(LEFT,RIGHT),local,left outer) + par2(~stable);

export build_file_base_did_rid := par3 : independent;