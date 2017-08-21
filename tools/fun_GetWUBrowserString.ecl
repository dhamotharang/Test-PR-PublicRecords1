IMPORT	wk_ut;
//////////////////////////////////////////////////////////////////////////////////////////////
// -- fun_GetWUBrowserString() function:
// -- 	Generic function to create a string containing a Hyperlink for a WU to include in 
// --		an email message.
// -- 	Parameters:
// -- 		string						pWorkunit				-- WorkUnit String.  Default is this WorkUnit.
// --		
//////////////////////////////////////////////////////////////////////////////////////////////
EXPORT	fun_GetWUBrowserString(STRING pWorkunit=WORKUNIT)	:=	FUNCTION

	sBrowserString	:=	'Use these links to open the Workunit in a browser window:' + '\n'
											+ 'http://' + wk_ut._constants.LocalEsp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + pWorkunit + '#/stub/Summary' + '\n'
											+ 'http://' + wk_ut._constants.LocalEsp + ':8010/WsWorkunits/WUInfo?Wuid=' + pWorkunit + ' (IE Friendly)' + '\n';

	OUTPUT('<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + pWorkunit + '">' + pWorkunit + '</a>'  ,OVERWRITE	,NAMED('wuid__html'));
	
	RETURN sBrowserString;
	
END;
