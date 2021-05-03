IMPORT std, SALT311, ut;
// rec := InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch;
EXPORT patch_specificities (matches)  := FUNCTIONMACRO   
  mytb := table(matches(mainnameweight>0), {reference, fname, mname, lname, mainnameweight, integer maxMNW := max(mainnameweight)}, reference, fname, mname, lname, mainnameweight);
  mytb2 := dedup(sort(mytb, reference, -maxMNW), reference)(length(trim(mname))=1); // only for single charater matches
  patched_weights := join(matches, mytb2, 
        left.reference = right.reference and left.fname=right.fname and left.mname[1]=right.mname[1] and left.lname=right.lname, 
        transform(RECORDOF(matches),   
            maxMNW := right.maxMNW; 
            oldMNW := LEFT.mainnameweight;
            newMNW := IF(oldMNW>0 AND LEFT.mnameweight>0, max(oldMNW, maxMNW-1), oldMNW);  // if there is no mainname weight does not change.
            nameweight := MAX(0, left.fnameweight) + MAX(0, left.mnameweight) + MAX(0, left.lnameweight);
            weightDiff := IF(maxMNW=0 OR LEFT.mnameweight=0, 0, // no max weight no difference.
                              newMNW - IF(nameweight> oldMNW and oldMNW>0, nameweight, oldMNW)); 
            self.weight := left.weight + weightDiff;
            self.mainnameweight := newMNW;
            self := left), left outer, hash);
  RETURN SORT(GROUP(patched_weights, Reference, ALL), -weight, DID);
ENDMACRO;


/*
EXPORT patch_specificities (matches)  := FUNCTIONMACRO   
mytb := table(matches(mainnameweight>0), {reference, fname, mname, lname, mainnameweight, integer maxMNW := max(mainnameweight)}, reference, fname, mname, lname, mainnameweight);
  mytb2 := dedup(sort(mytb, reference, -maxMNW), reference)(length(trim(mname))=1); // only for single charater matches
  
  layout := {integer2 maxMNW, integer2 oldMNW, integer2 newMNW, integer nameweight, 
    integer weightDiff, recordof(matches)};
  patched_weights := join(matches, mytb2, 
        left.reference = right.reference and left.fname=right.fname and left.mname[1]=right.mname[1] and left.lname=right.lname, 
        // transform(RECORDOF(matches),   
        transform(layout,   
            maxMNW := right.maxMNW; 
            oldMNW := LEFT.mainnameweight;
            newMNW := IF(oldMNW>0 AND LEFT.mnameweight>0, max(oldMNW, maxMNW-1), oldMNW);  // if there is no mainname weight does not change.
            nameweight := MAX(0, left.fnameweight) + MAX(0, left.mnameweight) + MAX(0, left.lnameweight);
            weightDiff := IF(maxMNW=0 or LEFT.mnameweight=0, 0, // no max weight no difference.
                              newMNW - IF(nameweight> oldMNW and oldMNW>0, nameweight, oldMNW)); 
            self.weight := left.weight + weightDiff;
            self.mainnameweight := newMNW;
            self.maxMNW := maxMNW; 
            self.oldMNW := oldMNW;
            self.newMNW := newMNW;
            self.nameweight := nameweight;
            self.weightDiff := weightDiff;
            self := left), left outer, hash);
output(mytb, named('mytb'));
output(mytb2, named('mytb2'));            
output(patched_weights, named('patched_weights'));
output(SORT(GROUP(patched_weights, Reference, ALL), -weight, DID),  named('patched_weights2'));
  RETURN SORT(GROUP(patched_weights, Reference, ALL), -weight, DID);
ENDMACRO;
*/