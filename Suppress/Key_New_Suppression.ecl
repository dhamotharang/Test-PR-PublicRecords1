import STD,doxie, ut,Data_Services,Suppress, vault, _control;

// Note: so far "Linking_type" and "Document_Type" are mutually exclusive,
// and that's how it was implemented in Suppress/MAC_Suppress
// IMPORTANT: in case it is changed, please notify query group
SetRequireLinkingId:=['SSN','DID','BDID','RDID'];
SetRequireDocumentId:=['FARES ID','OFFENDER KEY','OFFICIAL RECORD','FDN ID'];



#IF(_Control.Environment.onVault) 

export Key_New_Suppression := vault.Suppress.Key_New_Suppression(true);  // for riskview on vault testing, hard code this to true

#ELSE

export Key_New_Suppression := 
  index(Suppress.File_New_Suppression
	(
   (STD.Str.ToUpperCase(TRIM(linking_type,left,right))      in SetRequireLinkingId  and (unsigned)linking_id<>0)
or (STD.Str.ToUpperCase(TRIM(document_type,left,right))     in SetRequireDocumentId and           Document_Id<>'')
or (  STD.Str.ToUpperCase(TRIM(linking_type,left,right))  not in SetRequireLinkingId + SetRequireDocumentId
  and STD.Str.ToUpperCase(TRIM(document_type,left,right)) not in SetRequireLinkingId + SetRequireDocumentId)
	)
	,{Product,Linking_type,Linking_ID,Document_Type,Document_ID},{Date_Added,User,Compliance_ID}
        ,Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::new_suppression::'+doxie.Version_SuperKey+'::link_type_link_id');

#END;


