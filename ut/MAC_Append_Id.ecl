export MAC_Append_Id(infile,link_Field,append_field,patchfile,left_field,right_field,outfile) := macro

//-- Transform used by join below
//   If there is a new ID in the patchfile, replace the old ID.  Otherwise retain it.
#uniquename(tra)
typeof(infile) %tra%(infile l, patchfile rec) := transform
  self.append_field := if(rec.right_field<>0,rec.right_field,l.append_field); 
  self := l;
  end;

//****** Distribute infile by link_field to prepare for local join.
#uniquename(dinfile)
%dinfile% := distribute(infile,hash((integer8)link_field));

//****** Distribute patchfile by left_field to prepare for local join.
#uniquename(dpatchfile)
%dpatchfile% := distribute(patchfile,hash((integer8)left_field));

//****** Local left outer join of infile to patchfile on link_field = left_field using tra above
#uniquename(j1)
#uniquename(j2)
%j1% := join(%dinfile%,%dpatchfile%,left.link_field=right.left_field,%tra%(left,right),left outer, local);

%j2% := join(infile,patchfile,left.link_field=right.left_field,%tra%(left,right),left outer, lookup);

outfile := if ( count(patchfile)*sizeof(patchfile) < 300000000, %j2%, %j1% );
//outfile := %j2%;

  endmacro;