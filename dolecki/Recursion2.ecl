import dolecki;

export INTEGER Recursion2(INTEGER i) := FUNCTION
	return
		IF(i<10,
			-1,
			GLOBAL(dolecki.Recursion1(i-1))
		);
END;