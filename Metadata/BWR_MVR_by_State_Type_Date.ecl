// W20080515-143815 Vehicles by State Type Date (e.g. TX lessors) jjb
/*
wenhong ma: 7 is lienholder
wenhong ma: 5 is lessee
wenhong ma: 4 is registrants
wenhong ma: 2 is lessor
wenhong ma: 1 is owner
*/

output(choosen(table(VehicleV2.file_vehicleV2_party(orig_state='TX',orig_name_type='2'),{
min(group,Date_First_Seen),max(group,Date_Last_Seen),min(group,Date_Vendor_First_Reported),max(group,Date_Vendor_Last_Reported),count(group)}),all));