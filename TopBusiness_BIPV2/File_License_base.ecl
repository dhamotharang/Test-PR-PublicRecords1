// File_License_base_raw := dataset('~thor_data400::BASE::License_Base',TopBusiness_BIPV2.Layouts.rec_license_combined_layout,flat);
EXPORT File_License_base(string pversion = 'qa') := Files(pversion).License_Linkids.logical(
																										 license_number<>'' or
																										 license_state<>''
																										);


// string2   license_state;   // license issuing state, if applicable
// string60  license_board;   // the license issuing board or agency name
// string25  license_number;  // the license number issued
// string60  license_type;    // the type of license (pharmacy, pharmacist, etc.)
// string8   issue_date;      // the date the license was issued
// string8   expiration_date; // the date the license expires
