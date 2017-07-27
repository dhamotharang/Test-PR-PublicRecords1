
EXPORT Interfaces := MODULE

	EXPORT i_Entity := 
		INTERFACE
			// F L A P S D plus Company Name and FEIN		
			EXPORT STRING30  AccountNumber := '';
			EXPORT STRING50  FName         := '';
			EXPORT STRING50  LName         := '';
			EXPORT STRING120 CName         := '';
			EXPORT STRING10  Phone         := '';
			EXPORT STRING200 Address       := '';
			EXPORT STRING25  City          := '';
			EXPORT STRING2   State         := '';
			EXPORT STRING5   Zip           := '';
			EXPORT STRING9   SSN           := '';
			EXPORT STRING9   FEIN          := '';
			EXPORT UNSIGNED8 DOB           :=  0;				
			
		END;
				
	EXPORT i_FieldMatchList :=
		INTERFACE
			EXPORT BOOLEAN Name      := TRUE;
			EXPORT BOOLEAN Comp_Name := TRUE;
			EXPORT BOOLEAN StrAddr   := TRUE;
			EXPORT BOOLEAN City      := TRUE;
			EXPORT BOOLEAN State     := TRUE;
			EXPORT BOOLEAN Zip       := TRUE;
			EXPORT BOOLEAN Phone     := TRUE;
			EXPORT BOOLEAN SSN       := TRUE;
			EXPORT BOOLEAN FEIN      := TRUE;
			EXPORT BOOLEAN DOB       := TRUE;
		END;
		
END;