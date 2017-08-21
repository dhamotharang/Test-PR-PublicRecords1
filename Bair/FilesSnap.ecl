import std;

EXPORT FilesSnap := module

	allfiles 			:= nothor(STD.File.LogicalFileSuperSubList()) : INDEPENDENT;
	Builtbase 		:= allfiles(regexfind('::base::bair::\\S*::built', supername));
	QAbase 				:= allfiles(regexfind('::base::bair::\\S*::qa', supername));
	Fatherbase 		:= allfiles(regexfind('::base::bair::\\S*::father', supername));

	Builtbase_D 	:= Builtbase(regexfind('::delta::', supername));
	Builtbase_F 	:= Builtbase(~regexfind('::delta::', supername));
	QAbase_D 			:= QAbase(regexfind('::delta::', supername));
	QAbase_F 			:= QAbase(~regexfind('::delta::', supername));
	Fatherbase_D 	:= Fatherbase(regexfind('::delta::', supername));
	Fatherbase_F 	:= Fatherbase(~regexfind('::delta::', supername));

	BuiltKeys 		:= allfiles(regexfind('::key::bair::\\S*::built', supername));
	QAKeys 				:= allfiles(regexfind('::key::bair::\\S*::qa', supername));
	FatherKeys 		:= allfiles(regexfind('::key::bair::\\S*::father', supername));

	BuiltKeys_D 	:= BuiltKeys(regexfind('::delta::', supername));
	BuiltKeys_F 	:= BuiltKeys(~regexfind('::delta::', supername));
	QAKeys_D 			:= QAKeys(regexfind('::delta::', supername));
	QAKeys_F 			:= QAKeys(~regexfind('::delta::', supername));
	FatherKeys_D 	:= FatherKeys(regexfind('::delta::', supername));
	FatherKeys_F 	:= FatherKeys(~regexfind('::delta::', supername));

	PSbase_D 				:= allfiles(regexfind('::base::composite_public_safety_data_delta$', supername));
	FatherPSbase_D 	:= allfiles(regexfind('::base::composite_public_safety_data_delta_father', supername));
	PSbase_F 				:= allfiles(regexfind('::base::composite_public_safety_data_full$', supername));
	FatherPSbase_F 	:= allfiles(regexfind('::base::composite_public_safety_data_full_father', supername));
	QAPSkeys				:= allfiles(regexfind('::key::bair_externallinkkeys::qa::', supername));
	FatherPSkeys		:= allfiles(regexfind('::key::bair_externallinkkeys::father::', supername));

	Booleankeys 			:= allfiles(regexfind('bair::key::frags::qa::', supername));
	FatherBooleankeys := allfiles(regexfind('bair::key::frags::father::', supername));

	//1 - Payload Base Full, 2 - Payload Key Full, 3 - PS Base Full, 4 - PS Key Full, 5 - Boolean Key Full
	//1 - Payload Base Delta, 2 - Payload Key Delta, 3 - PS Base Delta, 4 - PS Key Delta, 5 - Boolean Key Delta

	Bair.layouts.rFileList AddSegment(Bair.layouts.FsLogicalSuperSubRecord L, unsigned no) := transform
		self.seg 			:= no;
		self 					:= L;
	end;
	
	Delta := project(Builtbase_D + QAbase_D + Fatherbase_D, AddSegment(LEFT, 1))
							+	project(BuiltKeys_D + QAKeys_D + FatherKeys_D, AddSegment(LEFT, 2))
							+	project(PSbase_D + FatherPSbase_D, AddSegment(LEFT, 3));
	
	Full := project(Builtbase_F + QAbase_F + Fatherbase_F, AddSegment(LEFT, 1))
							+	project(BuiltKeys_F + QAKeys_F + FatherKeys_F, AddSegment(LEFT, 2))
							+	project(PSbase_F + FatherPSbase_F, AddSegment(LEFT, 3));
							
	export all := Delta + Full + project(QAPSkeys + FatherPSkeys, AddSegment(LEFT, 4)) + project(Booleankeys + FatherBooleankeys, AddSegment(LEFT, 5));
	
End;							