basename:=cluster_name+'::in::appriss_agency_delete_raw_xml'; // samplebookingexport

export file_in_agency_deletes_raw_xml
   := DATASET(basename,layout_in_agency_deletes_raw_xml,XML('subscriber/agencyDelete'));
