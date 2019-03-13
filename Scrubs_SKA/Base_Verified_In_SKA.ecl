IMPORT Scrubs_SKA, busdata;

Base_Verified_In := DATASET('~thor_Data400::base::ska_verified', busdata.layout_ska_verified_bdid, FLAT);

//SALT is not happy with a field named "id" so we must project into a different/valid layout
EXPORT Base_Verified_In_SKA := PROJECT(Base_Verified_In, TRANSFORM(Scrubs_SKA.Base_Verified_Layout_SKA, SELF.ID_SKA := LEFT.ID, SELF := LEFT));