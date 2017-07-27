import RoxieKeyBuild;

EXPORT BuildKeys(string build_date) :=  FUNCTION

KEY_PREFIX_NAME            	:= Files.KEY_PREFIX_NAME;
FILE_KEY_CONTRACTOR        	:= Files.FILE_KEY_CONTRACTOR;	
FILE_KEY_CORRECTION        	:= Files.FILE_KEY_CORRECTION;
FILE_KEY_INSPECTION        	:= Files.FILE_KEY_INSPECTION;
FILE_KEY_PERMIT            	:= Files.FILE_KEY_PERMIT;
FILE_KEY_PROPERTY          	:= Files.FILE_KEY_PROPERTY;
FILE_KEY_PERMITCONTRACTOR  	:= Files.FILE_KEY_PERMITCONTRACTOR;
FILE_KEY_PROPERTY_ADDRESS	 	:= Files.FILE_KEY_PROPERTY_ADDRESS;
FILE_KEY_PROPERTY_ERR_ADDRESS	:= Files.FILE_KEY_PROPERTY_ERR_ADDRESS;
FILE_KEY_JURISDICTION				:= Files.FILE_KEY_JURISDICTION;
FILE_KEY_STREETLOOKUP				:= Files.FILE_KEY_STREETLOOKUP;
FILE_KEY_CORRECTION_PROPID  := Files.FILE_KEY_CORRECTION_PROPID;
FILE_KEY_PERMIT_PROPID 			:= Files.FILE_KEY_PERMIT_PROPID;
FILE_KEY_INSPECTION_PERMITID:= Files.FILE_KEY_INSPECTION_PERMITID;
FILE_KEY_PERMITCONTRACTOR_PERMITID := Files.FILE_KEY_PERMITCONTRACTOR_PERMITID;
FILE_KEY_PERMIT_JURISDICTION:= Files.FILE_KEY_PERMIT_JURISDICTION;
SUFFIX_PROPERTY_ADDRESS			:= Files.SUFFIX_PROPERTY_ADDRESS;
SUFFIX_PROPERTY_ERR_ADDRESS	:= Files.SUFFIX_PROPERTY_ERR_ADDRESS;
SUFFIX_CORRECTION_PROPID    := Files.SUFFIX_CORRECTION_PROPID;
SUFFIX_PERMIT_PROPID    		:= Files.SUFFIX_PERMIT_PROPID;
SUFFIX_INSPECTION_PERMITID  := Files.SUFFIX_INSPECTION_PERMITID;
SUFFIX_PERMITCONTRACTOR_PERMITID := Files.SUFFIX_PERMITCONTRACTOR_PERMITID;
SUFFIX_PERMIT_JURISDICTION	:= Files.SUFFIX_PERMIT_JURISDICTION;

SFCreation									:= CreateSuperFiles();

// CONTRACTOR mbKey
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_Contractor, FILE_KEY_CONTRACTOR, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().contractor, bld_contractor);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_CONTRACTOR, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().contractor, mvb_contractor);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_CONTRACTOR, 'Q', mv_contractor);

contractKey      						:= SEQUENTIAL(bld_contractor, mvb_contractor, mv_contractor);

// Correction mbKey
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_Correction, FILE_KEY_CORRECTION, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().correction, bld_correction);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_CORRECTION, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().correction, mvb_correction);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_CORRECTION, 'Q', mv_correction);

correctionKey      					:= SEQUENTIAL(bld_correction, mvb_correction, mv_correction);

// Inspection mbKey
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_inspection, FILE_KEY_INSPECTION, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().inspection, bld_inspection);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_INSPECTION, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().inspection, mvb_inspection);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_INSPECTION, 'Q', mv_inspection);

inspectionKey      					:= SEQUENTIAL(bld_inspection, mvb_inspection, mv_inspection);

// Permit  mbKey
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_Permit, FILE_KEY_PERMIT, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().permit, bld_permit);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_PERMIT, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().permit, mvb_permit);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_PERMIT, 'Q', mv_permit);

permitKey      							:= SEQUENTIAL(bld_permit, mvb_permit, mv_permit);

// Property  mbKey
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_Property, FILE_KEY_PROPERTY, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().property, bld_property);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_PROPERTY, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().property, mvb_property);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_PROPERTY, 'Q', mv_property);

propertyKey      						:= SEQUENTIAL(bld_property, mvb_property, mv_property);

// permitcontractor  mbKey
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PermitContractor, FILE_KEY_PERMITCONTRACTOR, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().permitcontractor, bld_permitcontractor);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_PERMITCONTRACTOR, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().permitcontractor, mvb_permitcontractor);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_PERMITCONTRACTOR, 'Q', mv_permitcontractor);

permitcontractorKey      		:= SEQUENTIAL(bld_permitcontractor, mvb_permitcontractor, mv_permitcontractor);

// Property Address  mbKey
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_Property_Address, FILE_KEY_PROPERTY_ADDRESS, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_PROPERTY_ADDRESS, bld_propertyaddress);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_PROPERTY_ADDRESS, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_PROPERTY_ADDRESS, mvb_propertyaddress);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_PROPERTY_ADDRESS, 'Q', mv_propertyaddress);

propertyaddressKey      		:= SEQUENTIAL(bld_propertyaddress, mvb_propertyaddress, mv_propertyaddress);

// Property Error Address  mbKey
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_Property_Err_Address, FILE_KEY_PROPERTY_ERR_ADDRESS, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_PROPERTY_ERR_ADDRESS, bld_propertyerraddress);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_PROPERTY_ERR_ADDRESS, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_PROPERTY_ERR_ADDRESS, mvb_propertyerraddress);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_PROPERTY_ERR_ADDRESS, 'Q', mv_propertyerraddress);

propertyerraddressKey      		:= SEQUENTIAL(bld_propertyerraddress, mvb_propertyerraddress, mv_propertyerraddress);

AllPropertyKeys							:= SEQUENTIAL(propertyKey, propertyaddressKey, propertyerraddressKey);

// Jurisdiction Key
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_Jurisdiction, FILE_KEY_JURISDICTION, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().Jurisdiction, bld_Jurisdiction);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_JURISDICTION, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().Jurisdiction, mvb_Jurisdiction);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_JURISDICTION, 'Q', mv_Jurisdiction);

JurisdictionKey      				:= SEQUENTIAL(bld_Jurisdiction, mvb_Jurisdiction, mv_Jurisdiction);

// StreetLookup Key
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_StreetLookup, FILE_KEY_STREETLOOKUP, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().StreetLookup , bld_StreetLookup);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_STREETLOOKUP, KEY_PREFIX_NAME + '::' + build_date + '::' + Constants().StreetLookup , mvb_StreetLookup);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_STREETLOOKUP, 'Q', mv_StreetLookup );

StreetLookupKey      				:= SEQUENTIAL(bld_StreetLookup, mvb_StreetLookup, mv_StreetLookup);

// Correction PropertyID mbKey
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_Correction_PropertyID, FILE_KEY_CORRECTION_PROPID, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_CORRECTION_PROPID, bld_correction_propID);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_CORRECTION_PROPID, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_CORRECTION_PROPID, mvb_correction_propID);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_CORRECTION_PROPID, 'Q', mv_correction_propID);

correction_propIDKey      	:= SEQUENTIAL(bld_correction_propID, mvb_correction_propID, mv_correction_propID);

// Permit PropertyID mbKey
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_Permit_PropertyID, FILE_KEY_PERMIT_PROPID, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_PERMIT_PROPID, bld_permit_propID);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_PERMIT_PROPID, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_PERMIT_PROPID, mvb_permit_propID);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_PERMIT_PROPID, 'Q', mv_permit_propID);

permit_propIDKey      			:= SEQUENTIAL(bld_permit_propID, mvb_permit_propID, mv_permit_propID);

// permitcontractor PermitID mbKey
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PermitContractor_PermitID, FILE_KEY_PERMITCONTRACTOR_PERMITID, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_PERMITCONTRACTOR_PERMITID, 
                                           bld_permitcontractor_permit);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_PERMITCONTRACTOR_PERMITID, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_PERMITCONTRACTOR_PERMITID, mvb_permitcontractor_permit);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_PERMITCONTRACTOR_PERMITID, 'Q', mv_permitcontractor_permit);

permitcontractor_PermitIDKey:= SEQUENTIAL(bld_permitcontractor_permit, mvb_permitcontractor_permit, mv_permitcontractor_permit);

// Inspection Permit mbKey
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_inspection_PermitID, FILE_KEY_INSPECTION_PERMITID, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_INSPECTION_PERMITID, bld_inspection_permit);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_INSPECTION_PERMITID, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_INSPECTION_PERMITID, mvb_inspection_permit);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_INSPECTION_PERMITID, 'Q', mv_inspection_permit);

inspection_PermitIDKey      := SEQUENTIAL(bld_inspection_permit, mvb_inspection_permit, mv_inspection_permit);

// Permit Jurisdiction mbKey
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_Permit_Jurisdiction, FILE_KEY_PERMIT_JURISDICTION, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_PERMIT_JURISDICTION, bld_permit_Jurisdiction);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(FILE_KEY_PERMIT_JURISDICTION, KEY_PREFIX_NAME + '::' + build_date + '::' + SUFFIX_PERMIT_JURISDICTION, mvb_permit_Jurisdiction);
RoxieKeybuild.MAC_SK_Move_V2 (FILE_KEY_PERMIT_JURISDICTION, 'Q', mv_permit_Jurisdiction);

permit_JurisdictionKey      			:= SEQUENTIAL(bld_permit_Jurisdiction, mvb_permit_Jurisdiction, mv_permit_Jurisdiction);

AdditonalFiveKeys						:= SEQUENTIAL(correction_propIDKey, permit_propIDKey, permitcontractor_PermitIDKey, inspection_PermitIDKey, permit_JurisdictionKey);

AllKeys											:= SEQUENTIAL(SFCreation, contractKey, correctionKey, inspectionKey, permitKey, AllPropertyKeys, permitcontractorKey, 
                                          JurisdictionKey, StreetLookupKey, AdditonalFiveKeys);

return AllKeys;
END;

