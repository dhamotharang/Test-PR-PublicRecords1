// Contains constant values used in the Suspicious Fraud products

IMPORT Models, Risk_Indicators, RiskWise, Suspicious_Fraud_LN, UT;

EXPORT Constants := MODULE
	EXPORT DefaultDataSource := 'Internal'; // Possible values: Internal, Customer, or Third Party
	
	EXPORT DeltabaseLimit := 10;
	
	EXPORT AddressMessage := 'No hits on input Address in the Fraud Defense Manager File';
	
	EXPORT CombinationMessage := 'No excessive searches on input combination in the Fraud Defense Manager File';
	
	EXPORT EmailMessage := 'No hits on input Email in the Fraud Defense Manager File';
	
	EXPORT IPAddressMessage := 'No hits on input IP Address in the Fraud Defense Manager File';
	
	EXPORT NameMessage := 'No hits on input Name in the Fraud Defense Manager File';
	
	EXPORT PhoneMessage := 'No hits on input Phone Number in the Fraud Defense Manager File';
	
	EXPORT SSNMessage := 'No hits on input SSN in the Fraud Defense Manager File';
END;