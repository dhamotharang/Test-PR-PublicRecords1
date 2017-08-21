//Missing record search
//Edited from MVR.ecl by John J. Bulten 20070418
//MVR by VIN W20071128-092208 W20080502-134848
//Moved to VehicleV2 from VehLic W20080807-102302 W20080811-100124

vin1:='3D7KU28C24G236972'; //May be changed to subject VIN
//vin2:='1J4GW58N82C322696';
//vin3:='JN8AZ08W55W411275';

import VehicleV2;

output(choosen(VehicleV2.File_VehicleV2_Main(vehicle_key=vin1 or orig_vin=vin1 or vina_vin=vin1),all));
//output(choosen(VehicleV2.File_VehicleV2_Main(vehicle_key=vin2 or orig_vin=vin2 or vina_vin=vin2),all));
//output(choosen(VehicleV2.File_VehicleV2_Main(vehicle_key=vin3 or orig_vin=vin3 or vina_vin=vin3),all));

output(choosen(VehicleV2.file_vehicleV2_party(vehicle_key=vin1),all));
//output(choosen(VehicleV2.file_vehicleV2_party(vehicle_key=vin2),all));
//output(choosen(VehicleV2.file_vehicleV2_party(vehicle_key=vin3),all));