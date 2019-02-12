IMPORT VersionControl;

pversion := '20181217';
pUseProd := true;

// BUILD ALL Methodology - Basically the STEPS to Paint By Numbers for Karl's tasks...

// BASE BUILD - 
VersionControl.macBuildNewLogicalFile(INQL_TMX.Filenames(pversion,pUseProd).base.new, INQL_TMX.build_base, Build_Base_File);
Build_Base_File;


// KEY BUILD - VersionControl.macBuildNewLogicalKey(INQL_TMX.Keys(pversion, pUseProd).search.new, BuildDidKey);
// BuildDidKey;