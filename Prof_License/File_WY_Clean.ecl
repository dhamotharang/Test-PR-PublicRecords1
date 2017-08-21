IMPORT Address;

EXPORT File_WY_Clean := FUNCTION

  Input_file := Prof_License.File_WY_Raw;
 
  trimUpper(STRING s) := FUNCTION
	  RETURN TRIM(stringlib.StringToUppercase(s), LEFT, RIGHT);
	END;
	
  Prof_License.Layout_WY_Raw.Input clean_trans(Prof_License.Layout_WY_Raw.Input L):= TRANSFORM
    SELF.website			  := trimUpper(L.website);
    SELF.state				  := trimUpper(L.state);
    SELF.business_name  := trimUpper(L.business_name);
    SELF.DBA            := trimUpper(L.DBA);
    SELF.name_first		  := trimUpper(L.name_first);
    SELF.name_middle		:= trimUpper(L.name_middle);
    SELF.name_last			:= trimUpper(L.name_last);
    SELF.name_suffix		:= trimUpper(L.name_suffix);
    SELF.address_line_1	:= trimUpper(L.address_line_1);
    SELF.address_line_2	:= trimUpper(L.address_line_2);
    SELF.address_city	  := trimUpper(L.address_city);
    SELF.address_st		  := trimUpper(L.address_st);
    SELF.address_zip		:= IF((INTEGER)StringLib.StringFilter(L.address_zip, '0123456789') <> 0,
		                          StringLib.StringFilter(L.address_zip, '0123456789'),
														  '');
    SELF.address_z4			:= IF((INTEGER)StringLib.StringFilter(L.address_z4,'0123456789') <> 0,
		                          StringLib.StringFilter(L.address_z4, '0123456789'),
														  '');
    SELF.email		      := trimUpper(L.email);
    SELF.license_number	:= trimUpper(L.license_number);
    SELF.license_type	  := trimUpper(L.license_type);
    SELF.license_status := trimUpper(L.license_status);
		
	  SELF := L;
  END;

  WY_Clean := PROJECT(Input_file, clean_trans(LEFT));

  RETURN WY_Clean;

END;