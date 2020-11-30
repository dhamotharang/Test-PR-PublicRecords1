import fcra,STD;
export Mac_Override_Spray_SFMove(sourceIP,filename,recordsize,datasetname,filedate
						,reexport='\'no\''
						,group_name='\'thor_200\''
						,filetype='\'txt\''
						,headtag='\'dataset\''
						,rowtag='\'row\''
						,converttoxml='false'
						,layouttouse) :=
macro

#uniquename(sprayfile)
#uniquename(super_main)
#uniquename(spraycsv)
	%sprayfile% := FileServices.SprayFixed(sourceIP,filename, recordsize,group_name,'~thor_data400::in::override::fcra::'+filedate+'::'+datasetname,-1,,,true);
	
	
	// after spraying header add datetime to each record
		#uniquename(new_rec)
		%new_rec% := record
			fcra.Layout_Override_Header_In;
			//string date_created := '';
		end;
		
		#uniquename(headerds)
		%headerds% := dataset('~thor_data400::in::override::fcra::'+filedate+'::'+datasetname+'::withoutdatetime',fcra.Layout_Override_Header_In - [date_created],csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
		
		#uniquename(get_create_date)
		%new_rec% %get_create_date%(fcra.Layout_Override_Header_In - [date_created] l) := transform
			self.date_created :=  ut.GetDate + ut.getTime();
			self := l;
		end;
		
		#uniquename(sprayedfile)
		%sprayedfile% := project(%headerds%, %get_create_date%(left));

  	%spraycsv% := if (datasetname = 'header',
													sequential(
													FileServices.SprayVariable(sourceIP,filename,,'\\t','\\n','\"',group_name,'~thor_data400::in::override::fcra::'+filedate+'::'+datasetname+'::withoutdatetime',-1,,,true),
													output(%sprayedfile%,,'~thor_data400::in::override::fcra::'+filedate+'::'+datasetname,csv(separator('\t'),quote('\"'),terminator('\r\n')),overwrite)
													),
													FileServices.SprayVariable(sourceIP,filename,,'\\t','\\n','\"',group_name,'~thor_data400::in::override::fcra::'+filedate+'::'+datasetname+if (converttoxml,'_var',''),-1,,,true));
		#uniquename(sprayxml)
		%sprayxml% := STD.File.SprayXML(sourceIP,filename,,rowtag,,group_name,'~thor_data400::in::override::fcra::'+filedate+'::'+datasetname,-1,,,true,true);
			
		#uniquename(convertvartoxml)
		%convertvartoxml% := sequential(
																if ( ~STD.File.superfileexists('~thor_data400::base::override::fcra::qa::'+datasetname+'_var')
																		,STD.File.createsuperfile('~thor_data400::base::override::fcra::qa::'+datasetname+'_var')
																		)
																,STD.File.RemoveOwnedSubFiles('~thor_data400::base::override::fcra::qa::'+datasetname+'_var',true)
																,%spraycsv%
																,STD.File.AddSuperFile('~thor_data400::base::override::fcra::qa::'+datasetname+'_var'
																											,'~thor_data400::in::override::fcra::'+filedate+'::'+datasetname+'_var')
																,Overrides.ConvertLayouts().layouttouse(
																								'~thor_data400::in::override::fcra::'+filedate+'::'+datasetname+'_var'
																								,'~thor_data400::in::override::fcra::'+filedate+'::'+datasetname
																								,headtag
																								,rowtag)
																);
	
	%super_main% := 
				//sequential(FileServices.StartSuperFileTransaction(),
				//FileServices.AddSuperFile('~thor_data400::base::override::fcra::delete::'+datasetname,'~thor_data400::base::override::fcra::father::'+datasetname,, true),
				//FileServices.ClearSuperFile('~thor_data400::base::override::fcra::father::'+datasetname),
				//FileServices.AddSuperFile('~thor_data400::base::override::fcra::father::'+datasetname, '~thor_data400::base::override::fcra::qa::'+datasetname,, true),
				//FileServices.ClearSuperFile('~thor_data400::base::override::fcra::qa::'+datasetname),
				sequential(
				FileServices.AddSuperFile('~thor_data400::base::override::fcra::qa::'+datasetname, '~thor_data400::in::override::fcra::'+filedate+'::'+datasetname),
				FileServices.AddSuperFile('~thor_data400::base::override::fcra::daily::qa::'+datasetname, '~thor_data400::in::override::fcra::'+filedate+'::'+datasetname),
				fileservices.addsuperfile('~thor_data400::base::override::fcra::qa::lastprocessed', '~thor_data400::in::override::fcra::'+filedate+'::'+datasetname)
				);
				//FileServices.FinishSuperFileTransaction(),
				//FileServices.ClearSuperFile('~thor_data400::base::override::fcra::delete::'+datasetname,true));

sequential(
				if ( ~fileservices.superfileexists('~thor_data400::base::override::fcra::qa::'+datasetname),fileservices.createsuperfile('~thor_data400::base::override::fcra::qa::'+datasetname)),
				if ( ~fileservices.superfileexists('~thor_data400::base::override::fcra::daily::qa::'+datasetname),fileservices.createsuperfile('~thor_data400::base::override::fcra::daily::qa::'+datasetname)),
				fileservices.removesuperfile('~thor_data400::base::override::fcra::qa::'+datasetname, '~thor_data400::in::override::fcra::'+filedate+'::'+datasetname),
				fileservices.clearsuperfile('~thor_data400::base::override::fcra::daily::qa::'+datasetname),
				fileservices.removesuperfile('~thor_data400::base::override::fcra::qa::lastprocessed', '~thor_data400::in::override::fcra::'+filedate+'::'+datasetname),
				if(recordsize = 1
						,if(filetype = 'xml'
								,%sprayxml%
								,if (converttoxml
												,%convertvartoxml%
												,%spraycsv%)
								)
						,%sprayfile%)
				,%super_main%
				)
			
endmacro;