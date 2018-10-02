/*This function computes the match weight for WILD(EXCLUSIVE) as the minimum of (#no. of matching non wild chars * 320, general _specificity*100, weight100 of candidate word)
* @param word - the candidate word being matched
* @param param - the search parameter
* @param field_specificity - general field_specificity 
* @param word_weight100 - weight100 of word
*/
EXPORT Fn_WildExclusiveMatchWeight(StrType word, StrType param, UNSIGNED field_specificity, UNSIGNED word_weight100) := 
MIN(LENGTH(TRIM(StringFilterOut(param, '*?')))*320, field_specificity*100, word_weight100);
