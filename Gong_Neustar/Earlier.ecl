import ut, _Validate;
EXPORT Earlier(string date1, string date2, string def = ut.Now()) := FUNCTION
			d1 := IF(Gong_Neustar.IsValidDate(date1), date1, def);
			d2 := IF(Gong_Neustar.IsValidDate(date2), date2, def);
			return min(d1, d2);
END;
