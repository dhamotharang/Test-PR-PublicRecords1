export Constants := module

	export Defaults := module
		export integer MaxResults := 2000;
		export unsigned2 TaxYearsToIgnore :=1;
	end;
	
	export IdentityTypeIndicator := module
		export string1 ADULT 			:= 'A';
		export string1 DEPENDENT 	:= 'D';
	end;
	
	export ScoreThreshold :=  50;
	export RealTimePermissibleUse := 'GOVERNMENT';
	
end;