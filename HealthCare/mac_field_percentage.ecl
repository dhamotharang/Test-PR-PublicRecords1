// pass it any dataset for salt base profiling (dIn)
// return value will contain the results from SALT30.MAC_Character_Counts.FN_Profile
// for all field in the dataset
export mac_field_percentage ( dIn, in_prefix = 'idv') := functionmacro

  import SALT30;
	import hipie_ecl;
  
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
		#if ( regexfind('(?i)unsigned|integer|real|decimal|udecimal', %'{@type}'%) )
		  #append(field_set, '{'+%'field_cnt'%+',\''+ %'{@label}'%+'\',true,\'' + %'{@type}'% + '\'}')
		#else
		  #append(field_set, '{'+%'field_cnt'%+',\''+ %'{@label}'%+'\',false,\'' + %'{@type}'% + '\'}')
		#end
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
	            transform(SALT30.MAC_Character_Counts.Data_Layout,
									      self.fldno:=counter,
												self.fld:=choose(#expand(%'field_values'%))
												)
							);
						
  type_fld_id := record(SALT30.MAC_Character_Counts.Field_Identification)
    boolean is_numeric;
    string15 datatype;
  end;

  fld_ids := dataset([#expand(%'field_set'%)], type_fld_id );
					
  fld_detail := join(%d_norm%, fld_ids, left.fldno=right.fldno, transform({SALT30.MAC_Character_Counts.Data_Layout;type_fld_id},self:=left,self:=right),lookup);

  row_cnt := count(dIn);
    
  fld_agg := table(fld_detail, 
                   {fldno, integer8 fld_cnt:=count(group, (not is_numeric and fld!='') or (is_numeric and (real8)fld!=0) ), total_recs:=row_cnt;},
	                 fldno,
									 few);


  layout_summary := record
    string Prefix_FieldName;
		// integer4 field_count;
    Integer Prefix_FieldPercent;
    // real4 unique_pct;
  end;
  
  fld_summary := 
    join(fld_ids
         ,fld_agg
         ,left.fldno=right.fldno
         ,transform(layout_summary, self.Prefix_FieldName := left.fieldname; /*self.field_count := right.fld_cnt;*/ self:=left, self:=right, self.Prefix_FieldPercent:= right.fld_cnt * 100 /right.total_recs)
         ,lookup);
    
	Results := hipie_ecl.macFieldRename(fld_summary, in_prefix, 'prefix_',,true);

  return Results;

#end
	
endmacro;
