
rec_in:=record
string45 event;
string60 Description;
end;

File_Event_Description_in := dataset('~thor_data400::webclick::Event_Descriptions',rec_in, 
									csv(heading(1), separator(','), terminator(['\n','\r\n']), quote('"')));
rec_out:=record
rec_in,
integer1 zero:=0,
end;
rec_out xform(rec_in l):=transform
self:=l;
self.zero:=0;
end;

EXPORT File_Event_Description := sort(project(File_Event_Description_in,xform(LEFT)),event);									