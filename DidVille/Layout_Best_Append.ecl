/*  Comments:
layout change
*/
import didville;
export Layout_Best_Append := RECORD
	
	DidVille.Layout_Best_fields;
	
  string9  	max_ssn := '';	
  unsigned1 	verify_best_phone := 255;
  unsigned1 	verify_best_ssn := 255;
  unsigned1 	verify_best_address := 255;
  unsigned1 	verify_best_name := 255;
  unsigned1 	verify_best_dob := 255;
  unsigned2 	score_any_ssn  := 0;
  unsigned2 	score_any_addr := 0;
  unsigned3	any_addr_date := 0;
  unsigned2 	score_any_dob  := 0;
  unsigned2 	score_any_phn  := 0;
  unsigned2	score_any_fzzy := 0;
END;