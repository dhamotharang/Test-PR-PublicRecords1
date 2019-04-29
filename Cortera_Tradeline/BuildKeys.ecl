IMPORT Std, VersionControl;

EXPORT BuildKeys(string pversion=(string8)Std.Date.Today()) := function

	VersionControl.macBuildNewLogicalKeyWithName(Cortera_Tradeline.Key_LinkIds.Key,	Cortera_Tradeline.keynames(pversion,false).LinkIds.New, BuildLinkIdsKey,,,,false);
	VersionControl.macBuildNewLogicalKeyWithName(Cortera_Tradeline.Key_Header_Link_Id,	Cortera_Tradeline.keynames(pversion,false).Tradeline_Link_Id.New, BuildHdrKey,,,,false);
	
	return SEQUENTIAL(
			PARALLEL(
				BuildLinkIdsKey,
				BuildHdrKey
			),
			$.Promote(pversion).BuildFiles.New2Built,
			$.Promote().Buildfiles.Built2QA
	);
end;