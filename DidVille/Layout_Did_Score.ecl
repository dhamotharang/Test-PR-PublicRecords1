export Layout_Did_Score := RECORD
	unsigned6 did;
	unsigned1 	score := 0;
	unsigned1		score_threshold := 75;
	unsigned1 	score_best_dob  := 0;
	unsigned1 	score_dl_number_best  := 0;
	unsigned1 	score_dl_number_any  := 0;
  unsigned1 	score_best_addr := 0;	
  unsigned1 	score_any_addr := 0;
  unsigned1 	score_dl_addr_best := 0;
  unsigned1 	score_dl_addr_any := 0;
  unsigned1 	score_credit_addr := 0;
END;