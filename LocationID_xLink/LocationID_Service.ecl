﻿/*--SOAP--
<message name="LocationID_Header_Service">
<part name="AddressLine1" type="xsd:string"/>
<part name="AddressLine2" type="xsd:string"/>
<part name="prim_range" type="xsd:string"/>
<part name="predir" type="xsd:string"/>
<part name="prim_name" type="xsd:string"/>
<part name="addr_suffix" type="xsd:string"/>
<part name="postdir" type="xsd:string"/>
<part name="sec_range" type="xsd:string"/>
<part name="city_name" type="xsd:string"/>
<part name="state" type="xsd:string"/>
<part name="zip" type="xsd:string"/>
<part name="LocationID" type="xsd:integer"/>
</message>
*/
/*--INFO-- Find those entities having records matching the input criteria.
<p>This service can be used one of three ways:</p>
<p>    1. Lookup all the records in a LocationID</p>
<p>    2. Retreive a LocationID for a given address by address fields</p>
<p>    3. Clean an address line/line2 and retreive a LocationID for the given address</p>
<p>If LocationID is provided then the other parameters will be ignored.</p>
<p>If the individual address parts are provided then the line1/line2 fields will be ignored.</p>
<p>For option 1 - The Location ID is required</p>
<p>For option 2 - prim_range, prim_name, and city/state or zip are required - but the more information provided the more likelihood of a match</p>
<p>For option 3 - AddressLine1 and AddressLine2 are required. PLEASE NOTE FOR OPTION 3 THE ADDRESS CLEANER WILL BE CALLED PRIOR TO LOCATION ID LOOKUP</p>
*/
EXPORT LocationID_Service := MACRO
  IMPORT SALT37,LocationId_xLink,Address,LocationID_Build;

#WEBSERVICE(FIELDS(
	'AddressLine1', 'AddressLine2', 'prim_range', 'predir', 'prim_name', 'addr_suffix',
	'postdir', 'sec_range', 'city_name', 'state', 'zip', 'LocationID'
	),
	DESCRIPTION(
	             '<h3>This service can be used one of three ways:</h3>\n'
			 + '<p>    1. Lookup all the records in a LocationID</p>'
			 + '<p>    2. Retreive a LocationID for a given address by address fields</p>'
			 + '<p>    3. Clean an address line/line2 and retreive a LocationID for the given address</p>'
			 + '<p>If LocationID is provided then the other parameters will be ignored.</p>'
			 + '<p>If the individual address parts are provided then the line1/line2 fields will be ignored.</p>'
			 + '<p>For option 1 - The Location ID is required</p>'
			 + '<p>For option 2 - prim_range, prim_name, and city/state or zip are required - but the more information provided the more likelihood of a match</p>'
			 + '<p>For option 3 - AddressLine1 and AddressLine2 are required. PLEASE NOTE FOR OPTION 3 THE ADDRESS CLEANER WILL BE CALLED PRIOR TO LOCATION ID LOOKUP</p>'
			 )
	      );
	  
  // baseIndex := LocationID_xLink.BaseFileKey().KeyDef();
  baseIndex := LocationID_xLink.Process_LocationID_Layouts.Key;
  
  STRING    line1        := ''    : STORED('AddressLine1', FORMAT(SEQUENCE(1)));
  STRING    linelast     := ''    : STORED('AddressLine2', FORMAT(SEQUENCE(2)));
  STRING    inPrimRange  := ''    : STORED('prim_range', FORMAT(SEQUENCE(3)));
  STRING    inPreDir     := ''    : STORED('predir', FORMAT(SEQUENCE(4)));
  STRING    inPrimName   := ''    : STORED('prim_name', FORMAT(SEQUENCE(5)));
  STRING    inAddrSuffix := ''    : STORED('addr_suffix', FORMAT(SEQUENCE(6)));
  STRING    inPostDir    := ''    : STORED('postdir', FORMAT(SEQUENCE(7)));
  STRING    inSecRange   := ''    : STORED('sec_range', FORMAT(SEQUENCE(8)));
  STRING    inCityName   := ''    : STORED('city_name', FORMAT(SEQUENCE(9)));
  STRING    inState      := ''    : STORED('state', FORMAT(SEQUENCE(10)));
  STRING    inZip        := ''    : STORED('zip', FORMAT(SEQUENCE(11)));
  unsigned8 inLocID      := 0     : STORED('LocationID', FORMAT(SEQUENCE(12)));

  InputRecAddrPart := record
	string prim_range;
	string pre_dir;
	string prim_name;
	string addr_suffix;
	string post_dir;
	string sec_range;
	string city;
	string state;
	string zip;
  end;  
  
  InputRecAddrLine := record
	string addr_line1;
	string addr_linelast;
  end;
  
  InputRecLocationID := record
	unsigned8 loc_id;
  end;
  
  InputDSAddrPart   := dataset([
                               {inPrimRange,inPreDir,inPrimName,inAddrSuffix,inPostDir,inSecRange,inCityName,inState,inZip}
                               ],InputRecAddrPart);
					    
  InputDSAddrLine   := dataset([
                               {line1, linelast}
                               ],InputRecAddrLine);
					    
  InputDSLocationID := dataset([
                               {inLocID}
                               ],InputRecLocationID);

  boolean isOption1 := inLocID > 0;
  boolean isOption2 := inPrimRange!='';
  boolean isOption3 := not isOption1 and not isOption2;
  
  clean_address := if(isOption3 and line1!='' and linelast!='',Address.CleanAddress182(line1, linelast),(string182) '');

  SALT37.StrType Input_prim_range  := if(inPrimRange!='',StringLib.StringToUpperCase(inPrimRange),Address.CleanFields(clean_address).prim_range);
  SALT37.StrType Input_predir      := if(inPrimRange!='',StringLib.StringToUpperCase(inPreDir),Address.CleanFields(clean_address).predir);
  SALT37.StrType Input_prim_name   := if(inPrimRange!='',StringLib.StringToUpperCase(inPrimName),Address.CleanFields(clean_address).prim_name);  
  SALT37.StrType Input_addr_suffix := if(inPrimRange!='',StringLib.StringToUpperCase(inAddrSuffix),Address.CleanFields(clean_address).addr_suffix);
  SALT37.StrType Input_postdir     := if(inPrimRange!='',StringLib.StringToUpperCase(inPostDir),Address.CleanFields(clean_address).postdir);
  SALT37.StrType Input_unit_desig  := if(inPrimRange!='','',Address.CleanFields(clean_address).unit_desig);
  SALT37.StrType Input_sec_range   := if(inPrimRange!='',StringLib.StringToUpperCase(inSecRange),Address.CleanFields(clean_address).sec_range);
  SALT37.StrType Input_v_city_name := if(inPrimRange!='',StringLib.StringToUpperCase(inCityName),Address.CleanFields(clean_address).v_city_name);
  SALT37.StrType Input_st          := if(inPrimRange!='',StringLib.StringToUpperCase(inState),Address.CleanFields(clean_address).st);
  SALT37.StrType Input_err_stat    := if(inPrimRange!='','S',Address.CleanFields(clean_address).err_stat);
  SALT37.StrType Input_zip5        := if(inPrimRange!='',StringLib.StringToUpperCase(inZip),Address.CleanFields(clean_address).zip);
  
  Template := DATASET([],LocationId_xLink.Process_LocationID_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))0,50,0
  ,(TYPEOF(Template.prim_range))Input_prim_range
  ,(TYPEOF(Template.predir))Input_predir
  ,(TYPEOF(Template.prim_name_derived))Input_prim_name
  ,(TYPEOF(Template.addr_suffix_derived))Input_addr_suffix
  ,(TYPEOF(Template.postdir))Input_postdir
  ,(TYPEOF(Template.err_stat))Input_err_stat
  ,(TYPEOF(Template.unit_desig))Input_unit_desig
  ,(TYPEOF(Template.sec_range))Input_sec_range
  ,(TYPEOF(Template.v_city_name))Input_v_city_name
  ,(TYPEOF(Template.st))Input_st
  ,(TYPEOF(Template.zip5))Input_zip5
  ,true,false,0,0}],LocationId_xLink.Process_LocationID_Layouts.InputLayout);
 
  Input_Data2 := project(Input_Data,
                         transform(LocationId_xLink.Process_LocationID_Layouts.InputLayout,                               
                                   POBoxIndex             := left.prim_name_derived[1..6]='PO BOX';
                                   RRIndex                := left.prim_name_derived[1..2] in ['RR','HC'];
                                   self.prim_range        := map(POBoxIndex and trim(left.prim_range)='' => left.prim_name_derived[8..],
                                                                 RRIndex and trim(left.prim_range)=''    => left.prim_name_derived[4..],
                                                                 left.prim_range),
                                   self.prim_name_derived := map(POBoxIndex and trim(left.prim_range)='' => 'PO BOX',
                                                                 RRIndex and trim(left.prim_range)=''    => 'RR',
                                                                 left.prim_name_derived),
                                   self.sec_range         := if(left.sec_range='','NOVALUE',left.sec_range),
                                   self.err_stat          := 'S',
                                   self                   := left));
              
  pm := LocationId_xLink.MEOW_LocationID(Input_Data2(prim_name_derived!='')); // This module performs regular xLocId functions
  ds := pm.Data_;
  FieldNumber(SALT37.StrType fn) := CASE(fn,'prim_range' => 1,'predir' => 2,'prim_name' => 3,'addr_suffix' => 4,'postdir' => 5,'unit_desig' => 6,'sec_range' => 7,'v_city_name' => 8,'st' => 9,'zip5' => 10,11);
  result := CHOOSE(FieldNumber(''),SORT(ds,-weight,LocId,prim_range,RECORD),SORT(ds,-weight,LocId,predir_derived,RECORD),SORT(ds,-weight,LocId,prim_name_derived,RECORD),SORT(ds,-weight,LocId,addr_suffix_derived,RECORD),SORT(ds,-weight,LocId,postdir,RECORD),SORT(ds,-weight,LocId,unit_desig,RECORD),SORT(ds,-weight,LocId,sec_range,RECORD),SORT(ds,-weight,LocId,v_city_name,RECORD),SORT(ds,-weight,LocId,st,RECORD),SORT(ds,-weight,LocId,zip5,RECORD),SORT(ds,-weight,LocId,RECORD));
  
  allRecs1 := join(dedup(result, locid, all), baseIndex,
                  left.locid = right.locid,
			   transform(right), limit(1000));

  allRecs2 := 	choosen(baseIndex(locID=inLocID), 100);
  
  allRecs  := if(inLocID>0, allRecs2, allRecs1);
  
  ResultsRec := record
	allRecs.LocID;
	allRecs.rid;
	allRecs.aid;
	allRecs.prim_range;
	allRecs.predir;
	allRecs.prim_name;
	allRecs.postdir;
	allRecs.addr_suffix;
	allRecs.unit_desig;
	allRecs.sec_range;
	allRecs.v_city_name;
	allRecs.st;
	allRecs.zip5;
	allRecs.zip4;
	allRecs.dbpc;
	allRecs.err_stat;
  end;
  
  
  //ALL LOCATION ID RECS
  if(isOption1,output(InputDSLocationID, named('INPUT_DATA_LOCATIONID')));
  if(isOption2,output(InputDSAddrPart, named('INPUT_DATA_ADDRESS_PARTS')));
  if(isOption3,output(InputDSAddrLine, named('INPUT_DATA_ADDRESS_LINES')));  
  if(isOption3,output(Input_Data,NAMED('CLEAN_ADDRESS')));
  output(project(allRecs, ResultsRec),NAMED('RESULTS'));
ENDMACRO;
