IMPORT STD;
EXPORT fn_LastNamesMatch(STRING last1, STRING last2, STRING dph1 = '', STRING dph2 = '') := FUNCTION

  DoubleMetaphone(STRING lname) := metaphonelib.DMetaPhone1(lname)[1..6];
  INTEGER EditDistance(STRING s1, STRING s2) := STD.STR.EditDistance(s1, s2);

  STRING plast1 := IF (dph1 <> '', dph1, DoubleMetaphone(last1));
  STRING plast2 := IF (dph2 <> '', dph2, DoubleMetaphone(last2));

  RETURN MAP(last1 = '' OR last2 = '' => FALSE,
             last1 = last2 => TRUE,
             LENGTH(last1) > 3 AND LENGTH(last2) > 3 AND plast1 = plast2 AND EditDistance(last1, last2) <= 1 => TRUE,
             FALSE);
END;
