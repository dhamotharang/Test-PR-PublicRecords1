IMPORT STD;

has(STRING src, STRING str) := STD.STR.Find(src,str,1) > 0;

EXPORT rankTitle(STRING title) :=MAP(
  has(title, 'WIFE') OR has(title, 'HUSBAND') OR has(title, 'VICE') => 5,
  has(title, 'CHAIRMAN') OR has(title, 'COB') => 1,
  has(title, 'CHIEF EXEC') OR has(title, 'CEO') => 2,
  has(title, 'PRESIDENT') OR has(title, 'PRES') => 3,
  has(title, 'OWNER') OR has(title, 'OWNR') => 4,
  title <> '' => 5,
  6);

/*
     1. CHAIRMAN, and any variation thereof. CHAIRMAN OF THE BOARD, COB etc.
     2. CHIEF EXECUTIVE OFFICER, CEO etc.
     3. PRESIDENT, PRES, etc. but not VICE PRESIDENT.
     4. OWNER
     5. All Other TITLES
*/

