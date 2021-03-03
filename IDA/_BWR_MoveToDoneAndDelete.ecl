import std;

EXPORT _BWR_MoveToDoneAndDelete(boolean pUseProd=FALSE) := FUNCTION

RDF:=IDA._Constants(pUseProd).RDF;

MoveToDone:=nothor(apply(global(DATASET(RDF)),STD.File.MoveExternalFile(IDA._Constants(pUseProd).Source_IP, IDA._Constants(pUseProd).spray_path + name, IDA._Constants(pUseProd).done_path + name)));

dir:=STD.File.RemoteDirectory(IDA._Constants(pUseProd).Source_IP, IDA._Constants(pUseProd).done_path,'IDA_LEXID_APPEND_*_request.txt');

del_files_done_dir:=nothor(apply(dir,STD.File.DeleteExternalFile(IDA._Constants(pUseProd).Source_IP, IDA._Constants(pUseProd).done_path + name)));

return sequential(MoveToDone,del_files_done_dir);

end;