IMPORT STD, UPI_DataBuild__dev;

EXPORT Functions := MODULE
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// SPRAY FILE FROM BATCH
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	EXPORT UPI_Spray(STRING Batch_JobID, STRING gcid, string filedate, STRING Batch_IP, STRING Batch_Source, STRING Batch_Cluster, STRING Batch_FileType) := FUNCTION
		Batch_FileName := MAP(STD.Str.ToUpperCase(Batch_FileType) = 'T' => 'from_batch',
																								'unknown_in');
																								
		UPI_Spray := STD.File.SprayVariable(
																	Batch_IP,			//varstring sourceIP
																	Batch_Source, //varstring sourcePath	
																	,	//integer4 sourceMaxRecordSize=8192
																	'|',	//varstring sourceCsvSeparate='\\,'
																	,	//varstring sourceCsvTerminate='\\n,\\r\\n'
																	,	//varstring sourceCsvQuote='"'
																	Batch_Cluster, //varstring destinationGroup	
																	'~ushc::crk::'+Batch_FileName+'::'+gcid+'::'+ Batch_JobID + '::' +filedate, 	// varstring destinationlogicalname
																	-1,	//integer4 timeOut=-1	
																	,	//varstring espServerIpPort=GETENV('ws_fs_server')
																	,	//integer4 maxConnections=-1
																	TRUE, //boolean allowoverwrite
																	,	//boolean replicate=false
																	TRUE	//boolean compress
																	//, varstring sourceCsvEscape=''
																	//, boolean failIfNoSourceFile=false
																	//, boolean recordStructurePresent=false
																	//, boolean quotedTerminator=true
																	//, varstring encoding='ascii'
																	//, boolean recordStr
																	//  integer4 expireDays=-1
																	);		
																	
		RETURN NOTHOR(UPI_Spray);

	END;
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//  UPI Transform Flat File to Pipe Delimited
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	EXPORT PipeFile(string pVersion, boolean pUseProd, string gcid, string pHistMode, string Batch_JobID) := FUNCTION
	
			flat_file := sort(UPI_DataBuild__dev.Files_V2(pVersion,pUseProd,gcid,pHistMode).tobatch_file.new, (integer)batch_seq_number);
			
			pipe_delimited :=	output(flat_file,,'~ushc::crk::'+ trim(gcid, all) +'_'+ trim(Batch_JobID, all) + '_out_tobatch',CSV(HEADING(SINGLE),SEPARATOR('|'),TERMINATOR('\r\n'),QUOTE('"')),OVERWRITE);
		
		RETURN pipe_delimited;
	END;
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//  UPI Transform Flat Stats File to Pipe Delimited
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	EXPORT PipeMetricsFile(string pVersion, boolean pUseProd, string gcid, string pHistMode, string Batch_JobID) := FUNCTION
	
			flat_file := UPI_DataBuild__dev.Files_V2(pVersion,pUseProd,gcid,pHistMode).tobatch_metrics_file.new;
			
			pipe_delimited :=	output(flat_file,,'~ushc::crk::' + trim(gcid, all) + '_' + trim(Batch_JobID, all) + '_metrics',CSV(HEADING(SINGLE),SEPARATOR('|'),TERMINATOR('\r\n'),QUOTE('\"')),OVERWRITE);
		
		RETURN pipe_delimited;
	END;
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//  UPI Transform Flat History File to Pipe Delimited
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	EXPORT PipeHistoryFile(string pVersion, boolean pUseProd, string gcid, string pHistMode, string Batch_JobID) := FUNCTION
	
			flat_file := dataset('~ushc::crk::healthcarenomatchheader::base::' + trim(gcid, all) + '::' + pVersion + '::customerrecordkey', UPI_DataBuild__dev.Layouts_V2.temp_header, thor);
	
			pipe_delimited :=	output(flat_file,,'~ushc::crk::' + trim(gcid, all) + '_' + trim(Batch_JobID, all) + '_linkhistory', CSV(HEADING(SINGLE),SEPARATOR('|'),TERMINATOR('\r\n'),QUOTE('\"')),OVERWRITE);
		
		RETURN pipe_delimited;
	END;
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//  UPI Transform Flat Aggregate Report File to Pipe Delimited
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	EXPORT PipeAggregateFile(string pVersion, boolean pUseProd, string gcid, string pHistMode, string Batch_JobID) := FUNCTION
	
			flat_file := UPI_DataBuild__dev.Files_V2(pVersion,pUseProd,gcid,pHistMode).aggregate_report_file.new;
			
			pipe_delimited :=	output(flat_file,,'~ushc::crk::' + trim(gcid, all) + '_' + trim(Batch_JobID, all) + '_aggregate',CSV(HEADING(SINGLE),SEPARATOR('|'),TERMINATOR('\r\n'),QUOTE('\"')),OVERWRITE);
		
		RETURN pipe_delimited;
	END;
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// DESPRAY BACK TO BATCH
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	EXPORT UPI_DeSpray(STRING Batch_JobID, string gcid, STRING Batch_IP, STRING Batch_Destination, STRING Batch_FileType) := FUNCTION
		Batch_FileName := MAP(STD.Str.ToUpperCase(Batch_FileType) = 'F' => '~ushc::crk::' + gcid + '_' + Batch_JobID + '_out_tobatch',
																								'unknown_out');

		UPI_DeSpray := STD.File.DeSpray(
																			Batch_FileName, //varstring logicalName
																			// gcid + '_' + Batch_JobID + '_' + STD.date.today() + '_metrics',//varstring logicalName

																			Batch_IP, //varstring destinationIP
																			Batch_Destination, //varstring destinationPath
																			-1, //integer4 timeOut
																			, //varstring espServerIpPort=GETENV('ws_fs_server')
																			, //integer4 masConnections
																			true); //boolean allowoverwrite
																			
		RETURN NOTHOR(UPI_DeSpray);
	END;
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// DESPRAY STATS TO BATCH
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		EXPORT UPI_Metrics_DeSpray(STRING Batch_JobID, string gcid, STRING Batch_IP, STRING Batch_Destination, STRING Batch_FileType) := FUNCTION
		Batch_FileName := MAP(STD.Str.ToUpperCase(Batch_FileType) = 'F' => '~ushc::crk::' + trim(gcid, all) + '_'+ trim(Batch_JobID, all) + '_metrics',
																								'unknown_out');

		UPI_Metrics_DeSpray := STD.File.DeSpray(
																			// '~ushc::crk::'+Batch_FileName+'::'+gcid+'::'+ Batch_JobID + '::out_tobatch_metrics', //varstring logicalName
																			Batch_FileName,//varstring logicalName
																			Batch_IP, //varstring destinationIP
																			Batch_Destination, //varstring destinationPath
																			-1, //integer4 timeOut
																			, //varstring espServerIpPort=GETENV('ws_fs_server')
																			, //integer4 masConnections
																			true); //boolean allowoverwrite
																			
		RETURN NOTHOR(UPI_Metrics_DeSpray);
	END; 
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// DESPRAY AGGREGATE TO BATCH
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		EXPORT UPI_Aggregate_DeSpray(STRING Batch_JobID, string gcid, STRING Batch_IP, STRING Batch_Destination, STRING Batch_FileType) := FUNCTION
		Batch_FileName := MAP(STD.Str.ToUpperCase(Batch_FileType) = 'F' => '~ushc::crk::' + trim(gcid, all) + '_'+ trim(Batch_JobID, all) + '_aggregate',
																								'unknown_out');																						

		UPI_Aggregate_DeSpray := STD.File.DeSpray(
																			// '~ushc::crk::'+Batch_FileName+'::'+gcid+'::'+ Batch_JobID + '::out_tobatch_metrics', //varstring logicalName
																			Batch_FileName,//varstring logicalName
																			Batch_IP, //varstring destinationIP
																			Batch_Destination, //varstring destinationPath
																			-1, //integer4 timeOut
																			, //varstring espServerIpPort=GETENV('ws_fs_server')
																			, //integer4 masConnections
																			true); //boolean allowoverwrite
																			
		RETURN NOTHOR(UPI_Aggregate_DeSpray);
	END; 
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// DESPRAY LINKING HISTORY TO BATCH
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	EXPORT UPI_History_DeSpray(STRING Batch_JobID, string gcid, STRING Batch_IP, STRING Batch_Destination, STRING Batch_FileType) := FUNCTION
		Batch_FileName := MAP(STD.Str.ToUpperCase(Batch_FileType) = 'F' => '~ushc::crk::' + trim(gcid, all) + '_'+ trim(Batch_JobID, all) + '_linkhistory',
		
																								'unknown_out');																						

		UPI_History_DeSpray := STD.File.DeSpray(
																			Batch_FileName,//varstring logicalName
																			Batch_IP, //varstring destinationIP
																			Batch_Destination, //varstring destinationPath
																			-1, //integer4 timeOut
																			, //varstring espServerIpPort=GETENV('ws_fs_server')
																			, //integer4 masConnections
																			true); //boolean allowoverwrite
																			
		RETURN NOTHOR(UPI_History_DeSpray);
	END;
END;
