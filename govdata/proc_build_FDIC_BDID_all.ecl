import ut, _control, Orbit3;

export proc_build_FDIC_BDID_all(string filedate) := function

//Spray source file
sprayfile := FileServices.SprayVariable(if ( _Control.ThisEnvironment.Name <> 'Prod_Thor' ,  _Control.IPAddress.bctlpedata12, _Control.IPAddress.bctlpedata11 )
									,'/data/prod_data_build_10/production_data/business_headers/fdic/in/'+filedate+'/'+'INSTITUTIONS2.CSV'
									//,1226
									,,,,
									, 'thor400_44',  // running on prod
									//,'thor400_88',   // running on dataland
									'~thor_data400::in::govdata::fdic_'+filedate+'.csv',-1,,,true,false,true);
									
//Convert csv file to fixed length

csvfile := dataset('~thor_data400::in::govdata::fdic_'+filedate+'.csv',Layouts_FDIC.Sprayed_CSV,CSV(heading(1),separator(','),Terminator(['\n','\r\n']),Quote('"')));

csv2fixed := project( csvfile,transform(Layouts_FDIC.Sprayed,self := left));

//Superfile Transactions
superfile_transac := sequential( output(csv2fixed,,'~thor_data400::in::govdata::fdic_'+filedate,compressed,overwrite),
                  fileservices.addsuperfile('~thor_data400::in::govdata::fdic_delete','~thor_data400::in::govdata::fdic_grandfather',,true),
								fileservices.clearsuperfile('~thor_data400::in::govdata::fdic_grandfather'),
								fileservices.addsuperfile('~thor_data400::in::govdata::fdic_grandfather','~thor_data400::in::govdata::fdic_father',,true),
								fileservices.clearsuperfile('~thor_data400::in::govdata::fdic_father'),
								fileservices.addsuperfile('~thor_data400::in::govdata::fdic_father','~thor_data400::in::govdata::fdic',,true),
								fileservices.clearsuperfile('~thor_data400::in::govdata::fdic'),
								fileservices.addsuperfile('~thor_data400::in::govdata::fdic','~thor_data400::in::govdata::fdic_'+filedate),
								fileservices.clearsuperfile('~thor_data400::in::govdata::fdic_delete',true)																	
								);
//Build BDID
make_BDID := govdata.make_FDIC_BDID(filedate);

//ORBIT item update
Orbit_Update := Orbit3.proc_Orbit3_CreateBuild_AddItem('FDIC',(filedate),'N');


retval := sequential(sprayfile
					  ,superfile_transac
					  ,make_BDID
					  ,govdata.Strata_Population_Stats.FDIC_pop
						,Orbit_Update); 


return retval;
end;