#workunit('name', 'Rollback ' + Corp2._Dataset().name + ' Build');
import tools;

pVersion				:=	'20150101';
pInputFilenames := 	Corp2.Filenames	(pversion).Input.dAll_filenames;
pBuildFilenames	:=	Corp2.Filenames	(pversion).dAll_filenames;

sequential(
 tools.mod_RollbackInput(pInputFilenames).used2sprayed
,tools.mod_RollbackBuild(pVersion,pBuildFilenames).father2qa
);
