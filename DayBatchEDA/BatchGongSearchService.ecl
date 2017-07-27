/*--SOAP--
<message name="DayBatchEDA">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="includeBus" type="xsd:byte"/>
	<part name="includeRes" type="xsd:byte"/>
	<part name="includeGov" type="xsd:byte"/>
</message>



*/
/*--INFO-- This service searches the gong file. */
import gong, doxie;
export BatchGongSearchService := MACRO

 UNSIGNED1 includeBus := 0 : stored('includeBus');
 UNSIGNED1 includeRes := 1 : stored('includeRes');
 UNSIGNED1 includeGov := 0 : stored('includeGov');

 in_format := DayBatchEDA.Layout_Batch_In;

 f := dataset([],in_format) : stored('batch_in',few);
 
 
  DayBatchEDA.Layout_Batch_In into(f l) := transform
	SELF.max_results := IF(l.max_results = 0,10,l.max_results);
	SELF.match_level := IF(l.match_level = 0,90,l.match_level);
	SELF.phone7 := IF(l.phoneno[8..10]='',l.phoneno[1..7],l.phoneno[4..10]);
	SELF.area_code := IF(l.phoneno[8..10]='','',l.phoneno[1..3]);
	SELF.prim_range := stringlib.stringtouppercase(TRIM(l.prim_range,LEFT,RIGHT)); 
  SELF.predir := stringlib.stringtouppercase(TRIM(l.predir,LEFT,RIGHT)); 
	SELF.prim_name := stringlib.stringtouppercase(TRIM(l.prim_name,LEFT,RIGHT));
	SELF.suffix := stringlib.stringtouppercase(TRIM(l.suffix,LEFT,RIGHT));
	SELF.postdir := stringlib.stringtouppercase(TRIM(l.postdir,LEFT,RIGHT)); 
	SELF.p_city_name := stringlib.stringtouppercase(TRIM(l.p_city_name,LEFT,RIGHT));
	SELF.name_last := stringlib.stringtouppercase(TRIM(l.name_last,LEFT,RIGHT));
	SELF.name_first := stringlib.stringtouppercase(TRIM(l.name_first,LEFT,RIGHT));
	SELF.name_first_init := l.name_first[1];
	SELF.PhoneticMatch := FALSE;
	SELF.AllowNickNames := FALSE;
	SELF.includeBus := IF(includeBus = 1,TRUE,FALSE);
	SELF.includeRes := IF(includeRes =1,TRUE,FALSE);
	SELF.includeGov := IF(includeGov =1,TRUE,FALSE);
	SELF := l;
 end;
prep := PROJECT(f,into(LEFT));

	FinalOutput := DayBatchEDA.Fetch_Batch_Gong_Full(prep);
	
	
	OUTPUT(FinalOutput, NAMED('Dataset'));
	
ENDMACRO;