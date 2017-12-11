import file_compare,std;

layout_payload := record
	string payload;
	end;

	payload := dataset(SANCTN.cluster_name + 'in::sanctn::payload'
                           ,layout_payload,csv(terminator('\n'), separator('')));
	payload_father := dataset(SANCTN.cluster_name + 'in::sanctn::payload_father'
                           ,layout_payload,csv(terminator('\n'), separator('')));
													 
EXPORT fnDeltaInput(string version) := file_compare.Fn_File_Compare(payload_father,payload,,,layout_payload,,,true,true,'SANCTN','InFile_Delta',version);