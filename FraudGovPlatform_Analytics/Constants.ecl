﻿EXPORT Constants := MODULE
	EXPORT KelEntityIdentifier := MODULE
		EXPORT STRING LEXID := '_01';
		EXPORT STRING PHYSICAL_ADDRESS := '_09';
		EXPORT STRING EVENT := '_11';
		EXPORT STRING SSN := '_15';
		EXPORT STRING PHONENO := '_16';
		EXPORT STRING EMAIL := '_17';
		EXPORT STRING IPADDRESS := '_18';
		EXPORT STRING BANKACCOUNT := '_19';
		EXPORT STRING DRIVER_LICENSE := '_20';
	END;	
	EXPORT KelEntityType := MODULE
		EXPORT STRING LEXID := '01';
		EXPORT STRING PHYSICAL_ADDRESS := '09';
		EXPORT STRING EVENT := '11';
		EXPORT STRING SSN := '15';
		EXPORT STRING PHONENO := '16';
		EXPORT STRING EMAIL := '17';
		EXPORT STRING IPADDRESS := '18';
		EXPORT STRING BANKACCOUNT := '19';
		EXPORT STRING DRIVER_LICENSE := '20';
	END;	
	EXPORT KelEntityTypeName := MODULE
		EXPORT STRING LEXID := 'ID';
		EXPORT STRING PHYSICAL_ADDRESS := 'ADDR';
		EXPORT STRING EVENT := 'ID';
		EXPORT STRING SSN := 'SSN';
		EXPORT STRING PHONENO := 'PH';
		EXPORT STRING EMAIL := 'EML';
		EXPORT STRING IPADDRESS := 'IP';
		EXPORT STRING BANKACCOUNT := 'BANK';
		EXPORT STRING DRIVER_LICENSE := 'DL';
		EXPORT STRING UNK := 'unk';
	END;
	EXPORT KelEntityDescription := MODULE
		EXPORT STRING LEXID := 'Identity';
		EXPORT STRING PHYSICAL_ADDRESS := 'Address';
		EXPORT STRING EVENT := 'Identity';
		EXPORT STRING SSN := 'SSN';
		EXPORT STRING PHONENO := 'Phone';
		EXPORT STRING EMAIL := 'Email';
		EXPORT STRING IPADDRESS := 'IP';
		EXPORT STRING BANKACCOUNT := 'Bank Account';
		EXPORT STRING DRIVER_LICENSE := 'Driver License';
		EXPORT STRING UNK := 'unk';
	END;	
END;