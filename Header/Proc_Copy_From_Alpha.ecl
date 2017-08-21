IMPORT ut;

EXPORT Proc_Copy_From_Alpha := MODULE // previously known as Header.Mod_XlabKeys

EXPORT getVname (string superfile, string v_end = ':') := FUNCTION

	FileName:=fileservices.GetSuperFileSubName(superfile,1);
	v_strt  := stringlib.stringfind(FileName,'20',1);
	v_endd	:= stringlib.stringfind(FileName[v_strt..],v_end,1);
	v_name  := FileName[v_strt..v_strt+if(v_endd<1,length(FileName),v_endd)-2];

	RETURN v_name;

END;
EXPORT getWuidx (string superfile) := FUNCTION
	FileName:=fileservices.GetSuperFileSubName(superfile,1);
	wName := regexfind('[W|w]2[0-9]{7}-[0-9]{6}',FileName,0);
	RETURN wName;
END;

shared AlphaSegDate:=getVname(ut.foreign_aprod+'thor_data400::key::insuranceheader_segmentation::did_ind_qa');
shared AlphaLabDate:=getVname(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::qa::did::refs::name');
shared AlphaLabRldt:=getVname(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::qa::did::refs::relative');
shared AlphaRelDate:=getVname(ut.foreign_aprod+'thor_data400::key::relatives_v3_qa');
shared AlphaRelBsfx:=getVname(ut.foreign_aprod+'thor_data400::base::insurance_header::relative');
shared AlphaDl_Date:=getVname(ut.foreign_aprod+'thor_data400::key::insuranceheader::qa::dln');
shared AlphaPs_wuid:=getWuidx(ut.foreign_aprod+'thor_data400::key::insuranceheader::allpossiblessns::qa');
shared AlphaUnqAddrDt:=getVname(ut.foreign_aprod+'thor_data400::key::insuranceheader::unique_addresses::expanded');
shared AlphaUnqFcAddrDt:=getVname(ut.foreign_aprod+'thor_data400::key::insuranceheader::unique_addresses::expanded_fcra');


EXPORT
 Copy
	:=
sequential
(

 output(AlphaSegDate,named('AlphaSegDate'))
,output(AlphaLabDate,named('AlphaLabDate'))
,output(AlphaLabRldt,named('AlphaLabRldt'))
,output(AlphaRelDate,named('AlphaRelDate'))
,output(AlphaRelBsfx,named('AlphaRelBsfx'))
,output(AlphaDl_Date,named('AlphaDl_Date'))
,output(AlphaPs_wuid,named('AlphaPs_wuid'))

// copy from alpharetta to thor400_60
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader_segmentation::'+AlphaSegDate+'::did_ind','thor400_60','~thor_data400::key::insuranceheader_segmentation::'+header.version_build+'::did_ind',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::address','thor400_60','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::dln','thor400_60','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::dob','thor400_60','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::lfz','thor400_60','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::name','thor400_60','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::ph','thor400_60','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::ssn','thor400_60','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::ssn4','thor400_60','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::'+AlphaLabDate+'::did::refs::zip_pr','thor400_60','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader_xlink::'+AlphaLabRldt+'::did::refs::relative','thor400_60','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::relative',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::base::insurance_header::relative'+AlphaRelBsfx+'','thor400_60',              '~thor_data400::base::insurance_header::'+header.version_build+'::relative',,,,,true,,true)

// clear BUILT content
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_segmentation::did_ind_built',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::built::did::refs::address',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::built::did::refs::dln',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::built::did::refs::dob',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::built::did::refs::lfz',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::built::did::refs::name',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::built::did::refs::ph',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::built::did::refs::ssn',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::built::did::refs::ssn4',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::built::did::refs::zip_pr',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::built::did::refs::relative',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::insuranceheader::built::relatives_v3',true)

,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_segmentation::did_ind_built')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::address')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::dln')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::dob')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::lfz')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::name')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::ph')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::ssn')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::ssn4')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::zip_pr')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::relative')
,fileservices.clearsuperfile('~thor_data400::base::insuranceheader::built::relatives_v3')

// move new version in thor400_60 to thor400_60 BUILT
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_segmentation::did_ind_built','~thor_data400::key::insuranceheader_segmentation::'+header.version_build+'::did_ind')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::address','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::dln','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::dob','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::lfz','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::name','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::ph','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::ssn','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::ssn4','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::zip_pr','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr')
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::built::did::refs::relative','~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::relative')
,fileservices.addsuperfile('~thor_data400::base::insuranceheader::built::relatives_v3','~thor_data400::base::insurance_header::'+header.version_build+'::relative')

// copy to thor400_44
,fileservices.fcopy('~thor_data400::key::insuranceheader_segmentation::'+header.version_build+'::did_ind','thor400_44','~thor400_44::key::insuranceheader_segmentation::'+header.version_build+'::did_ind',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address','thor400_44','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln','thor400_44','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob','thor400_44','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz','thor400_44','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name','thor400_44','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph','thor400_44','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn','thor400_44','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4','thor400_44','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr','thor400_44','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr',,,,,true,,true)
,fileservices.fcopy('~thor_data400::key::insuranceheader_xlink::'+header.version_build+'::did::refs::relative','thor400_44','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::relative',,,,,true,,true)

);

EXPORT copyOthers := sequential(

// copy from alpharetta to thor400_60
fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insurance_header::'     +AlphaRelDate+'::relatives_v3','thor400_60',     '~thor_data400::key::header::'+header.version_build+'::relatives_v3',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader::'+AlphaDl_Date+'::did','thor400_60',              '~thor_data400::key::insuranceheader::'+header.version_build+'::did',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader::'+AlphaDl_Date+'::dln','thor400_60',              '~thor_data400::key::insuranceheader::'+header.version_build+'::dln',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader::allpossiblessns::'+AlphaPs_wuid,'thor400_60','~thor_data400::key::insuranceheader::'+header.version_build+'::allpossiblessns',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader::unique_addresses::expanded_'+AlphaUnqAddrDt,'thor400_60','~thor_data400::key::header::'+header.version_build+'::addr_unique_expanded',,,,,true,,true)
,fileservices.fcopy(ut.foreign_aprod+'thor_data400::key::insuranceheader::unique_addresses::expanded_fcra_'+AlphaUnqFcAddrDt,'thor400_60',              '~thor_data400::key::fcra::header::'+header.version_build+'::addr_unique_expanded',,,,,true,,true)

// clear BUILT content
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader::built::relatives_v3',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader::built::did',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader::built::dln',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader::built::allpossiblessns',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::header::built::addr_unique_expanded',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::fcra::header::built::addr_unique_expanded',true)

,fileservices.clearsuperfile('~thor_data400::key::insuranceheader::built::relatives_v3')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader::built::did')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader::built::dln')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader::built::allpossiblessns')
,fileservices.clearsuperfile('~thor_data400::key::header::built::addr_unique_expanded')
,fileservices.clearsuperfile('~thor_data400::key::fcra::header::built::addr_unique_expanded')

// move new version in thor400_60 to thor400_60 BUILT
,fileservices.addsuperfile('~thor_data400::key::insuranceheader::built::relatives_v3','~thor_data400::key::header::'+header.version_build+'::relatives_v3')
,fileservices.addsuperfile('~thor_data400::key::insuranceheader::built::did','~thor_data400::key::insuranceheader::'+header.version_build+'::did')
,fileservices.addsuperfile('~thor_data400::key::insuranceheader::built::dln','~thor_data400::key::insuranceheader::'+header.version_build+'::dln')
,fileservices.addsuperfile('~thor_data400::key::insuranceheader::built::allpossiblessns','~thor_data400::key::insuranceheader::'+header.version_build+'::allpossiblessns')
,fileservices.addsuperfile('~thor_data400::key::header::built::addr_unique_expanded','~thor_data400::key::header::'+header.version_build+'::addr_unique_expanded')
,fileservices.addsuperfile('~thor_data400::key::fcra::header::built::addr_unique_expanded','~thor_data400::key::fcra::header::'+header.version_build+'::addr_unique_expanded')

);

EXPORT
 MoveToQA
	:=
sequential
(
// clear thor400_60 FATHER content
fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_segmentation::did_ind_father',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::father::did::refs::address',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::father::did::refs::dln',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::father::did::refs::dob',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::father::did::refs::lfz',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::father::did::refs::name',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::father::did::refs::ph',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::father::did::refs::ssn',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::father::did::refs::ssn4',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::father::did::refs::zip_pr',true)
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::father::did::refs::relative',true)

,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_segmentation::did_ind_father')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::address')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::dln')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::dob')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::lfz')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::name')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::ph')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::ssn')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::ssn4')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::zip_pr')
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::relative')

// move thor400_60 QA content to FATHER
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_segmentation::did_ind_father','~thor_data400::key::insuranceheader_segmentation::did_ind_qa',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::address','~thor_data400::key::insuranceheader_xlink::qa::did::refs::address',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::dln','~thor_data400::key::insuranceheader_xlink::qa::did::refs::dln',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::dob','~thor_data400::key::insuranceheader_xlink::qa::did::refs::dob',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::lfz','~thor_data400::key::insuranceheader_xlink::qa::did::refs::lfz',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::name','~thor_data400::key::insuranceheader_xlink::qa::did::refs::name',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::ph','~thor_data400::key::insuranceheader_xlink::qa::did::refs::ph',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::ssn','~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::ssn4','~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn4',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::zip_pr','~thor_data400::key::insuranceheader_xlink::qa::did::refs::zip_pr',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::father::did::refs::relative','~thor_data400::key::insuranceheader_xlink::qa::did::refs::relative',,true)

// clear thor400_60 and thor_data400 QA content
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
,fileservices.RemoveOwnedSubFiles('~thor400_60::key::insuranceheader_xlink::qa::did::refs::relative',true)

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
,fileservices.clearsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::relative')

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
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader_xlink::qa::did::refs::relative',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::relatives_v3_qa',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::base::relatives_insurance::boca_copy',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader::qa::did',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader::qa::dln',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::insuranceheader::qa::allpossiblessns',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::header::qa::addr_unique_expanded',true)
,fileservices.RemoveOwnedSubFiles('~thor_data400::key::fcra::header::qa::addr_unique_expanded',true)

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
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::relative')
,fileservices.clearsuperfile('~thor_data400::key::relatives_v3_qa')
,fileservices.clearsuperfile('~thor_data400::base::relatives_insurance::boca_copy')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader::qa::did')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader::qa::dln')
,fileservices.clearsuperfile('~thor_data400::key::insuranceheader::qa::allpossiblessns')
,fileservices.clearsuperfile('~thor_data400::key::header::qa::addr_unique_expanded')
,fileservices.clearsuperfile('~thor_data400::key::fcra::header::qa::addr_unique_expanded')

// move thor400_60 BUILT content to thor400_60 and thor_data400 QA
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_segmentation::did_ind_qa','~thor400_60::key::insuranceheader_segmentation::did_ind_built',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::address','~thor400_60::key::insuranceheader_xlink::built::did::refs::address',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::dln','~thor400_60::key::insuranceheader_xlink::built::did::refs::dln',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::dob','~thor400_60::key::insuranceheader_xlink::built::did::refs::dob',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::lfz','~thor400_60::key::insuranceheader_xlink::built::did::refs::lfz',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::name','~thor400_60::key::insuranceheader_xlink::built::did::refs::name',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::ph','~thor400_60::key::insuranceheader_xlink::built::did::refs::ph',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::ssn','~thor400_60::key::insuranceheader_xlink::built::did::refs::ssn',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::ssn4','~thor400_60::key::insuranceheader_xlink::built::did::refs::ssn4',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::zip_pr','~thor400_60::key::insuranceheader_xlink::built::did::refs::zip_pr',,true)
,fileservices.addsuperfile('~thor400_60::key::insuranceheader_xlink::qa::did::refs::relative','~thor400_60::key::insuranceheader_xlink::built::did::refs::relative',,true)

,fileservices.addsuperfile('~thor_data400::key::insuranceheader_segmentation::did_ind_qa','~thor400_60::key::insuranceheader_segmentation::did_ind_built',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::address','~thor400_60::key::insuranceheader_xlink::built::did::refs::address',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::dln','~thor400_60::key::insuranceheader_xlink::built::did::refs::dln',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::dob','~thor400_60::key::insuranceheader_xlink::built::did::refs::dob',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::lfz','~thor400_60::key::insuranceheader_xlink::built::did::refs::lfz',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::name','~thor400_60::key::insuranceheader_xlink::built::did::refs::name',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ph','~thor400_60::key::insuranceheader_xlink::built::did::refs::ph',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn','~thor400_60::key::insuranceheader_xlink::built::did::refs::ssn',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn4','~thor400_60::key::insuranceheader_xlink::built::did::refs::ssn4',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::zip_pr','~thor400_60::key::insuranceheader_xlink::built::did::refs::zip_pr',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader_xlink::qa::did::refs::relative','~thor400_60::key::insuranceheader_xlink::built::did::refs::relative',,true)

,fileservices.addsuperfile('~thor_data400::base::relatives_insurance::boca_copy','~thor_data400::base::insuranceheader::built::relatives_v3',,true)
,fileservices.addsuperfile('~thor_data400::key::relatives_v3_qa','~thor_data400::key::insuranceheader::built::relatives_v3',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader::qa::did','~thor_data400::key::insuranceheader::built::did',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader::qa::dln','~thor_data400::key::insuranceheader::built::dln',,true)
,fileservices.addsuperfile('~thor_data400::key::insuranceheader::qa::allpossiblessns','~thor_data400::key::insuranceheader::built::allpossiblessns',,true)
,fileservices.addsuperfile('~thor_data400::key::header::qa::addr_unique_expanded','~thor_data400::key::header::built::addr_unique_expanded',,true)
,fileservices.addsuperfile('~thor_data400::key::fcra::header::qa::addr_unique_expanded','~thor_data400::key::fcra::header::built::addr_unique_expanded',,true)

// clear thor400_44 QA content
,fileservices.RemoveOwnedSubFiles('~thor400_44::key::insuranceheader_segmentation::did_ind_qa',true)
,fileservices.RemoveOwnedSubFiles('~thor400_44::key::insuranceheader_xlink::qa::did::refs::address',true)
,fileservices.RemoveOwnedSubFiles('~thor400_44::key::insuranceheader_xlink::qa::did::refs::dln',true)
,fileservices.RemoveOwnedSubFiles('~thor400_44::key::insuranceheader_xlink::qa::did::refs::dob',true)
,fileservices.RemoveOwnedSubFiles('~thor400_44::key::insuranceheader_xlink::qa::did::refs::lfz',true)
,fileservices.RemoveOwnedSubFiles('~thor400_44::key::insuranceheader_xlink::qa::did::refs::name',true)
,fileservices.RemoveOwnedSubFiles('~thor400_44::key::insuranceheader_xlink::qa::did::refs::ph',true)
,fileservices.RemoveOwnedSubFiles('~thor400_44::key::insuranceheader_xlink::qa::did::refs::ssn',true)
,fileservices.RemoveOwnedSubFiles('~thor400_44::key::insuranceheader_xlink::qa::did::refs::ssn4',true)
,fileservices.RemoveOwnedSubFiles('~thor400_44::key::insuranceheader_xlink::qa::did::refs::zip_pr',true)
,fileservices.RemoveOwnedSubFiles('~thor400_44::key::insuranceheader_xlink::qa::did::refs::relative',true)

,fileservices.clearsuperfile('~thor400_44::key::insuranceheader_segmentation::did_ind_qa')
,fileservices.clearsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::address')
,fileservices.clearsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::dln')
,fileservices.clearsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::dob')
,fileservices.clearsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::lfz')
,fileservices.clearsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::name')
,fileservices.clearsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::ph')
,fileservices.clearsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::ssn')
,fileservices.clearsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::ssn4')
,fileservices.clearsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::zip_pr')
,fileservices.clearsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::relative')

// move new version on thor400_44 to thor400_44 superfiles
,fileservices.addsuperfile('~thor400_44::key::insuranceheader_segmentation::did_ind_qa','~thor400_44::key::insuranceheader_segmentation::'+header.version_build+'::did_ind')
,fileservices.addsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::address','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::address')
,fileservices.addsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::dln','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dln')
,fileservices.addsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::dob','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::dob')
,fileservices.addsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::lfz','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::lfz')
,fileservices.addsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::name','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::name')
,fileservices.addsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::ph','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ph')
,fileservices.addsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::ssn','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn')
,fileservices.addsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::ssn4','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::ssn4')
,fileservices.addsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::zip_pr','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::zip_pr')
,fileservices.addsuperfile('~thor400_44::key::insuranceheader_xlink::qa::did::refs::relative','~thor400_44::key::insuranceheader_xlink::'+header.version_build+'::did::refs::relative')

);

end;