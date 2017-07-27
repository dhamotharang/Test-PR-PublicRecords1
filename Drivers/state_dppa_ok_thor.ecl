import codes, mdr;
export state_dppa_ok_thor(inds, permission, headersource_field, outds) :=
MACRO


#uniquename(tran)
#uniquename(le)
inds %tran% (inds %le%) :=
TRANSFORM
	SELF := %le%;
END;

/*
#uniquename(isExperianVeh)
%isExperianVeh% := 
MACRO
(LEFT.headersource_field[2]='E' and LEFT.headersource_field not in ['DE','FE'])
ENDMACRO;
*/

outds := JOIN(inds(mdr.Source_is_DPPA(headersource_field)), codes.File_Codes_V3_In(file_name='GENERAL'), 
																				(((LEFT.headersource_field[2]='E' and LEFT.headersource_field not in ['DE','FE']) AND RIGHT.field_name='EXPERIAN-DL-PURPOSE') 
																							 OR (~(LEFT.headersource_field[2]='E' and LEFT.headersource_field not in ['DE','FE']) AND  RIGHT.field_name='DL-PURPOSE'))
																				// state check
																				AND RIGHT.field_name2=header.translateSource(LEFT.headersource_field)[1..2]
																				AND RIGHT.code=permission, %tran%(LEFT), LEFT ONLY, LOOKUP)+inds(~mdr.Source_is_DPPA(headersource_field));
																				
ENDMACRO;


/*

   NOT (d=1 and st IN ['CT','NH','NM','OR']) and
   NOT (d=2 and st IN ['CT','OK','OR']) and
   NOT (d=3 and st IN ['NH','NV','NM','TX','OR']) and
   NOT (d=4 and st IN ['CT','NM','ND','WV','OR']) and
   NOT (d=5 and st IN ['CT','KY','MT','NV','OK','OR']) and
   NOT (d=6 and st IN ['ID','NH','OR']) and
   NOT (d=7 and st IN ['AK','CT','IL','MD','MA','MI','NE','NH','NV','NM','SC','UT','WY','OR']);
*/