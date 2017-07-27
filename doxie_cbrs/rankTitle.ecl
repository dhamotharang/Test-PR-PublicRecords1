has(string src, string str) := stringlib.stringfind(src,str,1) > 0;

export rankTitle(string title) :=map(
has(title, 'WIFE') OR has(title, 'HUSBAND') or has(title, 'VICE')  => 5,
has(title, 'CHAIRMAN') or has(title, 'COB')  => 1,
has(title, 'CHIEF EXEC') or has(title, 'CEO') => 2,
has(title, 'PRESIDENT') or has(title, 'PRES') => 3,
has(title, 'OWNER') or has(title, 'OWNR') => 4,
title <> '' => 5,
6);

/*
     1.  CHAIRMAN, and any variation thereof.  CHAIRMAN OF THE BOARD, COB etc.
     2.  CHIEF EXECUTIVE OFFICER, CEO etc.
     3.  PRESIDENT, PRES, etc. but not VICE PRESIDENT.
     4.  OWNER
     5.  All Other TITLES
*/

