

import prte2_doc,prte2,ut,std, PromoteSupers;
filename:= constants.lookup_file;

file_offenses_base_plus_2:=project(PRTE2_DOC.files.file_offenses_base_plus,Layouts.layout_off_desc_1);

file_court_offenses_plus_2 := project(PRTE2_DOC.files.file_court_offenses_plus,
Transform(Layouts.layout_off_desc_1,
SELF.off_desc_1:= Left.court_off_desc_1;
));

file_arrests := project(PRTE2_DOC.files.file_court_offenses_plus,
Transform(Layouts.layout_off_desc_1,
SELF.off_desc_1:= Left.arr_off_desc_1;
));

all_files:=file_offenses_base_plus_2 + file_court_offenses_plus_2 + file_arrests;

PRTE2.CleanFields(all_files, file_offenses_base_plus_3);

my_index := index({ 
   string150 offensecharge;
  }, layouts.base_layout, filename);
	
	Join_file:= JOIN(my_index,
                 file_offenses_base_plus_3(off_desc_1 !=''), 
   LEFT.offensecharge = RIGHT.off_desc_1, 
                       TRANSFORM(layouts.base_layout,
											 self.offensecharge:=right.off_desc_1;
											 self:=left;));		
											 
base_file:=sort(dedup(Join_file),record);
	
PromoteSupers.Mac_SF_BuildProcess(base_file,Constants.base_name,base_out,,,true);

EXPORT proc_build_base :=   base_out;	



	