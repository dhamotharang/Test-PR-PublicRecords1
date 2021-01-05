import std;

EXPORT _BWR_MoveToDone(boolean pUseProd=FALSE) := FUNCTION

RDF:=IDA._Constants(pUseProd).RDF;

MoveToDone:=nothor(apply(global(DATASET(RDF)),STD.File.MoveExternalFile(IDA._Constants(pUseProd).Source_IP, IDA._Constants(pUseProd).spray_path + name, IDA._Constants(pUseProd).done_path + name)));

return MoveToDone;

end;