﻿IMPORT SALT44;
EXPORT Interfaces := MODULE
  EXPORT IConceptCustomFuzzy11 := INTERFACE
		EXPORT SALT44.StrType L1;
		EXPORT UNSIGNED2  L1Spec;
		EXPORT BOOLEAN    L1NNE;	
		EXPORT INTEGER    L1Force;
		EXPORT BOOLEAN    L1Initial;
		EXPORT UNSIGNED   L1InitSpec := 0;
		EXPORT INTEGER    L1Edit;
		EXPORT UNSIGNED1  L1EditThreshold;
		EXPORT UNSIGNED1  L1Length;
		EXPORT UNSIGNED2  L1FuzzySpec;
		EXPORT SALT44.StrType R1;
		EXPORT UNSIGNED1  R1Length;
		EXPORT UNSIGNED2  R1Spec := 0;
		EXPORT UNSIGNED2  R1FuzzySpec := 0;
	END;
	EXPORT IConceptCustomFuzzy12 := INTERFACE
	  EXPORT SALT44.StrType L2;
		EXPORT UNSIGNED2  L2Spec;
		EXPORT BOOLEAN    L2NNE;	
		EXPORT INTEGER    L2Force;
		EXPORT BOOLEAN    L2Initial;
		EXPORT UNSIGNED   L2InitSpec := 0;
		EXPORT INTEGER    L2Edit;
		EXPORT UNSIGNED1  L2EditThreshold;
		EXPORT UNSIGNED1  L2Length;
		EXPORT UNSIGNED2  L2FuzzySpec;
		EXPORT SALT44.StrType R2;
		EXPORT UNSIGNED1  R2Length;
		EXPORT UNSIGNED2  R2Spec := 0;
		EXPORT UNSIGNED2  R2FuzzySpec := 0;
	END;
	EXPORT IConceptCustomFuzzy13 := INTERFACE
	  EXPORT SALT44.StrType L3;
		EXPORT UNSIGNED2  L3Spec;
		EXPORT BOOLEAN    L3NNE;	
		EXPORT INTEGER    L3Force;
		EXPORT BOOLEAN    L3Initial;
		EXPORT UNSIGNED   L3InitSpec := 0;
		EXPORT INTEGER    L3Edit;
		EXPORT UNSIGNED1  L3EditThreshold;
		EXPORT UNSIGNED1  L3Length;
		EXPORT UNSIGNED2  L3FuzzySpec;
		EXPORT SALT44.StrType R3;
		EXPORT UNSIGNED1  R3Length;
		EXPORT UNSIGNED2  R3Spec := 0;
		EXPORT UNSIGNED2  R3FuzzySpec := 0;		
	END;
	EXPORT IConceptCustomFuzzy14 := INTERFACE
	  EXPORT SALT44.StrType L4;
		EXPORT UNSIGNED2  L4Spec;
		EXPORT BOOLEAN    L4NNE;	
		EXPORT INTEGER    L4Force;
		EXPORT BOOLEAN    L4Initial;
		EXPORT UNSIGNED   L4InitSpec := 0;
		EXPORT INTEGER    L4Edit;
		EXPORT UNSIGNED1  L4EditThreshold;
		EXPORT UNSIGNED1  L4Length;
		EXPORT UNSIGNED2  L4FuzzySpec;
		EXPORT SALT44.StrType R4;
		EXPORT UNSIGNED1  R4Length;
		EXPORT UNSIGNED2  R4Spec := 0;
		EXPORT UNSIGNED2  R4FuzzySpec := 0;		
	END;
	EXPORT IConceptCustomFuzzy15 := INTERFACE
	  EXPORT SALT44.StrType L5;
		EXPORT UNSIGNED2  L5Spec;
		EXPORT BOOLEAN    L5NNE;	
		EXPORT INTEGER    L5Force;
		EXPORT BOOLEAN    L5Initial;
		EXPORT UNSIGNED   L5InitSpec := 0;
		EXPORT INTEGER    L5Edit;
		EXPORT UNSIGNED1  L5EditThreshold;
		EXPORT UNSIGNED1  L5Length;
		EXPORT UNSIGNED2  L5FuzzySpec;
		EXPORT SALT44.StrType R5;
		EXPORT UNSIGNED1  R5Length;
		EXPORT UNSIGNED2  R5Spec := 0;
		EXPORT UNSIGNED2  R5FuzzySpec := 0;		
	END;	
  EXPORT IConceptCustomFuzzy2 := INTERFACE(IConceptCustomFuzzy11,IConceptCustomFuzzy12)
	END;
  EXPORT IConceptCustomFuzzy3 := INTERFACE(IConceptCustomFuzzy11,IConceptCustomFuzzy12,IConceptCustomFuzzy13)
	END;
  EXPORT IConceptCustomFuzzy4 := INTERFACE(IConceptCustomFuzzy11,IConceptCustomFuzzy12,IConceptCustomFuzzy13,IConceptCustomFuzzy14)
	END;
  EXPORT IConceptCustomFuzzy5 := INTERFACE(IConceptCustomFuzzy11,IConceptCustomFuzzy12,IConceptCustomFuzzy13,IConceptCustomFuzzy14,IConceptCustomFuzzy15)
	END;
END;
