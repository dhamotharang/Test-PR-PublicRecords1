import tools;
export mInputFileVersions(pfilenameversions, pLayout, pOutput, pfiletype = '\'Flat\'') :=
macro

	export pOutput := tools.macf_FilesInput(pfilenameversions, pLayout, pfiletype) : DEPRECATED('Use tools.macf_FilesInput instead');

endmacro;
