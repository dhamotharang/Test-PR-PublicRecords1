
EXPORT layout_residence_metrics := RECORD
	UNSIGNED6  did              :=  0;
	STRING3    ind_age          := '';  // Age (where available)
	STRING6    DOB              := '';  // MMYYYY (where available)
	DECIMAL6_2 Count_LN_Yrs     :=  0;  // Count of years on LN Database
	UNSIGNED2  Count_Zip1       :=  0;  // Count of total number of military base addresses (from ZIP SET 1).
	UNSIGNED2  Conseq_Zip1      :=  0;  // Count of highest number of consecutive military base addresses (from ZIP SET 1)
	DECIMAL6_2 AvgMoves_LN      :=  0;  // Calculate average number of moves per year on the LN database.
	UNSIGNED2  Count_Zip2       :=  0;  // Count of total number of addresses within 15 mile radius of a military base (from ZIP SET 2).
	UNSIGNED2  Conseq_Zip2      :=  0;  // Count of highest number of consecutive addresses within 15 mile radius of a military base (from ZIP SET 2).
	DECIMAL6_2 AvgMoves_Zip2    :=  0;  // Calculate average number of moves per year within 15 mile radius of a military base (from ZIP SET 2).
	STRING6    Recent_Dt_Zip1   := '';  // Provide the most recent date of residence on a military base (ZIP SET 1).
	STRING6    Recent_Dt_Zip2   := '';  // Provide the most recent date of residence within a 15 mile radius of a military base (ZIP SET 2).
END;