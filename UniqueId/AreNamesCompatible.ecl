import STD;
EXPORT boolean AreNamesCompatible(UNICODE s, UNICODE t) := FUNCTION
			s1 := Std.Uni.FilterOut(Std.Uni.ToUpperCase(s),',."');
			t1 := Std.Uni.FilterOut(Std.Uni.ToUpperCase(t),',."');
			RETURN s1 = t1;
//							(STD.Uni.Find(TRIM(s1), t1, 1) = 1 OR STD.Uni.Find(TRIM(t1), s1, 1) = 1);
END;
