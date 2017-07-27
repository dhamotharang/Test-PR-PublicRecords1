EXPORT HeaderSearchMatchCode := MODULE
  SHARED CodeEL_Base         := 0;
  EXPORT NoSearchCriteria := CodeEL_Base + 0;
	EXPORT BlankField := CodeEL_Base - 1;
	EXPORT FuzzyMatch := CodeEL_Base + 1;
	EXPORT NoMatch := CodeEL_Base - 2;
	EXPORT Match := CodeEL_Base + 2;
END;
