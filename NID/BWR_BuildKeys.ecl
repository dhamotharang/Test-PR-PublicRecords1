#workunit('name', 'Build Name Repository Keys');
BUILDINDEX(NID.Key_Repository,OVERWRITE);

BUILDINDEX(NID.Key_Repository_Name,OVERWRITE);

BUILDINDEX(NID.Key_Repository_ParsedName,OVERWRITE);
BUILDINDEX(NID.Key_Repository_ClnName,OVERWRITE);
BUILDINDEX(NID.Key_Repository_BizName,OVERWRITE);

