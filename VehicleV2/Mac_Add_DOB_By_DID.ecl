import dx_BestRecords;

export Mac_Add_DOB_By_DID(infile, append_dob_field, outfile) := macro

// Append "best" information (so far just DOB). Only for "contacts"
// Using best non-glb to be on a safe side.

#uniquename(add_dl)
typeof(infile) %add_dl%(infile L, dx_BestRecords.layout_best R) := TRANSFORM
  SELF.append_dob_field := if (R._valid and L.orig_dob = '', (string8) R.dob, '');
  SELF := L;
END;

#uniquename(best_recs)
%best_recs% := dx_BestRecords.append(infile, append_did, dx_BestRecords.Constants.perm_type.nonglb);

outfile := project(%best_recs%, %add_dl%(left, left._best));

endmacro;