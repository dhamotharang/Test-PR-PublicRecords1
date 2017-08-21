export MAC_Populate_DOB(inds,outds) :=
MACRO
import watchdog;


#uniquename(add_best_dob)
#uniquename(j)
#uniquename(j2)
#uniquename(with_best_dob)
#uniquename(with_more_best_dob)
#uniquename(all_with_best_dob)
#uniquename(without_best_dob)
#uniquename(prop_dob2)
#uniquename(overwrite_best)
#uniquename(bad_with_best_dob)
#uniquename(without_best_dob_prop)

/* ************** DOB Propagate ************ */
inds %add_best_dob%(inds le, watchdog.File_Best ri) :=
TRANSFORM
	SELF.best_dob := ri.dob;
	SELF := le;
END;
%j2% := JOIN(inds, watchdog.File_Best, LEFT.did=RIGHT.did, %add_best_dob%(LEFT,RIGHT), LEFT OUTER, LOCAL);

// For Dids that have a best DOB
%with_best_dob% := %j2%(best_dob<>0);

// If the dob is a low-quality version of best, use best
// If the dob is blank, use best
// Otherwise, keep the dob
%with_best_dob% %overwrite_best%(%with_best_dob% le) :=
TRANSFORM
	self.dob := header.propagate_dob(le.dob,le.best_dob);
	SELF := le;
END;
%with_more_best_dob% := PROJECT(%with_best_dob%, %overwrite_best%(LEFT));

// Duplicate these records with bad DOB's and fill in the best
%bad_with_best_dob% := PROJECT(%with_best_dob%(jflag1 IN ['I','T','B']), TRANSFORM(recordof(%with_best_dob%), SELF.dob := LEFT.best_dob, SELF := LEFT));

%all_with_best_dob% := %with_more_best_dob% + %bad_with_best_dob%;

// For Dids that have no best DOB, then just propagate down, from highest to lowest, filling in "low quality" dobs
%without_best_dob% := %j2%(best_dob=0);

%without_best_dob% %prop_dob2%(%without_best_dob% le,%without_best_dob% ri) := transform
	self.dob := header.propagate_dob(ri.dob,le.dob);
	self := ri;
end;
%without_best_dob_prop% := iterate(GROUP(sort(%without_best_dob%,did,-dob,LOCAL),did,LOCAL), %prop_dob2%(left,right));

outds := %all_with_best_dob% + %without_best_dob_prop%;

ENDMACRO;