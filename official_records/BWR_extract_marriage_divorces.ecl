ds_in := distribute(official_records.File_Moxie_Party_Prod,HASH(official_record_key));

dr_with_filing_type := RECORD
	ds_in;
	string1	filing_type;
END;

dr_with_filing_type append_filing_type(ds_in R) := TRANSFORM
	 self.filing_type := MAP(
		R.vendor='01' AND StringLib.StringToUpperCase(R.doc_type_desc)='AMEND JUD DISSOL MARR' => '7',
		R.vendor='01' AND StringLib.StringToUpperCase(R.doc_type_desc)='CERTIFICATE MARRIAGE'  => '3',
		R.vendor='01' AND StringLib.StringToUpperCase(R.doc_type_desc)='JUDGEMENT DISSOL MARR'  => '7',
		R.vendor='02' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE RECORD'  => '3',
		R.vendor='03' AND StringLib.StringToUpperCase(R.doc_type_desc)='DIVORCE WITH CONVEYANCE'  => '7',
		R.vendor='03' AND StringLib.StringToUpperCase(R.doc_type_desc)='FINAL JUDGEMENT DISSOLUTION OF MARRIAGE/DIVORCE'  => '7',
		R.vendor='04' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE SETTLEMENT AGREEMENT'  => '7',
		R.vendor='05' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE CERTIFICATE'  => '3',
		R.vendor='05' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE LICENSE AFFIDAVIT'  => '3',
		R.vendor='07' AND StringLib.StringToUpperCase(R.doc_type_desc)='DISSOLUTION OF MARRIAGE'  => '7',
		R.vendor='08' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE RECORD'  => '3',
		R.vendor='09' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE RECORD'  => '3',
		R.vendor='10' AND StringLib.StringToUpperCase(R.doc_type_desc)='CTF MAR' => '3',
		R.vendor='10' AND StringLib.StringToUpperCase(R.doc_type_desc)='DIVORCE' => '7',
		R.vendor='10' AND StringLib.StringToUpperCase(R.doc_type_desc)='MAR CTF' => '3',
		R.vendor='10' AND StringLib.StringToUpperCase(R.doc_type_desc)='MAR LIC' => '3',
		R.vendor='10' AND StringLib.StringToUpperCase(R.doc_type_desc)='MAR REC' => '3',
		R.vendor='10' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE LICENSE' => '3',
		R.vendor='10' AND StringLib.StringToUpperCase(R.doc_type_desc)='SEPARAT' => '7',
		R.vendor='11' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE LICENSE' => '3',
		R.vendor='12' AND StringLib.StringToUpperCase(R.doc_type_desc)='ABST DIV DEC' => '7',
		R.vendor='12' AND StringLib.StringToUpperCase(R.doc_type_desc)='CONT MARR AFFID'  => ' ',
		R.vendor='12' AND StringLib.StringToUpperCase(R.doc_type_desc)='COR FJ DIVORCE'  => '7',
		R.vendor='12' AND StringLib.StringToUpperCase(R.doc_type_desc)='CORR F JUD MARR'  => '7',
		R.vendor='12' AND StringLib.StringToUpperCase(R.doc_type_desc)='FJ DISSOL/MARR'  => '7',
		R.vendor='12' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE RECORD'  => '3',
		R.vendor='14' AND StringLib.StringToUpperCase(R.doc_type_desc)='AFFIDAVIT CONTINUOUS MARRIAGE'  => ' ',
		R.vendor='15' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE RECORD'  => '3',
		R.vendor='16' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE RECORD'  => '3',
		R.vendor='16' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE LICENSES'  => '3',
		R.vendor='17' AND StringLib.StringToUpperCase(R.doc_type_desc)='DECLARATION MARRIAGE'  => '3',
		R.vendor='17' AND StringLib.StringToUpperCase(R.doc_type_desc)='DISSOLUTION MARRIAGE'  => '7',
		R.vendor='17' AND StringLib.StringToUpperCase(R.doc_type_desc)='FINAL DIVORCE'  => '7',
		R.vendor='17' AND StringLib.StringToUpperCase(R.doc_type_desc)='INTERLOCUTORY DIVORCE'  => '7',
		R.vendor='17' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE'  => '3',
		R.vendor='17' AND StringLib.StringToUpperCase(R.doc_type_desc)='MODIFY FINAL DIVORCE'  => '7',
		R.vendor='17' AND StringLib.StringToUpperCase(R.doc_type_desc)='MODIFY INTLOC DIVORCE'  => '7',
		R.vendor='18' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARR CRT'  => '3',
		R.vendor='19' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE LICENSE'  => '3',
		R.vendor='20' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE RECORD'  => '3',
		R.vendor='21' AND StringLib.StringToUpperCase(R.doc_type_desc)='MARRIAGE RECORD' => '3',
		'');
		self := R;
END;

ds_with_filing_type := PROJECT(ds_in,append_filing_type(left));


output(ds_with_filing_type(filing_type<>''),,'~thor_200::out::official_records_marriage_divorce_party',Overwrite)