EXPORT Constants := MODULE

	EXPORT addrMaskString := '****';
	EXPORT phoneMaskString := '***-****';
	EXPORT AtSign := '@';
	
	EXPORT AddressTeaser := MODULE
		EXPORT MaxNames := 15;
		EXPORT MaxAddresses := 15;
		EXPORT StartDOB := 1900;
		EXPORT MaxPenalt := 5;
		EXPORT KeepLimitProperty := 10000;
		EXPORT KeepLimitYearBuilt := 1000;
		EXPORT RESIDENTIAL := 'Residential';
		EXPORT BUSINESS := 'Business';
	END;
END;