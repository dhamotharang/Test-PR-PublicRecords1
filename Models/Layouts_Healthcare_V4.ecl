Import Models;

EXPORT Layouts_Healthcare_V4 := module 
	EXPORT Output_Layout := RECORD
	Models.Layouts_Healthcare_Core.Final_Output_Layout;
	string10 ReadmissionScore_Category;
	string10 MedicationAdherenceScore_Category;
	END;
	
END;