import inquiry_acclogs;
EXPORT In_File := Inquiry_AccLogs.File_Bridger_Logs.preprocess;

layout := record
   recordof(In_File_) - [id];
   string id_;
 end;


EXPORT In_File := project(In_File_, transform(layout, self.id_ := left.id ; self := left;));