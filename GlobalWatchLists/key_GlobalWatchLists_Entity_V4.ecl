import	doxie;

dGWLEntityV2	:=	GlobalWatchLists.File_GlobalWatchLists_V4.Base.Entity;

dEntity := project(dGWLEntityV2,GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutEntity);

export	key_GlobalWatchLists_Entity_V4	:=	INDEX(	dEntity,
																										{EntityID},
																										{dEntity},
																										GlobalWatchLists.constants.Cluster	+	'key::globalwatchlists::'	+	doxie.Version_SuperKey	+	'::entities'
																									);