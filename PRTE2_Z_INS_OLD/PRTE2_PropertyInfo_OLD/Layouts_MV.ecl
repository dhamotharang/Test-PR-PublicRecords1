IMPORT PropertyCharacteristics;

EXPORT Layouts_MV := MODULE

	EXPORT tradematerials := RECORD
   string3 category;
   string3 material;
   real8 value;
   string1 quality;
   string1 condition;
   unsigned2 age;
  END;

	EXPORT MV_Base_Layout := PropertyCharacteristics.Layouts.Base;

END;