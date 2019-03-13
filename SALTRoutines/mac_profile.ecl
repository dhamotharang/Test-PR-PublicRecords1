import SALT35;
#WARNING('mac_profile is deprecated - utilize SALTNN.MOD_Profile instead');
// pass it any dataset for salt base profiling (dIn)
// return value will contain the results from SALT35.MAC_Character_Counts.FN_Profile
// for all field in the dataset
export mac_profile( dIn ) := functionmacro
  loadxml('<xml/>');
  // counter used in choose() later on
  #declare(field_values) #set(field_values,'counter')
	#declare(field_set)
  // Count of the input data fields
  #declare(field_cnt) #set(field_cnt,0)
  #exportxml(fields,recordof(dIn))

  #for(fields)
    #for(field)
			#append(field_values,',(string)left.'+%'{@label}'%)
			#set(field_cnt,%field_cnt%+1)
			#if (%field_cnt% != 1)
				#append(field_set, ',')
			#end
			#append(field_set, '{'+%'field_cnt'%+',\''+%'{@label}'%+'\'}')
    #end
  #end
	
	#if (%field_cnt% = 0)
		return 'No input given';
	#end
	
	#if (%field_cnt% > 0)
  // Produce the output, with one row for every field/column.
	#uniquename(d_norm)
  %d_norm%:=
		normalize(dIn,
		          %field_cnt%,
	            transform(SALT35.MAC_Character_Counts.Data_Layout,
									      self.fldno:=counter,
												self.fld:=choose(#expand(%'field_values'%))
												)
							);
						
	return SALT35.MAC_Character_Counts.FN_Profile(%d_norm%,
		dataset([#expand(%'field_set'%)]
		        , SALT35.MAC_Character_Counts.Field_Identification ) );

	#end
endmacro;
