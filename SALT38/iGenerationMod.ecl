// Declare machine-readable versions of the spec file and subsets thereof,
// to be generated as GenerationMod in each module
EXPORT iGenerationMod := INTERFACE
 
  // SALT Version info
  EXPORT STRING salt_VERSION := ''; // e.g. 'V3.8.1'
  EXPORT STRING salt_MODULE := ''; // e.g. 'SALT38'
  EXPORT STRING salt_TOOLSMODULE := '';	// e.g. 'SALTTOOLS30'
 
  // Core module configuration values
  EXPORT STRING spc_MODULE := ''; // e.g. 'SALT_Test'
  EXPORT STRING spc_NAMESCOPE := '';
  EXPORT STRING spc_PROCESS := '';
  EXPORT STRING spc_IDNAME := ''; // e.g. 'BDID'
  EXPORT STRING spc_IDFIELD := ''; // e.g. 'BDID'
  EXPORT STRING spc_RIDFIELD := ''; // e.g. 'rcid'
	EXPORT STRING spc_CONFIG := '';
	EXPORT STRING spc_FILEPREFIX := ''; // e.g. 'In_', 'File_'
	EXPORT STRING spc_FILENAME := ''; // e.g. 'Sample'
	EXPORT STRING spc_INGESTSTATUS := '';
	EXPORT BOOLEAN spc_HAS_TWOSTEP := FALSE;
	EXPORT BOOLEAN spc_HAS_PARTITION := FALSE;
	EXPORT BOOLEAN spc_HAS_FIELDTYPES := FALSE;
	EXPORT BOOLEAN spc_HAS_INCREMENTAL := FALSE;
	EXPORT BOOLEAN spc_HAS_ASOF := FALSE;
	EXPORT BOOLEAN spc_HAS_NONCONTIGUOUS := FALSE;
	EXPORT BOOLEAN spc_HAS_SUPERFILES := FALSE;
	
END;
