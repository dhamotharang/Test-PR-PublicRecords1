IMPORT LN_Propertyv2;
EXPORT Layout_prep_assessment := RECORD
				LN_Propertyv2.layout_property_common_model_base;
				string1		Append_ReplRecordInd := 'N';
				string3 	update_type;
				string100 raw_file_name;
END;
