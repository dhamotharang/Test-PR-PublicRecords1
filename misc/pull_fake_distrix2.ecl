
import vehiclev2;
import vehlic;
//
file_vehiclev1 := dataset('~thor_data400::base::vehicleV1_noupdating', VehLic.Layout_Vehicles,flat,unsorted,__compressed__);;

o1:=output(file_vehiclev1(orig_state='MN'),,'~thor_200::base::VehicleV1::MN_distrix_rvh',overwrite);


despray(STRING file, string DestinationIP, string destination) := 
		fileservices.despray(file,DestinationIP,destination,,,,TRUE); 

//DestinationIP       := _control.IPAddress.edata12;
DestinationIP       := '10.173.85.209'; // Distrix box 
xBasefilex     		:= '~thor_200::x';
punix               := '/c$/distrix/';


f5:='~thor_200::base::VehicleV1::MN_distrix_rvh';

d5 := despray(f5,DestinationIP,punix+f5+'.d00');


sequential(o1,d5);
