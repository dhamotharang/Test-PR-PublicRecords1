import inquiry_acclogs, inql_v2;
In_File_ := inql_v2.Files().bridger_input;
//Inquiry_AccLogs.File_Bridger_Logs.preprocess;

layout := record
   recordof(In_File_) - [id];
   string id_;
 end;


EXPORT In_File := project(In_File_, transform(layout, self.id_ := left.id ; self := left;));