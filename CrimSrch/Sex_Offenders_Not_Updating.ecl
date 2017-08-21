//This attribute is used for filtering out the Non-Updating Sex Offender states.
//In order to have the Updating list as a check please provide the list of updating states in the comment below.
//CA and NV are never included
//########Attenetion - These are older then the current production SO build.############
//######################################################################################
//Currently no older data is included
//######################################################################################
//Previously updating states from Sex Offender Build 2011909a
//AL,CT,DE,FL,IL,LA,MA,MD,ME,MN,MO,NE,NH,NM,NV,NY,OH,PA,RI,SD,TN,TX,UT,VA,VT,WA,WI and WY
//####################### These are the newest Updating States #########################
//Updating Sex Offender States as of the latest production Sex Offender Build 20111021b:
//AK,AL,AR,CT,DC,DE,FL,GA,IL,IN,KS,KY,LA,MA,MD,ME,MN,NH,NM,NY,PA,RI,SD,TN,UT,VT,WA and WI
//Using Hygenics Data Ver 20111118 - All sources updating - NV and CA not included
//OR is also being filtered due to the upload date from Hygencis 5/13/2011
export Sex_Offenders_Not_Updating := module

export SO_By_Key := 
['C2NV',
'C2CA'];

export SO_By_Source := 
['OR_SEX_OFFENDER_REGI'];

end;