/*--SOAP--
<message name="batch_in">
  <part name="batch_in" 						type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
IMPORT SALT27,HealthCareProvider,Address;
EXPORT xLNPID_Header_Batch_Service := MACRO
	
	Batch_In := DATASET ([], Health_Provider_Services.Layouts.batch_in) : STORED('batch_in', FEW);

	Header_Batch_Request	:=	PROJECT	(Batch_In, TRANSFORM (Health_Provider_Services.Layouts.Input_Layout,	SELF.UniqueID := (INTEGER) LEFT.UniqueID; SELF.DOB := (INTEGER) LEFT.DOB; SELF.TAX_ID := (INTEGER) LEFT.TAX_ID; SELF	:=	LEFT; SELF := [];));

	cleanData (string str) := TRIM(REGEXREPLACE(HealthCareProvider.CleanData.Name,HealthCareProvider.CleanData.fUpperCleanSpaces(HealthCareProvider.CleanData.fReplaceUnprintable(str)),' '),LEFT,RIGHT);
	cleanName (string name) := address.CleanNameFields (address.CleanPersonFML73(name));
	cleanLIC	(STRING25 lic) := Health_Provider_Services.fn_cleanlicense (lic);
	cleanPhone(STRING10 iphone) := Health_Provider_Services.fn_cleanphone (iPhone);
  Template := DATASET([],Health_Provider_Services.Process_xLNPID_Layouts.InputLayout);


	Health_Provider_Services.Process_xLNPID_Layouts.InputLayout cleanInputData (Health_Provider_Services.Process_xLNPID_Layouts.InputLayout L) := TRANSFORM 
		C_FNAME	:=	cleanData(L.FNAME);
		C_MNAME	:=	cleanData(L.MNAME);
		C_LNAME	:=	cleanData(L.LNAME);
		C_SNAME	:=	cleanData(L.SNAME);
		
		Name		:=	address.CleanNameFields (address.CleanPersonFML73(C_FNAME + ' ' + C_MNAME + ' ' + C_LNAME + ' ' + C_SNAME));
		FNAME 	:= 	Name.FNAME;
		MNAME 	:=	Name.MNAME;
		LNAME 	:= 	Name.LNAME;
		SNAME 	:= 	Name.NAME_SUFFIX;

		SELF.FNAME	 			:=	FNAME;
		SELF.MNAME	 			:=	MNAME;
		SELF.LNAME	 			:=	LNAME;
		SELF.SNAME	 			:=	SNAME;
		SELF.Gender 			:=	cleanData (L.Gender);
		SELF.PRIM_RANGE		:=	cleanData (L.PRIM_RANGE);
		SELF.PRIM_NAME		:=	cleanData (L.PRIM_NAME);
		SELF.SEC_RANGE		:=	cleanData (L.SEC_RANGE);
		SELF.V_CITY_NAME	:=	cleanData (L.V_CITY_NAME);
		SELF.ST						:=	cleanData (L.ST);
		SELF.ZIP					:=	cleanData (L.ZIP);
		DOB								:=	INTFORMAT(L.DOB,8,1);
		SELF.DOB					:=	IF(HealthCareProvider.isValidDOB (DOB),L.DOB,0);
		SELF.PHONE				:=	cleanPhone (L.PHONE);
		SELF.LIC_STATE		:=	cleanData (L.LIC_STATE);
		SELF.C_LIC_NBR		:=	cleanLIC  (L.C_LIC_NBR);
		SELF.TAX_ID				:=	(INTEGER)cleanData ((STRING)L.TAX_ID);
		SELF.DEA_NUMBER		:=	cleanData (L.DEA_NUMBER);
		SELF.NPI_NUMBER		:=	cleanData (L.NPI_NUMBER);
		SELF.UPIN					:=	cleanData (L.UPIN);
		SELF.Maxids				:=	50;
		SELF 							:= 	L;
		SELF 							:=	[];
	END;
	
	clean_input_data := PROJECT (Header_Batch_Request,cleanInputData(LEFT));
 
	pm := Health_Provider_Services.MEOW_xLNPID(clean_input_data);

	ds	:= pm.Data_;
	
	s_ds := dedup(sort(ds, uniqueid, -weight),uniqueid);

	Results := PROJECT (S_DS,TRANSFORM(Health_Provider_Services.Layouts.Batch_Out, self := left; self := [];));
	
	output (clean_input_data,named('request'));

	OUTPUT(Results, NAMED ('Results'));
ENDMACRO;