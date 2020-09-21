import ut,STD;

EXPORT AddComponentsToBuild(string			pLoginToken,
																	string			pBuildName,
																	string			pBuildVersion,
																	string			pEmailList,
																	dataset(Orbit4.Layouts.OrbitBuildInstanceLayout)	pBuildCandidates
																 ) := function

//SOAP Request format

///////////////////////////////////////////////////////////////////////////////////////////////
return Orbit4.AddComponentsToBuild ( pLoginToken,pBuildName,pBuildVersion,pEmailList,pBuildCandidates) : deprecated ( 'Use Orbit4.AddComponentsToBuild instead');
end;