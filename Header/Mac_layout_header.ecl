import header; 
export Mac_layout_header(inlayout,is_hdrbuild=false,outlayout) := macro
#uniquename(result)
 #if(is_hdrbuild=true)
 %result% := inlayout;
 #else
 %result% := inlayout-header.layout_header_exclusions;
 #end
 outlayout := %result%;
endmacro;
