/*--SOAP--
<message name="vehicle_registration_cn_search">
  <part name="cn" type="xsd:string"/>
  <part name="max_count" type="xsd:integer"/>
  <part name="return_count" type="xsd:integer"/>
  <part name="partial" type="xsd:boolean"/>
</message>
*/

// Generated by def2ecl.pl on Tue Feb 15 14:50:37 GMT 2005

export vehicle_registration_cn_search := MACRO

// beginning of fill in values
keyfilename := '~thor_data400::key::moxie.mv.cn.key';
payloadkey_filename := '~thor_data400::key::moxie.mv.fpos.data.key';
datasetlayout := RECORD
  VehLic.Layout_Vehreg_ToMike;
  unsigned integer8 fpos{virtual(fileposition)};
END;
// end of fill in values

STRING10 cn_val := '' : STORED('cn');
INTEGER max_count_value := 10000 : STORED('max_count');
INTEGER return_count_value := 1000 : STORED('return_count');
BOOLEAN partial := false : STORED('partial');

// key definitions
key := INDEX(dataset([],datasetlayout),{STRING10 cn := '',fpos},keyfilename);
#uniquename(f)
payloadkey := INDEX(dataset([],datasetlayout),{unsigned8 %f% := fpos},{datasetlayout},payloadkey_filename);

// index read
res := key(
            keyed(cn=cn_val)
);

#uniquename(seq)
Layout_Sequence :=
RECORD
	UNSIGNED6 %seq%;
	res;
END;

Layout_Sequence sequence(res le, INTEGER c) :=
TRANSFORM
	SELF.%seq% := c;
	SELF := le;
END;
lim_res := LIMIT(res,max_count_value,FAIL(11, doxie.ErrorCodes(11)),keyed);
srt_res := SORT(lim_res,RECORD);
prj_res := PROJECT(srt_res, sequence(LEFT, COUNTER));

// data fetch
DatasetLayout_Sequence :=
RECORD
	UNSIGNED6 %seq%;
	datasetlayout;
END;

DatasetLayout_Sequence getPayload(Layout_Sequence le, payloadkey ri) :=
TRANSFORM
  SELF.%seq% := le.%seq%;
  SELF := ri;
END;

j := JOIN(prj_res,payloadkey,keyed(LEFT.fpos=RIGHT.%f%),getPayload(LEFT,RIGHT));
output(TOPN(j,return_count_value,%seq%))

ENDMACRO;