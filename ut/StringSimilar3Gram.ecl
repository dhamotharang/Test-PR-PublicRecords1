export UNSIGNED INTEGER4 StringSimilar3Gram(STRING l, STRING r, 
																						UNSIGNED4 scale=100) := BEGINC++
// Helper functions
#include <math.h>
#include <string.h>
#include <stdlib.h>
#define FIXED_TGRAM_SZ 100
typedef struct TriGramEntry {
	char		trigram[3];
	short		freq[2];
} TriGramEntry;
int insertTrigram(int entries, TriGramEntry *tab, 
				const char* tg, int which) {
	int low = 0;
	int high = entries - 1;
	int mid = 0;
	int cr = -1;
	while (high-low >= 0) {
		mid = (high + low) >> 1; 
		cr = memcmp(tg, tab+mid, 3);
		if (cr < 0) high = mid - 1;
		else if (cr > 0) low = mid + 1;
		else break;
	}
	if (cr != 0) {		// entry not found
		if (cr > 0) mid++;		// mid is low
		if (mid < entries) {	// need to insert
			memmove((tab+mid+1), (tab+mid), 
					sizeof(TriGramEntry)*(entries-mid));
		}
		tab[mid].freq[0] = which==0 ? 1 : 0;
		tab[mid].freq[1] = which==1 ? 1 : 0;
		memcpy(tab+mid, tg, 3);
		entries++;
	} else {
		tab[mid].freq[which]++;
	}
	return entries;
}
int processString(int entries, int len, const char *str, 
				  TriGramEntry *tab, int which) {
	char	trigram[3];
	trigram[0] = ' ';
	trigram[1] = str[0];
	trigram[2] = len<2 ? ' '  : str[1];
	entries = insertTrigram(entries, tab, trigram, which);
	int i = 1;
	while (i < len-1) {
		entries = insertTrigram(entries, tab, str + i -1, which);
		i++;
	}
	if (len > 1) {
		trigram[0] = str[i-1];
		trigram[1] = str[i];
		trigram[2] = ' ';
		entries = insertTrigram(entries, tab, trigram, which);
	}
	return entries;
}
// Function called by ECL
// unsigned int 
// StringSimilar3gram(unsigned lenL, const char *l, 
				   // unsigned lenR, const char *r, 
				   // unsigned long scale=100) {
#body
#option pure
	// stack work area
	TriGramEntry* tab;
	TriGramEntry  stack_work[FIXED_TGRAM_SZ];
	unsigned int max_tgram = FIXED_TGRAM_SZ;
	unsigned int entries = 0;
	// trim trailing blanks
	while(lenL && l[lenL-1]==' ') lenL--;
	while(lenR && r[lenR-1]==' ') lenR--;
	// easy exits
	if (lenL==lenR && lenL==0) return scale;	// 2 empties are equal
	if (lenL==0 || lenR == 0)  return 0;	// perfect disagreement
	if (lenL==lenR && 0==memcmp(l, r, lenL)) return scale;
	// hard work ahead, build table
	if (lenL + lenR < max_tgram) {
		tab = stack_work;
	} else {
		max_tgram = lenL + lenR + 1;
		tab = (TriGramEntry*)malloc(max_tgram*sizeof(TriGramEntry));
	}
	entries = processString(entries, lenL, l, tab, 0);
	entries = processString(entries, lenR, r, tab, 1);
	long long lSqSum = 0;
	long long rSqSum = 0;
	long long lrSum  = 0;
	for (unsigned int i=0; i<entries; i++) {
		lSqSum += tab[i].freq[0] * tab[i].freq[0];
		rSqSum += tab[i].freq[1] * tab[i].freq[1];
		lrSum  += tab[i].freq[0] * tab[i].freq[1];
	}
	if (tab != stack_work) free(tab);
	double denominator = ((double) lSqSum) * ((double) rSqSum);
	denominator = sqrt(denominator);
	unsigned int sim = (int) ((scale * lrSum / denominator) + .5);
	if (sim > scale-1) sim = scale-1;
	return sim;
	
ENDC++;
