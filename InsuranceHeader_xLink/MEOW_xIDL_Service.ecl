/*--SOAP--
<message name="MEOW_xIDL_Service">
<part name="SNAME" type="xsd:string"/>
<part name="FNAME" type="xsd:string"/>
<part name="MNAME" type="xsd:string"/>
<part name="LNAME" type="xsd:string"/>
<part name="DERIVED_GENDER" type="xsd:string"/>
<part name="PRIM_RANGE" type="xsd:string"/>
<part name="PRIM_NAME" type="xsd:string"/>
<part name="SEC_RANGE" type="xsd:string"/>
<part name="CITY" type="xsd:string"/>
<part name="ST" type="xsd:string"/>
<part name="ZIP" type="xsd:string"/>
<part name="SSN5" type="xsd:string"/>
<part name="SSN4" type="xsd:string"/>
<part name="DOB" type="xsd:string"/>
<part name="PHONE" type="xsd:string"/>
<part name="DL_STATE" type="xsd:string"/>
<part name="DL_NBR" type="xsd:string"/>
<part name="SRC" type="xsd:string"/>
<part name="SOURCE_RID" type="xsd:string"/>
<part name="DT_FIRST_SEEN" type="xsd:string"/>
<part name="DT_LAST_SEEN" type="xsd:string"/>
<part name="DT_EFFECTIVE_FIRST" type="xsd:string"/>
<part name="DT_EFFECTIVE_LAST" type="xsd:string"/>
<part name="MAINNAME" type="xsd:string"/>
<part name="FULLNAME" type="xsd:string"/>
<part name="ADDR1" type="xsd:string"/>
<part name="LOCALE" type="xsd:string"/>
<part name="ADDRESS" type="xsd:string"/>
<part name="fname2" type="xsd:string"/>
<part name="lname2" type="xsd:string"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="disableForce" type="xsd:boolean"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
 
/*--INFO-- Attempt to resolve or find DIDs.
<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>FNAME:LNAME:ST</p>
<p>PRIM_RANGE:PRIM_NAME:ZIP</p>
<p>SSN5:SSN4</p>
<p>SSN4:FNAME:LNAME(NOFUZZY)</p>
<p>DOB:LNAME</p>
<p>DOB:FNAME</p>
<p>ZIP:PRIM_RANGE</p>
<p>SRC:SOURCE_RID</p>
<p>DL_NBR:DL_STATE</p>
<p>PHONE</p>
<p>LNAME:FNAME:ZIP</p>
<p>fname2:lname2</p>
*/
EXPORT MEOW_xIDL_Service := MACRO
  #WEBSERVICE(FIELDS(
	'SNAME', 'FNAME', 'MNAME', 'LNAME', 'NAME', 'DERIVED_GENDER',
	'ADDRESS1', 'ADDRESS2', 'PRIM_RANGE', 'PRIM_NAME', 'SEC_RANGE', 'CITY',
	'ST', 'ZIP', 'SSN', 'DOB', 'PHONE', 'DL_STATE', 'DL_NBR', 'fname2', 'lname2', 'SRC', 'SOURCE_RID', 'RID',
	'disableForce','MaxIds', 'LeadThreshold', 'UniqueID'
	),
	DESCRIPTION('SALT V3.7 <p/>'));/*HACK19*/
  IMPORT SALT37,InsuranceHeader_xLink;
  STRING Input_NAME := '' : STORED('NAME'); /*HACK20*/ 
	clean_n := address.CleanPersonFML73(Input_NAME);
	clean_n_parsed := Address.CleanNameFields(clean_n);
	nameLine := Input_name != '';
	STRING sSname := '' : STORED('SNAME');
	SALT37.StrType Input_SNAME := IF(nameLine, clean_n_parsed.name_suffix, sSname);
	STRING sFname := '' : STORED('FNAME');
	SALT37.StrType Input_FNAME := IF(nameLine, clean_n_parsed.fname, sFname);
	STRING sMname := '' : STORED('MNAME');
	SALT37.StrType Input_MNAME := IF(nameLine, clean_n_parsed.mname, sMname);
	STRING sLname := '' : STORED('LNAME');
	SALT37.StrType Input_LNAME := IF(nameLine, clean_n_parsed.lname, sLname); /*CLEAN NAME HACK*/
  SALT37.StrType Input_DERIVED_GENDER := '' : STORED('DERIVED_GENDER');
  STRING addressLine1 := '' : STORED('ADDRESS1');
	STRING addressLine2 := '' : STORED('ADDRESS2');
	CleanedAddress		:= Address.CleanAddressFieldsFips(Address.CleanAddress182(AddressLine1, AddressLine2)).addressrecord;
	addressLine 		:= addressLine1 != '' and addressLine2 != '';
	STRING sPrim_range := '' : STORED('PRIM_RANGE');
	SALT37.StrType Input_PRIM_RANGE := IF(addressLine,  CleanedAddress.prim_range, sPrim_range);
	STRING sPrim_name :=  '' : STORED('PRIM_NAME');
	SALT37.StrType Input_PRIM_NAME := IF(addressLine,  CleanedAddress.prim_name, sPrim_name);
	STRING sSec_range :=  '' : STORED('SEC_RANGE');
	SALT37.StrType Input_SEC_RANGE := IF(addressLine,  CleanedAddress.sec_range, sSec_range);
	STRING sCity :=  '' : STORED('CITY');
	SALT37.StrType Input_CITY := IF(addressLine,  CleanedAddress.v_city_name, sCity);
	STRING sSt :=  '' : STORED('ST');
	SALT37.StrType Input_ST := IF(addressLine,  CleanedAddress.st, sSt);
	STRING sZip :=  '' : STORED('ZIP');
	SALT37.StrType Input_ZIP := IF(addressLine,  CleanedAddress.zip, sZip); /*CLEAN ADDRESS HACK*/
	SALT37.StrType Input_SSN := '' : STORED('SSN');
	INTEGER ssnInt := (INTEGER)Input_SSN;
	SALT37.StrType Input_SSN5 := IF(ssnInt<>0, InsuranceHeader_xLink.mod_SSNParse(Input_SSN).SSN5, '');/* HACK SSN5 */
 	SALT37.StrType Input_SSN4 := IF(ssnInt<>0, InsuranceHeader_xLink.mod_SSNParse(Input_SSN).SSN4, ''); /* HACK SSN4 */
	SALT37.StrType Input_DOB := '' : STORED('DOB');
  SALT37.StrType Input_PHONE := '' : STORED('PHONE');
  SALT37.StrType Input_DL_STATE := '' : STORED('DL_STATE');
  SALT37.StrType Input_DL_NBR := '' : STORED('DL_NBR');
  SALT37.StrType Input_SRC := '' : STORED('SRC');
  SALT37.StrType Input_SOURCE_RID := '' : STORED('SOURCE_RID');
  SALT37.StrType Input_DT_FIRST_SEEN := '' : STORED('DT_FIRST_SEEN');
  SALT37.StrType Input_DT_LAST_SEEN := '' : STORED('DT_LAST_SEEN');
  SALT37.StrType Input_DT_EFFECTIVE_FIRST := '' : STORED('DT_EFFECTIVE_FIRST');
  SALT37.StrType Input_DT_EFFECTIVE_LAST := '' : STORED('DT_EFFECTIVE_LAST');
  SALT37.StrType Input_MAINNAME := '' : STORED('MAINNAME');
  SALT37.StrType Input_FULLNAME := '' : STORED('FULLNAME');
  SALT37.StrType Input_ADDR1 := '' : STORED('ADDR1');
  SALT37.StrType Input_LOCALE := '' : STORED('LOCALE');
  SALT37.StrType Input_ADDRESS := '' : STORED('ADDRESS');
  SALT37.StrType Input_fname2 := '' : STORED('fname2');
  SALT37.StrType Input_lname2 := '' : STORED('lname2');	
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds');
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold');	
  UNSIGNED e_DID := 0 : STORED('DID');
  UNSIGNED e_RID := 0 : STORED('RID');
  BOOLEAN Input_disableForce := InsuranceHeader_xLink.Config.DOB_NotUseForce : STORED('disableForce');/*HACK18*/
 
  Template := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout);
	ToUpperCase(STRING aString) := STD.Str.ToUpperCase(aString); /*HACK21a*/
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold,Input_disableForce
  ,(TYPEOF(Template.SNAME))InsuranceHeader_xLink.Fields.Make_SNAME(ToUpperCase((SALT37.StrType)Input_SNAME)) /*HACK21b*/
  ,(TYPEOF(Template.FNAME))InsuranceHeader_xLink.Fields.Make_FNAME(ToUpperCase((SALT37.StrType)Input_FNAME)) /*HACK21b*/
  ,(TYPEOF(Template.MNAME))InsuranceHeader_xLink.Fields.Make_MNAME(ToUpperCase((SALT37.StrType)Input_MNAME)) /*HACK21b*/
  ,(TYPEOF(Template.LNAME))InsuranceHeader_xLink.Fields.Make_LNAME(ToUpperCase((SALT37.StrType)Input_LNAME)) /*HACK21b*/
  ,(TYPEOF(Template.DERIVED_GENDER))InsuranceHeader_xLink.Fields.Make_DERIVED_GENDER(ToUpperCase((SALT37.StrType)Input_DERIVED_GENDER)) /*HACK21b*/
  ,(TYPEOF(Template.PRIM_RANGE))InsuranceHeader_xLink.Fields.Make_PRIM_RANGE(ToUpperCase((SALT37.StrType)Input_PRIM_RANGE)) /*HACK21b*/
  ,(TYPEOF(Template.PRIM_NAME))InsuranceHeader_xLink.Fields.Make_PRIM_NAME(ToUpperCase((SALT37.StrType)Input_PRIM_NAME)) /*HACK21b*/
  ,(TYPEOF(Template.SEC_RANGE))InsuranceHeader_xLink.Fields.Make_SEC_RANGE(ToUpperCase((SALT37.StrType)Input_SEC_RANGE)) /*HACK21b*/
  ,(TYPEOF(Template.CITY))InsuranceHeader_xLink.Fields.Make_CITY(ToUpperCase((SALT37.StrType)Input_CITY)) /*HACK21b*/
  ,(TYPEOF(Template.ST))InsuranceHeader_xLink.Fields.Make_ST(ToUpperCase((SALT37.StrType)Input_ST)) /*HACK21b*/
  ,(TYPEOF(Template.ZIP))Input_ZIP
  ,(TYPEOF(Template.SSN5))InsuranceHeader_xLink.Fields.Make_SSN5((SALT37.StrType)Input_SSN5)
  ,(TYPEOF(Template.SSN4))InsuranceHeader_xLink.Fields.Make_SSN4((SALT37.StrType)Input_SSN4)
  ,(TYPEOF(Template.DOB))InsuranceHeader_xLink.Fields.Make_DOB((SALT37.StrType)Input_DOB)
  ,(TYPEOF(Template.PHONE))Input_PHONE
  ,(TYPEOF(Template.DL_STATE))InsuranceHeader_xLink.Fields.Make_DL_STATE(ToUpperCase((SALT37.StrType)Input_DL_STATE)) /*HACK21b*/
  ,(TYPEOF(Template.DL_NBR))InsuranceHeader_xLink.Fields.Make_DL_NBR(ToUpperCase((SALT37.StrType)Input_DL_NBR)) /*HACK21b*/
  ,(TYPEOF(Template.SRC))InsuranceHeader_xLink.Fields.Make_SRC((SALT37.StrType)Input_SRC)
  ,(TYPEOF(Template.SOURCE_RID))InsuranceHeader_xLink.Fields.Make_SOURCE_RID((SALT37.StrType)Input_SOURCE_RID)
  ,(TYPEOF(Template.DT_FIRST_SEEN))InsuranceHeader_xLink.Fields.Make_DT_FIRST_SEEN((SALT37.StrType)Input_DT_FIRST_SEEN)
  ,(TYPEOF(Template.DT_LAST_SEEN))InsuranceHeader_xLink.Fields.Make_DT_LAST_SEEN((SALT37.StrType)Input_DT_LAST_SEEN)
  ,(TYPEOF(Template.DT_EFFECTIVE_FIRST))InsuranceHeader_xLink.Fields.Make_DT_EFFECTIVE_FIRST((SALT37.StrType)Input_DT_EFFECTIVE_FIRST)
  ,(TYPEOF(Template.DT_EFFECTIVE_LAST))InsuranceHeader_xLink.Fields.Make_DT_EFFECTIVE_LAST((SALT37.StrType)Input_DT_EFFECTIVE_LAST)
  ,(TYPEOF(Template.MAINNAME))InsuranceHeader_xLink.Fields.Make_MAINNAME((SALT37.StrType)Input_MAINNAME)
  ,(TYPEOF(Template.FULLNAME))InsuranceHeader_xLink.Fields.Make_FULLNAME((SALT37.StrType)Input_FULLNAME)
  ,(TYPEOF(Template.ADDR1))InsuranceHeader_xLink.Fields.Make_ADDR1((SALT37.StrType)Input_ADDR1)
  ,(TYPEOF(Template.LOCALE))InsuranceHeader_xLink.Fields.Make_LOCALE((SALT37.StrType)Input_LOCALE)
  ,(TYPEOF(Template.ADDRESS))InsuranceHeader_xLink.Fields.Make_ADDRESS((SALT37.StrType)Input_ADDRESS)
  ,(TYPEOF(Template.fname2))ToUpperCase(Input_fname2)/*HACK21c*/
  ,(TYPEOF(Template.lname2))ToUpperCase(Input_lname2)/*HACK21c*/
  ,false,false,0,0}],InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout);
 
  pm := InsuranceHeader_xLink.MEOW_xIDL(Input_Data); // This module performs regular xDID functions
  outputResults := pm.Raw_Results;
	OUTPUT(outputResults,NAMED('Results'));
	// add segmentation and keys_used description
	segKey := InsuranceHeader_PostProcess.segmentation_keys.key_did;
	LayoutScoredFetch := RECORD
		InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch.did;
		STRING10 Segmentation;
		InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch-did;
		STRING keys_used_desc;
	END;
	OutputLayout_Base := RECORD,MAXLENGTH(32000)
		BOOLEAN Verified := FALSE; // has found possible results
		BOOLEAN Ambiguous := FALSE; // has >= 20 dids within an order of magnitude of best
		BOOLEAN ShortList := FALSE; // has < 20 dids within an order of magnitude of best
		BOOLEAN Handful := FALSE; // has <6 IDs within two orders of magnitude of best
		BOOLEAN Resolved := FALSE; // certain with 3 nines of accuracy
		DATASET(LayoutScoredFetch) Results;
		UNSIGNED4 keys_tried := 0;
		STRING keys_tried_desc;
	END;
	OutputLayout := RECORD(OutputLayout_Base),MAXLENGTH(32000)
		InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout;
	END;
	resultsFormatted := project(outputResults, TRANSFORM(OutputLayout, 
		res := project(left.results, TRANSFORM(LayoutScoredFetch, 
				SELF.Segmentation := segKey(DID=left.did)[1].ind;
				SELF.keys_used_desc := InsuranceHeader_xLink.Process_xIDL_Layouts().KeysUsedToText(left.Keys_used);
				SELF := LEFT));
				self.Keys_tried_desc := InsuranceHeader_xLink.Process_xIDL_Layouts().KeysUsedToText(left.Keys_tried);
				self.results := res;
			self := left));
	output(resultsFormatted, named('FormattedResults'));/*MXIDLHACK01*/
ENDMACRO;
