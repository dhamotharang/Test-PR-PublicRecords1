export mac_JoinHeader_Raw(
		infile, outfile, did_field = 'did', outerjoin = false,
    mod_access
) := MACRO

//*** prep for the raw call
#uniquename(makeDIDs)
Doxie.layout_references %makeDIDs%(infile l) := transform
	self.did := l.did_field;
end;

#uniquename(myDIDs)
%myDIDs% := project(infile, %makeDIDs%(left));

//*** call raw
#uniquename(raw)
%raw% := doxie_raw.Header_Raw(%myDIDs%,mod_access);

//*** join the infile back to the raw
#uniquename(outrec)
%outrec% := record
	infile;
	%raw%;
end;

#uniquename(reAppend)
%outrec% %reAppend%(infile l, %raw% r) := transform
	self := l;
	self := r;
end;

outfile := join(infile, %raw%, left.did_field = right.did, %reAppend%(left, right)
	#if(outerjoin)
		, left outer
	#end
	);

ENDMACRO;