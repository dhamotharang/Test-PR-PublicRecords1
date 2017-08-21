import Business_Header,Lib_KeyLib, versioncontrol;

export MOXIE_BRG_KEYS(

	string pversion

) := 
function
	shared names := Moxie_Keynames(pversion).Business_Relatives_Group;

	shared h := distribute(File_Business_Relatives_Group_Keybuild, random());

	shared MyFields := record
		h.bdid;            // Seisint Business Identifier
		h.__filepos;
	end;
		
	shared bdid_records			:= table(h(bdid 		<> ''), MyFields);

	shared MyFields2 := record
		h.group_id;
		h.__filepos;
	end;

	shared group_id_records := table(h(group_id <> ''), MyFields2);

	/////////////////////////////////////////////////			
	// FPOS DATA KEY	
	/////////////////////////////////////////////////			
	shared unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
		if (filepos<headersize, rawsize+filepos, filepos);

	shared rawsize		:= sizeof(Layout_Business_Relatives_Group_Out) * count(h) : global;
	shared headersize := sizeof(Layout_Business_Relatives_Group_Out) : global;

	shared key1 := INDEX( bdid_records		, {bdid			,(big_endian unsigned8 )__filepos},names.key1.template);
	shared key2 := INDEX( group_id_records, {group_id	,(big_endian unsigned8 )__filepos},names.key2.template);
	shared key3 := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h}			,names.key3.template);

	versioncontrol.macBuildNewLogicalKeyWithName(key1		,names.key1.new	,BuildKey1	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key2		,names.key2.new	,BuildKey2	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key3		,names.key3.new	,BuildKey3	,,,true);

	return 
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(names.dAll_filenames)
		,parallel(
			 Buildkey1
			,Buildkey2
			,Buildkey3
		)
	);
			
end;