EXPORT fn_classify_dedup_hypothesis(DATASET(layout_classify_hypothesis) wh,BOOLEAN Verified) := FUNCTION
  // First eliminate easy cases - same size of hypothesis in same position - but one is far more likely
	D0 := DEDUP ( SORT( wh, StartPos, Spc, -len ), LEFT.StartPos=RIGHT.StartPos AND LEFT.Len >= RIGHT.Len and LEFT.SPC < RIGHT.SPC - 2 );
	D := DEDUP ( SORT( D0, StartPos, -len, Spc ), LEFT.StartPos=RIGHT.StartPos AND LEFT.Len >= RIGHT.Len and LEFT.SPC < RIGHT.SPC - 2 );
	// Now we look for cases where a longer (and better) match beats a match on some later starting part of it
	// EG: We have a match on A B although B is also a weak match to something else
	J := JOIN(D,D(Len>1),LEFT.StartPos > RIGHT.StartPos AND
	              LEFT.StartPos+LEFT.Len <= RIGHT.StartPos+RIGHT.Len AND
								LEFT.Spc >= RIGHT.Spc,TRANSFORM(LEFT),LEFT ONLY,ALL);
  RETURN IF(Verified,J,D);
  END;
