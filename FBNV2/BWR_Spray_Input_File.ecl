import FBNV2,_control;

export BWR_Spray_Input_File (string filename,string filedate,string source) 
		:= function

				sourceip 		:= _control.IPAddress.edata10;
				
				superfilename 	:= FBNV2.Get_Update_SupperFilename(source); 						
				logicalfilename := FBNV2.Get_Update_SupperFilename(source)[1..length(trim(superfilename))-length(source)]+filedate+'::'+source;
				reclength 		:= Get_Infile_Record_Length(source);

				spray_file 		:= FileServices.SprayFixed(sourceip,filename, reclength,'thor_dataland_linux',logicalfilename,-1,,,true,true);
				add_super 		:= fileservices.addsuperfile(superfilename,logicalfilename);

				retval 			:= sequential(spray_file,add_super);
		 return retval;
		
end;
/*fbnv2.BWR_Spray_Input_File ('/data_build_4/fbn/sources/ca/san_diego/build/san_diego.d00','20060106','San_diego') 

fbnv2.MAC_Spray_Input_Files('/data_build_4/fbn/sources/fl/build/Event.d00',
                             'in::fbnv2::20061205::FL::filing','Event','thor_dataland_linux');*/