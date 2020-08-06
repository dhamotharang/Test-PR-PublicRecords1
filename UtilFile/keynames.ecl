IMPORT VersionControl,dx_utility, $;

EXPORT keynames(STRING filedate):= MODULE

//logical file names for key build
//full keys
  EXPORT i_address            := $.fn_getSubKeyName('address',filedate);
  EXPORT i_did                := $.fn_getSubKeyName('did',filedate);
  EXPORT i_linkids            := $.fn_getSubKeyName('linkids',filedate);
//daily keys	
  EXPORT i_did_daily             := $.fn_getSubKeyName('daily.did',filedate);
  EXPORT i_fdid_daily            := $.fn_getSubKeyName('daily.fid',filedate);
//daily auto keys	
	EXPORT i_auto_address         := $.fn_getSubKeyName('daily.address',filedate);	
  EXPORT i_auto_name            := $.fn_getSubKeyName('daily.name',filedate);
  EXPORT i_auto_phone           := $.fn_getSubKeyName('daily.phone',filedate);
	EXPORT i_auto_ssn             := $.fn_getSubKeyName('daily.ssn',filedate);
  EXPORT i_auto_stname          := $.fn_getSubKeyName('daily.stname',filedate);
	EXPORT i_auto_citystname      := $.fn_getSubKeyName('daily.citystname',filedate);
  EXPORT i_auto_zipprlname      := $.fn_getSubKeyName('daily.zipprlname',filedate);
	EXPORT i_auto_zip             := $.fn_getSubKeyName('daily.zip',filedate);
 
//all key filename versions

  EXPORT	address			  :=	VersionControl.mBuildFilenameVersions(dx_utility.names('').i_address,filedate,i_address);
	EXPORT	did					  :=	VersionControl.mBuildFilenameVersions(dx_utility.names('').i_did,filedate,i_did);
	EXPORT	linkIDs		    :=	VersionControl.mBuildFilenameVersions(dx_utility.names('').i_linkIDs,filedate,i_linkIDs);
	EXPORT	did_daily					:=	VersionControl.mBuildFilenameVersions(dx_utility.names('').i_did_daily,filedate,i_did_daily);
	EXPORT	fdid_daily				:=	VersionControl.mBuildFilenameVersions(dx_utility.names('').i_fdid_daily,filedate,i_fdid_daily);
	EXPORT	auto_address			:=	VersionControl.mBuildFilenameVersions($.fn_getSubKeyName('daily.address',''),filedate,i_auto_address);
	EXPORT	auto_name					:=	VersionControl.mBuildFilenameVersions($.fn_getSubKeyName('daily.name',''),filedate,i_auto_name);
	EXPORT	auto_ssn					:=	VersionControl.mBuildFilenameVersions($.fn_getSubKeyName('daily.ssn',''),filedate,i_auto_ssn);
	EXPORT	auto_phone				:=	VersionControl.mBuildFilenameVersions($.fn_getSubKeyName('daily.phone',''),filedate,i_auto_phone);
	EXPORT	auto_stname				:=	VersionControl.mBuildFilenameVersions($.fn_getSubKeyName('daily.stname',''),filedate,i_auto_stname);
	EXPORT  auto_citystname		:=	VersionControl.mBuildFilenameVersions($.fn_getSubKeyName('daily.citystname',''),filedate,i_auto_citystname);
	EXPORT	auto_zipprlname		:=	VersionControl.mBuildFilenameVersions($.fn_getSubKeyName('daily.zipprlname',''),filedate,i_auto_zipprlname);
	EXPORT	auto_zip		      :=	VersionControl.mBuildFilenameVersions($.fn_getSubKeyName('daily.zip',''),filedate,i_auto_zip);

	EXPORT	dAll_filenames				:=
		address.dAll_filenames
		+	did.dAll_filenames
		+	linkids.dAll_filenames
		+	did_daily.dAll_filenames
		+	fdid_daily.dAll_filenames
		+	auto_address.dAll_filenames
		+	auto_name.dAll_filenames
		+	auto_ssn.dAll_filenames
		+	auto_phone.dAll_filenames
		+	auto_stname.dAll_filenames
		+	auto_citystname.dAll_filenames
		+	auto_zipprlname.dAll_filenames
		+	auto_zip.dAll_filenames

	;

END;	
	