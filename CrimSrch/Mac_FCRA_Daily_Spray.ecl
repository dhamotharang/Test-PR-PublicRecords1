export Mac_FCRA_Daily_Spray(filename,filedate,gname) :=
macro

#workunit('name','FCRA Daily Spray '+filedate);

FileServices.SprayFixed(_Control.IPAddress.edata12,'/thor_back5/fcra_landing/build/fcra_flag.d00', 
						525, gname,'~thor_data400::in::'+filename,-1,,,true,true);
	
endmacro;