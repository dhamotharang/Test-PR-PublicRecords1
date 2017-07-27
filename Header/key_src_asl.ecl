import american_student_list;

dASL_as_Source	:=	american_student_list.asl_as_source(,true);

mac_key_src(dASL_as_Source, american_student_list.layout_american_student_base, 
						asl_child, 
						'~thor_data400::key::asl_src_index_',id)
						
export Key_Src_ASL := id;