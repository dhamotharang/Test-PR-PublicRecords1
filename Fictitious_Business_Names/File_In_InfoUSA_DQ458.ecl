export File_In_InfoUSA_DQ458 :=
dataset('~thor_data400::in::FBN_DQ458_mod1.xml',Fictitious_Business_Names.Layout_In_InfoUSA,xml('batch/doc'));
//dataset('~thor_data400::in::FBN_DQ458_mod1.xml',{string line},xml);