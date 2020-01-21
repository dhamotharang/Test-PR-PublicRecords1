IMPORT _control, STD, data_services;
EXPORT proc_CopyFiles := module


SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION

CopyFiles1('~thor_data400::key::testseed::qa::amlriskattributes',								'~prte::key::testseed::'+ current_version + '::amlriskattributes', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::amlriskattributesbusn',						'~prte::key::testseed::'+ current_version + '::amlriskattributesbusn', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::amlriskattributesbusnv2',					'~prte::key::testseed::'+ current_version + '::amlriskattributesbusnv2', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::amlriskattributesv2',							'~prte::key::testseed::'+ current_version + '::amlriskattributesv2', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::binstantid',											'~prte::key::testseed::'+ current_version + '::binstantid', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::boca_shell',											'~prte::key::testseed::'+ current_version + '::boca_shell', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::boca_shell4',											'~prte::key::testseed::'+ current_version + '::boca_shell4', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::bs_services_iid_address_history',	'~prte::key::testseed::'+ current_version + '::bs_services_iid_address_history', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::businessdefender',								'~prte::key::testseed::'+ current_version + '::businessdefender', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::cbd',															'~prte::key::testseed::'+ current_version + '::cbd', dest_cluster);	 
CopyFiles1('~thor_data400::key::testseed::qa::cbdattributes',										'~prte::key::testseed::'+ current_version + '::cbdattributes',	dest_cluster);	
CopyFiles1('~thor_data400::key::testseed::qa::flexid',													'~prte::key::testseed::'+ current_version + '::flexid', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::fov_interactive',									'~prte::key::testseed::'+ current_version + '::fov_interactive', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::fov_renewal',											'~prte::key::testseed::'+ current_version + '::fov_renewal',	dest_cluster);	
CopyFiles1('~thor_data400::key::testseed::qa::frauddefender',										'~prte::key::testseed::'+ current_version + '::frauddefender', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::healthcareattributes',						'~prte::key::testseed::'+ current_version + '::healthcareattributes', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::identifier2',											'~prte::key::testseed::'+ current_version + '::identifier2', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::identityfraudnetwork_address',		'~prte::key::testseed::'+ current_version + '::identityfraudnetwork_address', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::identityfraudnetwork_combination','~prte::key::testseed::'+ current_version + '::identityfraudnetwork_combination', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::identityfraudnetwork_email',			'~prte::key::testseed::'+ current_version + '::identityfraudnetwork_email', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::identityfraudnetwork_ipaddress',	'~prte::key::testseed::'+ current_version + '::identityfraudnetwork_ipaddress', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::identityfraudnetwork_name',				'~prte::key::testseed::'+ current_version + '::identityfraudnetwork_name',	dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::identityfraudnetwork_phone',			'~prte::key::testseed::'+ current_version + '::identityfraudnetwork_phone', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::identityfraudnetwork_ssn',				'~prte::key::testseed::'+ current_version + '::identityfraudnetwork_ssn', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::identityreport',									'~prte::key::testseed::'+ current_version + '::identityreport', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::instantid',												'~prte::key::testseed::'+ current_version + '::instantid', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::intliid_gg2',											'~prte::key::testseed::'+ current_version + '::intliid_gg2', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::leadintegrityattributes',					'~prte::key::testseed::'+ current_version + '::leadintegrityattributes', dest_cluster);	
CopyFiles1('~thor_data400::key::testseed::qa::lnsmallbusiness',									'~prte::key::testseed::'+ current_version + '::lnsmallbusiness',	dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::os',															'~prte::key::testseed::'+ current_version + '::os',	dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::osattributes',										'~prte::key::testseed::'+ current_version + '::osattributes', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::part1::biid_v2',									'~prte::key::testseed::'+ current_version + '::part1::biid_v2', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::part2::biid_v2',									'~prte::key::testseed::'+ current_version + '::part2::biid_v2', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::part3::biid_v2',									'~prte::key::testseed::'+ current_version + '::part3::biid_v2', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::profilebooster',									'~prte::key::testseed::'+ current_version + '::profilebooster', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::redflags',												'~prte::key::testseed::'+ current_version + '::redflags', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::smallbusfinancialexchange',				'~prte::key::testseed::'+ current_version + '::smallbusfinancialexchange', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::smallbusinessanalytics',					'~prte::key::testseed::'+ current_version + '::smallbusinessanalytics', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::smallbusinessanalyticsv20',				'~prte::key::testseed::'+ current_version + '::smallbusinessanalyticsv20', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::smallbusmodels',									'~prte::key::testseed::'+ current_version + '::smallbusmodels', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::verificationofoccupancy',					'~prte::key::testseed::'+ current_version + '::verificationofoccupancy', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::vooreport::associatedidentities',	'~prte::key::testseed::'+ current_version + '::vooreport::associatedidentities', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::vooreport::ownedproperties',			'~prte::key::testseed::'+ current_version + '::vooreport::ownedproperties', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::vooreport::ownedpropertiesasof',	'~prte::key::testseed::'+ current_version + '::vooreport::ownedpropertiesasof', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::vooreport::phoneandutility',			'~prte::key::testseed::'+ current_version + '::vooreport::phoneandutility', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::vooreport::sources',							'~prte::key::testseed::'+ current_version + '::vooreport::sources', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::vooreport::summary',							'~prte::key::testseed::'+ current_version + '::vooreport::summary', dest_cluster);
CopyFiles1('~thor_data400::key::testseed::qa::vooreport::targetsummary',				'~prte::key::testseed::'+ current_version + '::vooreport::targetsummary', dest_cluster);
 
 
RETURN 'Success';	
	END;
END;