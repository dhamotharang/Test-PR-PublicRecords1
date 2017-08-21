	/*
**********************************************************************************
Created by    Comments
Vani 					This attribute 
              1)Use the persistent_key file with unique Persisitent_key and DID' values
							2)Extract Employer Name from . 
													
							
***********************************************************************************
*/	
import address;
Layout_Business_Contact_Slim := RECORD
  Files_used.Layout_Business_Contact.did;
  Files_used.Layout_Business_Contact.dt_first_seen;   // From contact info if available
  Files_used.Layout_Business_Contact.dt_last_seen;
  // Files_used.Layout_Business_Contact.source;          // Source file type
  // Files_used.Layout_Business_Contact.record_type;     // 'C' = Current, 'H' = Historical
  // Files_used.Layout_Business_Contact.from_hdr; // 'Y' if contact is from address  match with person headers.
  // Files_used.Layout_Business_Contact.glb;    // GLB restricted record (only possible for contacts pulled from header)
  // Files_used.Layout_Business_Contact.dppa; 
	Files_used.Layout_Business_Contact.Company_name;
end;

Business_contact_slim := PROJECT(Files_used.Bus_Hdr_Business_contacts_File, Layout_Business_Contact_Slim);

D_Business_contact_slim := DISTRIBUTE(Business_contact_slim,hash(DID));

//----------------------------------------------------------------------------------------------------------------------------
//Extract Employer List from Business contacts file
//----------------------------------------------------------------------------------------------------------------------------

  Layout_Employer_List Join_KeyFile_empData(Layout_UNQ_PK_DID_Plus_Relatives L, Layout_Business_Contact_Slim R) := TRANSFORM

    SELF:=L;
	SELF:=R;

  end;
	
  J_Employer_List   		  := JOIN(File_Generated_UNQ_PK_DID_Plus_Relatives, D_Business_contact_slim, 
	                                  LEFT.did = RIGHT.did ,
									  Join_KeyFile_empData(LEFT,RIGHT), LOCAL);
																	 

export Mapping_Extract_Employer_list := J_Employer_List ;//: persist('persist::IMAP::employer_list');