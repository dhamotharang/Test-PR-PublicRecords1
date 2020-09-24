IMPORT RoxieKeybuild,autokey,dx_utility,$;
EXPORT	proc_build_keys(STRING	filedate, BOOLEAN isDelta = FALSE)	:=	FUNCTION
names			:=	$.keynames(filedate);
//below autokey attributes only used to build keys but not used by queries, so they are not included in Dx module.
key_daily_address := INDEX({autokey.layout_address},names.auto_address.qa);
key_daily_name := INDEX(autokey.layout_name, names.auto_name.qa);
key_daily_phone := INDEX (autokey.layout_phone, names.auto_phone.qa);
key_daily_CityStName := INDEX (autokey.layout_CityStName, names.auto_citystname.qa);
key_daily_StName := INDEX (autokey.layout_StName, names.auto_stname.qa);
key_daily_zip := INDEX (autokey.layout_zip, names.auto_zip.qa);
key_daily_ZipPRLName := INDEX(autokey.Layout_ZipPRLName, names.auto_zipprlname.qa);
//build keys
RoxieKeybuild.MAC_build_logical(dx_utility.key_daily_did, $.data_key(filedate, isDelta).i_DID_daily, '', names.did_daily.new, bk_did_daily);
RoxieKeybuild.MAC_build_logical(dx_utility.key_did, $.data_key(filedate, isDelta).i_DID, '', names.did.new,   bk_did);
RoxieKeybuild.MAC_build_logical(dx_utility.key_daily_fdid, $.data_key(filedate, isDelta).i_fdid_daily, '', names.fdid_daily.new,   bk_fdid_daily);
RoxieKeybuild.MAC_build_logical(dx_utility.key_address, $.data_key(filedate, isDelta).i_address, '',  names.address.new, bk_address);
RoxieKeybuild.MAC_build_logical(key_daily_address, $.data_key(filedate, isDelta).i_auto_address, '',  names.auto_address.new, bk_auto_address);
RoxieKeybuild.MAC_build_logical(key_daily_name, $.data_key(filedate, isDelta).i_auto_name, '',  names.auto_name.new, bk_auto_name);
RoxieKeybuild.MAC_build_logical(dx_utility.key_daily_ssn, $.data_key(filedate, isDelta).i_auto_ssn, '',  names.auto_ssn.new, bk_auto_ssn);
RoxieKeybuild.MAC_build_logical(key_daily_phone, $.data_key(filedate, isDelta).i_auto_phone, '',  names.auto_phone.new, bk_auto_phone);
RoxieKeybuild.MAC_build_logical(key_daily_citystname, $.data_key(filedate, isDelta).i_auto_citystname, '',  names.auto_citystname.new, bk_auto_citystname);
RoxieKeybuild.MAC_build_logical(key_daily_stname, $.data_key(filedate, isDelta).i_auto_stname, '',  names.auto_stname.new, bk_auto_stname);
RoxieKeybuild.MAC_build_logical(key_daily_zip, $.data_key(filedate, isDelta).i_auto_zip, '',  names.auto_zip.new, bk_auto_zip);
RoxieKeybuild.MAC_build_logical(key_daily_zipprlname, $.data_key(filedate, isDelta).i_auto_zipprlname, '', names.auto_zipprlname.new, bk_auto_zipprlname);
RoxieKeybuild.MAC_build_logical(dx_utility.key_linkIDs.key, $.data_key(filedate, isDelta).i_LinkIDs, '', names.linkIDs.new,   bk_linkIDs);

 return sequential( parallel(
	bk_did_daily,
	bk_did,
	bk_address,
	bk_fdid_daily,
	bk_auto_address,
	bk_auto_name,
	bk_auto_ssn,
	bk_auto_phone,
	bk_auto_citystname,
	bk_auto_stname,
	bk_auto_zip,
	bk_auto_zipprlname,
	bk_linkIDs),
$.Promote_keys(filedate,'key',pIsDeltaBuild:=isDelta).BuildFiles.New2Built,
$.Promote_keys(filedate,'key',pIsDeltaBuild:=isDelta).BuildFiles.Built2QA);

END;



	

	
	
	
	
	