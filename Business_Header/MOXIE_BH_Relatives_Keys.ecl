import Business_Header,Lib_KeyLib, versioncontrol;

export MOXIE_BH_Relatives_Keys(

	string pversion

) := 
function

	shared h := Business_Header.File_Business_Relatives_Keybuild;

	shared MyFields := record
			h.bdid1;            // Seisint Business Identifier
		h.name_address;
		h.corp_charter_number;
		h.fbn_filing;
		h.fein;
		h.phone;
		h.bankruptcy_filing;
		h.__filepos;
	end;
		
	shared bdid1_records := table(h(bdid1 <> ''), MyFields);

	shared key1 := INDEX( bdid1_records, {bdid1,name_address,corp_charter_number,fbn_filing,fein,
								phone,bankruptcy_filing,(big_endian unsigned8 )__filepos},
				Business_Header.Base_Key_Name_Relatives + 'bdid1.name_address.corp_charter_number.fbn_filing.fein.phone.bankruptcy_filing.key');

	shared unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
		if (filepos<headersize, rawsize+filepos, filepos);

	shared rawsize := sizeof(Business_Header.Layout_Business_Relatives_Out) * count(h) : global;
	shared headersize := sizeof(Business_Header.Layout_Business_Relatives_Out) : global;

	shared key2 := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},Business_Header.Base_Key_Name_Relatives + 'fpos.data.key');

	shared names := Moxie_Keynames(pversion).Business_Relatives;

	versioncontrol.macBuildNewLogicalKeyWithName(key1		,names.key1.new	,BuildKey1	,,,true);
	versioncontrol.macBuildNewLogicalKeyWithName(key2		,names.key2.new	,BuildKey2	,,,true);

	return 
		if(not VersionControl.DoAllFilesExist.fNamesBuilds(names.dAll_filenames)
			,parallel(Buildkey1,Buildkey2)
		);

end;
