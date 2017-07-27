export BuildQueryItems(layout) := macro

CHOOSEN(
	IF(layout.fname!='' and layout.lname!='',dataset([{'',0.850000,
									'',trim(layout.lname), trim(layout.fname), '','',trim(layout.mname),
									'','','','','','','','','','','','','','','','',
									'','','','',''}], attus.layout_query_items)) &
	IF(layout.employer_name!='',dataset([{'',0.850000,
									'','', '', '','','',
									'','','','','','','','','','','','','','','','',
									'','',trim(layout.employer_name),'',''}], attus.layout_query_items)) & 
	if(layout.country!='',dataset([{'',0.850000,
									'','','', '','','',
									'','','','','','','','','','','','','','','','',
									'',trim(layout.country),'','',''}], attus.Layout_Query_Items)),
	3)
	
ENDMACRO;