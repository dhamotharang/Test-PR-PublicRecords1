IMPORT $;

// TODO: comments on the signature
EXPORT key_RID (integer data_category = 0, boolean pFastHeader = FALSE,  boolean pCombo = TRUE) := 
  INDEX ($.layouts.i_rid, 
         $.names().i_rid + IF (pCombo, '', $.Functions.SF_suffix (pFastHeader)), OPT);
