export Debug := MODULE
	export debug_flag := FALSE;
	
	export MAC_Output(rset, rset_name=#TEXT('')) := MACRO
		#IF(UPS_Services.Debug.debug_flag)
			#UNIQUENAME(rsn)
			%rsn% := if(rset_name <> '', rset_name, #TEXT(rset));
			OUTPUT(rset, NAMED(%rsn%));
		#END
	ENDMACRO;
END;