////////////////////////////////////////////////////////////////////////////////////////////
// -- mBuildFilenameVersions module
// -- Parameters:
// -- 		ptemplatename	--	template filename for your build(base filename, or keyname). 
// 								i.e. '~thor_data400::base::BBB::@version@::Member'
// 
// --		pdate			--	New build date, i.e. '20060328'
//  
// -- This module will give you access to all versions of a build filename(base or key)
// -- i.e., 
// -- export Base	:= ut.mBuildFilenameVersions('~thor_data400::base::BBB::@version@::Member',	'20060328');
// -- Then,
// -- Base.Building		 = '~thor_data400::base::BBB::Building::Member'
// -- Base.Built		 = '~thor_data400::base::BBB::Built::Member'
// -- Base.QA			 = '~thor_data400::base::BBB::QA::Member'
// -- Base.Prod			 = '~thor_data400::base::BBB::Prod::Member'
// -- Base.Father		 = '~thor_data400::base::BBB::Father::Member'
// -- Base.Grandfather	 = '~thor_data400::base::BBB::Grandfather::Member'
// -- Base.Delete		 = '~thor_data400::base::BBB::Delete::Member'
// -- Base.New			 = '~thor_data400::base::BBB::20060328::Member'
// -- Base.Template		 = '~thor_data400::base::BBB::@version@::Member'
// -- Base.dAll_superfilenames	= all of the above filenames(except the template and new) conveniently in a dataset
// --								for your pleasure(apply, etc)
// -- Base.dNew			= The Base.New filename in a dataset
// -- Base.dBoth		= all filenames(super and logical) in a dataset so you can tie them together
////////////////////////////////////////////////////////////////////////////////////////////
import tools;

export mBuildFilenameVersions(

	 string			pTemplatefilename
	,string			pdate									= ''
	,string			pNewTemplatefilename	= ''
	,unsigned1	pnGenerations					= 3

) := tools.mod_FilenamesBuild(pTemplatefilename,pdate,pNewTemplatefilename,pnGenerations);

