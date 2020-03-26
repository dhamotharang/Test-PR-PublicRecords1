IMPORT Scrubs_SKA, busdata;

Base_Nixie_In := DATASET('~thor_Data400::base::ska_nixie', busdata.layout_ska_nixie_bdid, FLAT);

//SALT is not happy with a field named "id" so we must project into a different/valid layout
EXPORT Base_Nixie_In_SKA := PROJECT(Base_Nixie_In, TRANSFORM(Scrubs_SKA.Base_Nixie_Layout_SKA, SELF.ID_SKA := LEFT.ID, SELF := LEFT));
