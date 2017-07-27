IMPORT ut;

///////////////////////////////////////////////////////////////
// Use Abi Company Base File
///////////////////////////////////////////////////////////////
abius_base := File_ABIUS_Company_Base;
abius_base_valid := abius_base(ABI_NUMBER != '', ABI_NUMBER != '000000000');

abius_base_valid_dedup := DEDUP(abius_base_valid, ABI_NUMBER, 
					ULTIMATE_PARENT_NUM, 
					SUBSIDIARY_PARENT_NUM, 
					 ALL);

///////////////////////////////////////////////////////////////
// Normalize out the relationships between 
// ABI, Subsidiary Parent, and Ultimate Parent Number
///////////////////////////////////////////////////////////////
Layout_ABI_To_Ultimate_ABI NormUltimate(abius_base_valid_dedup l, integer c) := TRANSFORM
	SELF.ABI_NUMBER		:= (unsigned4) choose(c, 
						l.ABI_NUMBER, 		  l.ABI_NUMBER, 		  l.SUBSIDIARY_PARENT_NUM); 
	SELF.ULTIMATE_PARENT_NUM := (unsigned4) choose(c, 
						l.ULTIMATE_PARENT_NUM,l.SUBSIDIARY_PARENT_NUM, l.ULTIMATE_PARENT_NUM);
END;

abius_ultimate_slim := NORMALIZE(abius_base_valid_dedup, 3, NormUltimate(LEFT, counter));

///////////////////////////////////////////////////////////////
// Filter out zero abi numbers and dedup
///////////////////////////////////////////////////////////////
abius_ultimate_filter := abius_ultimate_slim(ABI_NUMBER <> 0, ULTIMATE_PARENT_NUM <> 0);
abius_ultimate_dedup := DEDUP(abius_ultimate_filter, ABI_NUMBER, ULTIMATE_PARENT_NUM, ALL);

abius_ultimate_dist := DISTRIBUTE(
	DEDUP(abius_ultimate_dedup, ABI_NUMBER, ULTIMATE_PARENT_NUM, ALL),
	HASH(ABI_NUMBER));


EXPORT ABI_to_Ultimate_ABI := abius_ultimate_dist : PERSIST('TEMP::INFOUSA_ABI_To_Ultimate_ABI');