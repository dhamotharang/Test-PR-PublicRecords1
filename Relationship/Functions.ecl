EXPORT Functions := MODULE

	EXPORT getTransAssocFlgs(STRING transAssocMask) := FUNCTION
		RETURN ROW({
			transAssocMask[1] <>'' AND transAssocMask[1] <>'0', //Vehicle
			transAssocMask[2] <>'' AND transAssocMask[2] <>'0', //BankruptcyDirectRelationship
			transAssocMask[3] <>'' AND transAssocMask[3] <>'0', //BankruptcyIndirectRelationship
			transAssocMask[4] <>'' AND transAssocMask[4] <>'0', //PropertyDirectRelationship
			transAssocMask[5] <>'' AND transAssocMask[5] <>'0', //PropertyIndirectrelationship
			transAssocMask[6] <>'' AND transAssocMask[6] <>'0', //Experian
			transAssocMask[7] <>'' AND transAssocMask[7] <>'0', //Enclarity
			transAssocMask[8] <>'' AND transAssocMask[8] <>'0', //Transunion
			transAssocMask[9] <>'' AND transAssocMask[9] <>'0', //ForeclosureDirectRelationship
			transAssocMask[10]<>'' AND transAssocMask[10]<>'0', //Foreclosureindirectrelationship
			transAssocMask[11]<>'' AND transAssocMask[11]<>'0', //LienDirectRelationship
			transAssocMask[12]<>'' AND transAssocMask[12]<>'0', //LienIndirectrelationship
			transAssocMask[13]<>'' AND transAssocMask[13]<>'0', //EcrashSameVehicle
			transAssocMask[14]<>'' AND transAssocMask[14]<>'0', //EcrashDifferentVehicle
			transAssocMask[15]<>'' AND transAssocMask[15]<>'0', //Watercraft
			transAssocMask[16]<>'' AND transAssocMask[16]<>'0', //Aircraft
			transAssocMask[17]<>'' AND transAssocMask[17]<>'0', //UCC
			transAssocMask[18]<>'' AND transAssocMask[18]<>'0', //MarriageDivorce
			transAssocMask[19]<>'' AND transAssocMask[19]<>'0', //Policy
			transAssocMask[20]<>'' AND transAssocMask[20]<>'0', //SSN
			transAssocMask[21]<>'' AND transAssocMask[21]<>'0', //Claim
			transAssocMask[22]<>'' AND transAssocMask[22]<>'0', //Cohabit
			transAssocMask[23]<>'' AND transAssocMask[23]<>'0', //Apt
			transAssocMask[24]<>'' AND transAssocMask[24]<>'0', //POBox
		},Relationship.Layout_GetRelationship.TransactionalFlags_layout);
	END;

END;