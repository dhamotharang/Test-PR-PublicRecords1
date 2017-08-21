
import driversv2;
import vehiclev2;
import vehlic;
import corrections;
import sexoffender;
import images;
//	
file_dl_searchv2 				:= dataset('~thor_data400::base::DL2::DLSearch_PUBLIC', DriversV2.Layout_Drivers, flat);
//
file_vehiclev2_main 		:= vehiclev2.file_VehicleV2_Main;
file_vehiclev2_party		:= vehiclev2.file_VehicleV2_party;

//
file_offenders 		:= dataset('~thor_Data400::base::Corrections_Offenders_' + 'public' + '_BUILT',corrections.layout_Offender,flat);
file_offenses 		:= dataset('~thor_data400::base::corrections_offenses_' + 'public' + '_BUILT',corrections.layout_offense,flat);
file_courtoffenses 	:= dataset('~thor_Data400::base::corrections_court_offenses_' + 'public' + '_BUILT',corrections.layout_courtoffenses,flat);
file_activity 		:= dataset('~thor_data400::base::corrections_Activity_' + 'public' + '_BUILT',corrections.layout_activity,flat);
file_punishment 	:= dataset('~thor_Data400::base::corrections_punishment_' + 'public' + '_BUILT',corrections.Layout_CrimPunishment,flat);
//
file_so_search := sexoffender.File_Accurint_Search_In;
file_so_main := sexoffender.File_Accurint_In;

file_images := images.File_Images;
//
//*output(file_dl_searchv2(orig_state='MN'),,'~thor_200::base::DL2::DLSearch_MN_distrix_rvh',overwrite);

//*output(file_so_search(orig_state='MN'),,'~thor_200::in::so_accurint_search_MN_distrix_rvh',overwrite);
//*output(file_so_main(orig_state='MN'),,'~thor_200::in::so_accurint_MN_distrix_rvh',overwrite);

//*output(file_images(state='MN'),,'~thor_200::images::base::matrix_images_MN_distrix_rvh',overwrite);

//*output(file_vehiclev2_main(state_origin='MN'),,'~thor_200::base::VehicleV2::Main_MN_distrix_rvh',overwrite);
//*output(file_vehiclev2_party(state_origin='MN'),,'~thor_200::base::VehicleV2::party_MN_distrix_rvh',overwrite);

//*output(file_offenders(orig_state='Minnesota'),,'~thor_200::base::Corrections_Offenders_MN_distrix_rvh',overwrite);
//*output(file_offenses(orig_state='MN'),,'~thor_200::base::corrections_offenses_MN_distrix_rvh',overwrite);
//*output(file_courtoffenses(state_origin='MN'),,'~thor_200::base::corrections_court_offenses_distrix_rvh',overwrite);
//*output(file_activity(state_origin='MN'),,'~thor_200::base::corrections_Activity_MN_distrix_rvh',overwrite);
//*output(file_punishment(orig_state='MN'),,'~thor_200::base::corrections_punishment_MN_distrix_rvh',overwrite);

despray(STRING file, string DestinationIP, string destination) := 
		fileservices.despray(file,DestinationIP,destination,,,,TRUE); 

//DestinationIP       := _control.IPAddress.edata12;
DestinationIP       := '10.173.85.209'; // Distrix box 
xBasefilex     		:= '~thor_200::x';
punix               := '/c$/distrix/';

f1:='~thor_200::base::DL2::DLSearch_MN_distrix_rvh';
f2:='~thor_200::in::so_accurint_search_MN_distrix_rvh';
f3:='~thor_200::in::so_accurint_MN_distrix_rvh';
f4:='~thor_200::images::base::matrix_images_MN_distrix_rvh';
f5:='~thor_200::base::VehicleV2::Main_MN_distrix_rvh';
f6:='~thor_200::base::VehicleV2::party_MN_distrix_rvh';
f7:='~thor_200::base::Corrections_Offenders_MN_distrix_rvh';
f8:='~thor_200::base::corrections_offenses_MN_distrix_rvh';
f9:='~thor_200::base::corrections_court_offenses_distrix_rvh';
f10:='~thor_200::base::corrections_Activity_MN_distrix_rvh';
f11:='~thor_200::base::corrections_punishment_MN_distrix_rvh';


d1 := despray(f1,DestinationIP,punix+f1+'.d00');
d2 := despray(f2,DestinationIP,punix+f2+'.d00');
d3 := despray(f3,DestinationIP,punix+f3+'.d00');
d4 := despray(f4,DestinationIP,punix+f4+'.d00');
d5 := despray(f5,DestinationIP,punix+f5+'.d00');
d6 := despray(f6,DestinationIP,punix+f6+'.d00');
d7 := despray(f7,DestinationIP,punix+f7+'.d00');
d8 := despray(f8,DestinationIP,punix+f8+'.d00');
d9 := despray(f9,DestinationIP,punix+f9+'.d00');
d10 := despray(f10,DestinationIP,punix+f10+'.d00');
d11 := despray(f11,DestinationIP,punix+f11+'.d00');

sequential(d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11);
