/////////////////////////////////////////////////////////////////
//					MACRO TO LOOKUP CODE DESC FROM CODESV3						 //
/////////////////////////////////////////////////////////////////

//*******************************************************************/
//	IMPORTANT: INPUT DATASET MUST BE DISTRIBUTED	
//*******************************************************************/

// PARAMETERS
// -----------------------------------------------------------------------
// indataset 						-		Dataset that contains the code values
// inlayout							-		Layout that included code fields + desc fields
// outdataset 					- 	resulting dataset
// filename_val					-		filename to search for in codesv3
// code_field_name_val 	- 	String which contains the name of the code field
// desc_field_name 			- 	literal name of the description field (not a string)
// code_field_name 			- 	literal name of the code field (not a string)
// in_field_name2		-  Some datasets require field_name2 to be used in join, in this case
//						   pass the literal field name from the dataset that should be used,
//						   if not pass any valid field name from the dataset.
// use_field_name 		-  True - use in_field_name2 parameter,
//						   false - don't use in_field_name2
// ------------------------------------------------------------------------


export Mac_Convert_Codes_To_Desc(indataset,inlayout,outdataset,filename_val,code_field_name_val,
						desc_field_name,code_field_name,in_field_name2,use_field_name = 'false') := macro
import Codes;
	#uniquename(ds)
	%ds% := Codes.File_Codes_V3_In;
	#uniquename(lookup_code)
	inlayout %lookup_code%(indataset l,%ds% r) := transform
		self.desc_field_name := r.long_desc;
		self := l;
	end;
	
	outdataset := if ( use_field_name,
					join(indataset,%ds%(file_name = filename_val and field_name = code_field_name_val),
										left.code_field_name = right.code and left.in_field_name2 = right.field_name2,
										%lookup_code%(left,right),
										left outer,
										lookup
										),
					join(indataset,%ds%(file_name = filename_val and field_name = code_field_name_val),
										left.code_field_name = right.code,
										%lookup_code%(left,right),
										left outer,
										lookup
										));
	
endmacro;