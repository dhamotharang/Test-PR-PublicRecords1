import lib_fileservices;
export Layout_Sprays :=
module
	export ChildNames :=
	record, maxlength(100000)
	
		string		RemoteFilename												;
		unsigned8	remotesize										:= 0		;
		unsigned4	record_length									:= 0		;
		boolean		issizemultipleofrecordlength	:= false;
		string		ThorLogicalFilename										;
		boolean		fileexists														;
		boolean		ismemberofsuperfiles									;
		boolean		willspray															;
		
	end;
	export ChildSuperNames :=
	record, maxlength(100000)
	
		string								Name							;
		dataset(Layout_Names) dSuperfilecontents;
		
	end;
	export Info := 
	record, maxlength(100000)
		string									SourceIP															;
		string									SourceDirectory												;
		string									directory_filter				:= '*'				;
		unsigned4								record_size							:= 0					;
		string									Thor_filename_template								;
		dataset(Layout_Names)		dSuperfilenames												;
		string									fun_Groupname								;
		string									FileDate							:= ''						;
		string									date_regex						:= '[0-9]{8}'		;
		string									file_type							:= 'FIXED'			;  			// CAN BE 'VARIABLE', OR 'XML'
		string									sourceRowTagXML				:= ''						;
		integer4 								sourceMaxRecordSize		:= 8192					;
		string 									sourceCsvSeparate			:= '\\,'				;				// '\\,';
		string									sourceCsvTerminate		:= '\\n,\\r\\n'	;		// '\\n,\\r,\\n'
		string									sourceCsvQuote				:= '"'					;				// '\''
		boolean									compress							:= true					;
		boolean									shouldoverwrite				:= false				;
		boolean									ShouldSprayZeroByteFiles				:= false				;
		boolean									ShouldSprayMultipleFilesAs1			:= false				;
	end;
	
	export InfoOut :=
	record, maxlength(100000)
		string										SourceIP																			;
		string										SourceDirectory																;
		string										directory_filter				:= '*'								;
		unsigned4									record_size							:= 0									;
		string										Thor_filename_template												;
		dataset(ChildNames)				dFilesToSpray																	;
		dataset(ChildNames)				dMultAs1FilesToSpray													;
		dataset(ChildSuperNames)	dSuperfilenames																;
		string										fun_Groupname								:= '\'thor_dell400\''	;
		string										FileDate								:= ''									;
		string										date_regex							:= '[0-9]{8}'					;
		string										file_type								:= 'FIXED'						;  			// CAN BE 'VARIABLE', OR 'XML'
		string										sourceRowTagXML					:= ''									;
		integer4 									sourceMaxRecordSize			:= 8192								;
		string 										sourceCsvSeparate				:= '\\,'							;
		string										sourceCsvTerminate			:= '\\n,\\r\\n'				;
		string										sourceCsvQuote					:= '"'								;
		boolean										compress								:= true								;
		unsigned4									remotefilescount				:= 0									;
		unsigned8									remotefilessize					:= 0;
		unsigned4									superfilescount					:= 0									;
		string										spray_workunit					:= workunit						;
		boolean										ShouldSprayMultipleFilesAs1			:= false				;
	end;
	
	export NormForEmail :=
	record, maxlength(1000000)
		unsigned4					parent_unique_id									;
		unsigned4					child_unique_id										;
		string2						filetype													; // 'S' = superfile, 'L' = logical file
		string						emailine {maxlength(90000)} := ''	;
	end;
	export ReturnEmail :=
	record, maxlength(1000000)
		unsigned4				numFilesSprayed														;
		unsigned4				numFilesSkipped														;
		string					emailine 				{maxlength(90000)} := ''	;
	end;
end;
