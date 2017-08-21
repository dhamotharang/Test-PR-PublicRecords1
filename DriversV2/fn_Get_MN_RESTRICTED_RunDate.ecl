// Code originally created by Sandy Butler.
// READ ME NOW! READ ME NOW! READ ME NOW!
// All attributes that have the word RESTRICTED contain data for MN from OKC.  This data CANNOT be
//   part of the normal DL base and key files.  It will go through the normal DL process, but be
//   pulled out before the data becomes part of the base file.  Only if you have the LEGAL right to
//   access and use this data, should you even think about using the code or data.  When in doubt,
//   ask someone.
// READ ME NOW! READ ME NOW! READ ME NOW!

import _Validate, ut;

EXPORT fn_Get_MN_RESTRICTED_RunDate(string	pVersion					= ''
																	 ,string	pInSuperFile			=  ut.foreign_aprod +'thor::mvr::prescreen::rfi::qa::mnokclicensebase' //~foreign::10.194.12.1::
																	 )
 := function

		SubFile_Count 		:= nothor(FileServices.GetSuperFileSubCount(pInSuperFile));
		LogicalFileName 	:= if (SubFile_Count > 0, nothor(FileServices.GetSuperFileSubName(pInSuperFile, SubFile_Count)), 'Super file empty');

		rundate   := if (trim(pVersion) = '',
											if (stringlib.stringfind(LogicalFileName, 'foreign',1) > 0,
													stringlib.stringfilter(LogicalFileName[50..],'0123456789')[1..8],
													stringlib.stringfilter(LogicalFileName,'0123456789')[1..8]),
											trim(pVersion)
										);

		rundate_valid := if(_Validate.Date.fIsValid(rundate) AND
		                       _Validate.Date.fIsValid(rundate, _Validate.Date.Rules.DateInPast),
												  rundate,
													'');

		return rundate_valid;
		
end;