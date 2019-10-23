EXPORT MAC_Sequence_Records(infile,idfield,outfile,seed=1) := MACRO

#uniquename(tr1)
{infile} %tr1%(infile L) := transform
	self.idfield := 0 ; 
	self := l;
end;
#uniquename(p)
%p% := project(infile,%tr1%(left));

#uniquename(tr2)
{infile} %tr2%(%p% l,%p% r) := transform
	self.idfield := if(l.idfield=0, thorlib.node() + seed, l.idfield + thorlib.nodes() );
	self := r;
end;
outfile := iterate(%p%,%tr2%(left,right),local);

ENDMACRO;