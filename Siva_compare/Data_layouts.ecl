EXPORT Data_layouts := module

import SALT23;

export Data_Layout := RECORD
  SALT23.StrType Fld { MAXLENGTH(200000) };
	UNSIGNED2 FldNo;
  UNSIGNED2 FileNo;
  END;

export Field_Identification := RECORD
  unsigned2 FldNo;
  SALT23.StrType FieldName;
	string field_type;
	integer field_size;
  END;
	
	
	export get_fields_data(dataset(Data_Layout) TheDatas, dataset(Field_Identification)TheFields, integer in_file_fields, integer file_num ) := FUNCTION
	
	
  met_datas := join( 	TheDatas, TheFields,
	                    left.FldNo = right.FldNo );
	
	output(met_datas  ,, '~pview::compare::metadata' + file_num , overwrite);
	
	
	return 0;

  end;

end;	