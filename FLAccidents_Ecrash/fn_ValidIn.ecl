import VersionControl,_Control,ut,lib_fileservices, STD;


EXPORT fn_ValidIn (  boolean	pIsTesting	= false
	
) :=
       function
			 
  Incident_FileListing := FileServices.RemoteDirectory(Constants.LandingZone,
																						 Constants.ProcessPathForIncident , 
																						 '*');

d1 := Incident_FileListing ( size = 0);

if ( 	count(d1) <> 0 , Output(	d1 ,named('Incident_list_files_with_size_zero' )));

fn_Incident_chk ( string name,integer size ) := function

check_ala := regexreplace('[*]',regexreplace('[?]{3}',FLAccidents_Ecrash.Constants.IncidentFileMask,'ala'),'');


check_bct := regexreplace('[*]',regexreplace('[?]{3}',FLAccidents_Ecrash.Constants.IncidentFileMask,'bct'),'');



vIncident_chk := map  ( name[1..STD.Str.Find(name,'.',5)-1] not in [check_ala,check_bct]   => FAIL('FILE NAMING CONVENTION DONT MATCH') ,
                        size = 0 => FAIL('size is 0'), Output('Incident file '+name +'looks good')
												);
												
										
return  vIncident_chk ;
end;
												 
												 

dIncident_valid := nothor(apply ( Incident_FileListing , fn_Incident_chk(name,size)));


return dIncident_valid;
end;