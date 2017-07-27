// NAME: mac_TrimFields
// PARAMETERS: 			in_ds = input dataset (see IMPORTANT INFO below)
//						 in_ds_name = string of the name of the input dataset
//						 		 out_ds = resulting output dataset with string and qstring fields set as variable length
// PURPOSE: To set all string and qstring fields in a flattened dataset to be defined as variable length so that
//						the TRIM function can be applied to the result and thus take up less memory on output via roxie to 
//						the calling process.
//					Initially developed for use on large batch query outputs to the batch r3 environment via roxie to help 
//						alleviate java memory usage by removing trailing spaces from string and qstring fields.
// USEAGE: mac_TrimFields(input_dataset, 'input_dataset', output_dataset);
// EXAMPLE: *** shown below macro definition ***
// CODE GENERATION: *** shown below macro definition ***
// IMPORTANT INFO: Passing in nested / child datasets within the input dataset is allowed, but the trimming of 
//									string / qstring fields within the nested / child datasets is not supported at this time.  
//									The record structure of the nested / child dataset will be preserved.

EXPORT mac_TrimFields(in_ds, in_ds_name, out_ds) := MACRO
	// Generate XML of the input dataset layout
	LOADXML('<xml/>');
	#EXPORTXML(MetaInfoTrimFields,recordof(in_ds))
	
	// Declare symbols for template use
	#IF(%'LayoutTrimFields'%='')
		#DECLARE(LayoutTrimFields)
	#END
	#IF(%'TransformTrimFields'%='')
		#DECLARE(TransformTrimFields)
	#END
	#IF(%'NestedTrimName'%='')
		#DECLARE(NestedTrimName)
	#END

	// Set default symbol values
	#SET(LayoutTrimFields,'')
	#SET(TransformTrimFields,'')
	#SET(NestedTrimName,'')
	
	///////////////////////////////////////////////////////////////////////////
	// FIRST: Loop through the xml record structure of the input dataset and //
	//        build the guts of the new record and transformation structures //
	///////////////////////////////////////////////////////////////////////////
	#FOR(MetaInfoTrimFields)		
		#FOR(Field)
			// Check for nested / child datasets - START condition
			#IF(%'NestedTrimName'% = '' and (%'{@isRecord}'%<>'' or %'{@isDataset}'%<>''))
				// If at the start of the nested field, set the NestedTrimName to indicate start of nested field
				#SET(NestedTrimName,%'{@name}'%)
				// Macro does not support trim of strings for nested datasets at this time, so include full definition of nested dataset in layout_TrimFields
				#APPEND(LayoutTrimFields,'DATASET(RECORDOF(' + in_ds_name + '.' + %'{@name}'% + ')) ' + %'{@name}'% + ';\n')
				// For nested datasets, set the defination in TransformTrimFields to be the same as input nested dataset (preserve structure)
				#APPEND(TransformTrimFields,'SELF.' + %'{@name}'% + ' := L.' + %'{@name}'% + ';\n')
			#END
			// Check for being a non-nested dataset field
			#IF(%'NestedTrimName'% = '')
				#IF(%'{@type}'%	=	'string' or %'{@type}'%	=	'qstring')
					// If the field type is a string or qstring, create a new defination omitting the size of the string / qstring so variable length will be used			
					// So, if “STRING40 lastname;” was on the input record structure, then from the below, that would turn into “STRING lastname;”					
					#APPEND(LayoutTrimFields,%'{@type}'% + ' ' + %'{@name}'% + ';\n')
					// For string / qstring fields, add the TRIM command to the TransformTrimFields list
					#APPEND(TransformTrimFields,'SELF.' + %'{@name}'% + ' := TRIM(L.' + %'{@name}'% + ',LEFT,RIGHT);\n')
				#ELSE
					// All other field types will default to what they are defined as in the input dataset
					// So, if “INTEGER4 count_name;” was on the input record structure, then from the below, that will stay defined as "in_ds_name.count_name;”
					#APPEND(LayoutTrimFields,in_ds_name + '.' + %'{@name}'% + ';\n')
				#END
			#END
			// Check for nested / child datasets - END condition
			#IF(%'{@isEnd}'%<>'' and %'NestedTrimName'% = %'{@name}'%)
				// If at the end of the nested field for NestedTrimName, clear the NestedTrimName to indicate completion of nested field
				#SET(NestedTrimName,'')
			#END
		#END
	#END
	
	// TESTING: Show the guts of the record layout field list and transformation field list
	// output(%'LayoutTrimFields'%);
	// output(%'TransformTrimFields'%);
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	// SECOND: Create a record layout where string and qstring fields are set to variable length //
	//				  and all other field types stay as defined in the input data set									 //
	///////////////////////////////////////////////////////////////////////////////////////////////
	#UNIQUENAME(layout_TrimFields)	
	%layout_TrimFields% := RECORD, MAXLENGTH(2500000)
		// Record field layout list
    %LayoutTrimFields%
	END;
	
	///////////////////////////////////////////////////////////////////////////////////
	// THIRD: Create a transform to trim the trailing spaces from string and qstring // 
	//				 fields	this will help to preserve memory for batch processing output  //
	///////////////////////////////////////////////////////////////////////////////////
	#UNIQUENAME(xfm_TrimFields)
	%layout_TrimFields% %xfm_TrimFields%(in_ds	L) := TRANSFORM		
		// String / qstring fields to be trimmed or nested datasets to preserve
  	%TransformTrimFields%
		// All fields that are not a string, qstring, or nested dataset stay as defined
  	SELF := L;
  END;
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	// FOURTH: define resulting dataset with string / qstring fields trimmed and nested datasets preserved //
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	out_ds := PROJECT(in_ds, %xfm_TrimFields%(LEFT));
ENDMACRO;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// EXAMPLE 																																																																					 //
// *** When result output sets are compared all strings and qstrings of the input dataset that are not nested are now trimmed of trailing spaces *** //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		rec := RECORD
//			STRING40 lastname;
//			INTEGER4 lastname_count;
//			{STRING20 firstname, INTEGER2 firstname_count} firstname_info;
//		END;
//		ds_no_trim := DATASET([{'SMITH                   ', 1, {'JOHN   ',2}}], rec);
//		output(ds_no_trim,named('ds_no_trim'));
//		ut.mac_TrimFields(ds_no_trim,'ds_no_trim',ds_trimmed);
//		output(ds_trimmed,named('ds_trimmed'));

//////////////////////////////////////////////////////////////////////////////////////////////
// CODE GENERATED BY MACRO																																	//
// *** From ut.mac_TrimFields(ds_no_trim,'ds_no_trim',ds_trimmed) call in above example *** //
//////////////////////////////////////////////////////////////////////////////////////////////
// 		__Layout_TrimFields__111586__ := RECORD, MAXLENGTH(2500000)
// 			string lastName;
// 			ds_no_trim.lastname_count;
// 			DATASET(RECORDOF(ds_no_trim.firstname_info)) firstname_info;
// 		END;
//		__Layout_TrimFields__111586__ __xfm_TrimFields__111593__(ds_no_trim	L) := TRANSFORM
// 			SELF.lastName := TRIM(L.lastName,LEFT,RIGHT);
// 			SELF.firstname_info := L.firstname_info;
// 			SELF := L;
// 		END;
//		ds_trimmed := PROJECT(ds_no_trim, __xfm_TrimFields__111593__(LEFT));