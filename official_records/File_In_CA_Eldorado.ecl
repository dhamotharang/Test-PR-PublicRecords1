import lib_stringlib;

lraw := record
	string payload;
end;

File_in_eldorado := dataset('~thor_200::in::official_records::ca::el_dorado',lraw,CSV(heading(1),separator(''),Terminator(['\r\n']),quote(['\'','"'])),OPT);
                               

lraw trimquote( File_in_eldorado l) := transform
	self.payload := stringlib.stringfilterout(l.payload,'"');
end;

dWithoutquote := project(File_in_eldorado,trimquote(LEFT));

dWithouthdr := dWithoutquote(not(regexfind('Record|Date|Document|Days',payload)));


lparse := 
record
	string date_filed;
	string document_number;
	string document_title;
	string book;
	string page;
	string name1;
	string name1_etal;
	string grantee;
	string name2;
	string name2_etal;
	string crlf;
end;

lparse tcsvparse(dWithouthdr l ) := transform
self.date_filed              := l.payload[1..StringLib.StringFind(l.payload,',',1)-1];
self.document_number         := l.payload[StringLib.StringFind(l.payload,',',1)+1..StringLib.StringFind(l.payload,',',2)-1];
self.document_title          := l.payload[StringLib.StringFind(l.payload,',',2)+1..StringLib.StringFind(l.payload,',',3)-1];
self.book                    := l.payload[StringLib.StringFind(l.payload,',',3)+1..StringLib.StringFind(l.payload,',',4)-1];
self.page                    := l.payload[StringLib.StringFind(l.payload,',',4)+1..StringLib.StringFind(l.payload,',',5)-1];
self.name1                   := l.payload[StringLib.StringFind(l.payload,',',5)+1..StringLib.StringFind(l.payload,',',6)-1];
self.name1_etal              := l.payload[StringLib.StringFind(l.payload,',',6)+1..StringLib.StringFind(l.payload,',',7)-1];
self.grantee                 := l.payload[StringLib.StringFind(l.payload,',',7)+1..StringLib.StringFind(l.payload,',',8)-1];
self.name2                   := l.payload[StringLib.StringFind(l.payload,',',8)+1..StringLib.StringFind(l.payload,',',9)-1];
self.name2_etal              := l.payload[StringLib.StringFind(l.payload,',',9)+1..StringLib.StringFind(l.payload,',',10)-1];
SELF.crlf                    := '';
end;

predefine := project(dWithouthdr,tcsvparse(LEFT));

lfixed := 
record 
   string7 document_number;
   string5 book;
   string3 page;
   string8 date_filed;
   string15 document_title;
   string1 grantee;
   string80 name1;
   string1 name1_etal;
   string29 name2;
   string1 name2_etal;
   string2 crlf;
   
end;

lfixed csv2fixed( predefine l) := transform
   self.document_number     := trim(l.document_number,left,right);
   self.book                := trim(l.book,left,right);
   self.page                := trim(l.page,left,right);
   self.date_filed          := trim(l.date_filed,left,right);
   self.document_title      := stringlib.stringfilterout(trim(l.document_title,left,right),'\"');
   self.grantee             := trim(l.grantee,left,right);
   self.name1               := stringlib.stringfilterout(trim(l.name1,left,right),'\"');
   self.name1_etal          := trim(l.name1_etal,left,right);
   self.name2               := stringlib.stringfilterout(trim(l.name2,left,right),'\"');
   self.name2_etal          := trim(l.name2_etal,left,right);
   self.crlf                := l.crlf;
end;


export File_In_CA_Eldorado := project(predefine,csv2fixed(LEFT));




