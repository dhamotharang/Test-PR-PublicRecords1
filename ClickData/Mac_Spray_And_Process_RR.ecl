export Mac_Spray_And_Process_RR(srcIP,inpath, dstIP, outpath, appends = 'false') := macro
	
	#uniquename(insize) 
	%insize% := sizeof(clickdata.Layout_ClickData_In_RR);

	#uniquename(today)
	%today% := ut.GetDate;
	
	#uniquename(pre_spray)
	#uniquename(spray)
	#uniquename(build_super)
	%pre_spray% := fileservices.clearsuperfile('~thor_data400::in::clickdata_RR');
	%spray% := FileServices.SprayVariable(srcIP,inpath, %insize%, ',','\\n,\\r\\n','\'','thor400_92','~thor_data400::in::clickdata_RR_' + %today% ,-1,,,true,true);
	%build_super% := sequential(
                 FileServices.StartSuperFileTransaction(),
			  FileServices.ClearSuperFile('~thor_data400::in::clickdata_RR'),
                 FileServices.AddSuperFile('~thor_data400::in::clickdata_RR', 
                                           '~thor_data400::in::clickdata_RR_' + %today%), 
			  FileServices.FinishSuperFileTransaction());
                
	#uniquename(df)
	%df% := clickdata.proc_ClickData_RR(appends);
	
	#uniquename(despray)
	%despray% := fileservices.despray('~thor_data400::base::clickdata_RR',dstIP,outpath);
	
	#uniquename(post_proc)
	%post_proc% := sequential(
					FileServices.StartSuperFileTransaction(),
					FileServices.addsuperfile('~thor_data400::in::clickdata_RR_delete','~thor_data400::in::clickdata_father',,true),
					fileservices.clearsuperfile('~thor_data400::in::clickdata_RR_father'),
					fileservices.addsuperfile('~thor_data400::in::clickdata_RR_father','~thor_data400::in::clickdata_RR',,true),
					fileservices.clearsuperfile('~thor_data400::in::clickdata_RR'),
					fileservices.clearsuperfile('~thor_data400::in::clickdata_RR_delete',true),
					FileServices.FinishSuperFileTransaction());
	
	#uniquename(pre_seq)
	%pre_seq% := sequential(%pre_spray%, %spray%, %build_super%);
	
	#uniquename(my_out)
	%my_out% := output('Spraying Base File') : success(%pre_seq%);
	sequential(%my_out%, %df%, %post_proc%, %despray% );

endmacro;
