import	_control,ut,avm_v2;

export	Proc_Build_AVMV2_Keys(string	pIndexVersion)	:=
function
	vThorEnvCluster	:=	if(	ut.fnTrim2Upper(_control.ThisEnvironment.Name)	=	'DATALAND',
													ut.foreign_prod	+	'thor_data400',
													'~thor_data400'
												)	:	global;
	
	// Get the logical file name from the super key names
	vAVMAddressKeyName	:=	FileServices.SuperFileContents(vThorEnvCluster	+	'::key::avm_v2::qa::address')[1].name;
	vAVMAPNKeyName			:=	FileServices.SuperFileContents(vThorEnvCluster	+	'::key::avm_v2::qa::apn')[1].name;
	vAVMCompFIDKeyName	:=	FileServices.SuperFileContents(vThorEnvCluster	+	'::key::avm_v2::qa::comp_fid')[1].name;
	vAVMMedianKeyName		:=	FileServices.SuperFileContents(vThorEnvCluster	+	'::key::avm_v2::qa::medians')[1].name;
	
	// Function to replace the cluster name
	fnReplaceThorEnvCluster(string	pLogicalKeyName)	:=	regexreplace('thor_data400',pLogicalKeyName,vThorEnvCluster,nocase);
	
	// Find the index for "~"
	fnFindTilde(string	pStr)	:=	StringLib.StringFind(pStr,'~',1);
	
	// Replace the cluster names for all the AVM keys
	vAddressKeyName	:=	fnReplaceThorEnvCluster(vAVMAddressKeyName);
	vAPNKeyName			:=	fnReplaceThorEnvCluster(vAVMAPNKeyName);
	vCompFidKeyName	:=	fnReplaceThorEnvCluster(vAVMCompFIDKeyName);
	vMedianKeyName	:=	fnReplaceThorEnvCluster(vAVMMedianKeyName);
	
	// Find the tilde index for all the AVM keys
	vAddressTildeIndex	:=	fnFindTilde(vAddressKeyName);
	vAPNTildeIndex			:=	fnFindTilde(vAPNKeyName);
	vCompFidTildeIndex	:=	fnFindTilde(vCompFidKeyName);
	vMedianTildeIndex		:=	fnFindTilde(vMedianKeyName);
	
	// cpyAddressKey	:=	FileServices.Copy(vAddressKeyName[vAddressTildeIndex..],_control.TargetGroup.ADL_400,'~prte::key::avm_v2::'	+	pIndexVersion	+	'::address');
	// cpyAPNKey			:=	FileServices.Copy(vAPNKeyName[vAPNTildeIndex..],_control.TargetGroup.ADL_400,'~prte::key::avm_v2::'	+	pIndexVersion	+	'::apn');
	// cpyCompFidKey	:=	FileServices.Copy(vCompFidKeyName[vCompFidTildeIndex..],_control.TargetGroup.ADL_400,'~prte::key::avm_v2::'	+	pIndexVersion	+	'::comp_fid');
	// cpyMediansKey	:=	FileServices.Copy(vMedianKeyName[vMedianTildeIndex..],_control.TargetGroup.ADL_400,'~prte::key::avm_v2::'	+	pIndexVersion	+	'::medians');
	
	//Key Record Structure
	rKeyAVM_Address	:= record
		string28 prim_name;
		string2 st;
		string5 zip;
		string10 prim_range;
		string8 sec_range;
		avm_v2.layouts.layout_base_with_history;
	end;
	
	rKeyAVM_APN			:= record
		string45 unformatted_apn;
		avm_v2.layouts.layout_base_with_history;
	end;
	
	rKeyAVM_CompFid	:= record
		avm_v2.layouts.layout_hedonic_base;
	end;
	
	rKeyAVM_Medians	:= record
		string12 fips_geo_12;
		avm_v2.layouts.layout_medians_with_history;
	end;
	
	//Key index
	kKeyAVM_Address	:= index(dataset([],rKeyAVM_Address),{prim_name, st, zip, prim_range, sec_range},{dataset([],rKeyAVM_Address)},'~prte::key::avm_v2::'	+	pIndexVersion	+	'::address');
	kKeyAVM_APN			:= index(dataset([],rKeyAVM_APN),{unformatted_apn},{dataset([],rKeyAVM_APN)},'~prte::key::avm_v2::'	+	pIndexVersion	+	'::apn');
	kKeyAVM_CompFid	:= index(dataset([],rKeyAVM_CompFid),{ln_fares_id},{dataset([],rKeyAVM_CompFid)},'~prte::key::avm_v2::'	+	pIndexVersion	+	'::comp_fid');
	kKeyAVM_Medians	:= index(dataset([],rKeyAVM_Medians),{fips_geo_12},{dataset([],rKeyAVM_Medians)},'~prte::key::avm_v2::'	+	pIndexVersion	+	'::medians');
	
	//FCRA
	kKeyAVM_Address_FCRA	:= index(dataset([],rKeyAVM_Address),{prim_name, st, zip, prim_range, sec_range},{dataset([],rKeyAVM_Address)},'~prte::key::avm_v2::fcra::'	+	pIndexVersion	+	'::address');
	kKeyAVM_Medians_FCRA	:= index(dataset([],rKeyAVM_Medians),{fips_geo_12},{dataset([],rKeyAVM_Medians)},'~prte::key::avm_v2::fcra::'	+	pIndexVersion	+	'::medians');
	
	return	sequential(	parallel(	build(kKeyAVM_Address, update),
																build(kKeyAVM_APN, update),
																build(kKeyAVM_CompFid, update),
																build(kKeyAVM_Medians, update),
																build(kKeyAVM_Address_FCRA, update),
																build(kKeyAVM_Medians_FCRA, update)
															),
											PRTE.UpdateVersion(	'AVMV2Keys',												//	Package name
																					pIndexVersion,											//	Package version
																					_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																					'B',																//	B = Boca,A = Alpharetta
																					'N',																//	N = Non-FCRA,F = FCRA
																					'N'																	//	N = Do not also include boolean,Y = Include boolean too
																				),
											PRTE.UpdateVersion(	'FCRA_AVMV2Keys',												//	Package name
																					pIndexVersion,											//	Package version
																					_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																					'B',																//	B = Boca,A = Alpharetta
																					'F',																//	N = Non-FCRA,F = FCRA
																					'N'																	//	N = Do not also include boolean,Y = Include boolean too
																				)
										);

end;