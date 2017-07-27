// This is a form of the tr command in perl (or y in sed), scanning str and
// replacing characters found in s1 with the corresponding character in s2.  
// 
// Generally, s1 and s2 should be strings of identical length, defining a
// 1:1 substitution rule.  However...
//
// - If s2 is longer than s1, the "extra" characters in s2 will be ignored.
//
// - If s2 is shorter than s1, the final character of s2 is replicated until
//   it's long enough.
//
// - If s2 is the empty string, then str is returned verbatim.
//
// For example: tr('MAUI','AEIOU','12345') produces 'M153'
//
export string tr(const string str, const string s1, const string s2) := beginc++

	// allocate and initialize output buffer
	__lenResult = lenStr;
	__result = (char*)rtlMalloc(lenStr+1);
	strncpy(__result, str, lenStr);
	__result[lenStr] = '\0'; // ensure null termination
	
	// confirm non-empty s2
	bool doWork = (lenS2>0);
	
	// scan p through the output buffer, replacing chars as necessary
	if (doWork) {
		char* p = __result;
		while((p=strpbrk(p,s1)) != NULL) {
			unsigned i = index(s1,*p)-s1;
			if (i<lenS2) {
				*p = s2[i];				// normal replacement
			} else {
				*p = s2[lenS2-1];	// replace with last char of s2
			}
			p++;
		}
	}
endc++;