import std;

EXPORT Monitor_file(

   string pfilename
  ,string pEventname

) :=
function

  return STD.File.fMonitorLogicalFileName(pEventname,pfilename);

end;