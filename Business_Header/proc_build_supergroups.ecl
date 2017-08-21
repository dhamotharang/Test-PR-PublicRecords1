import ut, RoxieKeyBuild;

NewName		:= keynames.NewConvention;
OldName		:= keynames.OldConvention;

//f := dataset('TEMP::BH_Super_Group', Business_Header.Layout_BH_Super_Group, flat);

// Build the base Super Group file
ut.MAC_SF_BuildProcess(/* f */Business_Header.BH_Super_Group,'~thor_data400::BASE::BH_Super_Group',basefile,3)


// Build the BDID and group_id keys
k1 := index(Business_Header.File_Super_Group,{group_id},{bdid},OldName.Supergroup.Groupid.Root);
k2 := index(Business_Header.File_Super_Group,{bdid},{group_id},OldName.Supergroup.Bdid.Root);

RoxieKeyBuild.Mac_SK_BuildProcess_Local(k1	,NewName.Supergroup.Groupid.New	,'',Build_Key1);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(k2	,NewName.Supergroup.Bdid.New	,'',Build_Key2);

Build_Keys :=
sequential(
	 Build_Key1
	,Build_Key2
);

RoxieKeyBuild.Mac_SK_Move_To_Built(NewName.Supergroup.Groupid.New	,OldName.Supergroup.Groupid.Root	,MoveKeyToBuilt1);
RoxieKeyBuild.Mac_SK_Move_To_Built(NewName.Supergroup.Bdid.New		,OldName.Supergroup.Bdid.Root		,MoveKeyToBuilt2);

Move_Keys_To_Built :=
sequential(
	 MoveKeyToBuilt1
	,MoveKeyToBuilt2
);  

export proc_build_supergroups := 
sequential(
	 basefile
	,Build_Keys
	,Move_Keys_To_Built
);