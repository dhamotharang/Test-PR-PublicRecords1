export MaxScores := 
MODULE

	export IMax := 
	INTERFACE
		export unsigned2 maxScoreFromSSN := 100; 			
		export unsigned2 maxScoreFromAddress := 100;
		export unsigned2 maxScoreFromDOB := 90;
		export unsigned2 maxScoreFromPhone := 100;
	END;

	export MMax :=
	MODULE
		(IMax)
	END;

END;