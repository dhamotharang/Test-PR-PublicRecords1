/*--SOAP--
<message name="MedicalSchoolCleanService">
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="MinScoreThreshold"	  type="xsd:integer"/>
	<part name="MaxResults"	          type="xsd:byte"/>
	<part name="DumpMedSchools" 			type="xsd:boolean"/> 		
	<part name="SkipMedSchools" 			type="xsd:boolean"/> 		
</message>
*/
/*--INFO--
<pre>
This service will return a set of cleaned records.

</pre>
*/

EXPORT MedicalSchoolCleanService := MACRO
	ds_batch_in_stored := DATASET([],  healthcare_cleaners.Layouts_MedSchool.layoutmedschoolbatchin) : STORED('batch_in', FEW);
	boolean DmpFile := false : STORED('DumpMedSchools');
	boolean SkipMedSchools := false : STORED('SkipMedSchools');
	unsigned2 MinScore := 0 : STORED('MinScoreThreshold');
	unsigned2 maxRslts := 0 : STORED('MaxResults');
	unsigned2 returnCnt := if (maxRslts>0,maxRslts,5);
	getBest := Healthcare_Cleaners.Functions_Medschool.getbestmatch(ds_batch_in_stored,MinScore,returnCnt,SkipMedSchools);
	results := map(DmpFile => sort(project(Medschool_standardization.Keys(,Healthcare_Cleaners.Constants.useProd).medschool_msid_key.QA(),transform(healthcare_cleaners.Layouts_MedSchool.layoutMedicalSchoolFinal, self:=left;self:=[])),msid),
									getBest);
	ut.mac_TrimFields(results, 'results', fmtResults);
	output(fmtResults, named('Results'));
ENDMACRO;
