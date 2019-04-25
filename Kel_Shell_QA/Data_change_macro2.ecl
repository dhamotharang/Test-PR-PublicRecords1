EXPORT Data_change_macro2(dInput,test_lay,op_result) := MACRO

import ut, std, salt23;

	
loadxml('<xml/>');
// counter used in choose() later on
#declare(field_values) #set(field_values,'counter')
#declare(field_set) #set(field_set,'counter')

// Count of the input data fields
#declare(field_cnt) #set(field_cnt,0)
#exportxml(fields,test_lay)

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
#uniquename(din)
%din% := distribute(dinput):independent;

#uniquename(new_lay)
%new_lay% := record
	unsigned seq_num;
	recordof(%din%);
end;

#uniquename(proj_seq2)
%proj_seq2% := PROJECT(%din%, transform(%new_lay%,self.seq_num := counter;self := left;));

#uniquename(Data_Layout)
%Data_Layout% := record
	unsigned seq_num;
	string100 FieldName;
	SALT23.StrType field_value{maxlength(2000)};
end;
	
#if (%field_cnt% > 0)
	// Produce the output, with one row for every field/column.
	#uniquename(d_norm)
	%d_norm%:=
		normalize(%proj_seq2%,
							%field_cnt%,
							transform(%Data_Layout%,
								self.seq_num := left.#EXPAND('seq_num'),
								self.FieldName:= choose(%field_set%),
								// self.field_value:=[];
								self.field_value:=choose(#expand(%'field_values'%))
							));

	#uniquename(d_norm1)
	%d_norm1% := %d_norm%(FieldName not in ['seq_num']);
#end

#uniquename(lay1)	
%lay1% := record
	string100 FieldName;
  SALT23.StrType field_value{maxlength(2000)};
	test_lay;
end;

#uniquename(d_norm2)	
%d_norm2% := JOIN(%d_norm1%, %proj_seq2%, 
									left.seq_num = right.seq_num, 
									transform(%lay1%, 
										self.seq_num     := right.seq_num;
										self.fieldname   := left.fieldname;
										self.field_value := left.field_value;
										self             := right;
									));

op_result:=%d_norm2%;
endmacro;