import prte_csv,tools;

shared laypl	:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__bdid_pl;
shared dpl		:= PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__bdid_pl;

export prct_fetch_keys(

	 string					pversion										
	,dataset(laypl)	pBdidpl		= dpl

) :=
function

	//change name of keys before building so don't interfere with production keys

	dbdidpl := pBdidpl;
	dproj 	:= project(dbdidpl	,transform(business_header.Layout_Business_Header_Base_Plus_Orig	,self := left;self.rcid := counter;self := []; )) : global;
	dfetch 	:= Business_Header.File_business_header_fetch(dproj	,business_header.persistnames().FileBusinessHeaderFetch + '.prcttest');

	build_keys 	:= business_header.proc_build_new_fetch_keys(pversion,dfetch,,,'prte',false).all;
	lroxiekeys	:= business_header.RoxieKeys(pversion,dfetch,,,'prte').NewFetch;
	
	lDnames := business_header.keynames(pversion).NewFetch;
	lKnames := business_header.keynames(pversion,,,'prte').NewFetch;
	lOnames := business_header.keynames(pversion,,'out','prte').NewFetch;

	fprteBname(string pname) := regexreplace('key',regexreplace('thor_data400',pname,'prte',nocase),'out',nocase);

	lpath := regexreplace('::',PRTE_CSV.Constants.CSVFilesBaseDir,'/',nocase);
	fdesprayname	(string pname) := trim(regexreplace('::',pname,'__',nocase)[2..]) + '.csv';
	
	ddespray := dataset([
		 {lOnames.Address.new			,PRTE_CSV.Constants.CSVFilesIP	,lpath + fdesprayname(lDnames.Address.new			)	,true}
		,{lOnames.Fein.new				,PRTE_CSV.Constants.CSVFilesIP	,lpath + fdesprayname(lDnames.Fein.new				)	,true}
		,{lOnames.Name.new				,PRTE_CSV.Constants.CSVFilesIP	,lpath + fdesprayname(lDnames.Name.new				)	,true}
		,{lOnames.Phone.new				,PRTE_CSV.Constants.CSVFilesIP	,lpath + fdesprayname(lDnames.Phone.new				)	,true}
		,{lOnames.Stcityname.new	,PRTE_CSV.Constants.CSVFilesIP	,lpath + fdesprayname(lDnames.Stcityname.new	)	,true}
		,{lOnames.Stname.new			,PRTE_CSV.Constants.CSVFilesIP	,lpath + fdesprayname(lDnames.Stname.new			)	,true}
		,{lOnames.Street.new			,PRTE_CSV.Constants.CSVFilesIP	,lpath + fdesprayname(lDnames.Street.new			)	,true}
		,{lOnames.Zip.new					,PRTE_CSV.Constants.CSVFilesIP	,lpath + fdesprayname(lDnames.Zip.new					)	,true}
	],tools.Layout_DKCs.Input);
		
	return sequential(
		 build_keys
/*		,parallel(
			 output(lRoxieKeys.key_Address.New		,,lOnames.Address.new			,__compressed__,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)),overwrite)
			,output(lRoxieKeys.key_Fein.New				,,lOnames.Fein.new				,__compressed__,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)),overwrite)
			,output(lRoxieKeys.key_Name.New				,,lOnames.Name.new				,__compressed__,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)),overwrite)
			,output(lRoxieKeys.key_Phone.New			,,lOnames.Phone.new				,__compressed__,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)),overwrite)
			,output(lRoxieKeys.key_Stcityname.New	,,lOnames.Stcityname.new	,__compressed__,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)),overwrite)
			,output(lRoxieKeys.key_Stname.New			,,lOnames.Stname.new			,__compressed__,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)),overwrite)
			,output(lRoxieKeys.key_Street.New			,,lOnames.Street.new			,__compressed__,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)),overwrite)
			,output(lRoxieKeys.key_Zip.New				,,lOnames.Zip.new					,__compressed__,csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)),overwrite)
		)

		,tools.fun_Despray(ddespray)
*/
	);

end;