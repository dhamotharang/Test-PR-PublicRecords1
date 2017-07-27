import watchdog;

export Mac_Add_DOB_By_DID(infile, append_dob_field, outfile) := macro

// Append "best" information (so far just DOB). Only for "contacts"
// Using best non-glb to be on a safe side.


#uniquename(add_dl)

typeof(infile) %add_dl%(infile L, watchdog.Key_watchdog_nonglb R) := TRANSFORM
  SELF.append_dob_field := (string8) R.dob;
  SELF := L;
END;

outfile := JOIN (infile, watchdog.Key_watchdog_nonglb,
                      (Left.append_did != 0 AND Left.orig_dob = '') AND
                       keyed (Left.append_did = Right.did),
                       %add_dl%(Left, Right), LEFT OUTER, KEEP (1));

endmacro;