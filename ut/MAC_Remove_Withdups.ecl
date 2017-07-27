export MAC_Remove_Withdups(infile,infield,thresh,outfile) := macro
  #uniquename(r)
%R% := record
  infile;
  integer8 seq_no := 0;
  integer8 cnt := 0;
end;
  #uniquename(p)
  #uniquename(tra)

%r% %tra%(infile lef) := transform
  self.seq_no := 0;
  self.cnt := 0;
  self := lef;
  end;

%p% := project(infile,%tra%(left));

#uniquename(ws)

ut.MAC_Sequence_Records(%p%,seq_no,%ws%)

#uniquename(grp)
%grp% := group(%ws%,infield,all);

  #uniquename(add_cnt)
%r% %add_cnt%(%R% lef,%R% ref) := transform
  self.seq_no := if ( lef.seq_no = 0, ref.seq_no, lef.seq_no );
  self.cnt := lef.cnt+1;
  self := ref;
  end;
#uniquename(i)
%i% := iterate(%grp%,%add_cnt%(left,right));

#uniquename(to_rip)
%to_rip% := %i%(cnt=thresh);

#uniquename(null_join)
typeof(infile) %null_join%(%r% l) := transform
  self := l;
  end;
// The ,local is ok because these elements of grouped data
outfile := join(%i%,%to_rip%,left.seq_no=right.seq_no,%null_join%(left),left only,lookup);

  endmacro;