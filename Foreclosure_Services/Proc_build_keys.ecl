import ut, roxiekeybuild, autokeyb2,property;

export proc_build_keys(string filedate) := function


//---- Start of New code for standardizing the key names

if(fileservices.superfileexists('~thor_data400::key::foreclosure::built::fid'),
					FileServices.ClearSuperfile('~thor_data400::key::foreclosure::built::fid'),fileservices.createsuperfile('~thor_data400::key::foreclosure::built::fid'));
if(fileservices.superfileexists('~thor_data400::key::foreclosure::built::did'),
					FileServices.ClearSuperfile('~thor_data400::key::foreclosure::built::did'),fileservices.createsuperfile('~thor_data400::key::foreclosure::built::did'));
if(fileservices.superfileexists('~thor_data400::key::foreclosure::built::bdid'),
					FileServices.ClearSuperfile('~thor_data400::key::foreclosure::built::bdid'),fileservices.createsuperfile('~thor_data400::key::foreclosure::built::bdid'));					

if(fileservices.superfileexists('~thor_data400::key::foreclosure::qa::fid'),
					FileServices.ClearSuperfile('~thor_data400::key::foreclosure::qa::fid'),fileservices.createsuperfile('~thor_data400::key::foreclosure::qa::fid'));
if(fileservices.superfileexists('~thor_data400::key::foreclosure::qa::did'),
					FileServices.ClearSuperfile('~thor_data400::key::foreclosure::qa::did'),fileservices.createsuperfile('~thor_data400::key::foreclosure::qa::did'));
if(fileservices.superfileexists('~thor_data400::key::foreclosure::qa::bdid'),
					FileServices.ClearSuperfile('~thor_data400::key::foreclosure::qa::bdid'),fileservices.createsuperfile('~thor_data400::key::foreclosure::qa::bdid'));					

if(fileservices.superfileexists('~thor_data400::key::foreclosure::built::fid'),
					FileServices.ClearSuperfile('~thor_data400::key::foreclosure::built::fid'),fileservices.createsuperfile('~thor_data400::key::foreclosure::built::fid'));
if(fileservices.superfileexists('~thor_data400::key::foreclosure::built::did'),
					FileServices.ClearSuperfile('~thor_data400::key::foreclosure::built::did'),fileservices.createsuperfile('~thor_data400::key::foreclosure::built::did'));
if(fileservices.superfileexists('~thor_data400::key::foreclosure::built::bdid'),
					FileServices.ClearSuperfile('~thor_data400::key::foreclosure::built::bdid'),fileservices.createsuperfile('~thor_data400::key::foreclosure::built::bdid'));					

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Property.Key_Foreclosures_FID,'~thor_data400::key::foreclosure::@version@::fid','~thor_data400::key::foreclosure::' + filedate + '::fid',a);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Property.Key_Foreclosure_DID,'~thor_data400::key::foreclosure::@version@::did','~thor_data400::key::foreclosure::' + filedate + '::did',b);
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Property.Key_Foreclosures_BDID,'~thor_data400::key::foreclosure::@version@::bdid','~thor_data400::key::foreclosure::' + filedate + '::bdid',c);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~thor_data400::key::foreclosure::@version@::did','~thor_data400::key::foreclosure::' + filedate + '::did', b1);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~thor_data400::key::foreclosure::@version@::bdid','~thor_data400::key::foreclosure::' + filedate + '::bdid', c1);
RoxieKeyBuild.MAC_SK_Move_To_Built_V2('~thor_data400::key::foreclosure::@version@::fid','~thor_data400::key::foreclosure::' + filedate + '::fid', a1);

RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::foreclosure::@version@::did', 'Q', b2);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::foreclosure::@version@::bdid', 'Q', c2);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::foreclosure::@version@::fid', 'Q', a2);

// --- end of new code

// d := sequential(
		// fileservices.startsuperfiletransaction(),
		// fileservices.clearsuperfile('~thor_data400::base::foreclosure::BUILT'),
		// fileservices.addsuperfile('~thor_data400::base::foreclosure::BUILT','~thor_data400::persist::file_foreclosure_building',0,true),
		// fileservices.clearsuperfile('~thor_Data400::base::dea_BUILDING'),
		// fileservices.finishsuperfiletransaction()
		// );

ak := Foreclosure_Services.proc_build_autokeys(filedate);
	
return sequential(a,b,c,a1,b1,c1,a2,b2,c2,ak);
// if (fileservices.getsuperfilesubname('~thor_data400::base::foreclosure',1) = fileservices.getsuperfilesubname('~thor_data400::base::dea_BUILT',1),
		// output('BASE = BUILT, Nothing done.'),
		// sequential(a,b,c,a1,b1,c1,a2,b2,c2,ak,d));


end;