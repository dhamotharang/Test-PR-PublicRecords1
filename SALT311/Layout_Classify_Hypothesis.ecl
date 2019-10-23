export Layout_Classify_Hypothesis := RECORD
  UNSIGNED2 TokenType; // Field type of current hypothesis
	UNSIGNED4 StartPos; // Starting position of current hypothesis
	UNSIGNED1 Len; // Expected length of hypothesis
	UNSIGNED1 Spc; // Specificity attached
	BOOLEAN Confirmed; // Enough sequential items found to confirm existence (but may still be eaten by bigger fish!)
	END;
