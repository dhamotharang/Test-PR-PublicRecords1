﻿EXPORT Runway_Macro_Simplified( dIn, norm_fld) := functionmacro

import SALT23;

 Data_Layout := RECORD
 unsigned8 seq ;
 string100 Field_Name;
  SALT23.StrType field_value{ MAXLENGTH(200000) };
 END;
		
  loadxml('<xml/>');
  // counter used in choose() later on
  #declare(field_values) #set(field_values,'counter')
	#declare(field_set) #set(field_set,'counter')
  // Count of the input data fields
  #declare(field_cnt) #set(field_cnt,0)
  #exportxml(fields,recordof(dIn))

  #for(fields)
    #for(field)
			#append(field_values,',(string)left.'+%'{@label}'%)
			#set(field_cnt,%field_cnt%+1)
			#append(field_set, ',\''+%'{@label}'%+'\'')
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
	            transform(Data_Layout,
							self.seq := left.#EXPAND(norm_fld),	
							self.Field_Name:= choose(%field_set%),
							self.field_value:=choose(#expand(%'field_values'%))
							));
							

	
	d_norm1 := %d_norm%(Field_Name in ['nap', 'nas'] or (STD.str.find(Field_Name, 'score', 1) > 0 and Field_name not in ['rvd1110_1_0_score']));
	return d_norm1 ;

	#end
endmacro;