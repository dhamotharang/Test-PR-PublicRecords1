import std;
EXPORT Remove_auto_payload := FUNCTION
Remove:=SEQUENTIAL(
 STD.File.StartSuperFileTransaction(),
 STD.File.RemoveOwnedSubFiles('~prte::key::email_datav2::autokey::built::payload',true),
 STD.File.FinishSuperFileTransaction()
);

return remove;
 		 
 	End;