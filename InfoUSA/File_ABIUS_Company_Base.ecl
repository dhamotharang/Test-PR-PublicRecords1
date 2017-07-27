import business_header;

export File_ABIUS_Company_Base := PROJECT(InfoUSA.File_ABIUS_Company_Base_AID,TRANSFORM(InfoUSA.Layout_ABIUS_Company_Base,SELF := LEFT;))
+ fMap_Business_Best_to_Abius();
