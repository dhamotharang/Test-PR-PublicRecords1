/*--SOAP-- 
<message name="EclNet_GetMeta">
</message>
*/
/*--INFO-- NOT FOR DIRECT USE.  
*/
/*--HELP--
This is meta data ment for the new EclNet client.
*/

export EclNet_GetMeta() := 
  macro
EclNet.EclNet_Defines();

EdgarNamesRoot := 
	DATASET([{META_VERTEX, DESCRIPTOR, 0, 'Person'},
			 {META_VERTEX, DESCRIPTOR, 1, 'Company'},
			 {META_VERTEX, BORDER_COLOR, 0, WhiteSmoke},
			 {META_VERTEX, FILL_COLOR, 0, WhiteSmoke},
			 {META_VERTEX, SEL_BORDER_COLOR, 0, Navy},
			 {META_VERTEX, SEL_FILL_COLOR, 0, WhiteSmoke},
			 {META_VERTEX, BORDER_COLOR, 1, SeaShell},
			 {META_VERTEX, FILL_COLOR, 1, SeaShell},
			 {META_VERTEX, SEL_BORDER_COLOR, 1, Navy},
			 {META_VERTEX, SEL_FILL_COLOR, 1, SeaShell},
			 {META_EDGE, DESCRIPTOR, 0, 'On the Board'},
			 {META_EDGE, EDGE_COLOR, 0, PowderBlue},
			 {META_EDGE, EDGE_SHORTEST_PATH_COLOR, 0, OrangeRed}
			], MetaRecord);
			
output(EdgarNamesRoot)
  endmacro;