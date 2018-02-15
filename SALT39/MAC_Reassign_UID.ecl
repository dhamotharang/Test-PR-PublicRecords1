// Takes a file with DID/RID already present and a patch file with fields of the same name
// Takes the DID fields from the PATCH file for all of those RIDs present
export MAC_Reassign_UID(infile,patchfile,did_name,rid_name,o,penaltee='') := MACRO
#uniquename(tr)
  typeof(infile) %tr%(infile le,patchfile ri) := TRANSFORM
    SELF.did_name := IF(ri.did_name<>0,ri.did_name,le.did_name);
		#IF (#TEXT(penaltee)<>'')
		SELF.penaltee := IF(ri.did_name<>0,ri.penaltee,le.penaltee);
		#END		
	  SELF := le;
  END;
#uniquename(ot)
#uniquename(ofat)	
	%ot% := JOIN(infile,patchfile,left.rid_name=right.rid_name,%tr%(left,right),LOOKUP,LEFT OUTER);
	%ofat% := DISTRIBUTE(JOIN(infile,patchfile,left.rid_name=right.rid_name,%tr%(left,right),LEFT OUTER),HASH(did_name));
//	o := IF( COUNT(patchfile)<50000000, %ot%, %ofat% );
  o := IF( COUNT(patchfile)<SALT39.Config.LookupMaxSize, %ot%, %ofat% );
  ENDMACRO;
