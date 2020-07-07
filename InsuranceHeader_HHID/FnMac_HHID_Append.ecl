//**************************************************************************************************************
//** FnMac_HHID_Append - is a FUNCTIONMACRO that can be used to find additional lexids in the same household as the input lexid.
//** Parameters:
//**     infile 					=> Your dataset MUST contain a LexId field
//**     Input_LexId			=> LexId field
//**     Input_UniqueId		=> UniqueId field used to track each row
//**     returnlimit			=> max # of household lexids to return (unsorted)
//**     forcePull				=> set TRUE to pull keys or FALSE for indexed joins, overriding default check 
//**														(defaults to TRUE, sets to FALSE if running on less than 400 nodes or have less than 13M input recs)
//** Return:
//**     Your orginal dataset with hhid_relat and the additional household lexids appended.
//** Cody Fouts 3/7/2019
//**************************************************************************************************************

EXPORT FnMac_HHID_Append (infile,Input_LexID,Input_UniqueID='',returnlimit=20,forcePull=''):= FUNCTIONMACRO

IMPORT InsuranceHeader_Postprocess,IDLExternalLinking,Doxie;

forcePull_populated := #IF(#TEXT(forcePull)<> '')
												 TRUE;
											 #ELSE
												 FALSE;
											 #END

pullJoin := #IF(forcePull_populated)
							forcePull;
						#ELSE
							IF(thorlib.nodes() < 400 OR COUNT(infile) < 13000000,FALSE,TRUE);
						#END

////** Set a new Layout
inRec := RECORD
		unsigned8 i_uniqueid;
		unsigned8 i_lexid;
		recordof(infile);
		unsigned6 hhid_relat;
		DATASET({unsigned8 did}) household_lexids;
END;

////** Combine Parms and orginal File
inRec setlayout(infile L,integer C) := TRANSFORM
		SELF.i_uniqueid 			:= 	 #IF (#TEXT(Input_UniqueID)<>'')
																(TYPEOF(SELF.i_uniqueid))l.Input_UniqueID;
															 #ELSE
																(TYPEOF(SELF.i_uniqueid))C;
															 #END	
		SELF.i_lexid 					:= 	 #IF (#TEXT(Input_LexID)<>'')
																(TYPEOF(SELF.i_lexid))l.Input_LexID;
															 #ELSE
																(TYPEOF(SELF.i_lexid))'';
															 #END		
		SELF.hhid_relat				:= 	 [];
		SELF.household_lexids :=   [];
		SELF 									:= 	 L;		
	END;
	
file_in := PROJECT(infile, setlayout(LEFT,COUNTER));

key_did := Doxie.Key_Did_HDid; //want latest version
key_did_dist := DISTRIBUTE(PULL(key_did(ver = 1)),did);

////** Get hhid_relat by did
inRec joinByDid(inRec L, key_did R) := TRANSFORM
	 SELF.hhid_relat := R.hhid_relat;
	 SELF := L;
 END;


jn_did_pull := JOIN(DISTRIBUTE(file_in(i_lexid>0),i_lexid), key_did_dist,
									LEFT.i_lexid = RIGHT.did,
									joinByDid(LEFT, RIGHT), LEFT OUTER, LOCAL);

jn_did_index := JOIN(file_in(i_lexid>0), key_did,
									KEYED(LEFT.i_lexid = RIGHT.did) AND
									KEYED(RIGHT.ver = 1),
									joinByDid(LEFT, RIGHT), LEFT OUTER);

jn_did := IF(pullJoin,jn_did_pull,jn_did_index);

key_hhid := Doxie.Key_HHID_Did; //want latest version
key_hhid_dist := DISTRIBUTE(PULL(key_hhid(ver = 1)),hhid_relat);   

didRec := RECORD
	unsigned8 i_uniqueid;
	unsigned8 did;
END;

////** get all dids for latest hhid_relat
didRec joinByHHid(inRec L, key_hhid R) := TRANSFORM
	 SELF.i_uniqueid := L.i_uniqueid;
	 SELF.did := IF(R.did = L.i_lexid,SKIP,R.did);
 END;


jn_hhid_pull := JOIN(DISTRIBUTE(jn_did(hhid_relat>0),hhid_relat), key_hhid_dist,
									LEFT.hhid_relat = RIGHT.hhid_relat,
									joinByHHid(LEFT, RIGHT), KEEP(returnLimit),LOCAL);

jn_hhid_index := JOIN(jn_did(hhid_relat>0), key_hhid,
									KEYED(LEFT.hhid_relat = RIGHT.hhid_relat) AND
									KEYED(RIGHT.ver = 1),
									joinByHHid(LEFT, RIGHT), KEEP(returnLimit));

jn_hhid := IF(pulljoin,jn_hhid_pull,jn_hhid_index);

allowedInds := [IDLExternalLinking.Constants.CORE_IND,IDLExternalLinking.Constants.DEAD_IND];

key_seg := InsuranceHeader_Postprocess.segmentation_keys.key_did_ind;
key_seg_dist := DISTRIBUTE(PULL(InsuranceHeader_Postprocess.segmentation_keys.key_did_ind(ind IN allowedInds)),did);

////** filter to CORE/DEAD
jn_seg_pull := JOIN(DISTRIBUTE(jn_hhid,did), key_seg_dist,
									LEFT.did = RIGHT.did,
									TRANSFORM(didRec,SELF:=LEFT),LOCAL);

jn_seg_index := JOIN(jn_hhid, key_seg,
									KEYED(LEFT.did = RIGHT.did) AND
									RIGHT.ind IN allowedInds,
									TRANSFORM(didRec,SELF:=LEFT));

jn_seg := IF(pulljoin,jn_seg_pull,jn_seg_index);

////** add dids to output file using uniqueid
inRec joinByUid(inRec L, DATASET(didRec) R) := TRANSFORM
	 SELF.household_lexids := PROJECT(R,TRANSFORM({unsigned8 did},SELF:=LEFT));
	 SELF := L;
 END;

jn_uid_pull := DENORMALIZE(jn_did(hhid_relat>0), jn_seg,
									LEFT.i_uniqueid = right.i_uniqueid,
									GROUP,
									joinByUid(LEFT, ROWS(RIGHT)), LEFT OUTER, hash);

jn_uid_index := DENORMALIZE(jn_did(hhid_relat>0), jn_seg,
									LEFT.i_uniqueid = right.i_uniqueid,
									GROUP,
									joinByUid(LEFT, ROWS(RIGHT)), LEFT OUTER);

jn_uid := IF(pulljoin,jn_uid_pull,jn_uid_index); 

outRec := RECORD
	recordof(infile);
	unsigned6 hhid_relat;
	DATASET({unsigned8 did}) household_lexids;
END;

////** Reset back to the original Layout
outfile0_pull := DISTRIBUTE(file_in(i_lexid = 0) + jn_did(hhid_relat = 0) + jn_uid,i_uniqueid);
outfile_pull := PROJECT(outfile0_pull,TRANSFORM(outRec,SELF:=LEFT),LOCAL);

outfile0_index := file_in(i_lexid = 0) + jn_did(hhid_relat = 0) + jn_uid;
outfile_index := PROJECT(outfile0_index,TRANSFORM(outRec,SELF:=LEFT));

outfile := IF(pulljoin,outfile_pull,outfile_index);
	
RETURN outfile;

ENDMACRO;