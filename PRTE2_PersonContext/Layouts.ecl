Import PersonContext;

EXPORT Layouts := module

export In_layout := record
string LexID;
string datagroup;
string recordtype;
string eventtype;
string statement_sequence;
string source_system;
string data_type_version;
string dataadded;
string cd_id;
string statementid;
string content;
string FIRST_NAME;
string MIDDLE;
string LAST_NAME;
end;

Export Layout_deltakey_personcontext := record
PersonContext.layouts.Layout_deltakey_personcontext;
End;

End;
