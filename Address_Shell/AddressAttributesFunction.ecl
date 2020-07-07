/* 
 * AddressAttributesFunction: This function takes in the input and gathers all the
 * requested attributes and returns it in the flat layout.  This function should be able
 * to generate a layout to be used in a batch service, or to pass into a possible future model.
 */
import Gateway;

EXPORT AddressAttributesFunction (DATASET(Address_Shell.layoutInput) cleanedInput, UNSIGNED1 publicRecordsAttributesVersion,
       UNSIGNED1 propertyInformationAttributesVersion, UNSIGNED1 ercAttributesVersion,
       DATASET(Gateway.Layouts.Config) gateway_cfg) := FUNCTION
	pubRecs := Address_Shell.getPropertyAttributes(cleanedInput, publicRecordsAttributesVersion);
	
	propertyRecs := Address_Shell.getPropertyCharacteristics(cleanedInput, propertyInformationAttributesVersion, ercAttributesVersion, gateway_cfg);
	
	combinedAttributes := JOIN(pubRecs, propertyRecs, LEFT.Input.GeoLink = RIGHT.Input.GeoLink, TRANSFORM(Address_Shell.layoutPropertyCharacteristics, SELF.PropertyAttributes := LEFT.PropertyAttributes; SELF := RIGHT));

/* ************************************************************
	 * Debugging section.  This is only turned on when          *
   * Address_Shell.Constants.debugging is set to TRUE and     *
   * then the service is redeployed.  Allows the dev to look  *
   * at each step of the process.  ECL Developers use only.   *
   ************************************************************ */
	#if(Address_Shell.Constants.debugging)
		#STORED('PAPubRecs', pubRecs);
		#STORED('PCPropRecs', propertyRecs);
	#end
	
	RETURN(combinedAttributes);
END;