EXPORT ContainsField(field_name, layout_name ) := functionmacro
		
		#EXPORTXML(layout_xml,layout_name);
		local fm_found_flag := 'FALSE';
		//#SET(fm_found_flag, 'FALSE');
			#FOR (layout_xml) 
				 #FOR(Field)
						#IF(%'{@label}'% = field_name)
							#EXPAND('fm_found_flag := \'TRUE\';');//#SET(fm_found_flag, 'TRUE'); 
						#END
				 #END
			#END
		return if(fm_found_flag = 'FALSE', FALSE, TRUE);
	 EndMacro;