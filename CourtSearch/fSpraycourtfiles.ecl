import _control;
// export fSprayFiles(string version) := function
export fSpraycourtfiles(string fileName,string filedate) := function
groupname := 'thor400_88_dev';
result :=
sequential(

		 FileServices.SprayVariable(_control.IPAddress.edata12,fileName,8192,,,,groupname,'~thor_data400::in::courtsearch::'+filedate+'',-1,,,true,true),
		 FileServices.StartSuperFileTransaction(),
		 FileServices.ClearSuperFile('~thor_data400::in::courtsearch',false),
		 FileServices.addsuperfile('~thor_data400::in::courtsearch',
								   '~thor_data400::in::courtsearch::'+filedate+''),				 
		 FileServices.FinishSuperFileTransaction()
		   );
return result;
end;		   