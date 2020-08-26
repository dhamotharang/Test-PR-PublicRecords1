/*2012-08-09T16:09:24Z (skasavajjala)
C:\Users\KasavaSX\AppData\Roaming\HPCC Systems\eclide\skasavajjala\bocadataland\faa\Spray_In\2012-08-09T16_09_24Z.ecl
*/
import	lib_stringlib,lib_fileservices,_control,AID,Address, std;

export	Spray_In(string	process_date, STRING pSource, STRING srcIP = _control.IPAddress.bctlpedata11)	:=
function
	targetGrp	:=		STD.System.Thorlib.Group(); //'thor400_44'; 

	filenames	:=	'~thor_data400::in::faa::'	+	process_date;

	checkairmenfileexists(string FileName)	:=	if(	count(FileServices.remotedirectory(srcIP,pSource+'/',FileName,false)(size <>0 ))	=	1,
																						true,
																						false
																					);
																					
	add_super_pilot :=  Sequential(
	                         FileServices.StartSuperFileTransaction(),
													 FileServices.ClearSuperFile('~thor_data400::in::faa::airmen_pilot'),
													 FileServices.AddSuperFile('~thor_data400::in::faa::airmen_pilot',filenames+'::airmen_pilot'),
													 FileServices.FinishSuperFiletransaction());

	spray_airmen_pilot	:=	if(	checkairmenfileexists('PILOT.txt') and '~'+FileServices.GetSuperFileSubName('~thor_data400::in::faa::airmen_pilot',1) <> filenames+'::airmen_pilot',
	                         Sequential(
	                         FileServices.sprayfixed(	srcIP
																								,pSource+'/PILOT.txt'
																								,1122,targetGrp,filenames+'::airmen_pilot'
																								,,,,true,false,true
																							),add_super_pilot)
																							,
																output('no new airmen pilot files exists '));
																
	//Create Superfiles if not exists
	
	create_superfiles := Sequential(if ( not FileServices.FileExists('~thor_data400::in::faa::airmen_pilot'),FileServices.CreateSuperFile('~thor_data400::in::faa::airmen_pilot')),
	                                if ( not FileServices.FileExists('~thor_data400::in::faa::airmen_nonpilot'),FileServices.CreateSuperFile('~thor_data400::in::faa::airmen_nonpilot')),
																	if ( not FileServices.FileExists('~thor_data400::in::faa::aircraft_master'),FileServices.CreateSuperFile('~thor_data400::in::faa::aircraft_master')),
																	if ( not FileServices.FileExists('~thor_data400::in::faa::aircraft_actref'),FileServices.CreateSuperFile('~thor_data400::in::faa::aircraft_actref')),
																	Output('all_files_exists'));
																	
																	
	                               
																
	//Superfile transaction 
	
	
	  
		
		add_super_nonpilot :=  Sequential(
	                         FileServices.StartSuperFileTransaction(),
													 FileServices.ClearSuperFile('~thor_data400::in::faa::airmen_nonpilot'),
													 FileServices.AddSuperFile('~thor_data400::in::faa::airmen_nonpilot',filenames+'::airmen_nonpilot'),
													 FileServices.FinishSuperFiletransaction());
				 
	spray_airmen_nonpilot	:=	if(	checkairmenfileexists('NONPILOT.txt') and '~'+FileServices.GetSuperFileSubName('~thor_data400::in::faa::airmen_nonpilot',1) <> filenames+'::airmen_nonpilot',
	                       Sequential(
																			FileServices.sprayvariable(	srcIP
																								,pSource+'/NONPILOT.txt'
																								,,,,
																								,targetGrp
																								,filenames + '::airmen_nonpilot'
																								,,,,true,false,true
																							),add_super_nonpilot)
																						,
																		output('no new airmen nonpilot files exists '));
																		
																		
	//Superfile transaction 
	
	
	checkaircraftfileexists(string FileName)	:=	if(	count(FileServices.remotedirectory(srcIP,pSource+'/',filename,false)(size <>0 ))	=	1,
																						true,
																						false
																					);
	add_super_engine :=  Sequential(
	                         FileServices.StartSuperFileTransaction(),
													 FileServices.ClearSuperFile('~thor_data400::in::faa::aircraft_engine'),
													 FileServices.AddSuperFile('~thor_data400::in::faa::aircraft_engine',filenames+'::aircraft_engine'),
													 FileServices.FinishSuperFiletransaction());

	//check if file exists in UNIX and then spray
	spray_aircraft_engine	:=	if(	checkaircraftfileexists('ENGINE.txt') and '~'+FileServices.GetSuperFileSubName('~thor_data400::in::faa::aircraft_engine',1) <> filenames+'::aircraft_engine',
	                             Sequential(
	                              FileServices.sprayvariable(	srcIP
																								,pSource+'/ENGINE.txt'
																								,,,,
																								,targetGrp
																								,filenames+'::aircraft_engine'
																								,,,,true,false,true
																							),add_super_engine)
																							,
																		output('no new aircraft master files exists '));
																		
	
																		
		
	add_super_master :=  Sequential(
	                         FileServices.StartSuperFileTransaction(),
													 FileServices.ClearSuperFile('~thor_data400::in::faa::aircraft_master'),
													 FileServices.AddSuperFile('~thor_data400::in::faa::aircraft_master',filenames+'::aircraft_master'),
													 FileServices.FinishSuperFiletransaction());

	//check if file exists in UNIX and then spray
	spray_aircraft_master	:=	if(	checkaircraftfileexists('MASTER.txt') and '~'+FileServices.GetSuperFileSubName('~thor_data400::in::faa::aircraft_master',1) <> filenames+'::aircraft_master',
	                             Sequential(
	                              FileServices.sprayvariable(	srcIP
																								,pSource+'/MASTER.txt'
																								,,,,
																								,targetGrp
																								,filenames+'::aircraft_master'
																								,,,,true,false,true
																							),add_super_master)
																							,
																		output('no new aircraft master files exists '));
																		
																		
//Superfile transaction 
	
	
													 
	add_super_actref :=  Sequential(
	                         FileServices.StartSuperFileTransaction(),
													 FileServices.ClearSuperFile('~thor_data400::in::faa::aircraft_actref'),
													 FileServices.AddSuperFile('~thor_data400::in::faa::aircraft_actref',filenames+'::aircraft_actref'),
													 FileServices.FinishSuperFiletransaction());
																							
				 
	spray_aircraft_actref	:=	if(	checkaircraftfileexists('ACFTREF.txt') and '~'+FileServices.GetSuperFileSubName('~thor_data400::in::faa::aircraft_actref',1) <> filenames+'::aircraft_actref',
	                          Sequential(
	                           FileServices.sprayvariable(	srcIP
																								,pSource+'/ACFTREF.txt'
																								,,,,
																								,targetGrp
																								,filenames+'::aircraft_actref'
																								,,,,true,false,true
																							),add_super_actref)
																							,
																							
																			output('no new aircraft actref files exists '));
																			
	
																							
		return sequential(create_superfiles,spray_airmen_pilot,spray_airmen_nonpilot,spray_aircraft_engine,
		                   spray_aircraft_master,spray_aircraft_actref);
		
		end;
