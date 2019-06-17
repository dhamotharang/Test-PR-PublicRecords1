import STD,PRTE2, _control, PRTE, Data_Services, BIPV2, Equifax_Business_Data;

skipDOPS:= FALSE;
string emailTo:='';
dops_name := 'EquifaxBusinessDataKeys';

version :=(string8)STD.Date.CurrentDate(True);
pIndexVersion := version + '';

layout_linkids	:= RECORD
	BIPV2.IDlayouts.l_key_ids_bare;
	Equifax_Business_Data.layouts.base - {BIPV2.IDlayouts.l_xlink_ids};
end;

	ds_linkid			:= dataset([],layout_linkids);
	key_linkids		:= index(ds_linkid,	{ultid,orgid,seleid,proxid,powid,empid,dotid},{ds_linkid}, prte2.Constants.prefix + 'key::Equifax_Business_Data::'+pIndexVersion+'::linkids');

	//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:= PRTE.UpdateVersion(dops_name, pIndexVersion, notifyEmail,'B','N','N');
	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);
	//----------------------------------------------------------------
	
	
	build_keys := sequential(build(key_linkids, overwrite),PerformUpdateOrNot);

	build_keys;                       	
	output ('successful');