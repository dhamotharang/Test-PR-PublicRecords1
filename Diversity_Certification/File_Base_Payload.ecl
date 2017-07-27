//*** using this layout definition to remove the max length from the auto_keybuild layout. Since to avoid a compile issues with the batch service - Diversity_Certification_Services.Batch_Service_Records
PayLoad_Temp_Layout := RECORD
		Diversity_Certification.Layouts.Auto_KeyBuild;
END;

EXPORT File_Base_Payload := project(Diversity_Certification.File_SearchAutoKey, PayLoad_Temp_Layout);