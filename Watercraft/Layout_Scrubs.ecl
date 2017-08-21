Import Watercraft;

EXPORT Layout_Scrubs := Module	

	EXPORT Coastguard_Base :=  RECORD
		Watercraft.Layout_Watercraft_Coastguard_Base;
		unsigned scrubsbits1;
  END;
	
	EXPORT Search_Base := RECORD
		Watercraft.Layout_Watercraft_Search_Base;
		unsigned scrubsbits1;
		unsigned scrubsbits2;
	END;
	
	EXPORT Main_Base := RECORD
		Watercraft.Layout_Watercraft_Main_Base;
		unsigned scrubsbits1;
		unsigned scrubsbits2;
	END;
	
end;
