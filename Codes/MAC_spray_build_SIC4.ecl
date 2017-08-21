import Codes,lib_fileservices;

export MAC_spray_build_SIC4 (filedate
                            ,filepath
                            ,filename
							,group_name ='\'thor_dell400\'') := macro

#uniquename(spray_main);
#uniquename(super_main);
#uniquename(sourceCsvSeparator);
#uniquename(sourceCsvTeminator);
#uniquename(Layout_In_File);
#uniquename(outfile);
#uniquename(ds);
#uniquename(trfProject);
#uniquename(temp_delete);
#uniquename(do_super);

#workunit('name','SIC4 ' + filedate + ' Spray and Build Key ');

%sourceCsvSeparator% := '\\t';
%sourceCsvTeminator% := '\\n,\\r\\n';
// %cluster_name%       := '~thor_data400::';

%spray_main% := FileServices.SprayVariable('10.150.12.240'
                                          ,filepath + '/' + filename
										  ,84
										  ,%sourceCsvSeparator%
										  ,%sourceCsvTeminator%
										  ,
										  ,group_name
										  ,'~thor_data400::in::SIC4::'+filedate+'::temp_data'
										  ,
										  ,
										  ,
										  ,true
										  ,true
										  ,false);   										  

%Layout_In_File% := record, maxlength(84)
	Codes.Layout_SIC4_Codes;
end;

%Layout_In_File% %trfProject%(%Layout_In_File% l) := transform
	self := l;
end;

%outfile% := project(dataset('~thor_data400::in::SIC4::'+filedate+'::temp_data'
                            ,%Layout_In_File%
							,csv(heading(1)
							    ,separator('\t')
							    ,terminator(['\r\n','\r','\n'])
								,maxlength(84)
								)
							)
					,%trfProject%(left));

%ds% := output(%outfile%,,'~thor_data400::in::SIC4::'+filedate+'::Codes_Lookup',overwrite);

%temp_delete% := if (FileServices.FileExists(       '~thor_data400::base::SIC4::'+filedate+'::temp_data')
                    ,FileServices.DeleteLogicalFile('~thor_data400::base::SIC4::'+filedate+'::temp_data'));

%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  '~thor_data400::base::SIC4::Codes_Lookup::Delete',
				                            '~thor_data400::base::SIC4::Codes_Lookup::Grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::base::SIC4::Codes_Lookup::Grandfather'),
				FileServices.AddSuperFile(  '~thor_data400::base::SIC4::Codes_Lookup::Grandfather',
				                            '~thor_data400::base::SIC4::Codes_Lookup::Father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::SIC4::Codes_Lookup::Father'),
				FileServices.AddSuperFile(  '~thor_data400::base::SIC4::Codes_Lookup::Father', 
				                            '~thor_data400::base::SIC4::Codes_Lookup',, true),
				FileServices.ClearSuperFile('~thor_data400::base::SIC4::Codes_Lookup'),
				FileServices.AddSuperFile(  '~thor_data400::base::SIC4::Codes_Lookup', 
    				                        '~thor_data400::in::SIC4::'+filedate+'::Codes_Lookup'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::SIC4::Codes_Lookup::Delete',true));

%do_super%  := sequential(%spray_main%
                           ,%ds%
						   ,%super_main%
						   ,%temp_delete%
						   );

#uniquename(bk_SIC4);
#uniquename(mv2blt_SIC4);
#uniquename(mv2qa_SIC4);
#uniquename(emailN);
#uniquename(build_keys);

/* Build the DID key */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Codes.Key_SIC4
										  ,'~thor_data400::key::SIC4::Codes_Lookup'
										  ,'~thor_data400::key::SIC4::' + filedate + '::Codes_Lookup'
										  ,%bk_SIC4%
										  ,'true');
/* Move Keys to Built */
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::SIC4::Codes_Lookup'
                                     ,'~thor_data400::key::SIC4::' + filedate + '::Codes_Lookup'
									 ,%mv2blt_SIC4%);
/* Move Keys to QA */
ut.mac_sk_move('~thor_data400::key::SIC4::Codes_Lookup'
              ,'Q'
			  ,%mv2qa_SIC4%);

%emailN% := fileservices.sendemail('RoxieBuilds@seisint.com ; ehamel@seisint.com ',
								'SIC4: BUILD Key SUCCESS '+ filedate ,
								'keys: thor_data400::key::SIC4::Codes_Lookup_QA(thor_data400::key::SIC4::'+ filedate +'::Codes_Lookup)\n');

%build_keys% := sequential(%bk_SIC4%
					       ,%mv2blt_SIC4%
					       ,%mv2qa_SIC4%
						   ,%emailN%);

sequential(%do_super%
           ,%build_keys%);

endmacro;
