export Meta_Version(FileName_Info info) := FUNCTION
	DictIndx := Indx_Dictionary3(info);
	versionSet := CHOOSEN(DictIndx(KEYED(word=(Types.WordFixed) Constants.MetaVersion)),1);
	UNSIGNED4 v := IF(EXISTS(versionSet), EVALUATE(versionSet[1], suffix), 0);
	RETURN v;
END;