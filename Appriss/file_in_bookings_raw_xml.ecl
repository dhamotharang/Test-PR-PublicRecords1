
basename:=cluster_name+'::in::appriss_booking_charges_raw_xml'; // samplebookingexport
//basename:='~thor_data50::in::5001.1.2432.1245321499425_20090626';// ananth's file
//basename:='~thor_data50::test::appriss_bookings_raw_xml_test';//Jay test
export file_in_bookings_raw_xml := 
 DATASET(basename,layout_in_bookings_raw_xml,XML('subscriber/booking'));