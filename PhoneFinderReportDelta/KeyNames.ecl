IMPORT VersionControl,std,$;

EXPORT Keynames(STRING version	=	(STRING8)Std.Date.Today())	:=	MODULE
  
	//all key filename versions
  EXPORT	identities		                  :=	VersionControl.mBuildFilenameVersions($.names('').i_identities,version,$.names().i_identities);
  EXPORT	identities_lexid	              :=	VersionControl.mBuildFilenameVersions($.names('').i_identities_lexid,version,$.names().i_identities_lexid);
	EXPORT	otherphones		                  :=	VersionControl.mBuildFilenameVersions($.names('').i_otherphones,version,$.names().i_otherphones);
	EXPORT	riskindicators					        :=	VersionControl.mBuildFilenameVersions($.names('').i_riskindicators,version,$.names().i_riskindicators);
	EXPORT	transactions				            :=	VersionControl.mBuildFilenameVersions($.names('').i_transactions,version,$.names().i_transactions);
	EXPORT	transactions_companyid			    :=	VersionControl.mBuildFilenameVersions($.names('').i_transactions_companyid,version,$.names().i_transactions_companyid);
	EXPORT	transactions_companyrefcode			:=	VersionControl.mBuildFilenameVersions($.names('').i_transactions_companyrefcode,version,$.names().i_transactions_companyrefcode);
	EXPORT	transactions_date					      :=	VersionControl.mBuildFilenameVersions($.names('').i_transactions_date,version,$.names().i_transactions_date);
	EXPORT	transactions_phone				      :=	VersionControl.mBuildFilenameVersions($.names('').i_transactions_phone,version,$.names().i_transactions_phone);
	EXPORT	transactions_refcode			      :=	VersionControl.mBuildFilenameVersions($.names('').i_transactions_refcode,version,$.names().i_transactions_refcode);
	EXPORT  transactions_userid		          :=	VersionControl.mBuildFilenameVersions($.names('').i_transactions_userid,version,$.names().i_transactions_userid);
	EXPORT  sources		          						:=	VersionControl.mBuildFilenameVersions($.names('').i_sources,version,$.names().i_sources);
	
	EXPORT	dAll_filenames									:=	identities.dAll_filenames +
																							identities_lexid.dAll_filenames +
																							otherphones.dAll_filenames +
																							riskindicators.dAll_filenames +
																							transactions.dAll_filenames +
																							transactions_companyid.dAll_filenames +
																							transactions_companyrefcode.dAll_filenames +
																							transactions_date.dAll_filenames +
																							transactions_phone.dAll_filenames +
																							transactions_refcode.dAll_filenames +
																							transactions_userid.dAll_filenames +
																							sources.dAll_filenames;
		
END;	
	