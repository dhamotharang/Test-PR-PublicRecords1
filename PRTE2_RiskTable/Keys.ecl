IMPORT  doxie,mdr, PRTE2_RiskTable;

EXPORT keys := MODULE

EXPORT key_address_table_v4 := INDEX(
	FILES.Address_Table_v4, 
	 {zip,prim_name,prim_range,sec_range}, 
	 {FILES.Address_Table_v4}, 
	Constants.RiskTable_Keyname + doxie.Version_SuperKey + '::address_table_v4');

EXPORT key_addr_name := INDEX(
	FILES.addr_name_counts, 
	 {prim_name,prim_range,zip,lname,fname}, 
	 {FILES.addr_name_counts},
	Constants.RiskTable_Keyname + doxie.Version_SuperKey + '::addr_name');

EXPORT key_adl_risk_table_v4(Boolean IsFCRA) := INDEX(
	ADL_Risk_Table_v4(IsFCRA), 
	 {did}, 
	 {ADL_Risk_Table_v4(IsFCRA)}, 
	if(IsFCRA, Constants.RiskTable_FCRA_Keyname, Constants.RiskTable_Keyname) + doxie.Version_SuperKey + '::adl_risk_table_v4');

EXPORT key_phone_addr := INDEX(
	FILES.phone_addr_counts, 
	 {phone10, prim_name, prim_range, zip}, 
	 {FILES.phone_addr_counts}, 
	Constants.RiskTable_Keyname + doxie.Version_SuperKey + '::phone_addr');
	
EXPORT key_phone_lname := INDEX(
	FILES.phone_lname_counts, 
	 {phone10,lname}, 
	 {Files.phone_lname_counts}, 
	Constants.RiskTable_Keyname + doxie.Version_SuperKey + '::phone_lname');
	
EXPORT key_ssn_addr := INDEX(
	FILES.ssn_addr_counts, 
	 {ssn,prim_name,prim_range,zip}, 
	 {Files.ssn_addr_counts}, 
	Constants.RiskTable_Keyname + doxie.Version_SuperKey + '::ssn_addr');
	
EXPORT key_ssn_name := INDEX(
	FILES.ssn_name_counts, 
	 {ssn,lname,fname}, 
	 {Files.ssn_name_counts}, 
	Constants.RiskTable_Keyname + doxie.Version_SuperKey + '::ssn_name');

	
EXPORT key_ssn_table_v4_2 := INDEX(
	FILES.SSN_Table_v4_2(false), 
	{ssn}, 
	{Files.SSN_Table_v4_2(false)}, 
	Constants.RiskTable_Keyname + doxie.Version_SuperKey + '::ssn_table_v4_2');

EXPORT key_ssn_table_v4_filtered := INDEX(
	FILES.SSN_Table_v4(true),
	{ssn},
	{FILES.SSN_Table_v4(true)},
	Constants.RiskTable_FCRA_Keyname + doxie.Version_SuperKey + '::ssn_table_v4_filtered');
	
EXPORT key_suspicious_identities := INDEX(
	FILES.Suspicious_Identities_Base, 
	 {did}, 
	 {Files.Suspicious_Identities_Base}, 
	Constants.RiskTable_Keyname + doxie.Version_SuperKey + '::suspicious_identities');

//new CorrelationKeys :new for shell 5.3,
export key_ssn_name_summary := index(files.ssn_name_summary, {ssn, lname, fname}, {files.ssn_name_summary}, 
	Constants.RiskTable_Keyname +doxie.Version_SuperKey+'::ssn_name_summary');
	
export key_ssn_addr_summary := index(files.ssn_addr_summary, {ssn, prim_name, prim_range, zip}, {files.ssn_addr_summary}, 
	Constants.RiskTable_Keyname +doxie.Version_SuperKey+'::ssn_addr_summary');	

export key_ssn_dob_summary := index(files.ssn_dob_summary, {ssn, dob}, {files.ssn_dob_summary}, 
	Constants.RiskTable_Keyname +doxie.Version_SuperKey+'::ssn_dob_summary');
	
export key_ssn_phone_summary := index(files.ssn_phone_summary, {ssn, phone}, {files.ssn_phone_summary}, 
	Constants.RiskTable_Keyname +doxie.Version_SuperKey+'::ssn_phone_summary');	

export key_phone_dob_summary := index(files.phone_dob_summary, {phone, dob}, {files.phone_dob_summary}, 
	Constants.RiskTable_Keyname +doxie.Version_SuperKey+'::phone_dob_summary');	
	
export key_addr_name_summary := index(files.addr_name_summary, {prim_name, prim_range, zip, lname, fname}, {files.addr_name_summary}, 
	Constants.RiskTable_Keyname +doxie.Version_SuperKey+'::addr_name_summary');

export key_addr_dob_summary := index(files.addr_dob_summary, {prim_name, prim_range, zip, dob}, {files.addr_dob_summary}, 
	Constants.RiskTable_Keyname +doxie.Version_SuperKey+'::addr_dob_summary');	
	
export key_name_dob_summary := index(files.name_dob_summary, {lname, fname, dob}, {files.name_dob_summary}, 
	Constants.RiskTable_Keyname +doxie.Version_SuperKey+'::name_dob_summary');	
	
export key_phone_addr_summary := index(files.phone_addr_summary, {phone10, prim_name, prim_range, zip}, {files.phone_addr_summary}, 
	Constants.RiskTable_Keyname +doxie.Version_SuperKey+'::phone_addr_summary');	

export key_phone_addr_header_summary := index(files.phone_addr_header_summary, {phone10, prim_name, prim_range, zip}, {files.phone_addr_header_summary}, 
	Constants.RiskTable_Keyname +doxie.Version_SuperKey+'::phone_addr_header_summary');

export key_phone_lname_summary := index(files.phone_lname_summary, {phone10, lname := name_last}, {files.phone_lname_summary}, 
	Constants.RiskTable_Keyname +doxie.Version_SuperKey+'::phone_lname_summary');	
	
export key_phone_lname_header_summary := index(files.phone_lname_header_summary, {phone10, lname := name_last}, {files.phone_lname_header_summary}, 
	Constants.RiskTable_Keyname +doxie.Version_SuperKey+'::phone_lname_header_summary');	
	

END;
