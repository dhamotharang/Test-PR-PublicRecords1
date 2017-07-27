export Mac_Layout_Best(inlayout,is_NewLayout=false,outlayout) := macro
#uniquename(result)
 #if(is_NewLayout=true)
 %result% := inlayout;
 #else
 %result% := inlayout- watchdog.Layout_Exclusions;
 #end
 outlayout := %result%;
endmacro;
