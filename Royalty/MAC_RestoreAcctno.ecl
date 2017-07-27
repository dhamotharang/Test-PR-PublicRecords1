
// Use to restore original acctno in RoyaltySet, after BatchShare.MAC_SequenceInput()
EXPORT MAC_RestoreAcctno(dBatchIn, dRoyaltySet, dRoyaltySetOut) := MACRO

	dRoyaltySetOut	:= 
		dRoyaltySet(acctno='__BATCH__') + // aggregate row
		JOIN(dBatchIn, dRoyaltySet, // detailed rows
				 LEFT.acctno = RIGHT.acctno,
				 TRANSFORM(RECORDOF(dRoyaltySet), 
						SELF.acctno := LEFT.orig_acctno, 
            SELF := RIGHT));
						
ENDMACRO;