IMPORT NID;

EXPORT fn_FirstNamesMatch(STRING first1, STRING first2, STRING p1 = '', STRING p2 = '') := FUNCTION

  BOOLEAN isInitial(STRING name) := IF(LENGTH(TRIM(name)) = 1, TRUE, FALSE);
  STRING PreferredFirst(STRING name) := NID.PreferredFirstNew(name);
  UNSIGNED EditDistance(STRING s1, STRING s2) := STRINGLib.EditDistance(s1, s2);

  // we'll allow preferred first as inputs so we don't have to recompute them
  // if they're already avaialable. If they're not passed in, we'll figure
  // them out here...
  STRING pref1 := IF (p1 <> '', p1, PreferredFirst(first1));
  STRING pref2 := IF (p2 <> '', p2, PreferredFirst(first2));

  RETURN MAP(first1 = '' OR first2 = '' => FALSE,
             first1 = first2 => TRUE,
             pref1 = pref2 => TRUE,
             (isInitial(first1) OR isInitial(first2)) AND first1[1] = first2[1] => TRUE,
             LENGTH(first1) > 3 AND LENGTH(first2) > 3 AND EditDistance(first1, first2) <= 1 => TRUE,
             FALSE);
END;
