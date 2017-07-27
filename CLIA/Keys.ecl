IMPORT doxie, tools;

EXPORT Keys(STRING pversion = '',
	          DATASET(Layouts.Base) pBaseBuilt = Files(pversion).Base.Main.Built) := MODULE

	SHARED Base := PROJECT(pBaseBuilt(CLIA_Number != ''), Layouts.KeyBuild);
	SHARED Base_BDID := Base(BDID != 0);

	tools.mac_FilesIndex('Base, {CLIA_Number, record_type}, {Base}',
	                        KeyNames(pversion).CLIA_Number, CLIA_Number);
	tools.mac_FilesIndex('Base_BDID, {BDID, CLIA_Number}, {Base}',
	                        KeyNames(pversion).BDID, BDID);

END;