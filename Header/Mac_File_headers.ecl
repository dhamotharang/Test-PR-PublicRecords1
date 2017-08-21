export Mac_File_headers(infile,is_hdrbuild='false',outfile) := macro
#uniquename(result)
 #if(is_hdrbuild=true)
 %result% := infile;
 #else
 %result% := project(infile,transform({header.Layout_Header},self:=left));
 #end
 outfile := %result%;
endmacro;
