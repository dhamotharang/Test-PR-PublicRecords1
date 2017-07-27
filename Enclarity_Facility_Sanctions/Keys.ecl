import doxie, tools;

export Keys(string pversion = '',boolean pUseProd = false) := module

	shared facility_sanctions_base				:= Enclarity_facility_sanctions.Files(pversion,pUseProd).facility_sanctions_base.Built;
	shared facility_sanctions_base_lnfid	:= facility_sanctions_base(lnfid > 0);

	tools.mac_FilesIndex('facility_sanctions_base(lnfid>0)		,{lnfid			}	  ,{facility_sanctions_base_lnfid	}'	,enclarity_facility_sanctions.Keynames(pversion,pUseProd).facility_sanctions_lnfid,facility_sanctions_lnfid	 );
end;