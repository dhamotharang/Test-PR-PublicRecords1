/*--SOAP--
<message name="Totalsource_records_batchservice">
	<part name="batch_in"           type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/

IMPORT USAA;

EXPORT Totalsource_records_batchservice() := MACRO
	
	rec_Totalsource_slim := RECORD
		unsigned6  	did;
		string5 		title;
		string20 		fname;
		string20 		mname;
		string20 		lname;
		string5 		name_suffix;
		string3 		name_score;
		string10  	prim_range;
		string2   	predir;
		string28  	prim_name;
		string4   	addr_suffix;
		string2   	postdir;
		string10  	unit_desig;
		string8   	sec_range;
		string25  	p_city_name;
		string2   	st;
		string5   	zip;
		string4   	zip4;
		String10		telephone;	
	END;
	
	ds_batch_in := DATASET([], {UNSIGNED6 did}) : STORED('batch_in', FEW);

	recs_raw := JOIN( ds_batch_in, Marketing_Best.key_equifax_DID, 
								    KEYED(LEFT.did = RIGHT.l_did),
								    TRANSFORM(RECORDOF(Marketing_Best.key_equifax_DID),
													    SELF := RIGHT),
								    INNER );
	
	recs := PROJECT(recs_raw,	rec_Totalsource_slim);

	OUTPUT(recs, NAMED('Results'));

ENDMACRO;

/*
<dataset>
<row><did>25967023</did></row>
</dataset>
*/