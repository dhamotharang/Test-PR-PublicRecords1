export mac_DedupKeepN(infile, outfile, dedupField, NField) := macro
// INFILE SHOULD BE SORTED BY DEDUPFIELD
#uniquename(grp)
%grp% := group(infile, dedupField);

#uniquename(rec)
%rec% := record
	infile;
	localseq := 1;
end;

#uniquename(prj)
%prj% := project(%grp%, %rec%);

#uniquename(tra)
%rec% %tra%(%rec% l, %rec% r) := transform
	self.localseq := l.localseq + r.localseq;
	self := r;
end;

#uniquename(itr)
%itr% := iterate(%prj%, %tra%(left, right));

outfile := group(project(%itr%(localseq <= (integer)Nfield), recordof(infile)));

endmacro;