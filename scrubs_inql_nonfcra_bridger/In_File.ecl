import inquiry_acclogs, inql_v2;
In_File_ := INQL_V2.Files().InputFiles(false,true,'bridger','building');
//Inquiry_AccLogs.File_Bridger_Logs.preprocess;

layout := record
   recordof(In_File_) - [id];
   string id_;
 end;


EXPORT In_File := project(In_File_, transform(layout, self.id_ := left.id ; self := left;));