// Takes a file with DID/RID already present and a patch file with fields of the same name
// Takes the DID fields from the PATCH file for all of those RIDs present
// Ingoing Assumption: PatchFile is fairly tiny (can fit into a ,LOOKUP)
export MAC_Reassign_UID(infile,patchfile,did_name,rid_name,o) := MACRO
#uniquename(tr)
  typeof(infile) %tr%(infile le,patchfile ri) := TRANSFORM
    SELF.did_name := IF(ri.did_name<>0,ri.did_name,le.did_name);
	  SELF := le;
  END;
	o := JOIN(infile,patchfile,left.rid_name=right.rid_name,%tr%(left,right),LOOKUP,LEFT OUTER);
  ENDMACRO;
