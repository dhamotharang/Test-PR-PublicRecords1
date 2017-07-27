con := person_models.constants;

export 
title_rank(string t) := map(t = con.str_Subject	  => 0,
														t = con.str_Wife 			=> 1,
													  t = con.str_Husband 	=> 2,
														t = con.str_Daughter	=> 3,
														t = con.str_Son				=> 4,
														t = con.str_Child			=> 5,
														t = con.str_Mother		=> 6,
														t = con.str_Father		=> 7,
														t = con.str_Parent	  => 8,
														t = con.str_Sister		=> 9,
														t = con.str_Brother		=> 10,
														t = con.str_Sibling	  => 11,
														t <> ''								=> 12,
														15);