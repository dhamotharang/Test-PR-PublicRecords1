EXPORT STRING fn_Translate(STRING inValue,
                           DATASET(Constants.TranslationLayout) lookupTable = Constants.BusinessTranslations) := FUNCTION

  substitutionRec := RECORD(Constants.TranslationLayout)
    INTEGER idx;
    STRING120 outStr;
  END;

  substitutionRec prepSubstitutions(Constants.TranslationLayout L, INTEGER c) := TRANSFORM
    SELF.idx := c;
    SELF.outStr := REGEXREPLACE(TRIM(L.inputRegex), TRIM(inValue), TRIM(L.preferredValue));
    SELF := L;
  END;

  substitutions := PROJECT(lookupTable, prepSubstitutions(LEFT, COUNTER));

  changed := substitutions(outStr <> inValue);
  RETURN IF(EXISTS(changed), changed[1].outStr, inValue);
END;
