EXPORT FN_FindFiles(STRING espURL='', STRING filename=''):=FUNCTION
	publishendpoint :=espURL + 'WsDfu';
	layout_wupublish_in := {STRING FileName {XPATH('LogicalName')} := filename};
	layout_dfulogicalfile:={STRING Name {XPATH('Name')},BOOLEAN isSuperfile {XPATH('isSuperfile')},
					BOOLEAN isDirectory {XPATH('isDirectory')},STRING fromespurl:=espURL};
	layout_result:={dataset(layout_dfulogicalfile) DFULogicalFiles{XPATH('DFULogicalFiles/DFULogicalFile')}};
	ds2:= SOAPCALL(publishendpoint,'DFUQuery',layout_wupublish_in, layout_result,LITERAL,XPATH('DFUQueryResponse'));
	lfs:= DEDUP(ds2.DFULogicalFiles,ALL);
	result:=PROJECT(lfs,TRANSFORM(RECORDOF(lfs),SELF.fromespurl:=espURL;SELF:=LEFT;));
	RETURN result;
END;
