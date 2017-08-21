
/*
**********************************************************************************
Created by    Comments
Vani 					This attribute denormalizes the records in Attribute file. The data  
							is concatinated to populate scars_marks_tattoos field. 
***********************************************************************************
*/	 

// Re distribute based on id
DAttribute 	             := DISTRIBUTE(File_soff_Attribute,HASH32(File_soff_Attribute.id));
DSortedAttribute         := SORT (DAttribute,id,description,LOCAL);
// Populate the ID's in the denormalized layout
IdTable                  := table(DSortedAttribute,Layout_Denorm_Attribute,id,LOCAL);
DSortedAttribute_Deduped := DEDUP(DSortedAttribute,RECORD,LOCAL);

//output(count(File_soff_Attribute));
//output(count(File_soff_Attribute));
//output(count(File_soff_Attribute_Sorted));
//output(IdTable);

Layout_Denorm_Attribute DeNormAttribute(Layout_Denorm_Attribute L, Layout_soff_attribute R, INTEGER C) := TRANSFORM


   //for the second iteration concaticate desc to attribute only is field size allows it
   STRING V_temp_desc := IF (trim(R.description) not in Invalid_values, trim(R.description), '');

	 SELF.scars_marks_tattoos := MAP (C=1 => trim(V_temp_desc),
		                                       trim(L.scars_marks_tattoos)+IF(V_temp_desc <> '','; '+trim(V_temp_desc),'')
									                 );
   SELF := L;
end;
	 
export Mapping_Denorm_Attribute := DENORMALIZE(IdTable,DSortedAttribute_Deduped,
                                               LEFT.id = RIGHT.id,
								                               DeNormAttribute(LEFT,RIGHT,COUNTER),LOCAL);
																	

