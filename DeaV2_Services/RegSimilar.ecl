
export RegSimilar(string l, string r) := FUNCTION

sim := DataLib.StrCompare(StringLib.StringToUpperCase(l),r);

return map(sim =0 => sim,
					 sim = 1 =>  1,
					 sim < 12 => 2,
					 sim < 20 => 3,
					 sim = 20 => 4,
					 sim <= 80 => roundup(sim/10) +1,
					 roundup(sim/10));
	
END;
