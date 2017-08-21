export email := DATASET([{'category', 'label', 0, 'email'},
						 {'vertex', 'border', 0, 0xffffff},
						 {'vertex', 'fill', 0, 0x000000},
						 {'vertex', 'execute', 0, 'gordon.email_execute_%cat%(\'%id%\', result);output(result);'}
						], graph_meta_record);