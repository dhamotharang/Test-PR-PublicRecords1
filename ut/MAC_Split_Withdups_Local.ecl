export MAC_Split_Withdups_Local(infile,infield,thresh,outfile,remainder) := macro
  // similar to remove_withdups but assumes data is local and doesn't destroy that
  #uniquename(r)
%R% := record
  infile;
  integer8 cnt := 0;
end;
  #uniquename(p)
  #uniquename(tra)

%r% %tra%(infile lef) := transform
  self.cnt := 0;
  self := lef;
  end;

%p% := project(infile,%tra%(left));

#uniquename(grp)
%grp% := group(sort(%p%,infield,local),infield,local);

#uniquename(add_cnt)
%r% %add_cnt%(%R% lef,%R% ref) := transform
  self.cnt := lef.cnt+1;
  self := ref;
  end;
#uniquename(i)
%i% := group(sort(group(iterate(%grp%,%add_cnt%(left,right))),infield,-cnt,local),infield,local);

#uniquename(cpy)
%r% %cpy%(%R% lef,%R% ref) := transform
  self.cnt := IF(lef.cnt=0,ref.cnt,lef.cnt);
  self := ref;
  end;
#uniquename(i1)
%i1% := group(iterate(%i%,%cpy%(left,right)));

#uniquename(null_join)
typeof(infile) %null_join%(%r% l) := transform
  self := l;
  end;

outfile := project(%i1%(cnt<thresh),%null_join%(left));
remainder := project(%i1%(cnt>=thresh),%null_join%(left));

  endmacro;