IMPORT $;

inFile := dataset([],$.Layouts.Layout_Version);

EXPORT Key_Build_Version := INDEX ({inFile.last_build_version}, {inFile}, $.Keynames().Bld_Version.QA);