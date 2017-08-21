export fn_patch_county(string in_co, string in_st) := function

 string cleanup_ := trim(stringlib.stringcleanspaces(stringlib.stringfilterout(stringlib.stringtouppercase(in_co),'.')),left,right);
 string rename_  := if(stringlib.stringfind(cleanup_,'FAIRBANK',1)!=0 and in_st='AK','FAIRBANKS NORTH STAR',
                    if(stringlib.stringfind(cleanup_,' BOROUGH',1)!=0,cleanup_[1..stringlib.stringfind(cleanup_,' BOROUGH',1)-1],
					if(in_st='FL' and trim(cleanup_)='MIAMI-DADE','DADE',
					stringlib.stringfindreplace(cleanup_,'\'',''))));

 return rename_;
 
end;