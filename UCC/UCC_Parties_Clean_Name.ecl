import uccd;

UCC_Parties_All := 
//uccd.File_WithExpParty;

uccd.File_WithExpPartyExpanded;

// Same As Layout_UCC_Initial_Party_Master - Layout_UCC_Expanded_Party
layout_name_clean := RECORD

clean_name := IF(MATCHED(UCC.Pattern_Parse_Co_Name),
		UCC_Parties_All.name[1..(MATCHPOSITION(UCC.Pattern_Parse_Co_Name) - 1)],
		UCC_Parties_All.name);
UCC_Parties_All;
END;

Parties_Cleaned 
		:= PARSE(	UCC_Parties_All, orig_name, 
					UCC.Pattern_Parse_Co_Name, layout_name_clean,
					FIRST, NOSCAN, NOT MATCHED);


EXPORT UCC_Parties_Clean_Name 
		:= Parties_Cleaned
		 : PERSIST('TEMP::UCC_Clean_Party_Name');