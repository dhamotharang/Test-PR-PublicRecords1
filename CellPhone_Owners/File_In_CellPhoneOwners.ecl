Import Lib_Stringlib, ut;
Str(String s) := Trim(StringLib.StringCleanSpaces(Stringlib.StringtoUpperCase(s)), Left, Right);

String		SuperFileName	:=	'~thor_data400::in::cellphoneowners';
mySubFiles	:=	nothor(FileServices.SuperFileContents(SuperFileName));
myLayout	:=	Record
	String8 SubfileFiledate ;
	String12 MachineName ;
	CellPhone_Owners.Layout.VEndorIn
End;

myDataset	:=	Record
	Dataset(myLayout)	dData;
End;

myDataset	tGetDates(mySubFiles	pInput)	:=	TRANSFORM
	filename		:=	pInput.name;
	filedate		:=	(String)If(Regexfind('[0-9]{8}', filename) = True, (unsigned4) Regexfind('[0-9]{8}', filename, 0), 0);
	inFile			:=	Dataset('~'+filename, Layout.VendorIn,CSV(Heading(1), Separator(','), Quote('"'), Maxlength(100000)));
	Self.dData	:=	Project(inFile,Transform(RecordOf(myLayout), Self.SubfileFiledate:=filedate;Self.machineName :=Str(filename[45..57]); Self:=Left; Self := [];));
End;

filedates	:=	Project(mySubFiles,tGetDates(LEFT));
Layout.In_CellPhoneOwners xForm(Recordof(filedates.dData) L) := Transform
		Self.SourceCode := 'PO'; //'PO' for Infutor - Internal tracking purposes
		Self.AppEnded_First_Name := Str(L.AppEnded_First_Name);
		Self.AppEnded_Middle_Name := Str(L.AppEnded_Middle_Name);
		Self.AppEnded_Surname := Str(L.AppEnded_Surname);
		Self.AppEnded_Company_Name := Str(L.AppEnded_Company_Name);
		Self.AppEnded_Callerid_Name := Str(L.AppEnded_Callerid_Name);
		Self.AppEnded_Street_Number := Str(L.AppEnded_Street_Number);
		Self.AppEnded_Pre_Directional := Str(L.AppEnded_Pre_Directional);
		Self.AppEnded_Street_Name := Str(L.AppEnded_Street_Name);
		Self.AppEnded_Street_Suffix := Str(L.AppEnded_Street_Suffix);
		Self.AppEnded_Post_Directional := Str(L.AppEnded_Post_Directional);
		Self.AppEnded_Unit_Designator := Str(L.AppEnded_Unit_Designator);
		Self.AppEnded_Unit_Number := Str(L.AppEnded_Unit_Number);
		Self.AppEnded_City := Str(L.AppEnded_City);
		Self.AppEnded_State_Code := Str(L.AppEnded_State_Code);
		Self.AppEnded_Zip_Code := Str(L.AppEnded_Zip_Code);
		Self.AppEnded_Zip_Code_Extension := Str(L.AppEnded_Zip_Code_Extension);
		Self.Delivery_Point_Code := Str(L.Delivery_Point_Code);
		Self.Carrier_Route_Code := Str(L.Carrier_Route_Code);
		Self.AppEnded_County_Code := Str(L.AppEnded_County_Code);
		Self.Zip4_Type_Code := Str(L.Zip4_Type_Code);
		Self.Delivery_Point_Validation := Str(L.Delivery_Point_Validation);
		Self.AppEnded_Mail_Able_Flag := Str(L.AppEnded_Mail_Able_Flag);
		Self.Validation_Date := Str(L.Validation_Date);
		Self.AppEnded_Phone := Str(L.AppEnded_Phone);
		Self.AppEnded_Phone_Type := Str(L.AppEnded_Phone_Type);
		Self.AppEnded_Direct_In_Dial_Flag := Str(L.AppEnded_Direct_In_Dial_Flag);
		Self.AppEnded_Record_Type := Str(L.AppEnded_Record_Type);
		Self.AppEnded_First_Date := Str(L.AppEnded_First_Date);
		Self.AppEnded_Last_Date := Str(L.AppEnded_Last_Date);
		Self.AppEnded_Telco_Name := Str(L.AppEnded_Telco_Name);
		Self.AppEnded_Phone_Score := Str(L.AppEnded_Phone_Score);
		Self.AppEnded_Directory_Assistance_Flag := Str(L.AppEnded_Directory_Assistance_Flag);
		Self.MCD_Match_Code := Str(L.MCD_Match_Code);
		Self.Match_Type := Str(L.Match_Type);
		Self.Match_Level := Str(L.Match_Level);
		Self.Lexis_Nexis_Match_Code := Str(L.Lexis_Nexis_Match_Code);
		Self.Prepaid_Phone_Flag := Str(L.Prepaid_Phone_Flag);
		Self.Filler_Field_4 := Str(L.Filler_Field_4);
		Self := L;
		Self := [];
End;
Export File_In_CellPhoneOwners := Project(filedates.dData, xForm(Left));