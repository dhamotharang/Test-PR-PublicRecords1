export MAC_Match_Roxie(infile, outfile, fuzzy) := macro


#uniquename(outpipe)
did_add.Mac_Match_Fast_Roxie(infile,%outpipe%,'','',fuzzy)

#uniquename(slimrec)
%slimrec% := record
	%outpipe%.seq;
	%outpipe%.did;
	%outpipe%.score;
end;

outfile := table(%outpipe%, %slimrec%);// :  persist('~persist_did_add_mac_match_roxie','100way');

endmacro : DEPRECATED('Use DID_Add.Mac_Match_Roxie_V2 Instead');