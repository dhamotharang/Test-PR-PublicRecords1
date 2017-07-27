/*--SOAP--
<message name="Simple_Text_Doc_Retrieval_Service">
	<part name="TREC" type="xsd:boolean"/>
	<part name="Source ID" type="xsd:unsignedShort"/>
  <part name="Doc_ID" type="xsd:unsignedLong"/>
 </message>
*/
/*--INFO-- Retrieve a document by document number.
*/
/*--HELP-- Accepts a document number. <p/>
The current text collection is the small 7 document simple set.
Leave source empty for all sources.
*/
export Doc_Retrieval_Service := MACRO
#OPTION('maxLength',10000000)

Text_Search.Types.SourceID theSrc := 0 : STORED('Source_ID');
Text_Search.Types.DocID theDoc 	:= 0 : STORED('Doc_ID');
BOOLEAN useTREC := FALSE : STORED('TREC');

STRING stem		:= '~THOR::JDH';
STRING srcType1:= 'SIMPLE';
STRING qual1		:= 'SMALL_TEST';
info1 := Text_Search.FileName_Info_Instance(stem, srcType1, qual1);

STRING srcType2 := 'TREC';
STRING qual2 := 'WSJ0121';
info2 := Text_Search.FileName_Info_Instance(stem, srcType2, qual2);

d1 := Text_Search.File_Simple_Test(info1);
r1 := d1(docID=theDoc);
IF(NOT useTREC, OUTPUT(r1, NAMED('RESULTS_Simple')));

d2 := Text_Search.File_Document(info2);
r2 := d2((theSrc=0 OR docRef.src=theSrc) AND docRef.doc=theDoc);
IF(useTREC, OUTPUT(r2, NAMED('RESULTS_TREC')));

ENDMACRO;