EXPORT get_ds_of_Layout(La_Layout) := FUNCTIONMACRO
	LOADXML('<xml/>');
	#EXPORTXML(La_XML,La_Layout);

	LOCAL out_rec := RECORD
		UNSIGNED rec_no;
		string field_type;
		string field_size;
		string field_name;
	END;
	
	#declare(cn);
	#set(cn,0);
	out_rec_ds := DATASET([
	#FOR(La_XML)
		#FOR(Field)
			#IF(%cn% > 0) , #END
			#set(cn, %cn%+1)
			{%cn%, %'{@type}'%, %'{@size}'%, %'{@name}'%}
		#END
	#END
	], out_rec);
	return out_rec_ds;
ENDMACRO;
