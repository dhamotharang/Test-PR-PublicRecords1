//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.charge_arrests_BWR_PopulationStatistics - Population Statistics - SALT V3.11.9');
IMPORT Scrubs_Crim,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Crim.charge_arrests_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*vendor Field*/,/* recordid_field */,/* statecode_field */,/* caseid_field */,/* warrantnumber_field */,/* warrantdate_field */,/* warrantdesc_field */,/* warrantissuedate_field */,/* warrantissuingagency_field */,/* warrantstatus_field */,/* citationnumber_field */,/* bookingnumber_field */,/* arrestdate_field */,/* arrestingagency_field */,/* bookingdate_field */,/* custodydate_field */,/* custodylocation_field */,/* initialcharge_field */,/* initialchargedate_field */,/* initialchargecancelleddate_field */,/* chargedisposed_field */,/* chargedisposeddate_field */,/* chargeseverity_field */,/* chargedisposition_field */,/* amendedcharge_field */,/* amendedchargedate_field */,/* bondsman_field */,/* bondamount_field */,/* bondtype_field */,/* sourcename_field */,/* sourceid_field */,/* vendor_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
