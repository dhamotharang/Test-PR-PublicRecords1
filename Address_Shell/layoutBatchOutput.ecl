IMPORT Address_Shell;

EXPORT layoutBatchOutput := RECORD
	STRING20 AcctNo;
	Address_Shell.Layouts.address_shell_input - AccountNumber;
	STRING2 Address_Based_Public_Record__State := '';
	//Renaming State to Address_Based_Public_Record__State in Batch output since State already defined in input.
	Address_Shell.layoutPropertyCharacteristics_batch.attributesVersion1 - State; 
	Address_Shell.layoutPropertyCharacteristics_batch.propertyAddress_Output;
	Address_Shell.layoutPropertyCharacteristics_batch.propertyAttributes;
	Address_Shell.layoutPropertyCharacteristics_batch.propertyCharacteristics;
	Address_Shell.layoutPropertyCharacteristics_batch.propertyMortgages;
	Address_Shell.layoutPropertyCharacteristics_batch.propertySales;
	Address_Shell.layoutPropertyCharacteristics_batch.propertyTax;
END;