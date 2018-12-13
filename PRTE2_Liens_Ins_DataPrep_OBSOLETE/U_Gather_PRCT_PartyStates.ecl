
IMPORT PRTE2_Liens, PRTE2_Liens_Ins_DataPrep;

EXPORT U_Gather_PRCT_PartyStates(PRTE2_Liens.files.SprayParty Party_Base, INTEGER howMany) := FUNCTION

		Party_Base_D := DISTRIBUTE(Party_Base,hash32(st));
		Party_Base_S := SORT(Party_Base_D,st,local);
		Party_1 := CHOOSESETS(Party_Base_S,
									 st='AK'=>howMany,st='AL'=>howMany,st='AR'=>howMany,st='AZ'=>howMany,st='CA'=>howMany,st='CO'=>howMany,
									 st='CT'=>howMany,st='DC'=>howMany,st='DE'=>howMany,st='FL'=>howMany,st='GA'=>howMany,st='HI'=>howMany,
									 st='IA'=>howMany,st='ID'=>howMany,st='IL'=>howMany,st='IN'=>howMany,st='KS'=>howMany,st='KY'=>howMany,
									 st='LA'=>howMany,st='MA'=>howMany,st='MD'=>howMany,st='ME'=>howMany,st='MI'=>howMany,st='MN'=>howMany,
									 st='MO'=>howMany,st='MS'=>howMany,st='MT'=>howMany,st='NC'=>howMany,st='ND'=>howMany,st='NE'=>howMany,
									 st='NH'=>howMany,st='NJ'=>howMany,st='NM'=>howMany,st='NV'=>howMany,st='NY'=>howMany,st='OH'=>howMany,
									 st='OK'=>howMany,st='OR'=>howMany,st='PA'=>howMany,st='RI'=>howMany,st='SC'=>howMany,st='SD'=>howMany,
									 st='TN'=>howMany,st='TX'=>howMany,st='UT'=>howMany,st='VA'=>howMany,st='VT'=>howMany,st='WA'=>howMany,
									 st='WI'=>howMany,st='WV'=>howMany,st='WY'=>howMany, 0);
		RETURN DISTRIBUTE(Party_1,hash32(st));
		
END;