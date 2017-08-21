EXPORT Mod_XlabKeys := MODULE

FileName:=fileservices.GetSuperFileSubName('~foreign::10.194.12.1::thor_data400::key::insuranceheader_segmentation::did_ind_qa',1);
sub:=stringlib.stringfind(FileName,'20',1);
export AlphaSegDate:=FileName[sub..sub+7];

FileName:=fileservices.GetSuperFileSubName('~foreign::10.194.12.1::thor_data400::key::insuranceheader_xlink::qa::did::refs::name',1);
sub:=stringlib.stringfind(FileName,'20',1);
export AlphaLabDate:=FileName[sub..sub+7];

EXPORT
 Copy
	:=
sequential
(
// copy from alpharetta to thor400_30
fileservices.fcopy('~foreign::10.194.12.1::thor_data400::key::insuranceheader_segmentation::'+AlphaSegDate+'::did_ind','thor400_30','~thor_data400::key::insuranceheader_segmentation::'+header.version_build+'::did_ind',,,,,true,,true)
,fileservices.fcopy('~foreign::10.194.12.1::thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::address','thor400_30','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address',,,,,true,,true)
,fileservices.fcopy('~foreign::10.194.12.1::thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::dln','thor400_30','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln',,,,,true,,true)
,fileservices.fcopy('~foreign::10.194.12.1::thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::dob','thor400_30','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob',,,,,true,,true)
,fileservices.fcopy('~foreign::10.194.12.1::thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::lfz','thor400_30','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz',,,,,true,,true)
,fileservices.fcopy('~foreign::10.194.12.1::thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::name','thor400_30','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name',,,,,true,,true)
,fileservices.fcopy('~foreign::10.194.12.1::thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::ph','thor400_30','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph',,,,,true,,true)
,fileservices.fcopy('~foreign::10.194.12.1::thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::ssn','thor400_30','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn',,,,,true,,true)
,fileservices.fcopy('~foreign::10.194.12.1::thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::ssn4','thor400_30','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4',,,,,true,,true)
,fileservices.fcopy('~foreign::10.194.12.1::thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::zip_pr','thor400_30','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr',,,,,true,,true)

// clear BUILT content
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_segmentation::did_ind_built',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::built::did::refs::address',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::built::did::refs::dln',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::built::did::refs::dob',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::built::did::refs::lfz',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::built::did::refs::name',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::built::did::refs::ph',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::built::did::refs::ssn',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::built::did::refs::ssn4',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::built::did::refs::zip_pr',true)

,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_segmentation::did_ind_built')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::address')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::dln')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::dob')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::lfz')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::name')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::ph')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::ssn')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::ssn4')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::zip_pr')

// move new version in thor400_30 to thor400_30 BUILT
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_segmentation::did_ind_built','~thor_data400::key::insuranceheader_segmentation::'+header.version_build+'::did_ind')
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::address','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address')
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::dln','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln')
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::dob','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob')
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::lfz','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz')
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::name','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name')
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::ph','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph')
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::ssn','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn')
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::ssn4','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4')
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::built::did::refs::zip_pr','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr')

///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

// copy to thor400_20
,fileservices.fcopy('~thor_data400::key::insuranceheader_segmentation::'+header.version_build+'::did_ind','thor400_20','~thor400_20::key::insuranceheader_segmentation::'+header.version_build+'::did_ind',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address','thor400_20','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln','thor400_20','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob','thor400_20','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz','thor400_20','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name','thor400_20','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph','thor400_20','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn','thor400_20','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4','thor400_20','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr','thor400_20','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr',,,,,true,,true)

// copy to thor400_92
,fileservices.fcopy('~thor_data400::key::insuranceheader_segmentation::'+header.version_build+'::did_ind','thor400_92','~thor400_92::key::insuranceheader_segmentation::'+header.version_build+'::did_ind',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address','thor400_92','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln','thor400_92','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob','thor400_92','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz','thor400_92','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name','thor400_92','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph','thor400_92','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn','thor400_92','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4','thor400_92','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr','thor400_92','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr',,,,,true,,true)

// copy to thor400_60
,fileservices.fcopy('~thor_data400::key::insuranceheader_segmentation::'+header.version_build+'::did_ind','thor400_60','~thor400_60::key::insuranceheader_segmentation::'+header.version_build+'::did_ind',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address','thor400_60','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln','thor400_60','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob','thor400_60','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz','thor400_60','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name','thor400_60','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph','thor400_60','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn','thor400_60','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4','thor400_60','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr','thor400_60','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr',,,,,true,,true)

);

EXPORT
 MoveToQA
	:=
sequential
(
// clear thor400_30 FATHER content
fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_segmentation::did_ind_father',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::father::did::refs::address',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::father::did::refs::dln',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::father::did::refs::dob',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::father::did::refs::lfz',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::father::did::refs::name',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::father::did::refs::ph',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::father::did::refs::ssn',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::father::did::refs::ssn4',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::father::did::refs::zip_pr',true)

,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_segmentation::did_ind_father')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::address')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::dln')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::dob')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::lfz')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::name')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::ph')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::ssn')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::ssn4')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::zip_pr')

// move thor400_30 QA content to FATHER
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_segmentation::did_ind_father','~thor400_30::key::insuranceheader_segmentation::did_ind_qa',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::address','~thor400_30::key::insuranceheader_xlink::qa::did::refs::address',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::dln','~thor400_30::key::insuranceheader_xlink::qa::did::refs::dln',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::dob','~thor400_30::key::insuranceheader_xlink::qa::did::refs::dob',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::lfz','~thor400_30::key::insuranceheader_xlink::qa::did::refs::lfz',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::name','~thor400_30::key::insuranceheader_xlink::qa::did::refs::name',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::ph','~thor400_30::key::insuranceheader_xlink::qa::did::refs::ph',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::ssn','~thor400_30::key::insuranceheader_xlink::qa::did::refs::ssn',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::ssn4','~thor400_30::key::insuranceheader_xlink::qa::did::refs::ssn4',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::father::did::refs::zip_pr','~thor400_30::key::insuranceheader_xlink::qa::did::refs::zip_pr',,true)

// clear thor400_30 and thor_data400 QA content
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_segmentation::did_ind_qa',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::qa::did::refs::address',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::qa::did::refs::dln',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::qa::did::refs::dob',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::qa::did::refs::lfz',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::qa::did::refs::name',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::qa::did::refs::ph',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::qa::did::refs::ssn',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::qa::did::refs::ssn4',true)
,fileservices.RemoveOwnedSubFiles('~thor400_30::key::insuranceheader_xlink::qa::did::refs::zip_pr',true)

,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_segmentation::did_ind_qa')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::address')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::dln')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::dob')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::lfz')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::name')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::ph')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::ssn')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::ssn4')
,fileservices.clearsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::zip_pr')

,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader_segmentation::did_ind_qa',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader_xlink::qa::did::refs::address',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader_xlink::qa::did::refs::dln',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader_xlink::qa::did::refs::dob',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader_xlink::qa::did::refs::lfz',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader_xlink::qa::did::refs::name',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ph',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn4',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader_xlink::qa::did::refs::zip_pr',true)

,fileservices.clearsuperfile('~thor_data400::key::insuranceheader_segmentation::did_ind_qa')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::address')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::dln')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::dob')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::lfz')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::name')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ph')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn4')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::zip_pr')

// move thor400_30 BUILT content to thor400_30 and thor_data400 QA
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_segmentation::did_ind_qa','~thor400_30::key::insuranceheader_segmentation::did_ind_built',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::address','~thor400_30::key::insuranceheader_xlink::built::did::refs::address',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::dln','~thor400_30::key::insuranceheader_xlink::built::did::refs::dln',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::dob','~thor400_30::key::insuranceheader_xlink::built::did::refs::dob',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::lfz','~thor400_30::key::insuranceheader_xlink::built::did::refs::lfz',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::name','~thor400_30::key::insuranceheader_xlink::built::did::refs::name',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::ph','~thor400_30::key::insuranceheader_xlink::built::did::refs::ph',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::ssn','~thor400_30::key::insuranceheader_xlink::built::did::refs::ssn',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::ssn4','~thor400_30::key::insuranceheader_xlink::built::did::refs::ssn4',,true)
,fileservices.addsuperfile('~thor400_30::key::insuranceheader_xlink::qa::did::refs::zip_pr','~thor400_30::key::insuranceheader_xlink::built::did::refs::zip_pr',,true)

,fileservices.addsuperfile('~thor_data400::key::insuranceheader_segmentation::did_ind_qa','~thor400_30::key::insuranceheader_segmentation::did_ind_built',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::address','~thor400_30::key::insuranceheader_xlink::built::did::refs::address',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::dln','~thor400_30::key::insuranceheader_xlink::built::did::refs::dln',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::dob','~thor400_30::key::insuranceheader_xlink::built::did::refs::dob',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::lfz','~thor400_30::key::insuranceheader_xlink::built::did::refs::lfz',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::name','~thor400_30::key::insuranceheader_xlink::built::did::refs::name',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ph','~thor400_30::key::insuranceheader_xlink::built::did::refs::ph',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn','~thor400_30::key::insuranceheader_xlink::built::did::refs::ssn',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn4','~thor400_30::key::insuranceheader_xlink::built::did::refs::ssn4',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::zip_pr','~thor400_30::key::insuranceheader_xlink::built::did::refs::zip_pr',,true)

// clear thor400_20 QA content
,fileservices.RemoveOwnedSubFiles('~thor400_20::key::insuranceheader_segmentation::did_ind_qa',true)
,fileservices.RemoveOwnedSubFiles('~thor400_20::key::insuranceheader_xlink::qa::did::refs::address',true)
,fileservices.RemoveOwnedSubFiles('~thor400_20::key::insuranceheader_xlink::qa::did::refs::dln',true)
,fileservices.RemoveOwnedSubFiles('~thor400_20::key::insuranceheader_xlink::qa::did::refs::dob',true)
,fileservices.RemoveOwnedSubFiles('~thor400_20::key::insuranceheader_xlink::qa::did::refs::lfz',true)
,fileservices.RemoveOwnedSubFiles('~thor400_20::key::insuranceheader_xlink::qa::did::refs::name',true)
,fileservices.RemoveOwnedSubFiles('~thor400_20::key::insuranceheader_xlink::qa::did::refs::ph',true)
,fileservices.RemoveOwnedSubFiles('~thor400_20::key::insuranceheader_xlink::qa::did::refs::ssn',true)
,fileservices.RemoveOwnedSubFiles('~thor400_20::key::insuranceheader_xlink::qa::did::refs::ssn4',true)
,fileservices.RemoveOwnedSubFiles('~thor400_20::key::insuranceheader_xlink::qa::did::refs::zip_pr',true)

,fileservices.clearsuperfile('~thor400_20::key::insuranceheader_segmentation::did_ind_qa')
,fileservices.clearsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::address')
,fileservices.clearsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::dln')
,fileservices.clearsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::dob')
,fileservices.clearsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::lfz')
,fileservices.clearsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::name')
,fileservices.clearsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::ph')
,fileservices.clearsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::ssn')
,fileservices.clearsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::ssn4')
,fileservices.clearsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::zip_pr')

// move new version on thor400_20 to thor400_20 superfiles
,fileservices.addsuperfile('~thor400_20::key::insuranceheader_segmentation::did_ind_qa','~thor400_20::key::insuranceheader_segmentation::'+header.version_build+'::did_ind')
,fileservices.addsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::address','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address')
,fileservices.addsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::dln','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln')
,fileservices.addsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::dob','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob')
,fileservices.addsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::lfz','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz')
,fileservices.addsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::name','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name')
,fileservices.addsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::ph','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph')
,fileservices.addsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::ssn','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn')
,fileservices.addsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::ssn4','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4')
,fileservices.addsuperfile('~thor400_20::key::insuranceheader_xlink::qa::did::refs::zip_pr','~thor400_20::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr')

// clear thor400_92 QA content
,fileservices.RemoveOwnedSubFiles('~thor400_92::key::insuranceheader_segmentation::did_ind_qa',true)
,fileservices.RemoveOwnedSubFiles('~thor400_92::key::insuranceheader_xlink::qa::did::refs::address',true)
,fileservices.RemoveOwnedSubFiles('~thor400_92::key::insuranceheader_xlink::qa::did::refs::dln',true)
,fileservices.RemoveOwnedSubFiles('~thor400_92::key::insuranceheader_xlink::qa::did::refs::dob',true)
,fileservices.RemoveOwnedSubFiles('~thor400_92::key::insuranceheader_xlink::qa::did::refs::lfz',true)
,fileservices.RemoveOwnedSubFiles('~thor400_92::key::insuranceheader_xlink::qa::did::refs::name',true)
,fileservices.RemoveOwnedSubFiles('~thor400_92::key::insuranceheader_xlink::qa::did::refs::ph',true)
,fileservices.RemoveOwnedSubFiles('~thor400_92::key::insuranceheader_xlink::qa::did::refs::ssn',true)
,fileservices.RemoveOwnedSubFiles('~thor400_92::key::insuranceheader_xlink::qa::did::refs::ssn4',true)
,fileservices.RemoveOwnedSubFiles('~thor400_92::key::insuranceheader_xlink::qa::did::refs::zip_pr',true)

,fileservices.clearsuperfile('~thor400_92::key::insuranceheader_segmentation::did_ind_qa')
,fileservices.clearsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::address')
,fileservices.clearsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::dln')
,fileservices.clearsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::dob')
,fileservices.clearsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::lfz')
,fileservices.clearsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::name')
,fileservices.clearsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::ph')
,fileservices.clearsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::ssn')
,fileservices.clearsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::ssn4')
,fileservices.clearsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::zip_pr')

// move new version on thor400_92 to thor400_92 superfiles
,fileservices.addsuperfile('~thor400_92::key::insuranceheader_segmentation::did_ind_qa','~thor400_92::key::insuranceheader_segmentation::'+header.version_build+'::did_ind')
,fileservices.addsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::address','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address')
,fileservices.addsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::dln','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln')
,fileservices.addsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::dob','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob')
,fileservices.addsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::lfz','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz')
,fileservices.addsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::name','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name')
,fileservices.addsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::ph','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph')
,fileservices.addsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::ssn','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn')
,fileservices.addsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::ssn4','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4')
,fileservices.addsuperfile('~thor400_92::key::insuranceheader_xlink::qa::did::refs::zip_pr','~thor400_92::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr')

// clear thor400_60 QA content
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_segmentation::did_ind_qa',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::qa::did::refs::address',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::qa::did::refs::dln',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::qa::did::refs::dob',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::qa::did::refs::lfz',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::qa::did::refs::name',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::qa::did::refs::ph',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::qa::did::refs::ssn',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::qa::did::refs::ssn4',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::qa::did::refs::zip_pr',true)

,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_segmentation::did_ind_qa')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::address')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::dln')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::dob')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::lfz')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::name')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::ph')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::ssn')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::ssn4')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::zip_pr')

// move new version on thor400_60 to thor400_60 superfiles
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_segmentation::did_ind_qa','~thor400_60::key::insuranceheader_segmentation::'+header.version_build+'::did_ind')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::address','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::dln','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::dob','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::lfz','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::name','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::ph','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::ssn','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::ssn4','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::zip_pr','~thor400_60::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr')

);

end;