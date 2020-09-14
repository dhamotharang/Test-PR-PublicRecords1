EXPORT Override_Layouts :=  MODULE

	EXPORT Layout_Get_Orphans := RECORD
	
		STRING datagroup;
		STRING12 did;
		STRING recID;
		BOOLEAN IsSuppressed;
		BOOLEAN IsOverride;
		BOOLEAN IsOverwritten;

	END;
 
 
END;