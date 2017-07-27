u := UniqueNames;

Urec := record
	U;
	unsigned4	seq;
end;

Urec into_seq(U L, integer C) := transform
	self.seq := C;
	self := L;
end;

u2 := project(u,into_seq(LEFT,COUNTER));

res := record
  U;
  unsigned2 score := 0;
  end;

bads := patriot.Bad_Names;

res compare(U2 L, Bads R) := transform
	self.score := namecheck(L.fname,L.mname,L.lname,R.fname,R.mname,R.lname);
	self := L;
end;

o1a := join(U2(seq % 4 = 0),bads,
				patriot.namecheck(Left.fname,Left.mname,Left.lname,
								  Right.fname,Right.mname,Right.lname) < 3 ,
			compare(LEFT,RIGHT),left outer,all) : persist('persist::patriot_bn_1');
			
o1b := join(U2(seq % 4 = 1),bads,
				patriot.namecheck(Left.fname,Left.mname,Left.lname,
								  Right.fname,Right.mname,Right.lname) < 3 ,
			compare(LEFT,RIGHT),left outer,all) : persist('persist::patriot_bn_2');

o1c := join(U2(seq % 4 = 2),bads,
				patriot.namecheck(Left.fname,Left.mname,Left.lname,
								  Right.fname,Right.mname,Right.lname) < 3 ,
			compare(LEFT,RIGHT),left outer,all) : persist('persist::patriot_bn_3');

o1d := join(U2(seq % 4 = 3),bads,
				patriot.namecheck(Left.fname,Left.mname,Left.lname,
								  Right.fname,Right.mname,Right.lname) < 3 ,
			compare(LEFT,RIGHT),left outer,all) : persist('persist::patriot_bn_4');


o1 := o1a + o1b + o1c + o1d;

res roll(o1 L, o1 R) := transform
	self.score := if (L.score < R.score, L.score, R.score);
	self := L;
end;

o2 := rollup(sort(distribute(o1,hash(lname)),lname,fname,mname,local),left.fname = right.fname and left.mname = right.mname and left.lname = right.lname,
			roll(LEFT,RIGHT),local);

export ScoreNames := o2 : persist('Patriot::ScoreNames');