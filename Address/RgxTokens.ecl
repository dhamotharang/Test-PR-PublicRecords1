export RgxTokens := DATASET(
[
// junk matches (weight 0)
{'^ *$',16},					// blank line
{'^[^A-Z ]+$',0},			// no alpha characters
{'.+',5},					// pseudo-token to signal word match
{'.+',14},					// check for obscenities
{'\\b([^ ])\\1{4,}\\b',0},	// 5 or more repeated character
//{'\\b[B-DF-HJ-NP-TV-Z]{8,}\\b',0},	// 8 consecutive consonants
// business matches (weight 1)
//{'\\bINC(\\.)?\\b',1},
//{'\\bLLC$',1},
{'^[A-Z]+[0-9.+&]*[A-Z]*$',1},
//{'\\bCO(\\.)?$',1},
//{'\\bCORP(\\.)?$',1},
{'^[A-Z]+\'S\\b',1},		// Begins with 'S
//{'/',1},
{'[0-9]+$',1},
{'\\b[A-Z]+[ ]+OF[ ]+[A-Z]+\\b',1},
{'^[B-DF-HJ-NP-TVWXZ]{5,}\\b',1},	// begins with word with 5 consonants
{'\\b[B-DF-HJ-NP-TVWXZ]{5,}\\b',1},	// 5 consecutive consonants
{'^[0-9]+',1},
{' [0-9]+ ',1},
{'( [A-Z]){4,}\\b',1},					// 4 consecutive initials
{'([A-Z]\\.){3,}\\b',1},					// 3 consecutive initials with periods
{'^THE ',1},
{'\\b[A-Z]+\'S$',1},
//{'^[A-Z0-9]+$',1},
//{'^[A-Z0-9&-]+$',1},
{'^[A-Z0-9\'&-]+$',1},
{'#?[0-9]+\\b',1},
{'\\b[0-9]+[A-Z]+\\b',1},
{'^[A-Z]+ & [A-Z]+$',1},
{'[A-Z]+ FOR [A-Z]+',1},
{'[A-Z]+ WITH [A-Z]+',1},
//{'^[A-Z]+ AT [A-Z]+',1},
//{'^[A-Z]+ [A-Z]+ AT [A-Z]+\\b',1},
{'\\b[A-Z]+ AT [A-Z]+\\b',1},
{'^[A-Z]+ BY [A-Z]+$',1},
{'^[A-Z]+[ ]+AND[ ]+[A-Z]+$',1},
{'\\b[A-Z]+[ ]+AND[ ]+[A-Z]+[ ]+AND\\b',1},
{'[A-Z]+ TO [A-Z]+\\b',1},
{'[A-Z]+ IN [A-Z]+\\b',1},
{'\\b[B-DF-HJ-NP-TVWXZ]{5,}\\b',1},
{'^[A-Z] [A-Z] [A-Z]$',1},
{'^[A-Z] [A-Z&] [A-Z&] [A-Z]$',1},
{'\\b[B-DF-HJ-NP-TVWXZ]{4,}$',1},
{' \'N\\b',1},
{'\\bN\' ',1},
{'\\bINT\'L\\b',1},
//{'\\b[A-Z]+-[A-Z]+-[A-Z]+\\b',1},
{' - ',1},
//{'\\bDBA\\b',1},
{'\\bD/B/A\\b',1},
{'\\bD-B-A $',1},
{'\\bD-B-A$',1},
{'\\bD[.]?B[.]?A[.]?\\b',1},
{'\\bD B A$',1},
{'\\bP[ .]*L[ .]*L[ .]*C$',1},
//{'\\bP L L C$',1},
//{'\\bP\\.L\\.L\\.C\\.$',1},
//{'\\bP\\. L\\. L\\. C\\.$',1},
{'\\bL L C$',1},
{'\\bL[.]?L[.]?C[.]?$',1},
{'\\bL\\. L\\. C\\.$',1},
{'\\b"L[ .]L[ .]C\\.$"$',1},
{'\\bL L P$',1},
//{'LLC\\.$',1},
//{'[ ,-]L C$',1},
{'\\bL[.]?C[.]?$',1},
//{'[ ,-]LC$',1},
{'\\bS[.]?A[.]?$',1},
//{'FMLY L P$',1},
{'FAMILY L P$',1},
//{'[ ,-]L P$',1},
{'\\bL[.]?P[.]?$',1},
{'\\bL[.]?L[.]?P[.]?$',1},
//{'[ ,-]LP$',1},
//{'G P$',1},
//{'\\bGP$',1},
//{'\\bPC$',1},
{'\\bP[.]?C[.]?$',1},
{'\\bP\\. C\\.$',1},
{'\\bP[.]?A[.]?$',1},
{'\\bN[.]?A[.]?$',1},
//{'\\bPA$',1},
//{'\\bPA\\.$',1},
{'^[A-Z]\\.[A-Z]\\.[A-Z]\\.$',1},
{'^[A-Z] [A-Z] [A-Z]$',1},
{'^[A-Z] [A-Z] [A-Z] [A-Z]$',1},
{'^[A-Z] [A-Z] [A-Z] [A-Z] [A-Z]',1},
{'^[A-Z]+ [A-Z]+ [A-Z]+ TRUST$',1},
{'^[ ]*[^A-Z]',1},
{'^A A A ',1},
{'^A B C ',1},
{'^(THE|NAT\'L|SECOND|THIRD|UNIV|U OF|NEW)\\b',1},
//{'\\bPC$',1},
//{'^SECOND\\b',1},
//{'^THIRD ',1},
//{'^UNIV ',1},
//{'^U OF ',1},
//{'^NEW\\b',1},
//{'\\bWORLD$',1},
//{'\\bINST$',1},
//{'\\bCTR$',1},
//{'\\bCO$',1},
//{'\\bCO\\.$',1},
//{'\\.COM$',1},
//{'\\.NET$',1},
//{'\\bCOM$',1},
//{'\\bNET$',1},
{'\\bPUB$',1},
//{'\\bDIAL-A-.+',1},
//{'\\bRENT-A-.+',1},
//{'\\b(TWO|THREE|FOUR|SEVEN|EIGHT|NINE|TEN|ELEVEN|TWENTY|HUNDRED|MILLION)\\b',1},
//{'\\bSHOP(S)?$',1},
//{'^AAA\\b',1},
{'\\bF S B\\b',1},
{'\\bP S C\\b',1},
{'\\bR C CHURCH\\b',1},
{'\\bM E CHURCH\\b',1},
//{'\\bPRE-ARRANGEMENT\\b',1},
{'ODONTIC(S)?\\b',1},
{'OLOGY\\b',1},
{'OLOGIST(S)?\\b',1},
{'\\bU S A\\b',1},
{'^A T[ ]?&[ ]?T ',1},
{'^A T AND T ',1},
{'^bSALLIE MAE$',1},
{'^A [A-Z]+ (AND|&) A [A-Z]+$',1},	// e.g. A WING AND A PRAYER
{'^A [A-Z]+ A [A-Z]+$',1},			// e.g. A DAISY A DAY
{'[A-Z]*N\' ',1},					// a word ending in N'
{'[A-Z ,-]+&[A-Z ,-]*&',1},			// phrase with two ampersands
{',[^&]+,',1},						// multiple commas wihout intervening ampersand
// multiple names
//{'^[A-Z]{2,} [A-Z]{2,} [A-Z]{2,} & [A-Z]{2,}$',1},	// 
{'^([A-Z]{3,} ){3,}& [A-Z]+$',1},	// law firms
{'\\bE-Z\\b',1},
{'\\bA/C\\b',1},
{'\\bF/X\\b',1},
{'^CASA\\b',1},
{'OLOG(Y|ICAL|IST)\\b',1},
{'PLEX\\b',1},
{'& MORE$',1},
{'\\bXTRA[A-Z]*\\b',1},						// XTRAORDINAIRE
{'\\b[A-Z]+(LLC|CORP)\\b',1},
//{'\\bSELF( |-)SERV(IC)?E\\b',1},
{'\\bBAR B QUE\\b',1},
{', ?N\\.?A\\.?',1},						//**
{', ?P\\.? ?C\\.?',1},						//**
//{', N A',1},
//{', N\\. A\\.',1},
//{', N\\.A\\.',1},
//{',N\\. A\\.',1},
//{',N\\.A\\.',1},
{'L\\.T\\.D\\.',1},
{'-[A-Z]-',1},
{'\\b[A-Z]+\'S\\b',1},		
{'^ST(\\.)? [A-Z]+\'S\\b',1},		// Begins with ST nnn'S
{'^ST[.]? [A-Z]+[ ]+(CHURCH|SCHOOL|PARISH|CHAPEL|CATHEDRAL)',1},		// ST xxx CHURCH
{'\\b[A-Z]+ ON [A-Z]+\\b',1},
{'&&\\b',1},
{'^NO\\b',1},
{' -[A-Z]+',1},
{' A-[A-Z]+',1},
{'^([A-Z]+[ ]*,[ ]*){2,}',1},	// MOE, LARRY, AND CURLEY
// multiple words and phrases with punctuation
//{'\\bCO-OP\\b',1},
//{'\\bDRIVE-IN\\b',1},
//{'\\bON-LINE\\b',1},
//{'\\bSURGI-CENTER\\b',1},
//{'\\bT-SHIRT(S)?\\b',1},
//{'\\bAA\\b',1},
{'^A A A--$',1},
{'\\bA-\\b',1},
{'&[ ]*SONS\\b',1},
{'&[ ]*SON\\b',1},
{'& *FRIENDS$',1},
{'\\bCAB$',1},
{' A/C\\b',1},
// SPECIFIC COMPANIES
{'\\bH & R BLOCK\\b',1},
{'^A A$',1},
//{'\\bAL-ANON\\b',1},
{'\\bA[ ]+(AND|&)[ ]+P\\b',1},
{'^(LOS|LAS) ',1},
// junk matches (weight 0)
{'^AND [A-Z]+$',0},
{'^[A-Z]+ (AND|&)$',0},
{'^([A-Z]+) +[A-Z]+ +\\1$',15},		// word xxx word (word is repeated)
{'^([A-Z]+) +[A-Z]+ +[A-Z] +\\1$',15},		// word xxx y word (word is repeated)
//
//{'^([A-Z]{2,})[, ]+([A-Z]{2,})([ ]+AND[ ]+|[ ]*&[ ]*)([A-Z]{2,})$',8},	// name, name & name
//{'^[A-Z]+([ ]+AND[ ]+|[ ]*&[ ]*)[A-Z]+[ ]+([A-Z]+[ ]+)?[A-Z][\']?[A-Z-]+$',8},	// name & name name
{'^[A-Z][ ]*(&| AND )[ ]*[A-Z][ ]+[A-Z]+[ ]+[A-Z]+$',1},	// intial & initial word word
{'^[A-Z][ ]*(&| AND )[ ]*[A-Z][ ]+([A-Z]+)$',9},	// intial & initial word 
// conjunctive match
{'^[A-Z] +& +[A-Z] +[A-Z]+ AND [A-Z]+',1},	// A&B word and word
{'\\b([A-Z]+)[ ]*(&|AND)[ ]*([A-Z]+)\\b',7},	// word & word
{'\\b[A-Z]+[ ]*&[ ]*[A-Z]+[ ]+([A-Z]+)[ ]*(&|AND)[ ]*([A-Z]+)',7},	// A&B word and word
// match city names
{'^((\\w+\\W+){1,3}) *(CITY|TOWN|COUNTY)$',17},
// match dual names
{'^[A-Z]+ +OR +[A-Z]+$',0},		// name OR name (seems to be incomplete)
{'( AND |&| OR |&/OR )', 8},
// match names with slash
{'/', 10},
// probable business
//{'\\bAAA[A-Z-]*\\b',11},
{'\\b(AAA[A-Z-]*)\\b',13},
//{'\\b(AAA[A-Z-]*)\\b',1},
{'^A ([A-Z]+) [A-Z]+',12},
// unclassifiable
{'^(EST|DC|MMS) ',18},
// match ambiguous words
{'.+', 6},
// catch all ... this must be last
{'.+', 4}]
,Layout_Weighted_Tokens) : GLOBAL(FEW);