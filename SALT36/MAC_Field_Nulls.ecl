// Assumes count for value is in 'cnt' field
export MAC_Field_Nulls(infile,null_type,outfile) := MACRO
#uniquename(topn_r)
%topn_r% := record
  infile;
	real8 rat := 0.0;
  end;
#uniquename(topnf)
%topnf% := topn(table(infile,%topn_r%),2000,-cnt);
#uniquename(note_rat)
%topn_r% %note_rat%(%topnf% le,%topnf% ri) := transform
  self.rat := if ( ri.cnt=0, 1, le.cnt/ri.cnt );
  self := ri;
  end;
		
#uniquename(acnt)
%acnt% := ave(infile,cnt) * 0.25;
#uniquename(nv)
%nv% := sort(iterate(%topnf%,%note_rat%(left,right))(rat>5,cnt>%acnt%),cnt);
#uniquename(tnv)
%tnv% := %topnf%(exists(%nv%) and cnt>%nv%[1].cnt)+dataset([transform(%topn_r%, SELF := [])]);
#uniquename(inv)
null_type %inv%(%tnv% le) := transform
  self := le;
  end;
outfile := project(%tnv%,%inv%(left));
  ENDMACRO;
