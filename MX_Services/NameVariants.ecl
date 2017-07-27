/* 
 *****************************************************************************
 * Returns the variants for the names provided. Somewhat similar to ut.NameVariants.
 * The variants in this case are derived from the MX Synonym table provided by the vendor.  
 *****************************************************************************
 */
import MXD_Names;

export NameVariants(string20 	name1, 									// 1st name to match against.
										string20 	name2, 									// 2nd name to match against.
										string20 	name3, 									// 3rd name to match against.
										unsigned1 max_num_variants = 0, 	// Max number of variants per name. 0 -> return all variants.
										boolean 	phonetic_match = false	// Match variants by metaphonemes. 
										) := function

	// NOTE: The requirement is to apply only the vendor provided synonyms. We're doing that by default (phonetic_match=false).
	//  So, technically, we're not really using the phonetic variants and score mechanisms built into the keys. But that
	// 	will give us some flexibility if we need to leverage this table for other purposes (e.g. when doing phonetic search) 
	// 	in the future.

	key_syn := MXD_Names.Key_Synonym;
	
	n1m1	:= MetaphoneLib.DMetaphone1(name1)[1..6];
	n1m2	:= MetaphoneLib.DMetaphone2(name1)[1..6];
	n2m1	:= MetaphoneLib.DMetaphone1(name2)[1..6];
	n2m2	:= MetaphoneLib.DMetaphone2(name2)[1..6];	
	n3m1	:= MetaphoneLib.DMetaphone1(name3)[1..6];
	n3m2	:= MetaphoneLib.DMetaphone2(name3)[1..6];	
			
	ds_synonyms := project(key_syn(
													// do we have a match on the first metaphone for name 1, 2 or 3?
													keyed(term1m1 in [n1m1, n2m1, n3m1]) and
													// do we have a match on the second metaphone for name 1, 2 or 3?
													keyed(term1m2 in  [n1m2, n2m2, n3m2]) and
													// do we have a strict match on name 1, 2 or 3?
													keyed(phonetic_match or t1 in [name1, name2, name3])
													),
													transform(Layouts.MXNameVariant,
															// do we have a phonetic match on name 1?																		
															fuzzy_n1_match 	:= name1<>'' and left.term1m1 = n1m1 and left.term1m2 = n1m2;	
															// do we have a phonetic match on name 2?
															fuzzy_n2_match 	:= name2<>'' and left.term1m1 = n2m1 and left.term1m2 = n2m2;
															// do we have a phonetic match on name 3?
															fuzzy_n3_match 	:= name3<>'' and left.term1m1 = n3m1 and left.term1m2 = n3m2;	
															self.name 			:= left.t1,
															self.variant 		:= left.t2,
															self.uvariant		:= left.term2,
															self.nameMatch	:= map(fuzzy_n1_match => 1, fuzzy_n2_match => 2, fuzzy_n3_match => 3, 0);
															self.score			:= left.score))(nameMatch<>0);

	top_variants := ungroup(topn(group(sort(ds_synonyms, name, score, variant), name), max_num_variants, score));

  return if(max_num_variants>0, top_variants, sort(ds_synonyms, name, score, variant));	
	
end;