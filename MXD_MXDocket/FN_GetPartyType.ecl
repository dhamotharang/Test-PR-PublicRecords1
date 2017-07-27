export MXD_MXDocket.Layouts_build.PartyType FN_GetPartyType(UNICODE party) := FUNCTION
	modifiedParty := u' '+party+u' ';
	checkBusiness :=
		IF(UnicodeLib.UnicodeFind(modifiedParty,u' SA ',1)>0 OR
			 UnicodeLib.UnicodeFind(modifiedParty,u' SAP ',1)>0 OR
			 UnicodeLib.UnicodeFind(modifiedParty,u' SCL ',1)>0 OR
			 UnicodeLib.UnicodeFind(modifiedParty,u' SCRL ',1)>0 OR
			 UnicodeLib.UnicodeFind(modifiedParty,u' SNC ',1)>0 OR
			 UnicodeLib.UnicodeFind(modifiedParty,u' SOCIEDA ',1)>0,
					TRUE, FALSE);
	checkNonProfit :=
		IF(UnicodeLib.UnicodeWildMatch(modifiedParty, u' A? ', false),
					TRUE, FALSE);
	checkCoop :=
		IF(UnicodeLib.UnicodeFind(modifiedParty,u' EDIGO ',1)>0 OR
			 UnicodeLib.UnicodeFind(modifiedParty,u' EGIDAL ',1)>0 OR
			 UnicodeLib.UnicodeFind(modifiedParty,u' COOPERATIBA ',1)>0 OR
			 UnicodeLib.UnicodeFind(modifiedParty,u' CONDOMINIOS ',1)>0 OR
			 UnicodeLib.UnicodeFind(modifiedParty,u' CONDOMINIO ',1)>0 OR
			 UnicodeLib.UnicodeFind(modifiedParty,u' CONDOMOS ',1)>0 OR
			 UnicodeLib.UnicodeFind(modifiedParty,u' CONDOMO ',1)>0,
					TRUE, FALSE);
	checkCreditUnion :=
		IF(UnicodeLib.UnicodeFind(modifiedParty,u' CREDITO ',1)>0,
					TRUE, FALSE);
	checkGovernment :=
		IF(UnicodeLib.UnicodeFind(modifiedParty,u' INFONAVIT ',1)>0 OR
			 UnicodeLib.UnicodeFind(modifiedParty,u' ASOCIACION ',1)>0 OR
			 UnicodeLib.UnicodeFind(modifiedParty,u' LOTERIA ',1)>0,
					TRUE, FALSE);
	checkEstate :=
		IF(UnicodeLib.UnicodeFind(modifiedParty,u' ESTATE OF ',1)>0,
					TRUE, FALSE);
	checkUnknown :=
		IF(UnicodeLib.UnicodeFind(modifiedParty,u' WITHHELD ',1)>0 OR
			 LENGTH(TRIM(party,LEFT,RIGHT))=0,
					TRUE, FALSE);
					
	return MAP(checkBusiness => MXD_MXDocket.Layouts_build.PartyType.BUSINESS,
						 checkNonProfit => MXD_MXDocket.Layouts_build.PartyType.NONPROFIT,
						 checkCoop => MXD_MXDocket.Layouts_build.PartyType.COOP,
						 checkCreditUnion => MXD_MXDocket.Layouts_build.PartyType.CREDITUNION,
						 checkGovernment => MXD_MXDocket.Layouts_build.PartyType.GOVERNMENT,
						 checkEstate => MXD_MXDocket.Layouts_build.PartyType.ESTATE,
						 checkUnknown => MXD_MXDocket.Layouts_build.PartyType.UNKNOWN,
						 MXD_MXDocket.Layouts_build.PartyType.PERSON);
END;
