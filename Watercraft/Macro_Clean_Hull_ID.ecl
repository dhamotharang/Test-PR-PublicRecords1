import watercraft;

//bug# 22654
export Macro_Clean_Hull_ID(clean_in,cleanlayout,hull_clean_in):= macro
#uniquename(reformat)

cleanlayout %reformat%(clean_in L) := transform

string temp_hull := if(trim(StringLib.stringfilterout(L.hull_id,'-0*#$+,.!{}\\`') ,left,right) = '','' ,L.hull_id);
self.hull_id := if(trim(temp_hull,left,right)in['NO S/N','NOS/N','N/S/N', 
                                                'UNK', 'UNKNOWN','UNKN',
                                                'NONE','NA','N/A',
												'"N/A"', '"NONE"',
												'NONE GIVEN','UNKOWN'],'',if(StringLib.StringFind(temp_hull,'S/N',1) = 1,trim(temp_hull,left,right)[4..],temp_hull)) ;
self := L;
end;

hull_clean_in := project(clean_in, %reformat%(left));
	
endmacro;



  