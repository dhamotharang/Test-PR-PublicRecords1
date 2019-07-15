import infutor;

EXPORT Prep_For_New(String9 cversion_dev) := Function

STRING cversion := trim(cversion_dev,left,right);

step1 := sequential(
 fileservices.startsuperfiletransaction(),
 fileservices.clearsuperfile(infutor.filename_infutor,true),
 fileservices.finishsuperfiletransaction()
	                 ) : success(output('superfile emptied - success')), failure(output('superfile emptied - failure'));

step2 := sequential(
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ak'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::al'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ar'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::az'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ca'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::co'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ct'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::dc'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::de'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::fl'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ga'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::hi'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ia'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::id'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::il'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::in'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ks'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ky'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::la'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ma'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::md'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::me'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::mi'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::mn'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::mo'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ms'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::mt'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::nc'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::nd'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ne'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::nh'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::nj'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::nm'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::nv'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ny'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::oh'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ok'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::or'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::pa'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::pr'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ri'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::sc'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::sd'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::tn'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::tx'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::ut'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::va'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::vt'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::wa'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::wi'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::wv'),
 fileservices.addsuperfile(infutor.filename_infutor,'~thor_dell400::in::infutor::'+cversion+'::wy')
) : success(output('new files added - success')), failure(output('new files added - failure'));

return sequential(step1,step2);

 
 END;