import Scrubs, Scrubs_Property_Foreclosures, Orbit3SOA, SALT30, ut, tools, std;

EXPORT scrubs_foreclosure_raw(string pVersion, string emailList='') := FUNCTION
#workunit('name', 'Scrubs Property Foreclosures');
#option('multiplePersistInstances',FALSE);

return scrubs.ScrubsPlus('property_foreclosures','Scrubs_Property_Foreclosures','Scrubs_Property_Foreclosures','',pVersion,emailList,false);

END;	