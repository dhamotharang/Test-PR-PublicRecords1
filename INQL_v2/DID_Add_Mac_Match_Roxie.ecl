export DID_Add_MAC_Match_Roxie(infile, outfile, fuzzy, p_in_matchset=false) := macro

#uniquename(outpipe)
// did_add.Mac_Match_Fast_Roxie(infile,%outpipe%,'','BEST_ALL,MAX_SSN',fuzzy,,,,,p_in_matchset,'40')
DID_add_Mac_Match_Fast_Roxie(infile,%outpipe%,'','BEST_ALL',fuzzy,,,,,'2')

#uniquename(slimrec)
%slimrec% := record
	%outpipe%.seq;
	%outpipe%.did;
	%outpipe%.score;
	%outpipe%.phone10;
	%outpipe%.max_ssn;
	%outpipe%.best_ssn;
end;

outfile := table(%outpipe%, %slimrec%);// :  persist('~persist_did_add_mac_match_roxie','100way');

endmacro;