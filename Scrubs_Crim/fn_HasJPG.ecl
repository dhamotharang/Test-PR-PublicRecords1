import STD;

EXPORT fn_HasJPG(string inString) := function
return if(STD.Str.Find(STD.Str.ToUpperCase(inString),'.JPG',1)=0 and STD.Str.Find(STD.Str.ToUpperCase(inString),'.JPEG',1)=0 and inString<>'',0,1);
end;