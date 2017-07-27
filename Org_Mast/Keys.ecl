IMPORT doxie, tools;

EXPORT Keys(

	 string		pversion							= ''
	,boolean pUseProd = false

) :=
MODULE

	Export organization_Base			:= Files(pversion,pUseProd).organization_Base.Built;
	Export Relationship_Base			:= Files(pversion,pUseProd).Relationship_Base.Built;	
	Export Facilities_LNFID_Base				:= organization_Base((string)LNFID <> '');
	Export Relationship_ID1_Base				:= Relationship_Base((ID1 <> ''));
	Export Relationship_ID1Type		:= Relationship_Base((ID1Type <> ''));
	Export Relationship_Key1			:= Relationship_Base((ID1 <> '') and (ID1Type <> ''));
	Export Relationship_ID2_Base				:= Relationship_Base((ID2 <> ''));
	Export Relationship_ID2Type		:= Relationship_Base((ID2Type <> ''));
	Export Relationship_Key2			:= Relationship_Base((ID2 <> '') and (ID2Type <> ''));
	

	tools.mac_FilesIndex('organization_Base		,{LNFID	}	  ,{Facilities_LNFID_Base	}'	,keynames(pversion,pUseProd).Facilities_LNFID_key		,Facilities_LNFID	 );
	tools.mac_FilesIndex('Relationship_Base		,{ID1	}	  ,{Relationship_ID1_Base	}'	,keynames(pversion,pUseProd).Relationship_ID1_key		,Relationship_ID1	 );
	tools.mac_FilesIndex('Relationship_Base		,{ID1type	}	  ,{Relationship_ID1Type}',keynames(pversion,pUseProd).Relationship_ID1Type_key		,Relationship_ID1Type_key );
	tools.mac_FilesIndex('Relationship_Base		,{ID2	}	  ,{Relationship_ID2_Base	}'	,keynames(pversion,pUseProd).Relationship_ID2_key		,Relationship_ID2	 );
	tools.mac_FilesIndex('Relationship_Base		,{ID2type	}	  ,{Relationship_ID2Type}',keynames(pversion,pUseProd).Relationship_ID2Type_key		,Relationship_ID2Type_key );
	
	
	tools.mac_FilesIndex('Relationship_Base		,{ID1,ID1type	}	  ,{Relationship_Key1	}'	,keynames(pversion,pUseProd).Relationship_ID1_ID1type		,Affiliates_Key1	 );
	tools.mac_FilesIndex('Relationship_Base		,{ID2,ID2type	}	  ,{Relationship_Key2	}'	,keynames(pversion,pUseProd).Relationship_ID2_ID2type		,Affiliates_Key2	 );
	
END;
