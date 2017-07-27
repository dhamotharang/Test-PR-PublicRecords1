/*--SOAP--
<message name="BatchService">
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="DataRestrictionMask"  type="xsd:string"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="30"/>
	<part name="NumberPropertyYears"  type="xsd:integer"/>
	<part name="NumberInterval1Years" type="xsd:integer"/>
	<part name="NumberInterval2Years" type="xsd:integer"/>
</message>
*/
/*
	batch_in fields:
	======================
	STRING20 acctno
	STRING20 name_first
	STRING20 name_middle
	STRING20 name_last
	STRING5  name_suffix
	STRING9  ssn
	STRING8  dob
	STRING10 phone
	STRING10 prim_range 
	STRING2  predir
	STRING28 prim_name
	STRING4  addr_suffix
	STRING2  postdir
	STRING10 unit_desig
	STRING8  sec_range
	STRING25 p_city_name
	STRING2  st
	STRING5  z5
	STRING4  zip4
*/

IMPORT PropertyFraudDiscovery,BatchShare,Address;

EXPORT BatchService() := FUNCTION

	batch_params := PropertyFraudDiscovery.IParams.getBatchParams();
	ds_xml_in := DATASET([],PropertyFraudDiscovery.Layouts.batch_in_raw) : STORED('batch_in',FEW);

	BatchShare.MAC_SequenceInput(ds_xml_in,ds_xml_in_seq);
	BatchShare.MAC_CapitalizeInput(ds_xml_in_seq,ds_xml_in_cap);
	ds_batch_in:=PROJECT(ds_xml_in_cap,TRANSFORM(PropertyFraudDiscovery.Layouts.batch_in,
		SELF.addr:=Address.Addr1FromComponents(LEFT.prim_range,LEFT.predir,LEFT.prim_name,LEFT.addr_suffix,LEFT.postdir,LEFT.unit_desig,LEFT.sec_range),
		SELF:=LEFT,
		SELF:=[]));
	ds_batchview_recs := PropertyFraudDiscovery.Records.BatchView(ds_batch_in,batch_params);
	BatchShare.MAC_RestoreAcctno(ds_batch_in,ds_batchview_recs,Results,,FALSE);

	RETURN OUTPUT(Results,NAMED('Results'));

END;
