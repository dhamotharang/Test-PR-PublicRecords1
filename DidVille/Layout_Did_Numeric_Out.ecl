import Doxie;

export Layout_Did_Numeric_Out := MODULE

Export Addr_Best :=
RECORD
 doxie.layout_best;
 string1 tnt :='';
END;

Export OUT_REC :=
RECORD
	unsigned2 ssn4;
	unsigned3 zip;
	UNSIGNED2 yob;
	UNSIGNED1 fi;
	
	unsigned6 did;
	unsigned2 score := 0;
	string9  	best_ssn := '';
  string5		best_title;
  string20	best_fname := '';
  string20	best_mname := '';
  string20	best_lname := '';
  string5		best_name_suffix := '';
  string120 	best_addr1 := '';
  string30	best_city := '';
  string2		best_state := '';
  string5		best_zip :='';
  string4		best_zip4 := '';
	string10  best_phone := '';
  unsigned3	best_addr_date := 0;
  string8  	best_dob := '';
  string8  	best_dod := '';
	string1		tnt;
	
	unsigned1 	verify_best_ssn := 255;
  unsigned1 	verify_best_address := 255;
  unsigned1 	verify_best_name := 255;
  unsigned1 	verify_best_dob := 255;
  unsigned1 	score_any_ssn  := 0;
  unsigned1 	score_any_addr := 0;
	unsigned1		score_any_name := 0;
  unsigned1 	score_any_dob  := 0;
	unsigned3		any_addr_date := 0;
END;

END;
