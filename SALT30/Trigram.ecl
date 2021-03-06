// Trigram similarity measures for UNICODE and SBCS strings.
EXPORT Trigram := MODULE,FORWARD
  IMPORT Std;
  EXPORT Bundle := MODULE(Std.BundleBase)
    EXPORT Name := 'Trigram';
    EXPORT Description := 'Trigram string similarity for UNICODE and SBCS strings';
    EXPORT Authors := ['John Holt'];
    EXPORT License := 'http://www.apache.org/licenses/LICENSE-2.0';
    EXPORT Copyright := 'Copyright (C) 2014 HPCC Systems';
    EXPORT DependsOn := [];
    EXPORT Version := '1.0.0';
  END;
  /* Measure string similarity based upon ration of common trigrams to all trigrams
   * found in the UNICODE argument strings.
   * @param l_str     the left string
   * @param r_str     the right string
   * @param uniq_ends distinguish the first and last trigrams.
   * @return          the ration of the number of trigrams in common to the combined
   *                  number of trigrams from both strings
   */
  EXPORT REAL8 compare_unicode(UNICODE l_str, UNICODE r_str,
                               BOOLEAN uniq_ends=FALSE) := FUNCTION
    UNICODE1 begin_text := IF(uniq_ends, u'\0002', u' ');
    UNICODE1 end_text := IF(uniq_ends, u'\0003', u' ');;
    tgram_rec := RECORD
      UNSIGNED2 l_count;
      UNSIGNED2 r_count;
      UNSIGNED2 common;
      UNICODE3 t_gram;
    END;
    ds := DATASET([{l_str, r_str}], {UNICODE l_str, UNICODE r_str});
    // make the bags of trigrams
    tgram_rec make_tg(RECORDOF(ds) d, UNSIGNED c, UNSIGNED1 pick) := TRANSFORM
      UNICODE  w_str := TRIM(CHOOSE(pick, d.l_str, d.r_str));
      UNICODE3 first_str := begin_text + w_str[1..2];
      UNICODE3 mid_str := w_str[c-1..c+1];
      UNICODE3 last_str := w_str[c-1..c] + end_text;
      SELF.t_gram := MAP(c BETWEEN 2 AND LENGTH(w_str)-1  => mid_str,
                         c = 1                            => first_str,
                         last_str);
      SELF.l_count := IF(pick = 1, 1, 0);
      SELF.r_count := IF(pick = 1, 0, 1);
      SELF.common := 0;
    END;
    l_tgrams := NORMALIZE(ds, LENGTH(LEFT.l_str), make_tg(LEFT, COUNTER, 1));
    r_tgrams := NORMALIZE(ds, LENGTH(LEFT.r_str), make_tg(LEFT, COUNTER, 2));
    indv_rec := SORT(l_tgrams+r_tgrams, t_gram);
    // roll for easy counting for easy counting
    tgram_rec roll_tgram(tgram_rec accum, tgram_rec next) := TRANSFORM
      SELF.t_gram := accum.t_gram;
      SELF.l_count := accum.l_count + next.l_count;
      SELF.r_count := accum.r_count + next.r_count;
      SELF.common  := MIN(SELF.l_count, SELF.r_count);
    END;
    roll_rec := ROLLUP(indv_rec, roll_tgram(LEFT,RIGHT), t_gram);
    common_card := 2 * SUM(roll_rec, common);
    tot_card := SUM(roll_rec, l_count) + SUM(roll_rec, r_count);
    REAL8 quick := quick_compare(l_str, r_str, uniq_ends);
    REAL8 ret_val := MAP(LENGTH(l_str)=0 AND LENGTH(r_str)=0  => 1.0,
                         LENGTH(l_str)=0                      => 0.0,
                         LENGTH(r_str)=0                      => 0.0,
                         l_str = r_str                        => 1.0,
                         LENGTH(l_str)=1 OR LENGTH(r_str)=1   => 0.0,
                         LENGTH(l_str) + LENGTH(r_str) < 5000 => quick,
                         common_card/tot_card);
    RETURN ret_val;
  END;
  /* Measure string similarity based upon ration of common trigrams to all trigrams
   * found in the single byte character set argument strings.
   * @param l_str     the left string
   * @param r_str     the right string
   * @param uniq_ends disting the first and last trigrams
   * @return          the ration of the number of trigrams in common to the combined
   *                  number of trigrams from both strings
   */
  EXPORT REAL8   compare_string(STRING l_str, STRING r_str,
                                BOOLEAN uniq_ends=FALSE) := FUNCTION
    RETURN compare_unicode((UNICODE) l_str, (UNICODE) r_str, uniq_ends);
  END;
  SHARED REAL8 quick_compare(UNICODE l, UNICODE r,
                                BOOLEAN uniq_ends=FALSE) := BEGINC++
  // Helper functions
  #include <math.h>
  #include <string.h>
  #include <stdlib.h>
  #define FIXED_TGRAM_SZ 200
  typedef struct TriGramEntry {
    UChar		trigram[3];
    short		freq[2];
  } TriGramEntry;
  int insertTrigram(int entries, TriGramEntry *tab,
          const UChar* tg, int which_one) {
    int low = 0;
    int high = entries - 1;
    int mid = 0;
    int cr = -1;
    while (high-low >= 0) {
      mid = (high + low) >> 1;
      cr = memcmp(tg, tab+mid, 3*sizeof(UChar));
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
      tab[mid].freq[0] = which_one==0 ? 1 : 0;
      tab[mid].freq[1] = which_one==1 ? 1 : 0;
      memcpy(tab+mid, tg, 3*sizeof(UChar));
      entries++;
    } else {
      tab[mid].freq[which_one]++;
    }
    return entries;
  }
  int processString(int entries, int len, const UChar *str,
            TriGramEntry *tab, int which_one, bool uniq_ends) {
    UChar	trigram[3];
    trigram[0] = uniq_ends ? 0x0002  : 0x0020;  //STX or blank
    trigram[1] = str[0];
    trigram[2] = len<2 ? (uniq_ends ?0x0003 :0x0020)  : str[1];
    entries = insertTrigram(entries, tab, trigram, which_one);
    int i = 1;
    while (i < len-1) {
      entries = insertTrigram(entries, tab, str + i -1, which_one);
      i++;
    }
    if (len > 1) {
      trigram[0] = str[i-1];
      trigram[1] = str[i];
      trigram[2] = uniq_ends ? 0x0003 : 0x0020;   // ETX or blank
      entries = insertTrigram(entries, tab, trigram, which_one);
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
    while(lenL && l[lenL-1]==0x0020) lenL--;
    while(lenR && r[lenR-1]==0x0020) lenR--;
    // easy exits
    if (lenL==lenR && lenL==0) return 1.0;	// 2 empties are equal
    if (lenL==0 || lenR == 0)  return 0.0;	// perfect disagreement
    if (lenL==lenR && 0==memcmp(l, r, lenL*sizeof(UChar))) return 1.0;
    // hard work ahead, build table
    if (lenL + lenR < max_tgram) {
      tab = stack_work;
    } else {
      max_tgram = lenL + lenR + 1;
      tab = (TriGramEntry*)malloc(max_tgram*sizeof(TriGramEntry));
    }
    entries = processString(entries, lenL, l, tab, 0, uniq_ends);
    entries = processString(entries, lenR, r, tab, 1, uniq_ends);
    long lCount = 0;
    long rCount = 0;
    long common  = 0;
    for (unsigned int i=0; i<entries; i++) {
      lCount += tab[i].freq[0];
      rCount += tab[i].freq[1];
      common += 2*(tab[i].freq[0]<tab[i].freq[1] ?tab[i].freq[0] :tab[i].freq[1]);
    }
    if (tab != stack_work) free(tab);
    double denominator = (double)(lCount + rCount);
    return common/denominator;
  ENDC++;
END;