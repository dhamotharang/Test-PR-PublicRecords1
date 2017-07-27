IMPORT tools;

EXPORT Keys(STRING pversion = '',
	          DATASET(Layouts.Base) pBaseBuilt = Files(pversion).Base.Main.Built) := MODULE

	SHARED Base := pBaseBuilt(ssn != '');
	SHARED Base_DID := Base(did != 0);

	tools.mac_FilesIndex('Base, {ssn, customer_id}, {Base}',
	                        KeyNames(pversion).SSNCustID, SSNCustID);
	tools.mac_FilesIndex('Base_DID, {did, customer_id}, {Base_DID}',
	                        KeyNames(pversion).DIDCustID, DIDCustID);

END;