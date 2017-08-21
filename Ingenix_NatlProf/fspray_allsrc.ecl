import lib_fileservices,Ingenix_NatlProf,_control,Data_Services;
EXPORT fspray_allsrc(string filedate) := function
ds := dataset(Data_Services.foreign_prod+'thor_data400::out::ingenix_spray_lookup',{string20 srctype,string150 filename},thor) ;

serverip := if ( _Control.ThisEnvironment.Name = 'Prod_Thor' ,_Control.IPAddress.bctlpedata10,_Control.IPAddress.bctlpedata12 );

rec := record
string srctype;
string unixfilename;
string thorfilename;
string superfilename;
string thor_filename;
end;

rec tr(ds le) := transform

self.thorfilename := if( le.filename = 'GroupPractice.txt','GroupAffiliation',trim(regexreplace('.txt',le.filename,'')));
self.unixfilename := le.filename;
self.superfilename := Ingenix_NatlProf.Get_SourceFileName_In(le.srctype,self.thorfilename);
self.thor_filename := self.superfilename + '_' + filedate;
self := le;
end;


tempds := project(ds,tr(left));
	
	outds := output(tempds,named('copyfiles'),EXTEND);//,'~thor_data400::out::'+dsname+'::alpha::copy',overwrite);
	ds1 := dataset(workunit('copyfiles'),rec);
  copyfiles := nothor(apply(ds1,Sequential(
								 
									
									           if ( fileservices.fileexists(superfilename) = false,  fileservices.CreateSuperFile(superfilename)),
                              if( lib_fileservices.fileservices.fileexists(thor_filename) and FileServices.FindSuperFileSubName(superfilename,thor_filename) <> 0,output('Skip spray part '+srctype+ ' '+thorfilename), 
															Sequential(
                                             FileServices.SprayVariable(serverip,'/data/data_build_1/Ingenix_NatlProf/sources/'+trim(srctype,left,right)+'/'+filedate+'/'+trim(unixfilename,left,right), , '|', ,'~~~', 'thor400_20', 
				                                      trim(superfilename) + '_' + filedate ,-1,,,true,false,true),
																							lib_fileservices.FileServices.ClearSuperFile(superfilename),
                                  lib_fileservices.FileServices.AddSuperFile(superfilename, thor_filename),
																	Ingenix_NatlProf.Send_Spray_Completion_Email(thorfilename, thor_filename, 
						superfilename, srctype,  filedate)
						                           )
																	)
															)
															
						)	
			);
			
return Sequential(outds,copyfiles); 

end;