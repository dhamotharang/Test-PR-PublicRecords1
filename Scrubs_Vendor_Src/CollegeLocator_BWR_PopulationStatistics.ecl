﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Vendor_Src.CollegeLocator_BWR_PopulationStatistics - Population Statistics - SALT V3.11.6');
IMPORT Scrubs_Vendor_Src,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Vendor_Src.CollegeLocator_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* lnfilecategory_field */,/* lnsourcetcode_field */,/* vendorname_field */,/* address1_field */,/* address2_field */,/* city_field */,/* state_field */,/* zipcode_field */,/* phone_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
