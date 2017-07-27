// Standard set of search argument.  Sub-class to overide SOAP parameters
EXPORT StandardSearchArgs := MODULE(Text_Search.Alert_Info.AlertParams),VIRTUAL
	EXPORT STRING srchString 	:= '' 	 : STORED('Search');
	EXPORT BOOLEAN runBoolean	:= FALSE : STORED('Terms_Connectors');
	EXPORT BOOLEAN rankResult := FALSE : STORED('Rank_Result');
	EXPORT UNSIGNED4 ansLimit	:= 1000  : STORED('Answer_Limit');
	EXPORT BOOLEAN showOnly  	:= FALSE : STORED('Show_Search_Only');
	EXPORT BOOLEAN showHits		:= FALSE : STORED('Show_Hits');
	EXPORT BOOLEAN countOnly  := FALSE : STORED('Count_Only');
	EXPORT BOOLEAN NoLAFN			:= FALSE : STORED('LAFN_Disabled');
	EXPORT BOOLEAN NoEqvExp		:= FALSE : STORED('No_Equivalents');
	EXPORT UNSIGNED4 valueLAFN:= 10000 : STORED('LAFN_Limit');
	EXPORT BOOLEAN LAFN				:= ~NoLAFN AND runBoolean;
	EXPORT BOOLEAN EqvExp			:= ~NoEqvExp;
	EXPORT BOOLEAN runSearch 	:= ~showOnly;
	EXPORT BOOLEAN showSearch := TRUE;
	EXPORT DATASET(Layout_Bookmark) bookMarks
														:= DATASET([], Layout_Bookmark): STORED('Bookmark_List');
	SET OF STRING focusSet		:= []		 : STORED('Focus_Doc_List');
	EXPORT DATASET(Layout_ExternalKey) focusList := DATASET(focusSet, Layout_ExternalKey);
	EXPORT Types.SourceList SourceList := [] : STORED('Source_List');
END;