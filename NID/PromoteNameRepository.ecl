import STD;

superFile := Common.filename_NameRepository_Base;
rep := Common.filename_NameRepository;

sfList := [
	rep,
	superFile+'::father',
	superFile+'::grandfather',
	superFile+'::delete'
	];
	
EXPORT PromoteNameRepository(varstring files) :=
	 Std.file.fPromoteSuperFileList(sfList, files, deltail := true); 