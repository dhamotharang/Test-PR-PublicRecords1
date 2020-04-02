IMPORT Std, VersionControl;

EXPORT BuildKeys(string pversion=(string8)Std.Date.Today()) := function

	VersionControl.macBuildNewLogicalKeyWithName(Cortera.Key_LinkIds.Key,	Cortera.keynames(pversion,false).LinkIds.New, BuildLinkIdsKey,,,,false);
	VersionControl.macBuildNewLogicalKeyWithName(Cortera.Key_Header_Link_Id,	Cortera.keynames(pversion,false).Hdr_Link_Id.New, BuildHdrKey,,,,false);
	VersionControl.macBuildNewLogicalKeyWithName(Cortera.Key_Attributes_Link_Id,	Cortera.keynames(pversion,false).Attr_Link_Id.New, BuildAttrKey,,,,false);
	VersionControl.macBuildNewLogicalKeyWithName(Cortera.Key_Executive_did,	Cortera.keynames(pversion,false).Executive_Did.New, BuildExecutiveDidKey,,,,false);
	
	return SEQUENTIAL(
			PARALLEL(
				BuildLinkIdsKey,
				BuildHdrKey,
				BuildAttrKey,
				BuildExecutiveDidKey
			),
			Cortera.Promote(pversion).BuildFiles.New2Built,
			Cortera.Promote().Buildfiles.Built2QA
	);
end;