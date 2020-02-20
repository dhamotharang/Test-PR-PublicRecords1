/*--SOAP--
<message name="RAN_BestInfo_Batch_Service">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="DPPAPurpose" type="xsd:unsignedInt"/>
  <part name="GLBPurpose" type="xsd:unsignedInt"/>
  <part name="ExcludeRelatives" type="xsd:boolean"/>
  <part name="ExcludeAssociates" type="xsd:boolean"/>
  <part name="ExcludeInputAddrNeighbors" type="xsd:boolean"/>
  <part name="ExcludeUpdateAddrNeighbors" type="xsd:boolean"/>
  <part name="SuppressSameAddress" type="xsd:boolean"/>
  <part name="SuppressSamePhone" type="xsd:boolean"/>
  <part name="DedupRelativesAssociatesOnPhone" type="xsd:boolean"/>
  <part name="RelativesDepth" type="xsd:unsignedInt"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
</message>
*/
/*--INFO-- This service returns relatives, associates and neighbors etc.*/

/*
<message name="RAN_BestInfo_Batch_Service" wuTimeout="300000">
*/



/*
  Here is the general logic for the Relatives-Associates-Neighbors batch service.
  It avoids details and is slightly inaccurate, but in broad-brushstroke terms it’s pretty good:

  1.	Append LexID to the subject record
  2.	Get the Best Address (via Watchdog) for the subject by LexID
  3.	Find Neighbors of the subject using the subject’s Best Address; append phones numbers
  4.	Find Neighbors of the subject using the subject’s input address; append phone numbers
  5.	Find Relatives and Associates of the subject by the subject’s LexID. That is, get the identities of everyone who lives or has lived in the same dwelling as the search subject. An Associate differs from a Relative only in that an Associate is not related to the search subject (I know--sounds obvious).
  6.	Get Best Address and phone numbers for each Relative and Associate.
  7.	Return:
    a.	the 3 Neighbors nearest to the subject’s input address
    b.	the 3 Neighbors nearest to the subject’s Best Address
    c.	the top 6 Relatives closest by family relationship to the subject
    d.	the top 6 Associates of the subject
*/

export RAN_BestInfo_Batch_Service := macro
import didville,Doxie;
  //get input
  f_in_raw := dataset([],DidVille.Layout_RAN_BestInfo_BatchIn) : stored('batch_in',few);
  unsigned4 ProfileBoosterRelatives := 0 : stored('ProfileBoosterMaxRelatives'); // Profile Booster relatives count - to limit fetching profile booster attributes for Relatives
  unsigned4 ProfileBoosterAssociates := 0 : stored('ProfileBoosterMaxAssociates'); // Profile Booster Associates count - to limit fetching profile booster attributes for Associates
  unsigned4 ProfileBoosterNeighbors := 0 : stored('ProfileBoosterMaxNeighbors');// Profile Booster Neighbors count - to limit fetching profile booster attributes for Neighbors
  boolean IncludeProfileBooster := false : stored('IncludeProfileBooster');

  MAP(IncludeProfileBooster AND (ProfileBoosterNeighbors) > 6 => FAIL(303, Doxie.ErrorCodes(303)+':'+' Neighbors count exceeds 6'),
      IncludeProfileBooster AND (ProfileBoosterRelatives + ProfileBoosterAssociates + ProfileBoosterNeighbors) > 10 =>
                FAIL(303,Doxie.ErrorCodes(303)+':'+' Relatives, Associates and Neighbors total count exceeds 10'));

  // check if all input counts for profile booster blank and apply default values
  useDefaultPBCounts := ProfileBoosterRelatives = 0 AND ProfileBoosterAssociates = 0 AND ProfileBoosterNeighbors = 0;
  RelativesCount := IF(useDefaultPBCounts,4,ProfileBoosterRelatives);
  AssociatesCount := IF(useDefaultPBCounts,4,ProfileBoosterAssociates);
  NeighborsCount := IF(useDefaultPBCounts,2,ProfileBoosterNeighbors);

  recs :=  DidVille.RAN_BestInfo_Batch_Service_Records(f_in_raw,PbRelativesCount := RelativesCount,
                                                                PbAssociatesCount := AssociatesCount,
                                                                PbNeighborsCount := NeighborsCount);
  Results := project(recs, transform(recordof(recs) - input_addr_matched_rel - input_addr_name_matched_rel, self := LEFT));
  OUTPUT(Results, NAMED('Results'));

endmacro;


