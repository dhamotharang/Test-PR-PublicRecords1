export Mac_File_Best(infile,is_NewLayout=false,outfile) := macro
#uniquename(result)
 #if(is_NewLayout=true)
 %result% := infile;
 #else
 %result% := project(infile,Layout_Best);
 #end
 outfile := %result%;
endmacro;
