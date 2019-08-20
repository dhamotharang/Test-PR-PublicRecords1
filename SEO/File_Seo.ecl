EXPORT File_Seo := DATASET(
			'~thor::seo',
			$.Layout_Seo,
			CSV(SEPARATOR(',')
					, TERMINATOR('\r\n')
					, HEADING(1,SINGLE)
					,QUOTE('"')
					)
		);