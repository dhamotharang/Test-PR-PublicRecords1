import _control;
// export fSprayFiles(string version) := function
export fSprayFilesCustomer(string filename,string filesrc) := function
groupname := 'thor400_44';
thorfilename := '~thor_data400::in::phonesFeedback_fcra::'+filesrc+'::'+thorlib.WUID()+'::customer';
result :=
sequential(        
         FileServices.SprayFixed(_control.IPAddress.bctlpedata10,filename,457,groupname,thorfilename,-1,,,true,true,true),
		 FileServices.StartSuperFileTransaction(),		 
		 FileServices.addsuperfile('~thor_data400::in::phonesFeedback_fcra::sprayed::customer',
								   thorfilename),								 
		 FileServices.FinishSuperFileTransaction(),
		   );
return result;
end;		   
		  
