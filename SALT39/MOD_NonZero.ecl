EXPORT MOD_NonZero := MODULE
	EXPORT AVENZ(INTEGER x, INTEGER y) := MAP(x=0 => y, y=0 => x, AVE(x,y));
	EXPORT MINNZ(INTEGER x, INTEGER y) := MAP(x=0 => y, y=0 => x, MIN(x,y));
	EXPORT MAXNZ(INTEGER x, INTEGER y) := MAP(x=0 => y, y=0 => x, MAX(x,y));	
END;
