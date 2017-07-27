export MAC_Improve_Prim_Range(infile, prim_range_field,outfile) := macro

#uniquename(betterRange)
qstring10 %betterRange%(qstring10 pr) := 
	trim((qstring10)((integer8)pr), left, right);

#uniquename(isBadRange)
boolean %isBadRange%(qstring10 pr) := 
	pr[1] = '0' and (integer4)pr > 0;

#uniquename(fixem)
typeof(infile) %fixem%(infile l) := transform
	self.prim_range_field := 
		if(%isBadRange%(l.prim_range_field),
		   %betterRange%(l.prim_range_field),
		   l.prim_range_field);
	self := l;
end;

outfile := project(infile, %fixem%(left));

endmacro;