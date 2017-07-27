//////////////////////////////////////////////////////////////////////////////////////////
// Attribute 	: AddSuperFileContents - Function

// PARAMETER	: Liens source name - string

// DEPENDENT ON : NONE

// PURPOSE	 	: Add the contents of input Liensv2 Superfile to input building superfile
//////////////////////////////////////////////////////////////////////////////////////////


export AddSuperFileContents(string SourceName) :=
function

prefix := '~thor_data400::in::liensv2::';

// Add the contents of input Liensv2 superfile to the corresponding 
// building superfile based on the source parameter passed.

retval := map(
	SourceName = 'ILFDLN' => sequential(fileservices.clearsuperfile(prefix+'building::ilfdln::federal'),fileservices.addsuperfile(prefix+'building::ilfdln::federal',prefix+'ilfdln::federal',,true)),
	SourceName = 'NYC' => sequential(fileservices.clearsuperfile(prefix+'building::nyc::judgmts'),fileservices.addsuperfile(prefix+'building::nyc::judgmts',prefix+'nyc::judgmts',,true)),
	SourceName = 'NYFDLN' => sequential(fileservices.clearsuperfile(prefix+'building::nyf::federal'),fileservices.addsuperfile(prefix+'building::nyf::federal',prefix+'nyf::federal',,true)),
	SourceName = 'SA' => sequential(fileservices.clearsuperfile(prefix+'building::sab::servabs'),fileservices.addsuperfile(prefix+'building::sab::servabs',prefix+'sab::servabs',,true)),
	SourceName = 'CGL' => sequential(
									  sequential(fileservices.clearsuperfile(prefix+'building::cgl::fstlien'),fileservices.addsuperfile(prefix+'building::cgl::fstlien',prefix+'cgl::fstlien',,true)),
									  sequential(fileservices.clearsuperfile(prefix+'building::cgl::fstrles'),fileservices.addsuperfile(prefix+'building::cgl::fstrles',prefix+'cgl::fstrles',,true)),
									  sequential(fileservices.clearsuperfile(prefix+'building::cgl::judgmts'),fileservices.addsuperfile(prefix+'building::cgl::judgmts',prefix+'cgl::judgmts',,true)),
									  sequential(fileservices.clearsuperfile(prefix+'building::cgl::satjmts'),fileservices.addsuperfile(prefix+'building::cgl::satjmts',prefix+'cgl::satjmts',,true)),
									  sequential(fileservices.clearsuperfile(prefix+'building::cgl::subjmts'),fileservices.addsuperfile(prefix+'building::cgl::subjmts',prefix+'cgl::subjmts',,true)),
									  sequential(fileservices.clearsuperfile(prefix+'building::cgl::vacjmts'),fileservices.addsuperfile(prefix+'building::cgl::vacjmts',prefix+'cgl::vacjmts',,true)),
									  sequential(fileservices.clearsuperfile(prefix+'building::cgl::disjmts'),fileservices.addsuperfile(prefix+'building::cgl::disjmts',prefix+'cgl::disjmts',,true))
									  ),
	SourceName = 'CA' => sequential(
									 sequential(fileservices.clearsuperfile(prefix+'building::caf::busdtor'),fileservices.addsuperfile(prefix+'building::caf::busdtor',prefix+'caf::busdtor',,true)),
									 sequential(fileservices.clearsuperfile(prefix+'building::caf::bussecp'),fileservices.addsuperfile(prefix+'building::caf::bussecp',prefix+'caf::bussecp',,true)),
									 sequential(fileservices.clearsuperfile(prefix+'building::caf::chgfilg'),fileservices.addsuperfile(prefix+'building::caf::chgfilg',prefix+'caf::chgfilg',,true)),
									 sequential(fileservices.clearsuperfile(prefix+'building::caf::filings'),fileservices.addsuperfile(prefix+'building::caf::filings',prefix+'caf::filings',,true)),
									 sequential(fileservices.clearsuperfile(prefix+'building::caf::perdtor'),fileservices.addsuperfile(prefix+'building::caf::perdtor',prefix+'caf::perdtor',,true)),
									 sequential(fileservices.clearsuperfile(prefix+'building::caf::persecp'),fileservices.addsuperfile(prefix+'building::caf::persecp',prefix+'caf::persecp',,true))
									 ),
	SourceName = 'MA' => sequential(
									 sequential(fileservices.clearsuperfile(prefix+'building::ma::childsupportlien'),fileservices.addsuperfile(prefix+'building::ma::childsupportlien',prefix+'ma::childsupportlien',,true)),
									 sequential(fileservices.clearsuperfile(prefix+'building::ma::welflien'),fileservices.addsuperfile(prefix+'building::ma::welflien',prefix+'ma::welflien',,true)),
									 sequential(fileservices.clearsuperfile(prefix+'building::ma::writs'),fileservices.addsuperfile(prefix+'building::ma::writs',prefix+'ma::writs',,true)),
									 sequential(fileservices.clearsuperfile(prefix+'building::ma::writsname'),fileservices.addsuperfile(prefix+'building::ma::writsname',prefix+'ma::writsname',,true))
									 ),
	
	SourceName = 'HOGAN' => sequential(fileservices.clearsuperfile(prefix+'building::hgn::okclien'),fileservices.addsuperfile(prefix+'building::hgn::okclien',prefix+'hgn::okclien',,true))
	//0
);

return retval;

end;