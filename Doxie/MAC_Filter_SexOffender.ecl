export MAC_Filter_SexOffender(applicationType, recs, f_recs_out) :=
MACRO

	import doxie,AutoStandardI,codes;

	#uniquename(SORestrictions)
	%SORestrictions% := Codes.Key_Codes_V3(file_name='GENERAL',field_name='SEXOFFENDER-RESTRICTIONS',field_name2='');

	// Check if restrictions are supposed to be applied based on codes v3 configuration
	#uniquename(applyLERestrictions)
	%applyLERestrictions% := exists(%SORestrictions%(code=AutoStandardI.Constants.APPLICATION_TYPE_LE));
	
	#uniquename(appType)
	%appType% := TRIM(stringlib.StringToUpperCase(applicationType));

	// Checking for LE user:
	//	(1) Check ApplicationType if available (all ESP requests) 
	//	(2) Check DPM to account for cases where ApplicationType is not yet available (i.e. Batch services)
	#uniquename(isLE)
	%isLE% := doxie.DataPermission.use_LE or %appType%=AutoStandardI.Constants.APPLICATION_TYPE_LE;
	
	// Current SO restrictions: [01/19/2011]
	//	- Oregon SO data (C2ORP) should only be allowed for LE 
	f_recs_out := recs(~%applyLERestrictions% or %isLE% or seisint_primary_key[1..5]<>'C2ORP');
	
ENDMACRO;
