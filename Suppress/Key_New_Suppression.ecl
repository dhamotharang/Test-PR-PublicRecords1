import STD,doxie, ut,Data_Services,Suppress;

// Note: so far "Linking_type" and "Document_Type" are mutually exclusive,
// and that's how it was implemented in Suppress/MAC_Suppress
// IMPORTANT: in case it is changed, please notify query group
export Key_New_Suppression(boolean isFCRA = false) :=  function

SetRequireLinkingId:=['SSN','DID','BDID','RDID'];
SetRequireDocumentId:=['FARES ID','OFFENDER KEY','OFFICIAL RECORD','FDN ID'];

get_recs := if(isFCRA, Suppress.File_New_Suppression_FCRA,Suppress.File_New_Suppression);

FilteredDS := if(isFCRA, get_recs(STD.Str.ToUpperCase(TRIM(linking_type,left,right)) in ['SSN','DID'] and (unsigned)linking_id<>0),
																										get_recs(
																																			 (STD.Str.ToUpperCase(TRIM(linking_type,left,right)) in SetRequireLinkingId and (unsigned)linking_id<>0)
																																						or (STD.Str.ToUpperCase(TRIM(document_type,left,right)) in SetRequireDocumentId and Document_Id<>'')
																																						or (STD.Str.ToUpperCase(TRIM(linking_type,left,right)) not in SetRequireLinkingId + SetRequireDocumentId
																																						and STD.Str.ToUpperCase(TRIM(document_type,left,right)) not in SetRequireLinkingId + SetRequireDocumentId)
																																					)
																																);

KeyName 						:= 'thor_data400::key::new_suppression::';
KeyName_fcra 	:= 'thor_data400::key::new_suppression::fcra::';

key_name := Data_Services.Data_location.Prefix('NONAMEGIVEN')+ if(isFCRA,KeyName_fcra,KeyName) +	doxie.Version_SuperKey+'::link_type_link_id';


key := index(FilteredDS,{Product,Linking_type,Linking_ID,Document_Type,Document_ID},{Date_Added,User,Compliance_ID},key_name);

return key;

end;