// Fuction to remove preceding Seq# from the RMSID for D&B Records. There are occasions where D&B will resend a
// filing to correct an error. When this occurs a sequence (#D) is prefixed to the rmsid to avoid duplicate
// rmsid numbers. However, the party records do not have the sequenced rmsid numbers, to to match up
// with the party records the prefixed seq# is removed.
IMPORT STD;
EXPORT fn_remove_DNB_rmsid_seq(STRING inRmsid, STRING inTmsid) := FUNCTION
   UNSIGNED2 position :=STD.STR.Find(inRmsid,'D',1)+1;
   Rmsid := IF(inTmsid[1..3] = 'DNB', inRmsid[position..], inRmsid);
   RETURN(Rmsid);
END;
