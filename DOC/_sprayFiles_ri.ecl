import VersionControl;

filesToSpray := DATASET([{   
// --       SourceIP				-- Remote Server's IP address
            'edata12'
//--        SourceDirectory			-- Absolute path of directory on Remote Server where files are located
            ,'/data_999/doc/ri/' 
// --		directory_filter		-- Regular expression filter for files to be sprayed, default = '*'
            ,'*_prepended.txt' 
// --		record_size				-- record length of files to be sprayed(for fixed length files only)
     	    ,0
// --		Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
// 	        ,'~thor_data400::temp::lbentley::wither::@version@::update'  
            ,'~thor_data400::in::doc::ri::@version@'
// --		dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
	        ,[{'~thor_data400::in::doc::ri'}] 
// --		GroupName				-- Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
 	 	    ,'thor_dataland_linux' 
// --		FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
    	    ,''  
// --		date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
 	        ,'[0-9]{8}'  
// --		file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
            ,'VARIABLE'   
// --		sourceRowTagXML			-- XML Row tag.  Only used when file_type = 'XML'.  Default = ''
			,''
// --		sourceMaxRecordSize		-- Maximum record size for Variable or XML files.  Default = 8192;
			,1000
// --		sourceCsvSeparate		-- Field separator for variable length records only. Default = '\\,' (comma)
			,'|'
// -- 	    sourceCsvTerminate		-- Record separator for variable length records only.  Default = '\\n,\\r\\n'  (line feed or carriage return, line feed)
// --		sourceCsvQuote			-- Quoted Field delimiter for variable length records only.  Default = '"';	 (quote)
// --		compress				-- true = Compress, false = Don't compress.  Default = true

}],VersionControl.Layout_Sprays.Info);



export _sprayFiles_ri := VersionControl.fSprayInputFiles(FilesToSpray);
