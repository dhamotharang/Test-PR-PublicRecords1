
IMPORT tools;

EXPORT Keynames(

	 string		pversion							= '',
   boolean pUseProd = false

) := MODULE
	EXPORT Org_Mast_lFileTemplate				:= _Dataset(pUseProd).thor_cluster_files+ 'key::'	+ _Dataset().name + '::Org_Mast::@version@::'	;
	EXPORT Relationship_lFileTemplate		:= _Dataset(pUseProd).thor_cluster_files+ 'key::'	+ _Dataset().name + '::Relationship::@version@::'	;	

	SHARED Facilities_lLNFID_key				:= Org_Mast_lFileTemplate + 'Facility_lnfid';
	EXPORT Facilities_LNFID_key					:= tools.mod_FilenamesBuild(Facilities_lLNFID_key	,pversion);
	EXPORT Facilities_LNFID_dAll_filenames:= Facilities_LNFID_key.dAll_filenames;
	
	SHARED Relationship_lID1_key			:= Relationship_lFileTemplate + 'ID1';
	EXPORT Relationship_ID1_key				:= tools.mod_FilenamesBuild(Relationship_lID1_key	,pversion);
	EXPORT Relationship_ID1_dAll_filenames:= Relationship_ID1_key.dAll_filenames;
	
	SHARED Relationship_lID2_key			:= Relationship_lFileTemplate + 'ID2';
	EXPORT Relationship_ID2_key				:= tools.mod_FilenamesBuild(Relationship_lID2_key	,pversion);
	EXPORT Relationship_ID2_dAll_filenames:= Relationship_ID2_key.dAll_filenames;
	
	SHARED Relationship_lID1Type_key			:= Relationship_lFileTemplate + 'ID1Type';
	EXPORT Relationship_ID1Type_key				:= tools.mod_FilenamesBuild(Relationship_lID1Type_key	,pversion);
	EXPORT Relationship_ID1Type_dAll_filenames:= Relationship_ID1Type_key.dAll_filenames;
	
	SHARED Relationship_lID2Type_key			:= Relationship_lFileTemplate + 'ID2Type';
	EXPORT Relationship_ID2Type_key				:= tools.mod_FilenamesBuild(Relationship_lID2Type_key	,pversion);
	EXPORT Relationship_ID2Type_dAll_filenames:= Relationship_ID2Type_key.dAll_filenames;

	// EXPORT Relationship_Key1	:= Relationship_ID1_key.dAll_filenames + Relationship_ID1Type_key.dAll_filenames;
	// EXPORT Relationship_Key2	:= Relationship_ID2_key.dAll_filenames + Relationship_ID2Type_key.dAll_filenames;	
	
	EXPORT LNFID_key	:= Facilities_LNFID_key.dAll_filenames;
	
	SHARED Relationship_lID1_ID1type	:= Relationship_lFileTemplate + 'Key1';
	EXPORT Relationship_ID1_ID1type	:= tools.mod_FilenamesBuild(Relationship_lID1_ID1type, pversion);
	EXPORT Relationship_Key1_dAll_filenames	:= Relationship_ID1_ID1type.dAll_filenames;
	
	SHARED Relationship_lID2_ID2type	:= Relationship_lFileTemplate + 'Key2';
	EXPORT Relationship_ID2_ID2type	:= tools.mod_FilenamesBuild(Relationship_lID2_ID2type, pversion);
	EXPORT Relationship_Key2_dAll_filenames	:= Relationship_ID2_ID2type.dAll_filenames;
	


END;	
