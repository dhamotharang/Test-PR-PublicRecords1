Import Data_Services, doxie_files, doxie,ut,SANCTN_Mari, BIPV2;

// DEFINE THE INDEX
  f_sanctn_party		:= SANCTN_Mari.files_SANCTN_common.party_bip;

KeyName 			:= 'thor_data400::key::sanctn::np::';

layout_party_srch := RECORD
	SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_srch;
	string26 midex_rpt_nbr;
	BIPV2.IDlayouts.l_xlink_ids;
END;

dsParty := project(f_sanctn_party,transform(layout_party_srch,
																	self.party_key := (string)left.party_key;
																	temp_party_nbr := if(trim(left.PARTY_NUM) = '000','0',left.PARTY_NUM); 
																	self.midex_rpt_nbr := StringLib.StringCleanSpaces(trim(left.BATCH) + '-'
																																										+ trim(left.INCIDENT_NUM) + '-' 
																																										+ trim(temp_party_nbr));
																	self:=left));


export key_MIDEX_RPT_NBR := index(dsParty
																	,{midex_rpt_nbr}
																	,{dsParty}
																	,Data_Services.Data_location.Prefix('sanctn')+KeyName +doxie.Version_SuperKey+ '::midex_rpt_nbr');


