export MAC_Remove_Withdups(infile,infield,thresh,outfile) := macro
  #uniquename(r)
%R% := record
  unsigned8 hv;
end;
  #uniquename(tra)
	
%r% %tra%(infile le) := transform
  self.hv := hash64(evaluate(le,infield));
  end;	
  #uniquename(t)
%t% := project(infile,%tra%(left));
  #uniquename(rt)
%Rt% := record
  %t%.hv;
	unsigned8 cnt := count(group);
end;
  #uniquename(tl)
%tl% := table(%t%,%RT%,hv,local);
  #uniquename(rtt)
%RTT% := record
  %tl%.hv;
	unsigned8 cnt := sum(group,%tl%.cnt);
end;
  #uniquename(tll)
%tll% := table(%tl%,%RTT%,hv)(cnt>thresh);
outfile := join(infile,%tll%,hash64(evaluate(left,infield))=right.hv,transform(left),left only,lookup);
  endmacro;
