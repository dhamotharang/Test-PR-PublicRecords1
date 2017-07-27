import watchdog;
export fn_Populate_SSN(dataset(layout_matchcandidates)inds,dataset(watchdog.Layout_Best) bestfile) :=
function


/* ************** SSN Propagate ************ */
#uniquename(add_best_ssn)
#uniquename(j)
#uniquename(with_best_ssn)
#uniquename(with_more_best_ssn)
#uniquename(bad_with_best)
#uniquename(all_with_best)
#uniquename(without_best_ssn)

inds %add_best_ssn%(inds le, watchdog.File_Best ri) :=
TRANSFORM
	SELF.best_ssn := ri.ssn;
	SELF := le;
END;
%j% := JOIN(inds, bestfile, LEFT.did=RIGHT.did, %add_best_ssn%(LEFT,RIGHT), LEFT OUTER, LOCAL);

// For DIDs that have a best ssn
%with_best_ssn% := %j%(best_ssn<>'');
// Propogate best into blanks
%with_more_best_ssn% := PROJECT(%with_best_ssn%, TRANSFORM(layout_matchcandidates, SELF.ssn := IF(LEFT.ssn='',LEFT.best_ssn,LEFT.ssn), 
																																		 SELF.valid_ssn := IF(LEFT.ssn='','G',LEFT.valid_ssn), SELF := LEFT));
// Dupe bad SSN records with the best SSN
%bad_with_best% := PROJECT(%with_best_ssn%(valid_ssn IN ['F','R','O','U','B']), TRANSFORM(layout_matchcandidates, SELF.ssn := LEFT.best_ssn, SELF.valid_ssn := 'G', SELF := LEFT));
// All header records for Dids that have best ssn
%all_with_best% := %with_more_best_ssn% + %bad_with_best%;

// For Dids that don't have a best ssn
%without_best_ssn% := %j%(best_ssn='');

return %all_with_best% + %without_best_ssn%;
 
END;