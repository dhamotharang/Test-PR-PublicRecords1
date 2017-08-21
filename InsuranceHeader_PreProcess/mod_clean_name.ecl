// 1)	If fname is blank and mname multi-token then pull first token from mname
// 2)	If fname & mname are blank and lname multi-token pull first token from lname
// 3)	If mname is blank and lname multi-token and first token of lname is gender-identifyable then pull first token from lname
// 4)	If lname is blank and mname is multi-token pull last token from mname
// 6)	If last two chars of lname are JR or SR, or last 3 chars are III then pull into name suffix
import ut;
export mod_clean_name(string sname, string fname, string mname, string lname) := module

	// Jr or Sr in last name
	shared idx_from := (length(lname)-1);
	shared idx_to   := (length(lname));
	shared suffixInLastName := if(lname[idx_from..idx_to] = 'SR' or lname[idx_from..idx_to] = 'JR', true, false);
	// Remove suffix name from last name
	shared updatedLname := if(/*sname = '' and */suffixInLastName, lname[1..length(lname)-2], lname);

	shared fnameTokens := stringlib.StringFindCount(fname, ' ') + 1;
	shared mnameTokens := stringlib.StringFindCount(mname, ' ') + 1;
	shared lnameTokens := stringlib.StringFindCount(lname, ' ') + 1;
	
	export first_name 	:= map(fname = '' and mnameTokens > 1 => ut.word(mname, 1, ' '),
														 fname = '' and mname = '' and lnameTokens > 1 => ut.word(updatedLname, 1, ' '),
														 fname);

	export middle_name 	:= map(mname = '' and lnameTokens > 1 and fname != ''=> ut.word(updatedLname, 1, ' '),
																						mnameTokens > 1 and fname = '' => ut.word(mname, 2, ' '),
														 mname);

	export last_name 		:= map(updatedLname = '' and mnameTokens > 1 and fname != '' => ut.word(mname, 2, ' '),
																						       lnameTokens > 1 and (fname  = '' or mname = '') => ut.word(updatedLname, 2, ' '),
														 updatedLname);

	export suffix_name 	:= if(sname = '' and suffixInLastName, lname[idx_from..idx_to], sname);
														 
end;