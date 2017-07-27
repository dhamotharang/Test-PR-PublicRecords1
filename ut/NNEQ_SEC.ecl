// Check that two secondary ranges (two strings) are equal
// equality is defined as:
//				key (left) is non blank and the match field (right) is blank
//				key (left) == match field (right)
// 
// Assumption: the key is obtained from *best* information, therefore it is
//	inappropriate to also give the defintion of equality the further inclusion
//	of key (left) is blank and the match field (right) is non blank
//
export NNEQ_SEC(string l, string r) := l<>'' and r='' or l=r;
