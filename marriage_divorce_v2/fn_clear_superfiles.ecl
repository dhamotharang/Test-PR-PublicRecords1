
export fn_clear_superfiles( dataset(FsLogicalFileInfoRecord)	pAll_superfilenames) := FUNCTION

return nothor(APPLY(pAll_superfilenames,
		fileservices.ClearSuperFile('~' + pAll_superfilenames.name)
		));
end;