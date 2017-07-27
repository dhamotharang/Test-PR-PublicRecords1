EXPORT UNSIGNED4 Dict_Version(FileName_Info info) := FUNCTION
  // defaults to 2 of new dictionary not available
	DictIndx := Indx_Dictionary3(info);
	versionSet := CHOOSEN(DictIndx(KEYED(word=(Types.WordFixed) Constants.DictVersion)),1);
	UNSIGNED4 v := IF(EXISTS(versionSet), EVALUATE(versionSet[1], suffix),
																				FAIL(UNSIGNED4, Limits.DictNoGood_Code, Limits.DictNoGood_Msg));
	RETURN v;
END;