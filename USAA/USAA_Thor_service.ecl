
IMPORT USAA;

/* Command:
      USAA.USAA_Thor_Service('10.121.147.206','/batch01_dv01/bps/b1032035/','inputdata.dat')
*/

EXPORT USAA_Thor_service(SourceServerIP,filepath,filename) := MACRO

  #WORKUNIT('Name','USAA_zip_affinity_'+filename)
	#UNIQUENAME(batch_sourceIP)
	#UNIQUENAME(source_path)
	#UNIQUENAME(group_name)
	#UNIQUENAME(out_file)
	#UNIQUENAME(thor_USAA_IN)
	#UNIQUENAME(thor_USAA_OUT)
	#UNIQUENAME(in_filename)
	#UNIQUENAME(spray_main)
	#UNIQUENAME(infile_layout)
	#UNIQUENAME(USAA_in)
	#UNIQUENAME(USAA_res)
	#UNIQUENAME(EMPTY_USAA_res)
	#UNIQUENAME(result)
	#UNIQUENAME(output_action)
	#UNIQUENAME(despray_main)	
	
	%batch_sourceIP% := SourceServerIP;
	%source_path%    := filepath;       
	%group_name%     := 'production_watch_thor';
	
	%out_file%       := %source_path% + 'bpsbatch.txt';
	%thor_USAA_IN%   := %group_name% + '::in::usaa::' + filename;
	%thor_USAA_OUT%  := %group_name% + '::out::usaa::' + filename+'_'+Thorlib.WUID();
	%in_filename%    := %source_path% + filename;
	
	%spray_main%     := FileServices.SprayVariable(
													%batch_sourceIP%, %in_filename%
													, 4096,,,,%group_name%, %thor_USAA_IN%,-1,,,TRUE,TRUE);

	%infile_layout%  := USAA.layout_infile;

	%USAA_in%        := DATASET(%thor_USAA_IN%, %infile_layout%, CSV(TERMINATOR('\r\n'), QUOTE('"'), SEPARATOR(',')))[1];

  %USAA_res%       := USAA.fn_get_market_slice( %USAA_in% );  // ***** Get the records *****
	%EMPTY_USAA_res% := DATASET([{'NO RESULTS FOR THE GIVEN INPUT'}],USAA.layout_zip_affinity_out);
	%result%         := IF(EXISTS(%USAA_res%),%USAA_res%,%EMPTY_USAA_res%);
	
	%output_action%  := OUTPUT(%result%, , %thor_USAA_OUT%, CSV( TERMINATOR('\r\n'),QUOTE('"'), SEPARATOR(',') ), OVERWRITE);
	
	%despray_main%   := fileservices.Despray(%thor_USAA_OUT%, %batch_sourceIP%, %out_file%,,,,true);

	OUTPUT(%thor_USAA_IN%, NAMED('thor_USAA_IN'), OVERWRITE);
	OUTPUT(%USAA_in%, NAMED('USAA_in'), OVERWRITE);

	SEQUENTIAL(	%spray_main%, %output_action% , %despray_main% ) 
	         :  FAILURE(FileServices.SendEmail( 'steven.barnes@lexisnexis.com'
	                                           ,' USAA affinity zipcode job has failed utterly. '
													                   ,'Executed Workunit on THOR: '+Thorlib.WUID() )
											);
ENDMACRO;
