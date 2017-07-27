EXPORT Functions_C := MODULE
    Export UNSIGNED4 BusName_PrefixMatchCount(STRING a, STRING b) := BEGINC++
        unsigned int    minLength = lenA < lenB ? lenA : lenB;
        unsigned int    numMatched = 0;

        for (numMatched = 0; numMatched < minLength; numMatched++)
        {
            if (a[numMatched] != b[numMatched])
            {
                break;
            }
        }

        return numMatched;
    ENDC++;
		EXPORT INTEGER1 getLevenshteinDistance(STRING srow, STRING scol) := BEGINC++

			int RowLen = lenSrow; // length of sRow
			int ColLen = lenScol; // length of sCol
			int RowIdx;                // iterates through sRow
			int ColIdx;                // iterates through sCol
			int cost;                  // cost
			
			// Step 1
			
			if (RowLen == 0)
				return ColLen;
			
			if (ColLen == 0)
				return RowLen;
			
			// Create the two vectors
			int* v0 = new int[RowLen + 1];
			int* v1 = new int[RowLen + 1];
			int* vTmp;
			
			// Step 2
			// Initialize the first vector
			for (RowIdx = 0; RowIdx <= RowLen; RowIdx++)
				v0[RowIdx] = RowIdx;
			
			// Step 3
			
			// Fore each column
			for (ColIdx = 1; ColIdx <= ColLen; ColIdx++)
			{
				// Set the 0'th element to the column number
				v1[0] = ColIdx;
				
				// Step 4
				
				// Fore each row
				for (RowIdx = 1; RowIdx <= RowLen; RowIdx++)
				{
					// Step 5
					if (srow[RowIdx - 1] == scol[ColIdx - 1])
						cost = 0;
					else
						cost = 1;
					
					// Step 6
					
					// Find minimum
					int m_min = v0[RowIdx] + 1;    // insert
					int b = v1[RowIdx - 1] + 1;    // delete
					int c = v0[RowIdx - 1] + cost; // substitute
					
					if (b < m_min)
						m_min = b;
					if (c < m_min)
						m_min = c;
					
					v1[RowIdx] = m_min;
				}
				
				// Swap the vectors
				vTmp = v0;
				v0 = v1;
				v1 = vTmp;
			}
			
			// The vectors where swaped one last time at the end of the last loop,
			// that is why the result is now in v0 rather than in v1
			int dist = v0[RowLen];
			
			delete [] v0;
			delete [] v1;
			
			return dist;

		ENDC++;
		EXPORT REAL8 getOliverConfidence(STRING astr1, STRING astr2) := BEGINC++

		int sim_char(const char *str1, int len1, const char *str2, int len2)
		{
			int max = 0, l, pos1 = 0, pos2 = 0, sum;
			const char *p, *q, *end1, *end2;
			 
			end1 = str1 + len1;
			end2 = str2 + len2;
			
			for (p = str1; p < end1; p ++)
			{
				for (q = str2; q < end2; q ++)
				{
					for (l = 0; (p + l < end1) && (q + l < end2) &&
						p[l] == q[l]; l ++);
					if (l > max)
					{
						max = l;
						pos1 = p - str1;
						pos2 = q - str2;
					}
				}
			}
			
			if (max == 0)
				return 0;
			
			sum = max;
			if (pos1 && pos2)
			{
				sum += sim_char(str1, pos1, str2, pos2);
			}
			if ((pos1 + max < len1) && (pos2 + max < len2))
			{
				sum += sim_char(str1 + pos1 + max, len1 - pos1 - max,
						str2 + pos2 + max, len2 - pos2 - max);
			}
			
			return sum;
		}

		#body

		{
			int result = sim_char(astr1, lenAstr1, astr2, lenAstr2);
			double confidence = (double)(result * 2) / (double)(lenAstr1 + lenAstr2);
			return confidence;
		}

		ENDC++;
		EXPORT STRING getDoubleMetaphone(STRING str) := BEGINC++

		#include <string>
		#include <stdarg.h>

		void MakeUpper(std::string& str)
		{
			for (int i = 0; i < str.length(); i++)
				str[i] = toupper(str[i]);
		}

		bool IsVowel(std::string s, int pos)
		{
			char c;

			if ((pos < 0) || (pos >= s.length()))
				return false;

			c = s.at(pos);
			if ((c == 'A') || (c == 'E') || (c == 'I') || (c =='O') ||
					(c =='U')  || (c == 'Y'))
				return true;

			return false;
		}

		bool SlavoGermanic(std::string s)
		{
			if (s.find("W") != std::string::npos)
				return true;
			else if (s.find("K") != std::string::npos)
				return true;
			else if (s.find("CZ") != std::string::npos)
				return true;
			else if (s.find("WITZ") != std::string::npos)
				return true;
			else
				return false;
		}

		int GetLength(std::string s)
		{
				return s.length();
		}

		char GetAt(std::string s, int pos)
		{
			if ((pos < 0) || (pos >= s.length()))
				return '\0';

			return (s.at(pos));
		}

		void SetAt(std::string& s, int pos, char c)
		{
			if ((pos < 0) || (pos >= s.length()))
				return;

			s[pos] = c;
		}

		/*
			 Caveats: the START value is 0 based
		*/
		bool StringAt(std::string s, int start, int length, ...)
		{
				std::string pos;
				char *test;
				va_list ap;

				if ((start < 0) || (start >= s.length()))
						return 0;
						
				pos = s.substr(start, length);

				va_start(ap, length);

				do
				{
					test = va_arg(ap, char *);
					if (*test && (pos == test))
						return 1;
				}
				while (strcmp(test, ""));

				va_end(ap);

				return 0;
		}

		void MetaphAdd(std::string& s, std::string new_str)
		{
			if (new_str == "")
				return;
				
			s = s + new_str;
		}

		#body

		//void
		//DoubleMetaphone(const char *str, char **codes)
		{
				int             length;
				std::string     original;
				std::string     primary;
				std::string     secondary;
				int             current;
				int             last;

				current = 0;
				/* we need the real length and last prior to padding */
				length  = lenStr;
				last    = length - 1;
				original = str;
				/* Pad original so we can index beyond end */
				MetaphAdd(original, "     ");

				MakeUpper(original);

				/* skip these when at start of word */
				if (StringAt(original, 0, 2, "GN", "KN", "PN", "WR", "PS", ""))
					current += 1;

				/* Initial 'X' is pronounced 'Z' e.g. 'Xavier' */
				if (GetAt(original, 0) == 'X')
				{
					MetaphAdd(primary, "S");	/* 'Z' maps to 'S' */
					MetaphAdd(secondary, "S");
					current += 1;
				}

				/* main loop */
				while ((primary.length() < 4) || (secondary.length() < 4))
				{
				if (current >= length)
						break;

				switch (GetAt(original, current))
					{
					case 'A':
					case 'E':
					case 'I':
					case 'O':
					case 'U':
					case 'Y':
				if (current == 0)
											{
						/* all init vowels now map to 'A' */
						MetaphAdd(primary, "A");
						MetaphAdd(secondary, "A");
											}
				current += 1;
				break;

					case 'B':

				/* "-mb", e.g", "dumb", already skipped over... */
				MetaphAdd(primary, "P");
				MetaphAdd(secondary, "P");

				if (GetAt(original, current + 1) == 'B')
						current += 2;
				else
						current += 1;
				break;

					// case 'Ã‡':
				// MetaphAdd(primary, "S");
				// MetaphAdd(secondary, "S");
				// current += 1;
				// break;

					case 'C':
				/* various germanic */
				if ((current > 1)
						&& !IsVowel(original, current - 2)
						&& StringAt(original, (current - 1), 3, "ACH", "")
						&& ((GetAt(original, current + 2) != 'I')
					&& ((GetAt(original, current + 2) != 'E')
							|| StringAt(original, (current - 2), 6, "BACHER",
							"MACHER", ""))))
					{
							MetaphAdd(primary, "K");
							MetaphAdd(secondary, "K");
							current += 2;
							break;
					}

				/* special case 'caesar' */
				if ((current == 0)
						&& StringAt(original, current, 6, "CAESAR", ""))
					{
							MetaphAdd(primary, "S");
							MetaphAdd(secondary, "S");
							current += 2;
							break;
					}

				/* italian 'chianti' */
				if (StringAt(original, current, 4, "CHIA", ""))
					{
							MetaphAdd(primary, "K");
							MetaphAdd(secondary, "K");
							current += 2;
							break;
					}

				if (StringAt(original, current, 2, "CH", ""))
					{
							/* find 'michael' */
							if ((current > 0)
						&& StringAt(original, current, 4, "CHAE", ""))
					{
							MetaphAdd(primary, "K");
							MetaphAdd(secondary, "X");
							current += 2;
							break;
					}

							/* greek roots e.g. 'chemistry', 'chorus' */
							if ((current == 0)
						&& (StringAt(original, (current + 1), 5, "HARAC", "HARIS", "")
						 || StringAt(original, (current + 1), 3, "HOR",
									 "HYM", "HIA", "HEM", ""))
						&& !StringAt(original, 0, 5, "CHORE", ""))
					{
							MetaphAdd(primary, "K");
							MetaphAdd(secondary, "K");
							current += 2;
							break;
					}

							/* germanic, greek, or otherwise 'ch' for 'kh' sound */
							if (
						(StringAt(original, 0, 4, "VAN ", "VON ", "")
						 || StringAt(original, 0, 3, "SCH", ""))
						/*  'architect but not 'arch', 'orchestra', 'orchid' */
						|| StringAt(original, (current - 2), 6, "ORCHES",
									"ARCHIT", "ORCHID", "")
						|| StringAt(original, (current + 2), 1, "T", "S",
									"")
						|| ((StringAt(original, (current - 1), 1, "A", "O", "U", "E", "")
															|| (current == 0))
						 /* e.g., 'wachtler', 'wechsler', but not 'tichner' */
						&& StringAt(original, (current + 2), 1, "L", "R",
															"N", "M", "B", "H", "F", "V", "W", " ", "")))
					{
							MetaphAdd(primary, "K");
							MetaphAdd(secondary, "K");
					}
							else
					{
							if (current > 0)
								{
							if (StringAt(original, 0, 2, "MC", ""))
								{
							/* e.g., "McHugh" */
							MetaphAdd(primary, "K");
							MetaphAdd(secondary, "K");
								}
							else
								{
							MetaphAdd(primary, "X");
							MetaphAdd(secondary, "K");
								}
								}
							else
								{
							MetaphAdd(primary, "X");
							MetaphAdd(secondary, "X");
								}
					}
							current += 2;
							break;
					}
				/* e.g, 'czerny' */
				if (StringAt(original, current, 2, "CZ", "")
						&& !StringAt(original, (current - 2), 4, "WICZ", ""))
					{
							MetaphAdd(primary, "S");
							MetaphAdd(secondary, "X");
							current += 2;
							break;
					}

				/* e.g., 'focaccia' */
				if (StringAt(original, (current + 1), 3, "CIA", ""))
					{
							MetaphAdd(primary, "X");
							MetaphAdd(secondary, "X");
							current += 3;
							break;
					}

				/* double 'C', but not if e.g. 'McClellan' */
				if (StringAt(original, current, 2, "CC", "")
						&& !((current == 1) && (GetAt(original, 0) == 'M')))
						{
								/* 'bellocchio' but not 'bacchus' */
								if (StringAt(original, (current + 2), 1, "I", "E", "H", "")
												&& !StringAt(original, (current + 2), 2, "HU", ""))
								{
										/* 'accident', 'accede' 'succeed' */
										if (((current == 1)
																&& (GetAt(original, current - 1) == 'A'))
														|| StringAt(original, (current - 1), 5, "UCCEE",
																"UCCES", ""))
										{
												MetaphAdd(primary, "KS");
												MetaphAdd(secondary, "KS");
												/* 'bacci', 'bertucci', other italian */
										}
										else
										{
												MetaphAdd(primary, "X");
												MetaphAdd(secondary, "X");
										}
										current += 3;
										break;
								}
								else
								{	  /* Pierce's rule */
										MetaphAdd(primary, "K");
										MetaphAdd(secondary, "K");
										current += 2;
										break;
								}
						}

				if (StringAt(original, current, 2, "CK", "CG", "CQ", ""))
					{
							MetaphAdd(primary, "K");
							MetaphAdd(secondary, "K");
							current += 2;
							break;
					}

				if (StringAt(original, current, 2, "CI", "CE", "CY", ""))
					{
							/* italian vs. english */
							if (StringAt
						(original, current, 3, "CIO", "CIE", "CIA", ""))
					{
							MetaphAdd(primary, "S");
							MetaphAdd(secondary, "X");
					}
							else
					{
							MetaphAdd(primary, "S");
							MetaphAdd(secondary, "S");
					}
							current += 2;
							break;
					}

				/* else */
				MetaphAdd(primary, "K");
				MetaphAdd(secondary, "K");

				/* name sent in 'mac caffrey', 'mac gregor */
				if (StringAt(original, (current + 1), 2, " C", " Q", " G", ""))
						current += 3;
				else
						if (StringAt(original, (current + 1), 1, "C", "K", "Q", "")
					&& !StringAt(original, (current + 1), 2, "CE", "CI", ""))
						current += 2;
				else
						current += 1;
				break;

					case 'D':
				if (StringAt(original, current, 2, "DG", ""))
											{
							if (StringAt(original, (current + 2), 1, "I", "E", "Y", ""))
								{
							/* e.g. 'edge' */
							MetaphAdd(primary, "J");
							MetaphAdd(secondary, "J");
							current += 3;
							break;
								}
							else
								{
							/* e.g. 'edgar' */
							MetaphAdd(primary, "TK");
							MetaphAdd(secondary, "TK");
							current += 2;
							break;
								}
											}

				if (StringAt(original, current, 2, "DT", "DD", ""))
					{
							MetaphAdd(primary, "T");
							MetaphAdd(secondary, "T");
							current += 2;
							break;
					}

				/* else */
				MetaphAdd(primary, "T");
				MetaphAdd(secondary, "T");
				current += 1;
				break;

					case 'F':
				if (GetAt(original, current + 1) == 'F')
						current += 2;
				else
						current += 1;
				MetaphAdd(primary, "F");
				MetaphAdd(secondary, "F");
				break;

					case 'G':
				if (GetAt(original, current + 1) == 'H')
					{
							if ((current > 0) && !IsVowel(original, current - 1))
					{
							MetaphAdd(primary, "K");
							MetaphAdd(secondary, "K");
							current += 2;
							break;
					}

							if (current < 3)
					{
							/* 'ghislane', ghiradelli */
							if (current == 0)
								{
							if (GetAt(original, current + 2) == 'I')
								{
							MetaphAdd(primary, "J");
							MetaphAdd(secondary, "J");
								}
							else
								{
							MetaphAdd(primary, "K");
							MetaphAdd(secondary, "K");
								}
							current += 2;
							break;
								}
					}
							/* Parker's rule (with some further refinements) - e.g., 'hugh' */
							if (
						((current > 1)
						 && StringAt(original, (current - 2), 1, "B", "H", "D", ""))
						/* e.g., 'bough' */
						|| ((current > 2)
								&& StringAt(original, (current - 3), 1, "B", "H", "D", ""))
						/* e.g., 'broughton' */
						|| ((current > 3)
								&& StringAt(original, (current - 4), 1, "B", "H", "")))
					{
							current += 2;
							break;
					}
							else
					{
							/* e.g., 'laugh', 'McLaughlin', 'cough', 'gough', 'rough', 'tough' */
							if ((current > 2)
						&& (GetAt(original, current - 1) == 'U')
						&& StringAt(original, (current - 3), 1, "C",
									"G", "L", "R", "T", ""))
								{
							MetaphAdd(primary, "F");
							MetaphAdd(secondary, "F");
								}
							else if ((current > 0)
								 && GetAt(original, current - 1) != 'I')
								{


							MetaphAdd(primary, "K");
							MetaphAdd(secondary, "K");
								}

							current += 2;
							break;
					}
					}

				if (GetAt(original, current + 1) == 'N')
					{
							if ((current == 1) && IsVowel(original, 0)
						&& !SlavoGermanic(original))
					{
							MetaphAdd(primary, "KN");
							MetaphAdd(secondary, "N");
					}
							else
						/* not e.g. 'cagney' */
						if (!StringAt(original, (current + 2), 2, "EY", "")
								&& (GetAt(original, current + 1) != 'Y')
								&& !SlavoGermanic(original))
					{
							MetaphAdd(primary, "N");
							MetaphAdd(secondary, "KN");
					}
							else
														{
							MetaphAdd(primary, "KN");
										MetaphAdd(secondary, "KN");
														}
							current += 2;
							break;
					}

				/* 'tagliaro' */
				if (StringAt(original, (current + 1), 2, "LI", "")
						&& !SlavoGermanic(original))
					{
							MetaphAdd(primary, "KL");
							MetaphAdd(secondary, "L");
							current += 2;
							break;
					}

				/* -ges-,-gep-,-gel-, -gie- at beginning */
				if ((current == 0)
						&& ((GetAt(original, current + 1) == 'Y')
					|| StringAt(original, (current + 1), 2, "ES", "EP",
								"EB", "EL", "EY", "IB", "IL", "IN", "IE",
								"EI", "ER", "")))
					{
							MetaphAdd(primary, "K");
							MetaphAdd(secondary, "J");
							current += 2;
							break;
					}

				/*  -ger-,  -gy- */
				if (
						(StringAt(original, (current + 1), 2, "ER", "")
						 || (GetAt(original, current + 1) == 'Y'))
						&& !StringAt(original, 0, 6, "DANGER", "RANGER", "MANGER", "")
						&& !StringAt(original, (current - 1), 1, "E", "I", "")
						&& !StringAt(original, (current - 1), 3, "RGY", "OGY",
						 ""))
					{
							MetaphAdd(primary, "K");
							MetaphAdd(secondary, "J");
							current += 2;
							break;
					}

				/*  italian e.g, 'biaggi' */
				if (StringAt(original, (current + 1), 1, "E", "I", "Y", "")
						|| StringAt(original, (current - 1), 4, "AGGI", "OGGI", ""))
					{
							/* obvious germanic */
							if (
						(StringAt(original, 0, 4, "VAN ", "VON ", "")
						 || StringAt(original, 0, 3, "SCH", ""))
						|| StringAt(original, (current + 1), 2, "ET", ""))
					{
							MetaphAdd(primary, "K");
							MetaphAdd(secondary, "K");
					}
							else
					{
							/* always soft if french ending */
							if (StringAt
						(original, (current + 1), 4, "IER ", ""))
								{
							MetaphAdd(primary, "J");
							MetaphAdd(secondary, "J");
								}
							else
								{
							MetaphAdd(primary, "J");
							MetaphAdd(secondary, "K");
								}
					}
							current += 2;
							break;
					}

				if (GetAt(original, current + 1) == 'G')
						current += 2;
				else
						current += 1;
				MetaphAdd(primary, "K");
				MetaphAdd(secondary, "K");
				break;

					case 'H':
				/* only keep if first & before vowel or btw. 2 vowels */
				if (((current == 0) || IsVowel(original, current - 1))
						&& IsVowel(original, current + 1))
					{
							MetaphAdd(primary, "H");
							MetaphAdd(secondary, "H");
							current += 2;
					}
				else		/* also takes care of 'HH' */
						current += 1;
				break;

					case 'J':
				/* obvious spanish, 'jose', 'san jacinto' */
				if (StringAt(original, current, 4, "JOSE", "")
						|| StringAt(original, 0, 4, "SAN ", ""))
					{
							if (((current == 0)
						 && (GetAt(original, current + 4) == ' '))
						|| StringAt(original, 0, 4, "SAN ", ""))
					{
							MetaphAdd(primary, "H");
							MetaphAdd(secondary, "H");
					}
							else
					{
							MetaphAdd(primary, "J");
							MetaphAdd(secondary, "H");
					}
							current += 1;
							break;
					}

				if ((current == 0)
						&& !StringAt(original, current, 4, "JOSE", ""))
					{
							MetaphAdd(primary, "J");	/* Yankelovich/Jankelowicz */
							MetaphAdd(secondary, "A");
					}
				else
					{
							/* spanish pron. of e.g. 'bajador' */
							if (IsVowel(original, current - 1)
						&& !SlavoGermanic(original)
						&& ((GetAt(original, current + 1) == 'A')
								|| (GetAt(original, current + 1) == 'O')))
					{
							MetaphAdd(primary, "J");
							MetaphAdd(secondary, "H");
					}
							else
					{
							if (current == last)
								{
							MetaphAdd(primary, "J");
							MetaphAdd(secondary, "");
								}
							else
								{
							if (!StringAt(original, (current + 1), 1, "L", "T",
														"K", "S", "N", "M", "B", "Z", "")
									&& !StringAt(original, (current - 1), 1,
									 "S", "K", "L", ""))
																				{
									MetaphAdd(primary, "J");
									MetaphAdd(secondary, "J");
																				}
								}
					}
					}

				if (GetAt(original, current + 1) == 'J')	/* it could happen! */
						current += 2;
				else
						current += 1;
				break;

					case 'K':
				if (GetAt(original, current + 1) == 'K')
						current += 2;
				else
						current += 1;
				MetaphAdd(primary, "K");
				MetaphAdd(secondary, "K");
				break;

					case 'L':
				if (GetAt(original, current + 1) == 'L')
					{
							/* spanish e.g. 'cabrillo', 'gallegos' */
							if (((current == (length - 3))
						 && StringAt(original, (current - 1), 4, "ILLO",
									 "ILLA", "ALLE", ""))
						|| ((StringAt(original, (last - 1), 2, "AS", "OS", "")
							|| StringAt(original, last, 1, "A", "O", ""))
						 && StringAt(original, (current - 1), 4, "ALLE", "")))
					{
							MetaphAdd(primary, "L");
							MetaphAdd(secondary, "");
							current += 2;
							break;
					}
							current += 2;
					}
				else
						current += 1;
				MetaphAdd(primary, "L");
				MetaphAdd(secondary, "L");
				break;

					case 'M':
				if ((StringAt(original, (current - 1), 3, "UMB", "")
						 && (((current + 1) == last)
					 || StringAt(original, (current + 2), 2, "ER", "")))
						/* 'dumb','thumb' */
						|| (GetAt(original, current + 1) == 'M'))
						current += 2;
				else
						current += 1;
				MetaphAdd(primary, "M");
				MetaphAdd(secondary, "M");
				break;

					case 'N':
				if (GetAt(original, current + 1) == 'N')
						current += 2;
				else
						current += 1;
				MetaphAdd(primary, "N");
				MetaphAdd(secondary, "N");
				break;

					// case 'Ã‘':
				// current += 1;
				// MetaphAdd(primary, "N");
				// MetaphAdd(secondary, "N");
				// break;

					case 'P':
				if (GetAt(original, current + 1) == 'H')
					{
							MetaphAdd(primary, "F");
							MetaphAdd(secondary, "F");
							current += 2;
							break;
					}

				/* also account for "campbell", "raspberry" */
				if (StringAt(original, (current + 1), 1, "P", "B", ""))
						current += 2;
				else
						current += 1;
				MetaphAdd(primary, "P");
				MetaphAdd(secondary, "P");
				break;

					case 'Q':
				if (GetAt(original, current + 1) == 'Q')
						current += 2;
				else
						current += 1;
				MetaphAdd(primary, "K");
				MetaphAdd(secondary, "K");
				break;

					case 'R':
				/* french e.g. 'rogier', but exclude 'hochmeier' */
				if ((current == last)
						&& !SlavoGermanic(original)
						&& StringAt(original, (current - 2), 2, "IE", "")
						&& !StringAt(original, (current - 4), 2, "ME", "MA", ""))
					{
							MetaphAdd(primary, "");
							MetaphAdd(secondary, "R");
					}
				else
					{
							MetaphAdd(primary, "R");
							MetaphAdd(secondary, "R");
					}

				if (GetAt(original, current + 1) == 'R')
						current += 2;
				else
						current += 1;
				break;

					case 'S':
				/* special cases 'island', 'isle', 'carlisle', 'carlysle' */
				if (StringAt(original, (current - 1), 3, "ISL", "YSL", ""))
					{
							current += 1;
							break;
					}

				/* special case 'sugar-' */
				if ((current == 0)
						&& StringAt(original, current, 5, "SUGAR", ""))
					{
							MetaphAdd(primary, "X");
							MetaphAdd(secondary, "S");
							current += 1;
							break;
					}

				if (StringAt(original, current, 2, "SH", ""))
					{
							/* germanic */
							if (StringAt
						(original, (current + 1), 4, "HEIM", "HOEK", "HOLM",
						 "HOLZ", ""))
					{
							MetaphAdd(primary, "S");
							MetaphAdd(secondary, "S");
					}
							else
					{
							MetaphAdd(primary, "X");
							MetaphAdd(secondary, "X");
					}
							current += 2;
							break;
					}

				/* italian & armenian */
				if (StringAt(original, current, 3, "SIO", "SIA", "")
						|| StringAt(original, current, 4, "SIAN", ""))
					{
							if (!SlavoGermanic(original))
					{
							MetaphAdd(primary, "S");
							MetaphAdd(secondary, "X");
					}
							else
					{
							MetaphAdd(primary, "S");
							MetaphAdd(secondary, "S");
					}
							current += 3;
							break;
					}

				/* german & anglicisations, e.g. 'smith' match 'schmidt', 'snider' match 'schneider'
					 also, -sz- in slavic language altho in hungarian it is pronounced 's' */
				if (((current == 0)
						 && StringAt(original, (current + 1), 1, "M", "N", "L", "W", ""))
						|| StringAt(original, (current + 1), 1, "Z", ""))
					{
							MetaphAdd(primary, "S");
							MetaphAdd(secondary, "X");
							if (StringAt(original, (current + 1), 1, "Z", ""))
						current += 2;
							else
						current += 1;
							break;
					}

				if (StringAt(original, current, 2, "SC", ""))
					{
							/* Schlesinger's rule */
							if (GetAt(original, current + 2) == 'H')
									{
											/* dutch origin, e.g. 'school', 'schooner' */
											if (StringAt(original, (current + 3), 2, "OO", "ER", "EN",
																	"UY", "ED", "EM", ""))
											{
													/* 'schermerhorn', 'schenker' */
													if (StringAt(original, (current + 3), 2, "ER", "EN", ""))
													{
															MetaphAdd(primary, "X");
															MetaphAdd(secondary, "SK");
													}
													else
													{
															MetaphAdd(primary, "SK");
															MetaphAdd(secondary, "SK");
													}
													current += 3;
													break;
											}
											else
											{
													if ((current == 0) && !IsVowel(original, 3)
																	&& (GetAt(original, 3) != 'W'))
													{
															MetaphAdd(primary, "X");
															MetaphAdd(secondary, "S");
													}
													else
													{
															MetaphAdd(primary, "X");
															MetaphAdd(secondary, "X");
													}
													current += 3;
													break;
											}
									}

							if (StringAt(original, (current + 2), 1, "I", "E", "Y", ""))
					{
							MetaphAdd(primary, "S");
							MetaphAdd(secondary, "S");
							current += 3;
							break;
					}
							/* else */
							MetaphAdd(primary, "SK");
							MetaphAdd(secondary, "SK");
							current += 3;
							break;
					}

				/* french e.g. 'resnais', 'artois' */
				if ((current == last)
						&& StringAt(original, (current - 2), 2, "AI", "OI", ""))
					{
							MetaphAdd(primary, "");
							MetaphAdd(secondary, "S");
					}
				else
					{
							MetaphAdd(primary, "S");
							MetaphAdd(secondary, "S");
					}

				if (StringAt(original, (current + 1), 1, "S", "Z", ""))
						current += 2;
				else
						current += 1;
				break;

					case 'T':
				if (StringAt(original, current, 4, "TION", ""))
					{
							MetaphAdd(primary, "X");
							MetaphAdd(secondary, "X");
							current += 3;
							break;
					}

				if (StringAt(original, current, 3, "TIA", "TCH", ""))
					{
							MetaphAdd(primary, "X");
							MetaphAdd(secondary, "X");
							current += 3;
							break;
					}

				if (StringAt(original, current, 2, "TH", "")
						|| StringAt(original, current, 3, "TTH", ""))
					{
							/* special case 'thomas', 'thames' or germanic */
							if (StringAt(original, (current + 2), 2, "OM", "AM", "")
						|| StringAt(original, 0, 4, "VAN ", "VON ", "")
						|| StringAt(original, 0, 3, "SCH", ""))
					{
							MetaphAdd(primary, "T");
							MetaphAdd(secondary, "T");
					}
							else
					{
							MetaphAdd(primary, "0"); /* yes, zero */
							MetaphAdd(secondary, "T");
					}
							current += 2;
							break;
					}

				if (StringAt(original, (current + 1), 1, "T", "D", ""))
						current += 2;
				else
						current += 1;
				MetaphAdd(primary, "T");
				MetaphAdd(secondary, "T");
				break;

					case 'V':
				if (GetAt(original, current + 1) == 'V')
						current += 2;
				else
						current += 1;
				MetaphAdd(primary, "F");
				MetaphAdd(secondary, "F");
				break;

					case 'W':
				/* can also be in middle of word */
				if (StringAt(original, current, 2, "WR", ""))
					{
							MetaphAdd(primary, "R");
							MetaphAdd(secondary, "R");
							current += 2;
							break;
					}

				if ((current == 0)
						&& (IsVowel(original, current + 1)
					|| StringAt(original, current, 2, "WH", "")))
					{
							/* Wasserman should match Vasserman */
							if (IsVowel(original, current + 1))
					{
							MetaphAdd(primary, "A");
							MetaphAdd(secondary, "F");
					}
							else
					{
							/* need Uomo to match Womo */
							MetaphAdd(primary, "A");
							MetaphAdd(secondary, "A");
					}
					}

				/* Arnow should match Arnoff */
				if (((current == last) && IsVowel(original, current - 1))
						|| StringAt(original, (current - 1), 5, "EWSKI", "EWSKY",
						"OWSKI", "OWSKY", "")
						|| StringAt(original, 0, 3, "SCH", ""))
					{
							MetaphAdd(primary, "");
							MetaphAdd(secondary, "F");
							current += 1;
							break;
					}

				/* polish e.g. 'filipowicz' */
				if (StringAt(original, current, 4, "WICZ", "WITZ", ""))
					{
							MetaphAdd(primary, "TS");
							MetaphAdd(secondary, "FX");
							current += 4;
							break;
					}

				/* else skip it */
				current += 1;
				break;

					case 'X':
				/* french e.g. breaux */
				if (!((current == last)
							&& (StringAt(original, (current - 3), 3, "IAU", "EAU", "")
							 || StringAt(original, (current - 2), 2, "AU", "OU", ""))))
											{
							MetaphAdd(primary, "KS");
							MetaphAdd(secondary, "KS");
											}


				if (StringAt(original, (current + 1), 1, "C", "X", ""))
						current += 2;
				else
						current += 1;
				break;

					case 'Z':
				/* chinese pinyin e.g. 'zhao' */
				if (GetAt(original, current + 1) == 'H')
					{
							MetaphAdd(primary, "J");
							MetaphAdd(secondary, "J");
							current += 2;
							break;
					}
				else if (StringAt(original, (current + 1), 2, "ZO", "ZI", "ZA", "")
					|| (SlavoGermanic(original)
							&& ((current > 0)
						&& GetAt(original, current - 1) != 'T')))
					{
							MetaphAdd(primary, "S");
							MetaphAdd(secondary, "TS");
					}
				else
											{
						MetaphAdd(primary, "S");
						MetaphAdd(secondary, "S");
											}

				if (GetAt(original, current + 1) == 'Z')
						current += 2;
				else
						current += 1;
				break;

					default:
				current += 1;
					}
						/* printf("PRIMARY: %s\n", primary->str);
						printf("SECONDARY: %s\n", secondary->str);  */
					}

				if (primary.length() > 4)
					SetAt(primary, 4, '\0');

				if (secondary.length() > 4)
					SetAt(secondary, 4, '\0');
					
				std::string result = primary + "|" + secondary;
				
			__lenResult = result.length();
			__result = new char[__lenResult];
			strcpy(__result,(char*)result.c_str());

		}

		ENDC++;

		EXPORT STRING getSoundex(STRING s) := BEGINC++

			inline bool isalpha(char c) {
				return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z');
			}

			inline char toupper(char c) {
				if (c >= 'a' && c <= 'z')
					return c - 0x20;
				return c;
			}
		/*
		NARA Soundex coding rules:

		Coding consists of a letter followed by three numerals. Examples: L123, C472, S160
		The first letter of a surname is not coded, it is retained.
		A, E, I, O, U, Y, W, and H are not coded.
		Double letters are coded as one letter (as in Lloyd).
		Prefixes to surnames like "van", "Von", "Di", "de", "le", "D", "dela" or "du" are sometimes disregarded in coding.
		Code the following letters to three digits using 0 at the end if needed.
		Letter  Code
		B P F V 1
		C S K G J Q X Z 2
		D T 3
		L 4
		M N 5
		R 6
		*/

		const char *soundex_table =
		 "0000000000000000" // 0x00 - 0x0f
		 "0000000000000000" // 0x10 - 0x1f
		 "0000000000000000" // 0x20 - 0x2f
		 "0000000000000000" // 0x30 - 0x3f
		 "0012301200224550" // 0x40 - 0x4f
		// ABCDEFGHIJKLMNO
		 "1262301020200000" // 0x50 - 0x5f
		//PQRSTUVWXYZ
		 "0012301200224550" // 0x60 - 0x6f
		// abcdefghijklmno
		 "1262301020200000" // 0x70 - 0x7f
		//pqrstuvwxyz
		 "0000000000000000" // 0x80 - 0x8f
		 "0000000000000000" // 0x90 - 0x9f
		 "0000000000000000" // 0xa0 - 0xaf
		 "0000000000000000" // 0xb0 - 0xbf
		 "0000000000000000" // 0xc0 - 0xcf
		 "0000000000000000" // 0xd0 - 0xdf
		 "0000000000000000" // 0xe0 - 0xef
		 "0000000000000000"; // 0xf0 - 0xff

		#body

		{
			char soundex[5] = "Z000";
			const char *source = s;
			int i;
			char code = 0;
			char last_code = ' ';
			char last_char = ' ';

			strcpy(soundex, "Z000");
			// first alpha character is first char of soundex
			// skipping over non alphas
			while (*source && !isalpha(*source)) source++;
			if (*source == 0) {
				// no good characters here
				__lenResult = strlen(soundex);
				__result = new char[__lenResult];
				strcpy(__result,soundex);
				return;
			}
			soundex[0] = toupper(*source);
			code = soundex_table[(int)*source];
			last_char = *source;
			last_code = code;
			source++;

			// next characters should be lookups into the soundex table;
			for (i = 1; i < 4 && *source != 0; ) {
				// advance while source not null and we have '0' codes
				while (*source != 0 && ((code = soundex_table[(int)*source]) == '0' )) {
					last_char = *source;
					last_code = code;
					source++;
				}
				if (*source == 0) continue;

				// if this soundex code is different from the last, use it.
				if (code != last_code) {
					// If the last character was an 'H' or 'W' and the last soundex code
					// assigned was the same as this one, don't code it.
					if ( soundex[i-1] == code
							 && ( last_char == 'H' || last_char == 'h'
							 || last_char == 'W' || last_char == 'w')) {
						last_code = code;
						last_char = *source;
						source++;
						continue;
					}

					soundex[i] = code;
					last_code = code;
					last_char = *source;
					i++;
				}
				source++;
			}
			
			__lenResult = strlen(soundex);
			__result = new char[__lenResult];
			strcpy(__result,soundex);

		}

		ENDC++;
		EXPORT STRING fatFingerCorrectedString(STRING str1, STRING str2) := BEGINC++

		#include <string>

		#body

			std::string myStr1 = str1;
			std::string myStr2 = str2;
			std::string correctedString;
					
			for (int i = 0; i < myStr1.length(); i++)
			{
				correctedString.push_back( myStr1[i] );
				if (myStr1[i] != myStr2[i])
				{
					if (((myStr1[i] == '9') || (myStr1[i] == '(') || (myStr1[i] == '-') || (myStr1[i] == '_')) && (myStr2[i] == '0'))
						correctedString.replace(i,1,"0");
					else if (((myStr1[i] == '`') || (myStr1[i] == '~') || (myStr1[i] == '2') || (myStr1[i] == '@')) && (myStr2[i] == '1'))
						correctedString.replace(i,1,"1");
					else if (((myStr1[i] == 's') || (myStr1[i] == 'S')) && (myStr2[i] == 'a'))
						correctedString.replace(i,1,"a");
					else if (((myStr1[i] == 's') || (myStr1[i] == 'S')) && (myStr2[i] == 'A'))
						correctedString.replace(i,1,"A");
					else if (((myStr1[i] == 'a') || (myStr1[i] == 'A') || (myStr1[i] == 'd') || (myStr1[i] == 'D')) && (myStr2[i] == 's'))
						correctedString.replace(i,1,"s");
					else if (((myStr1[i] == 'a') || (myStr1[i] == 'A') || (myStr1[i] == 'd') || (myStr1[i] == 'D')) && (myStr2[i] == 'S'))
						correctedString.replace(i,1,"S");
					else if (((myStr1[i] == 's') || (myStr1[i] == 'S') || (myStr1[i] == 'f') || (myStr1[i] == 'F')) && (myStr2[i] == 'd'))
						correctedString.replace(i,1,"d");
					else if (((myStr1[i] == 's') || (myStr1[i] == 'S') || (myStr1[i] == 'f') || (myStr1[i] == 'F')) && (myStr2[i] == 'D'))
						correctedString.replace(i,1,"D");
					else if (((myStr1[i] == 'o') || (myStr1[i] == 'O')) && (myStr2[i] == 'i'))
						correctedString.replace(i,1,"i");
					else if (((myStr1[i] == 'o') || (myStr1[i] == 'O')) && (myStr2[i] == 'I'))
						correctedString.replace(i,1,"I");
					else if (((myStr1[i] == 'i') || (myStr1[i] == 'I')) && (myStr2[i] == 'o'))
						correctedString.replace(i,1,"o");
					else if (((myStr1[i] == 'i') || (myStr1[i] == 'I')) && (myStr2[i] == 'O'))
						correctedString.replace(i,1,"O");
					else if (((myStr1[i] == 'f') || (myStr1[i] == 'F')) && (myStr2[i] == 'R'))
						correctedString.replace(i,1,"R");
					else if (((myStr1[i] == 'r') || (myStr1[i] == 'R')) && (myStr2[i] == 'F'))
						correctedString.replace(i,1,"F");
				}
			}
			
			__lenResult = correctedString.length();
			__result = new char[__lenResult];
			strcpy(__result,(char*)correctedString.c_str());

		ENDC++;
		EXPORT BOOLEAN CompareTokens100(STRING str1, STRING str2) := BEGINC++

		#include <string>
		#include <vector>

		void split(const char* str, int lenstr, std::vector<std::string> &vstr)
		{
			char *pIn = (char*)str;

			char data[256];
			char* ptr = data;
			int cnt = 0;
			while (cnt++ < lenstr) {
				if (*pIn == ' ') {
					if (cnt > 1) {
						*ptr = '\0';
						vstr.push_back( data );
					
						ptr = data;
					}
					while ((*pIn == ' ') && (cnt < lenstr)) {
						pIn++;
						cnt++;
					}
				}
				else
				{
					if ((*pIn >= 'a') && (*pIn <= 'z'))
						*(ptr++) = *(pIn++) + -'a' + 'A';
					else
						*(ptr++) = *(pIn++);
				}
			}
			
			*ptr = '\0';
			if (data[0] != '\0')
				vstr.push_back( data );
		}


		#body

			std::vector<std::string> vstr1;
			std::vector<std::string> vstr2;
			std::vector<bool> vbool;
			
			split(str1, lenStr1, vstr1);
			split(str2, lenStr2, vstr2);
			
			if (vstr1.size() != vstr2.size())
				return false;
			
			for (int i = 0; i < vstr2.size(); i++)
				vbool.push_back(false);

			for (int i = 0; i < vstr1.size(); i++) {
				bool match = false;
				for (int j = 0; j < vstr2.size(); j++) {
					if ((vstr1[i] == vstr2[j]) && !vbool[j]) {
						match = true;
						vbool[j] = true;
					}
				}
				
				if (!match)
					return false;
			}
			
			return true;

		ENDC++;
END; // Module

//******************************************************************************

