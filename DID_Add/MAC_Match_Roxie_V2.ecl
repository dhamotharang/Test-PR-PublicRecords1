export MAC_Match_Roxie_v2(infile, outfile, fuzzy) := macro


#uniquename(outpipe)
did_add.Mac_Match_Fast_Roxie_v2(infile,%outpipe%,'','',fuzzy)

#uniquename(slimrec)
%slimrec% := record
	%outpipe%.seq;
	%outpipe%.did;
	%outpipe%.score;
end;

outfile := table(%outpipe%, %slimrec%);

endmacro;