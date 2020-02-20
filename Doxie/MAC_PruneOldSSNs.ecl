export MAC_PruneOldSSNs(infile, outfile, ssn_field, did_field, is_fcra=false) := macro

IMPORT dx_header, doxie;
  // no need to import doxie, since it must inevitable been done by the caller

// need to eliminate any SSNs that aren't recent or dead if ~keep_old_ssns

// TODO: FCRA version will be "activated" when the index is included into fcra-header build.
#uniquename(kdsd)
%kdsd% := dx_header.key_DID_SSN_date ();

#uniquename(pruneSsns)
infile %pruneSsns%(infile l, %kdsd% r) := TRANSFORM
  // key_DID_SSN_date is an exclusion key, so if not found the ssn is OK to display
	SELF.ssn_field := IF(r.did = 0, l.ssn_field, '');
	SELF := l;
END;

#uniquename(pruned)
#uniquename(pruned_fcra)
%pruned% := join (infile, %kdsd%,
                  keyed ((unsigned6) LEFT.did_field = RIGHT.did) and
                  keyed (LEFT.ssn_field = RIGHT.ssn), 
                  %pruneSsns%(LEFT,RIGHT), LEFT OUTER, KEEP(1), LIMIT(0));

%pruned_fcra% := infile;

outfile := if(doxie.keep_old_ssns_val,
              infile,
              if (is_fcra, %pruned_fcra%, %pruned%));
endmacro;
