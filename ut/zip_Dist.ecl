export zip_Dist(string5 zip1, string5 zip2) :=
	ut.LL_Dist((real)(ut.getLL(zip1)[1..9]), (real)(ut.getLL(zip1)[11..21]), 
			   (real)(ut.getLL(zip2)[1..9]), (real)(ut.getLL(zip2)[11..21]));