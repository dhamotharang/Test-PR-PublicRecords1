IMPORT  doxie,mdr, BIPV2;

EXPORT keys := MODULE

EXPORT key_fbnv2_bdid := INDEX(
	FILES.DS_Bdid, 
	 {bdid}, 
	 {Files.DS_Bdid}, 
	'~prte::key::fbnv2:: ' + doxie.Version_SuperKey + '::bdid');
		
EXPORT key_fbnv2_did := INDEX(
	FILES.DS_Did, 
	 {did}, 
	 {Files.DS_Did},
	'~prte::key::fbnv2:: ' + doxie.Version_SuperKey + '::did');
	
EXPORT key_fbnv2_filing_number := INDEX(
	FILES.DS_Business_File_Num, 
	 {filing_number}, 
	 {Files.DS_Business_File_Num}, 
	'~prte::key::fbnv2:: ' + doxie.Version_SuperKey + '::filing_number');

EXPORT key_fbnv2_rmsid_business := INDEX(
	FILES.Business_Base_2, 
	 {tmsid,rmsid}, 
	 {Files.Business_Base_2},
 	'~prte::key::fbnv2:: ' + doxie.Version_SuperKey + '::rmsid_business');

EXPORT key_fbnv2_rmsid_contact := INDEX(
	FILES.Contact_Base_2, 
	 {tmsid,rmsid}, 
	 {Files.Contact_Base_2},
	'~prte::key::fbnv2:: ' + doxie.Version_SuperKey + '::rmsid_contact');
	
	//LINKIDS

EXPORT Key_LinkIds := MODULE
  
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.Business_Base_1, out_key, 
	constants.KeyName_fbnv2 + doxie.Version_SuperKey + '::linkids');
  export Key := out_key;
  
	//DEFINE THE INDEX ACCESS
	export kFetch2(
	  dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																												 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																												//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
								) :=FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out_fetch, Level, joinLimit, JoinType);
	  return out_fetch;	
  END;
		
END;

END;
