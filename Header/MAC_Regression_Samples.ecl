export MAC_Regression_Samples(dold, dnew, diff, rid_rield, happened, intchoosen, old, new)
	:= macro

#uniquename(dint)
%dint% := diff(what_happened = happened);

#uniquename(prod)
typeof(dold) %prod%(dold le) := transform
  self := le;
  end;

#uniquename(from_old)
#uniquename(from_new)
%from_old% := join(dold,%dint%,left.rid_rield=right.rid_rield,%prod%(left),lookup);
%from_new% := join(dnew,%dint%,left.rid_rield=right.rid_rield,%prod%(left),lookup);

old := output(choosen(%from_old%,intchoosen));
new := output(choosen(%from_new%,intchoosen));

endmacro;