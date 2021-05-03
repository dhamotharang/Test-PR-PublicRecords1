import std;

EXPORT _BWR_MoveToIncoming(boolean pUseProd=FALSE) := FUNCTION

RDF:=STD.File.RemoteDirectory('bctlpbatchio04.noam.lnrm.net', '/data/prod_r3/b1032432/dali_files/'):independent;

MoveToIncoming:=apply(RDF,STD.File.MoveExternalFile(IDA._Constants(pUseProd).Source_IP, IDA._Constants(pUseProd).despray_path + name, IDA._Constants(pUseProd).despray_incoming_path + name));

return IF(EXISTS(RDF),sequential(MoveToIncoming),OUTPUT('THERE IS NO FILES TO MOVE'));

end;

