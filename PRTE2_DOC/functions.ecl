
export Functions := module

EXPORT get_category(STRING off_desc_in) := FUNCTION
     my_index := index({ 
   string150 offensecharge;
   }, layouts.base_layout, constants.lookup_key_file);
    
		Category_list:=my_index(offensecharge = off_desc_in);
    Category_ID_out:=if(count(category_list)= 0,'0',category_list[1].ID); 
     
		RETURN Category_ID_out;
	END;

EXPORT get_category_Lit(unsigned8 category_in) := FUNCTION
     my_index := index({ 
   string150 offensecharge;
   }, layouts.base_layout, constants.lookup_key_file);
    
		Category_list:=my_index((unsigned8)ID = category_in);
    Category_out:=if(count(category_list)= 0,'0',category_list[1].category); 
     
		RETURN Category_out;
	END;

end;

