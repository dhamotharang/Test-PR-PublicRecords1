import _control;
export fSprayFiles(string sourcepath) := function
 groupname := 'thor400_30';
// groupname := 'thor400_92';
// groupname := 'thor400_88';
result :=
sequential(        
         FileServices.SprayXML(_control.IPAddress.edata12,sourcepath,10000,'Record',,groupname,'~thor_data400::in::GSA::'+thorlib.WUID()+'::report_xml'),
		 FileServices.StartSuperFileTransaction(),
		 FileServices.ClearSuperFile('~thor_data400::in::GSA::report_xml'),
		 FileServices.addsuperfile('~thor_data400::in::GSA::report_xml',
								   '~thor_data400::in::GSA::'+thorlib.WUID()+'::report_xml'),								 
		 FileServices.FinishSuperFileTransaction()
		   );
return result;
end;		   

