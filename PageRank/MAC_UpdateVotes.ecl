//
// This macro assumes that the LEFT has already been distibuted by "from".
// Remember too that the results are distributed by "from".
//
export MAC_UpdateVotes(dsDataDistByFrom, dsScoreLinks,  dsUpdatedVotes , extension):= MACRO

#UNIQUENAME(dsDistNewScores);
%dsDistNewScores% := DISTRIBUTE(dsScoreLinks, PageId);

dsUpdatedVotes := JOIN(dsDataDistByFrom,%dsDistNewScores%,
												LEFT.From = RIGHT.pageId,
												TRANSFORM(resultsRec, 
																	SELF.Vote := RIGHT.NewScore * LEFT.oneOverLinkCount;
																	SELF := LEFT),
																	LEFT OUTER,
																	LOCAL);
																	
// OUTPUT(	dsUpdatedVotes, named('UpdatedVotes_' + extension));																
ENDMACRO;