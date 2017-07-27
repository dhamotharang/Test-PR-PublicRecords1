export MAC_RemoveUncleanCityZip(infile,outfile) := MACRO
	//This Macro sets the city and state to empty string if
	//the city field has the value 'XXXX'
	//This is done to counter the BatchGate Address Cleaning
	//idiosyncrasy of adding 'XXXXX' as city and 'AL' as state
	//for uncleanable addresses
	#UNIQUENAME(xFormClean)
	infile %xFormClean%(infile le):= TRANSFORM
		isUnclean := le.p_city_name[1..5] = 'XXXXX';
		SELF.p_city_name := IF(isUnclean,'',le.p_city_name);
		SELF.st := IF(isUnclean,'',le.st);
		SELF := le;
	END;
	
	outfile := PROJECT(infile,%xFormClean%(LEFT));
ENDMACRO;