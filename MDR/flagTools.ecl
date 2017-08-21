export flagTools := 
MODULE

	export jflag2 := 
	MODULE
	
	export Ambiguous := 'A';
	export AmbiguousPropertySingleton := 'D';
	export AmbiguousPropertyMultiple := 'E';
	export NotAmbiguousPropertyMultiple := 'C';
	export NotAmbiguousPropertySingleton := 'B';

	export setAmbiguous := [Ambiguous,AmbiguousPropertySingleton,AmbiguousPropertyMultiple];
	export isAmbiguous(string1 jf) := jf in setAmbiguous;
	
	END;

END;