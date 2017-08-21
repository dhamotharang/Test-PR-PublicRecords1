EXPORT MAC_get_metadata( dIn, file_num )   := functionmacro


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
			// #append(field_set, '{'+%'field_cnt'%+',\''+%'{@label}'%+'\'}')
			#append(field_set, '{'+ %'field_cnt'% + ',\''+ %'{@label}'%+'\''  +
			        ',\''+ %'{@type}'%+'\'' +  ',\''+ %'{@size}'%+'\''     +' }')
    #end
  #end
	
	#if (%field_cnt% = 0)
		return 'No input given';
	#end
	
	
	// output(%field_cnt%);
	
	
	#if (%field_cnt% > 0)
  // Produce the output, with one row for every field/column.
	#uniquename(d_norm)
  %d_norm%:=
		normalize(dIn,
		          %field_cnt%,
	            transform( siva_compare.Data_layouts.data_layout,
									      self.fldno:=counter,
												self.FileNo := file_num ,
												self.fld:=choose(#expand(%'field_values'%))
												)
							);


    
    return siva_compare.Data_layouts.get_fields_data (%d_norm%,
		dataset([#expand(%'field_set'%)]
		        , siva_compare.Data_layouts.Field_Identification ), %field_cnt%, file_num  ) ;
		
	#end
	
	endmacro;