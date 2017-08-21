import Business_Header,Lib_KeyLib, versioncontrol;

export MOXIE_BH_Stats_Keys(

	string pversion

) := 
function

	shared h := Business_Header.File_Business_Header_Stats_Keybuild;

	shared MyFields := record
			h.bdid;            // Seisint Business Identifier
		h.__filepos;
	end;
		
	shared bdid_records := table(h(bdid <> ''), MyFields);

	shared key1 := INDEX( bdid_records, {bdid,(big_endian unsigned8 )__filepos},
				Business_Header.Base_Key_Name_Header_Stat + 'bdid.key');

	/////////////////////////////////////////////////			
	// FPOS DATA KEY	
	/////////////////////////////////////////////////			
	shared unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
		if (filepos<headersize, rawsize+filepos, filepos);

	shared rawsize := sizeof(Business_Header.Layout_Business_Header_Stat_Out) * count(h) : global;
	shared headersize := sizeof(Business_Header.Layout_Business_Header_Stat_Out) : global;

	shared Key2 := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},Business_Header.Base_Key_Name_Header_Stat + 'fpos.data.key');

	shared names := Moxie_Keynames(pversion).Business_Stat;

	versioncontrol.macBuildNewLogicalKeyWithName(key1		,names.key1.new	,BuildKey1	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key2		,names.key2.new	,BuildKey2	,,,true);

	return
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(names.dAll_filenames)
		,parallel(Buildkey1,Buildkey2)
	);

end;