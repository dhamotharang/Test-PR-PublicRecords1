myMiscRead := file_delta(SSN != '' or phone != '' or DOB != 0 or dod != '');
myNameRead := file_delta(title != '' or fname!= '' or mname!='' or lname!='' or
						name_Suffix != '');
myAddrRead := file_delta(prim_range != '' or predir!='' or prim_name!='' or
						suffix != '' or postdir != '' or unit_desig != '' or
						sec_range!='' or city_name != '' or st != '' or
						zip != '' or zip4!='');
myRecRead := file_delta(prpty_deed_id != '' or bkrupt_crtcode_caseno != '' or
						vehicle_vehnum != '');

ssnTab := myMiscRead(SSN!='');

titleTab := myNameRead(title != '');
fnameTab := myNameRead(fname != '');
mnameTab := myNameRead(mname != '');
lnameTab := myNameRead(lname != '');
nmSuffixTab := myNameRead(name_Suffix != '');

phoneTab := myMiscRead(phone != '');

DOBTab := myMiscRead(DOB != 0);

Prim_RgTab := myAddrRead(Prim_range != '');
PredirTab := myAddrRead(Predir != '');
Prim_NmTab := myAddrRead(Prim_Name != '');
SuffixTab := myAddrRead(Suffix != '');
postdirTab := myAddrRead(Postdir != '');
UDesigTab := myAddrRead(Unit_Desig != '');
SecRangeTab := myAddrRead(Sec_Range != '');
CityTab := myAddrRead(City_Name != '');
StateTab := myAddrRead(st != '');
ZipTab := myAddrRead(zip != '');
Zip4Tab := myAddrRead(Zip4 != '');

DODTab := myMiscRead(DOD != '');

PrptDeedTab := myRecRead(Prpty_Deed_Id != '');
VehicleTab := myRecRead(Vehicle_vehnum != '');
BankruptTab := myRecRead(Bkrupt_CrtCode_CaseNo != '');

Dedupify(InputTableName,InputTableNameSrt,FieldName,OutputName) := MACRO
	InputTableNameSrt := sort(distribute(InputTableName,hash(did)),did,FieldName,local);
	OutputName := dedup(InputTableNameSrt,LEFT.did = RIGHT.did and
								LEFT.FieldName = RIGHT.FieldName,local);
ENDMACRO;

Dedupify(ssnTab,ssnsort,SSN,ssnDD)
Dedupify(TitleTab,titlesort,title,titleDD)
Dedupify(fnameTab,fnamesort,fname,fnameDD)
Dedupify(mnameTab,mnamesort,mname,mnameDD)
Dedupify(lnameTab,lnamesort,lname,lnameDD)
Dedupify(nmSuffixTab,nmsuffsort,name_suffix,nmSuffixDD)
Dedupify(DOBTab,dobsort,DOB,DOBDD)
Dedupify(PhoneTab,phonesort,phone,PhoneDD)
Dedupify(Prim_RgTab,primrsort,Prim_range,prangeDD)
Dedupify(PredirTab,predirsort,Predir,PredirDD)
Dedupify(Prim_NmTab,pnamesort,prim_name,pnameDD)
Dedupify(SuffixTab,suffixsort,suffix,suffixDD)
dedupify(postdirTab,postdirsort,postdir,PostDirDD)
dedupify(UDesigTab,udesort,Unit_desig,udesigDD)
dedupify(SecRangeTab,secrsort,Sec_range,secrangeDD)
dedupify(CityTab,citysort,city_name,CityDD)
dedupify(StateTab, statesort,st, stateDD)
dedupify(ZipTab,zipsort,zip,ZipDD)
dedupify(Zip4Tab,zip4sort,zip4,zip4DD)
dedupify(DODTab,DODsort,DOD,DODDD)
dedupify(PrptDeedTab,prptddsort,prpty_deed_id,pdeedDD)
dedupify(vehicleTab,vehiclesort,vehicle_vehnum,vehicleDD)
dedupify(BankRuptTab,bakruptSort,bkrupt_crtcode_caseno,bkruptDD)

getStats(FmtName,TableName,Field,outName) := Macro

FmtName := RECORD
	did := TableName.did;
	UNSIGNED4 CntDiff := COUNT(GROUP,TableName.Field);
END;

outName := TABLE(TableName,FmtName,TableName.did,local);

ENDMACRO;

getStats(ssnfmt,ssnDD,ssn,ssnStats)
getStats(phonefmt,phonedd,phone,phoneStats)
getStats(dobfmt,dobdd,dob,dobStats)
getStats(titlefmt,titleDD,title,titleStats)
getStats(lnamefmt,lnameDD,lname,lnameStats)
getStats(mnamefmt,mnameDD,mname,mnameStats)
getStats(fnamefmt,fnameDD,fname,fnameStats)
getStats(nmSuffixFmt,nmSuffixDD,name_suffix,nmSuffixStats)
getStats(primrfmt,prangeDD,prim_range,prangeStats)
getStats(predirfmt,predirDD,predir,predirStats)
getStats(suffixfmt,suffixDD,suffix,suffixStats)
getStats(primnameFmt,pnameDD,prim_name,pnameStats)
getStats(postdirfmt,postDirDD,postdir,postdirStats)
getStats(udesigfmt,udesigDD,unit_desig,udesigStats)
getStats(secrangefmt,secrangeDD,sec_range,secrangeStats)
getStats(cityfmt,cityDD,city_name,cityStats)
getStats(statefmt,stateDD,st,stateStats)
getStats(zipfmt,zipDD,zip,ZipStats)
getStats(zip4fmt,zip4DD,zip4,Zip4Stats)
getStats(dodfmt,dodDD,dod,dodStats)
getStats(pdeedfmt,pdeedDD,prpty_deed_id,propertyStats)
getStats(bkruptfmt,bkruptDD,bkrupt_crtcode_caseno,bankruptStats)
getStats(vehiclefmt,vehicleDD,vehicle_vehnum,vehicleStats)

finalTabStart := distribute(TABLE(file_delta,stat3_finalFmt),hash(did));

doJoin(JoinName,InputTable,Field,prevOutput,outputTable) := MACRO
	stat3_finalFmt JoinName(InputTable L, stat3_finalFmt R) := Transform
		SELF.Field := L.CntDiff;
		SELF := R;
	END;

	outputTable := JOIN(inputTable,prevOutput,LEFT.did = RIGHT.did,JoinName(LEFT,RIGHT),RIGHT OUTER,local);
ENDMACRO;

doJoin(jointitle,titleStats,difftitle,finalTabStart,finalTab0)
doJoin(joinfname,fnameStats,difffname,finalTab0,finalTab1)
doJoin(joinlname,lnameStats,difflname,finalTab1,finalTab2)
doJoin(joinmname,mnameStats,diffmname,finalTab2,finalTab3)
doJoin(joinssn,ssnStats,diffssn,finalTab3,finalTab4)
doJoin(joinphone,phoneStats,diffphone,finalTab4,finalTab5)
doJoin(joindob,dobStats,diffdob,finalTab5,finalTab6)
doJoin(joinprimrange,prangeStats,diffprim_range,finalTab6,finalTab7)
doJoin(joinpredir,predirStats,diffPredir,finalTab7,finalTab8)
doJoin(joinprimname,pnameStats,diffPrim_Name,finalTab8,finalTab9)
doJoin(joinpostdir,postdirStats,diffPostdir,finalTab9,finalTab10)
doJoin(joinsuffix,suffixStats,diffSuffix,finalTab10,finalTab11)
doJoin(joinsecrange,secrangeStats,diffSec_Range,finalTab11,finalTab12)
doJoin(joinfunitdesig,udesigStats,diffUnit_Desig,finalTab12,finalTab13)
doJoin(joincity,cityStats,diffCity,finalTab13,finalTab14)
doJoin(joinstate,stateStats,diffState,finalTab14,finalTab15)
doJoin(joinzip,zipStats,diffZip,finalTab15,finalTab16)
doJoin(joinzip4,zip4Stats,diffZip4,finalTab16,finalTab17)
doJoin(joinNmSuff,nmSuffixStats,diffnmsuffix,finalTab17,finalTab18)
doJoin(joindod,dodStats,diffdod,finalTab18,finalTab19)
doJoin(joinprpty,propertyStats,diffprpty,finalTab19,finalTab20)
doJoin(joinbkrupt,bankruptStats,diffbkrupt,finalTab20,finalTab21)
doJoin(joinvehicle,vehicleStats,diffVehicle,finalTab21,quarter_finalTab)

semi_finalTab := sort(quarter_finalTab,did,local);
export stat3_finalTab := dedup(semi_finalTab,did,local);