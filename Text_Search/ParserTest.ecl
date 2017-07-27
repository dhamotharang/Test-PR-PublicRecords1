/*--SOAP--
<message name="Test for the Boolean Search Query Parser">
	<part name="Queries" type="tns:xmlDataset" cols="70" rows="4"/>
	<part name="ExpEqv" type="xsd:boolean">
		<html>
			<td width="20%"><font face="Verdana" size="2">Expand Equivalences:</font></td>
			<td><input type="checkbox" name="ExpEqv" checked="true"/></td>
		</html>
	</part>
	<part name="DrctExp" type="xsd:boolean">
		<html>
			<td width="20%"><font face="Verdana" size="2">Expand Directionals:</font></td>
			<td><input type="checkbox" name="DrctExp" checked="false"/></td>
		</html>
	</part>
</message>
*/
/*--USES-- Text_Search.search_form_xslt
*/
/*--INFO-- Parses boolean search queries (DataSet).
*/
/*--HELP--
<PRE>Input example:
&lt;Dataset&gt;&lt;Row&gt;&lt;str&gt;Search AND Google&lt;/str&gt;&lt;/Row&gt;&lt;Row&gt;&lt;str&gt;BODY(open source)&lt;/str&gt;&lt;/Row&gt;&lt;/Dataset&gt;

The list of available segment names:
DATE - date type
COPYRIGHT - text type
PUBLICATION - text type
AUTHOR - text type
NUM - numeric type
HEADLINE - text type
LEAD - text type
BODY - text type</PRE>
*/
EXPORT ParserTest() := FUNCTION

	tmpInputs := DATASET([], Text_Search.TestInput) : STORED('Queries', FEW);
	BOOLEAN expEqv := FALSE : STORED('ExpEqv');
	BOOLEAN drctExp := FALSE : STORED('DrctExp');
	qs := tmpInputs : GLOBAL;

	segDef := DATASET([{'DATE', Text_Search.Types.SegmentType.DateType, [1]},
										 {'COPYRIGHT', Text_Search.Types.SegmentType.TextType, [2]},
										 {'PUBLICATION', Text_Search.Types.SegmentType.TextType, [3]},
										 {'AUTHOR', Text_Search.Types.SegmentType.TextType, [4]},
										 {'NUM', Text_Search.Types.SegmentType.NumericType, [5]},
										 {'HEADLINE', Text_Search.Types.SegmentType.TextType, [10]},
										 {'LEAD', Text_Search.Types.SegmentType.TextType, [11]},
										 {'BODY', Text_Search.Types.SegmentType.TextType, [12]}],
										Text_Search.Layout_Segment_Definition);

	segNorm := SORT(segDef, segName, -segType) : GLOBAL;
	segList := SET(segNorm, segName) : GLOBAL;
	isSegName(STRING s) := StringLib.StringToUpperCase(s) IN segList;

	Text_Search.Types.SegmentType getSegType(STRING s) := FUNCTION
		STRING tmpStr := StringLib.StringToUpperCase(s);
		RETURN IF(EXISTS(segNorm(segName = tmpStr)), segNorm(segName = tmpStr)[1].segType, 0);
	END;

	Boolean isThisSeg(STRING s, Text_Search.Types.SegmentType t) := FUNCTION
		RETURN getSegType(s) = t;
	END;

	DATASET(Text_Search.Layout_Search_RPN_Set) toRPNSet(DATASET(Text_Search.Layout_ParseRec) input) := FUNCTION
		Text_Search.Layout_Search_RPN_Set toRPN(Text_Search.Layout_ParseRec input) := TRANSFORM
			Text_Search.Layout_RPN_Oprnd toPRNOprnd(Text_Search.Layout_OprndRec oprnd) := TRANSFORM
				eqvs := Text_Search.Equivalence.get(oprnd.word)[1];
				drcts := Text_Search.Equivalence.getDirectional(oprnd.word)[1];
				segList := segNorm(segName = oprnd.segName)[1].segList;
				BOOLEAN xEqv := ~input.A.sprsEqv AND expEqv;
				BOOLEAN xDrct := input.A.drctExp AND drctExp;

				SELF.searchArg := IF(xDrct, Text_Search.Equivalence.getDirRepl(drcts), oprnd.word);
				SELF.segList := IF(oprnd.segName <> '', segList, []);
				SELF.terms := IF(xEqv, eqvs.wds,
															 IF(xDrct, drcts.wds, []));
				SELF := oprnd;
				SELF := [];
			END;

			SELF.inputs := ROW(toPRNOprnd(input.A));
			SELF := input;
			SELF := [];
		END;

		RETURN PROJECT(input, toRPN(LEFT));
	END;

	Result := RECORD, MAXLENGTH(65536)
		Text_Search.TestInput.str;
		DATASET(Text_Search.Layout_Search_RPN_Set) rpns;
	END;

	Result toResult(Text_Search.TestInput ti) := TRANSFORM
		SELF := ti;
		SELF.rpns := Text_Search.ParseQueryFuncUnicode((UNICODE) ti.str, isSegName, isThisSeg, toRPNSet);
	END;

	RETURN OUTPUT(PROJECT(qs, toResult(LEFT)), ALL);

END;
