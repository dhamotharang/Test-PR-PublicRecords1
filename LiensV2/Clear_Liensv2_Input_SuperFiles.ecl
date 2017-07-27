//////////////////////////////////////////////////////////////////////////////////////////
// Attribute 	: Clear_Liensv2_Input_SuperFiles - Function

// PARAMETER	: Liens source name - string

// DEPENDENT ON : NONE

// PURPOSE	 	: Clear files in input liensv2 superfile based on the 
//				  contents in the building input superfile and finally
//				  clear the input building superfile.
//////////////////////////////////////////////////////////////////////////////////////////


export Clear_Liensv2_Input_SuperFiles(string SourceName) :=
function

prefix := '~thor_data400::in::liensv2::';

// 1. Clear the input Liensv2 superfile based on the contents of building superfile
// 2. Clears the input building superfile


clearlogicalfile(string suffix,string sname = 'NA') := 
			sequential(
						nothor(
							apply(fileservices.superfilecontents(prefix+'building::'+suffix),
								if(fileservices.findsuperfilesubname(prefix+suffix,'~'+name) > 0,
									Fileservices.removesuperfile(prefix+suffix,'~'+name),
									output('~'+name + 'not found in '+ prefix+suffix)
								  )
								 )
							  ),
						if ( sname = 'MA',
							fileservices.clearsuperfile(prefix+'building::'+suffix,true),
							fileservices.clearsuperfile(prefix+'building::'+suffix)
							)
					    );

// Call the clearlogicalfile inline function based on the Source parameter

retval := map(
	SourceName = 'ILFDLN' => clearlogicalfile('ilfdln::federal'),
	SourceName = 'NYC' => clearlogicalfile('nyc::judgmts'),
	SourceName = 'NYFDLN' => clearlogicalfile('nyf::federal'),
	SourceName = 'SA' => clearlogicalfile('sab::servabs'),
	SourceName = 'CGL' => sequential(
									  clearlogicalfile('cgl::fstlien'),
									  clearlogicalfile('cgl::fstrles'),
									  clearlogicalfile('cgl::judgmts'),
									  clearlogicalfile('cgl::satjmts'),
									  clearlogicalfile('cgl::subjmts'),
									  clearlogicalfile('cgl::vacjmts'),
									  clearlogicalfile('cgl::disjmts')
									  ),
	SourceName = 'CA' => sequential(
									 clearlogicalfile('caf::busdtor'),
									 clearlogicalfile('caf::bussecp'),
									 clearlogicalfile('caf::chgfilg'),
									 clearlogicalfile('caf::filings'),
									 clearlogicalfile('caf::perdtor'),
									 clearlogicalfile('caf::persecp')
									 ),
	SourceName = 'MA' => sequential(
									 clearlogicalfile('ma::childsupportlien',sourcename),
									 clearlogicalfile('ma::welflien',sourcename),
									 clearlogicalfile('ma::writs',sourcename),
									 clearlogicalfile('ma::writsname',sourcename)
									 ),
	SourceName = 'HOGAN' => clearlogicalfile('hgn::okclien')
	//0
);

return retval;

end;