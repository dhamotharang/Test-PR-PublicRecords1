import ut,RoxieKeyBuild;

export proc_build_bid_key(string filedate) :=
function


//---- Start of New code for standardizing the key names
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(dea.Key_dea_did_bid,'~thor_data400::key::dea::@version@::bid::did','~thor_data400::key::dea::' + filedate + '::bid::did',b);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(dea.Key_dea_bid,'~thor_data400::key::dea::@version@::bid','~thor_data400::key::dea::' + filedate + '::bid',c);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(dea.Key_dea_reg_num_bid,'~thor_data400::key::dea::@version@::bid::reg_num','~thor_data400::key::dea::' + filedate + '::bid::reg_num',e);


RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~thor_data400::key::dea::@version@::bid::did','~thor_data400::key::dea::' + filedate + '::bid::did', b1);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~thor_data400::key::dea::@version@::bid','~thor_data400::key::dea::' + filedate + '::bid', c1);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~thor_data400::key::dea::@version@::bid::reg_num','~thor_data400::key::dea::' + filedate + '::bid::reg_num', e1);

RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dea::@version@::bid::did', 'Q', b2);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dea::@version@::bid', 'Q', c2);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dea::@version@::bid::reg_num', 'Q', e2);
// --- end of new code

ak := dea.proc_build_bid_autokeys(filedate);
	
return sequential(b,c,e,b1,c1,e1,b2,c2,e2,ak);

end;
