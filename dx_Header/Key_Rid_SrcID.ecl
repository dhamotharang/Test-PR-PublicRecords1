IMPORT $;

// TODO: comments on the signature
EXPORT key_Rid_SrcID (integer data_category = 0, boolean pFastHeader = FALSE,  boolean pCombo = TRUE) := 
  INDEX ({$.layouts.i_rid.rid}, 
	       $.layouts.i_rid_src,
         $.names().i_rid_src + IF (pCombo, '', $.Functions.SF_suffix (pFastHeader)), OPT);
