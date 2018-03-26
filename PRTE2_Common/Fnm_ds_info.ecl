EXPORT Fnm_ds_info(m_ds, m_Layout, ds_name='', file_name='') := FUNCTIONMACRO
	LOADXML('<xml/>');
	#EXPORTXML(m_Layout_XML,m_Layout);
	LOCAL out_rec := RECORD
		string tested_ds;
		string field_name;
		string field_type;
		string field_size;
		string file;
		string test_name;
		string test_description;
		unsigned test_count;
		unsigned all_records;
		real   test_percent;
	END;
	LOCAL record_count := count(m_ds);
	return dataset([
	 {ds_name,'','','',file_name,'RecordSize','Size or Record', sizeof(m_ds), record_count, -1.0}
	,{ds_name,'','','',file_name,'RecordCount','Count of Records', record_count, record_count, -1.0}
	#FOR(m_Layout_XML)
		#FOR(Field)
			,{ds_name,  %'{@name}'%,  %'{@type}'%,  %'{@size}'%,file_name,
			#IF(%'{@type}'% = 'boolean')
				'is_empty',  %'{@name}'% + ' = TRUE',  count(m_ds(%{@name}% = TRUE)), record_count, IF(record_count=0, -1.0, (count(m_ds(%{@name}% = TRUE)) * 100)/record_count)
			#ELSEIF(%'{@type}'% = 'unsigned')
				'is_empty',  %'{@name}'% + ' = 0',     count(m_ds(%{@name}% = 0)), record_count,    IF(record_count=0, -1.0, (count(m_ds(%{@name}% = 0)) * 100)/record_count)
			#ELSEIF(%'{@type}'% = 'integer')
				'is_empty',  %'{@name}'% + ' = 0',     count(m_ds(%{@name}% = 0)), record_count,    IF(record_count=0, -1.0, (count(m_ds(%{@name}% = 0)) * 100)/record_count)
			#ELSEIF(%'{@type}'% = 'string')
				'is_empty',  %'{@name}'% + ' = \'\'',  count(m_ds(%{@name}% = '')), record_count,   IF(record_count=0, -1.0, (count(m_ds(%{@name}% = '')) * 100)/record_count)
			#ELSE
				'','','', record_count, -1.0
			#END
			}
		#END
	#END
	],out_rec);
ENDMACRO;
