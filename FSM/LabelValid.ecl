export unsigned1 LabelValid(string s) := BEGINC++
//unsigned char valid_label(unsigned lenS, char* s)
//{
	unsigned char score = 0;
	char c_char = 0;
	unsigned char non_ascii = 0;
	unsigned char c_char_rep = 0;
	while ( lenS > 0 && s[lenS-1] == ' ' ) lenS--;
	for ( int i = 0; i < lenS; i++ )
	{
		if ( s[i] == c_char )
		{
			if ( ++c_char_rep > 2 )
			{
				score += c_char_rep - 2;
			}
		}
		else
		{
			c_char = s[i];
			c_char_rep = 1;
		}
		if ( ( s[i] < 'a' || s[i] > 'z' ) && ( s[i]<'A' || s[i]>'Z' ) && s[i] != ' ' && s[i] != '-' )
		{
			score += ++non_ascii;
		}
		if ( score >= 10 )
			return 10;
	}
	return score;
//}
  ENDC++;

/*STRING reverseString(STRING value) := BEGINC++
size32_t len = lenValue;
char * out = (char *)rtlMalloc(len);
for (unsigned i= 0; i < len; i++)
out[i] = value[len-1-i];
__lenResult = len;
__result = out;
ENDC++;*/