layout_did := RECORD
  unsigned4 seq;
	qSTRING9  ssn;
	qSTRING8  dob;
	qstring10 phone10;
	qSTRING5  title;
	qSTRING20 fname;
	qSTRING20 mname;
	qSTRING20 lname;
	qSTRING5  suffix;
	qSTRING10 prim_range;
	qSTRING2  predir;
	qSTRING28 prim_name;
	qSTRING4  addr_suffix;
	qSTRING2  postdir;
	qSTRING10 unit_desig;
	qSTRING8  sec_range;
	qSTRING25 p_city_name;
	qSTRING2  st;
	qSTRING5  z5;
	qSTRING4  zip4;
END;

layout_cleanNames := RECORD
RECORDOF(_certification.TestFile_BuildNames);
END;

layout_did genDidTransform(layout_cleanNames l, INTEGER C):=TRANSFORM
  self.seq := 501+C;
	self.ssn := (String)(200948150+C);
	self.dob := (string)(1960+C%30)+'0401';
	self.phone10 := '5615551212';
	self.title := '';
	self.fname := L.fname;
	self.mname := L.middle;
	self.lname :=L.lname;
	self.suffix:=L.suffix;
	self.prim_range:='';
	self.predir:='';
	self.prim_name:='';
  self.addr_suffix:='';
	self.postdir:='';
	self.unit_desig:='';
	self.sec_range:='';
	self.p_city_name:='BIRMINGHAM';
	self.st := 'AL';
	self.z5 := '';
	self.zip4 := '';
END;

layout_did copyTestDid(layout_did L, integer C):= TRANSFORM
self.seq:=1+C;
self:=l;
END;
//
did_ds:=project(CHOOSEN(_certification.TestFile_BuildNames,500), genDidTransform(left,COUNTER));
//Original Data -- From Bob VanHeusen
did_test_data
 :=
  dataset([
	{
	1,
	'364000000',
	'',
	'',
	'',
	'INGLIS',
	'',
	'FORD',
	'',
	'',
	'',
	'',
	'',
	'',
	'',
	'',
	'',
	'',
	'',
	''
  }],
  layout_did
  );

didCopy_ds:=normalize(did_test_data,500,copyTestDid(left,counter));

export TestFile_Dids := didCopy_ds+did_ds;