import watchdog, dx_BestRecords;

export Mac_Add_DOB_By_DID(infile, append_dob_field, outfile) := macro

// Append "best" information (so far just DOB). Only for "contacts"
// Using best non-glb to be on a safe side.


#uniquename(add_dl)
typeof(infile) %add_dl%(infile L, dx_BestRecords.layout_best R) := TRANSFORM
  SELF.append_dob_field := (string8) R.dob;
  SELF := L;
END;

outfile := JOIN (infile, dx_BestRecords.fn_get_best_records(infile, append_did, dx_BestRecords.Constants.perm_type.nonglb),
                    	(Left.append_did != 0 AND Left.orig_dob = '') AND
                    	(Left.append_did = Right.did),
                    	%add_dl%(Left, Right), LEFT OUTER, KEEP (1));

endmacro;