export Mac_Spray_And_Process(srcIP,inpath, dstIP, outpath, appends = 'false') := macro
	
	#uniquename(insize) 
	%insize% := sizeof(clickdata.Layout_ClickData_In);

	#uniquename(today)
	%today% := thorlib.wuid();
	
	#uniquename(best_phone)
	%best_phone% := false; // disabling phone appends
	
	#uniquename(pre_spray)
	#uniquename(spray)
	#uniquename(build_super)
	%pre_spray% := fileservices.clearSuperFile('~thor_data400::in::clickdata');
	%spray% := FileServices.SprayVariable(srcIP,inpath, %insize%, ',','\\n,\\r\\n','\'','thor_dell400','~thor_data400::in::clickdata_' + %today% ,-1,,,true,true);
	%build_super% := sequential(
                 FileServices.StartSuperFileTransaction(),
			  FileServices.ClearSuperFile('~thor_data400::in::clickdata'),
                 FileServices.AddSuperFile('~thor_data400::in::clickdata', 
                                           '~thor_data400::in::clickdata_' + %today%), 
			  FileServices.FinishSuperFileTransaction());
                
	#uniquename(df)
	%df% := clickdata.proc_ClickData(appends, %bestphone%);
	
	#uniquename(despray)
	%despray% := fileservices.despray('~thor_data400::base::clickdata',dstIP,outpath);
	
	#uniquename(post_proc)
	%post_proc% := sequential(
					FileServices.StartSuperFileTransaction(),
					FileServices.addsuperfile('~thor_data400::in::clickdata_delete','~thor_data400::in::clickdata_father',,true),
					fileservices.clearsuperfile('~thor_data400::in::clickdata_father'),
					fileservices.addsuperfile('~thor_data400::in::clickdata_father','~thor_data400::in::clickdata',,true),
					fileservices.clearsuperfile('~thor_data400::in::clickdata'),
					fileservices.clearsuperfile('~thor_data400::in::clickdata_delete',true),
					FileServices.FinishSuperFileTransaction());
	
	#uniquename(pre_seq)
	%pre_seq% := sequential(%pre_spray%, %spray%, %build_super%);
	
	#uniquename(my_out)
	%my_out% := output('Spraying Base File') : success(%pre_seq%);
	sequential(%my_out%, %df%, %post_proc%, %despray% );

endmacro;
