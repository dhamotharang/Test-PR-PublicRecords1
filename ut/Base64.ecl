/*
	* A base64 encoder/decoder. Use at your own risk.
	*
	* These functions are expected to be included in the ECL Standard Library. 
	* See: https://track.hpccsystems.com/browse/HPCC-9090
	*
	* These code is the same as RWTEST.Base64, except for a few minor tweaks to fix compilation issues.
	*
*/
EXPORT Base64 := MODULE
	EXPORT STRING encode_data(DATA str) := BEGINC++
		static const char TBL_E[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
		static const unsigned char PADDING_E = '=';

		#body
		unsigned extra = lenStr % 3;
		unsigned cnt = lenStr - extra;
		unsigned len = (cnt << 2) / 3 + (extra > 0 ? 4 : 0);
		// unsigned char* inStr = reinterpret_cast<unsigned char*>(str);
		// unsigned char* outStr = reinterpret_cast<unsigned char*>(__result = reinterpret_cast<char*>(malloc(len)));
		unsigned char* inStr =  (unsigned char*)(str);
		unsigned char* outStr = (unsigned char*)(__result = (char*)(malloc(len)));

		unsigned char a0 = '\0';
		unsigned char a1 = '\0';
		unsigned char a2 = '\0';

		for (unsigned i = 0; i < cnt; i += 3)
		{
			a0 = *inStr++;
			a1 = *inStr++;
			a2 = *inStr++;
			*outStr++ = TBL_E[a0 >> 2];
			*outStr++ = TBL_E[((a0 & 3) << 4) | (a1 >> 4)];
			*outStr++ = TBL_E[((a1 & 0x0F) << 2) | (a2 >> 6)];
			*outStr++ = TBL_E[a2 & 0x3F];
		}
		if (extra > 0)
		{
			a0 = *inStr++;
			a1 = extra > 1 ? *inStr++ : 0;
			*outStr++ = TBL_E[a0 >> 2];
			*outStr++ = TBL_E[((a0 & 3) << 4) | (a1 >> 4)];
			if (extra > 1)
				*outStr++ = TBL_E[(a1 & 0x0F) << 2];
			else
				*outStr++ = PADDING_E;
			*outStr++ = PADDING_E;
		}
		// __lenResult = reinterpret_cast<char*>(outStr) - __result;
		__lenResult = (char*)(outStr) - __result;
	ENDC++;


	EXPORT STRING encode(UNICODE str, STRING enc = 'UTF-8') := encode_data(FROMUNICODE(str, enc));


	EXPORT DATA decode_data(STRING str) := BEGINC++
		static const unsigned char TBL_D[] =
			{
				99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
				99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
				99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 62, 99, 99, 99, 63,
				52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 99, 99, 99, 99, 99, 99,
				99, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
				15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 99, 99, 99, 99, 99,
				99, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
				41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 99, 99, 99, 99, 99,
				99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
				99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
				99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
				99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
				99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
				99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
				99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
				99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99
			};
		static const char PADDING_D = '=';

		#body
		unsigned cnt = (lenStr >> 2) << 2;
		unsigned len = cnt * 3;
		// unsigned char* inStr = reinterpret_cast<unsigned char*>(str);
		// unsigned char* outStr = reinterpret_cast<unsigned char*>(__result = malloc(len));
		unsigned char* inStr = (unsigned char*)(str);
		unsigned char* outStr = (unsigned char*)(__result = malloc(len));

		unsigned char a0 = '\0';
		unsigned char a1 = '\0';
		unsigned char a2 = '\0';
		unsigned char a3 = '\0';

		for (unsigned i = 0; i < cnt; i += 4)
		{
			a0 = TBL_D[*inStr++];
			a1 = TBL_D[*inStr++];
			a2 = TBL_D[*inStr++];
			a3 = TBL_D[*inStr++];
			if (a0 > 63 || a1 > 63)	// This should not happen if the input is truly base64 encoded.
				break;
			*outStr++ = (a0 << 2) | (a1 >> 4);
			if (a2 > 63)
				break;
			*outStr++ = (a1 << 4) | (a2 >> 2);
			if (a3 > 63)
				break;
			*outStr++ = (a2 << 6) | a3;
		}
		// __lenResult = outStr - reinterpret_cast<unsigned char*>(__result);
		__lenResult = outStr - (unsigned char*)(__result);
	ENDC++;


	EXPORT UNICODE decode(STRING str, STRING enc = 'UTF-8') := TOUNICODE(decode_data(str), enc);
END;