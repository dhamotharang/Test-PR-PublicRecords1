import mdr;
// The following source types are considered to have a highly populated phone which can be used
// when appropriate for distribution and matching including Business_Header.MAC_Basic_Match_Phone.
// If the source type is included in Business_Header.Set_Source_Vendor_Id_Unique, it should not
// be included here
export Set_Source_Phone :=
[
	 MDR.sourceTools.src_Gong_Business  				// Gong Business
	,MDR.sourceTools.src_Gong_Government  			// Gong Government
	,MDR.sourceTools.src_Employee_Directories   // Employee Directories
	,MDR.sourceTools.src_Yellow_Pages  					// Yellow Pages
];