import Business_Header, PRTE_CSV, PRTE2, Risk_Indicators, MDR;

export Files_Prte_Addr_HRI_Keys() := 
module

	shared lSubDirName				:=	'';
	shared lCSVFileNamePrefix	:= PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

	
	//*** ******************* Key1 GOOD *********************************************************
	//*** Key attibute Risk_Indicators.Key_HRI_Address_To_Sic
	//*** Superfile name: ~thor_data400::key::hri_address_to_sic_qa
	//*** Logicalfile name: ~prte::key::business_header::<versiondate>::hri::address
	//*** **********************************************************************************
	shared rthor_data400__key__business_header__hri__address	:= record
		string5		z5;
		string28	prim_name;
		string4		suffix;
		string2 	predir;
		string2 	postdir;
		string10 	prim_range;
		string8 	sec_range;
		unsigned3 dt_first_seen;
		string4 	sic_code;
		string120 company_name;
		string25 	city;
		string2 	state;
		string2 	source;
		unsigned8 __internal_fpos__;
	end;
	
	//*** thor_data400__key__business_header____hri__address.csv is missing so, using the below one, which is of same layout and same record
	export HRI_Addr_Sic := project(dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__filtered____hri__address.csv' ,rthor_data400__key__business_header__hri__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single))),
																 transform(Risk_Indicators.Layout_HRI_Address_Sic,
																					 self.addr_suffix := left.suffix,
																					 self.zip := left.z5,
																					 self := left,
																					 self := [])) +
												 Risk_Indicators.files(,true).HRIAddressSicCode.qa((integer)zip<>0 and ~mdr.sourceTools.SourceIsACA(source) and ~mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(source));

	
	//*** ******************* Key2 GOOD *********************************************************
	//*** Key attibute Risk_Indicators.Key_HRI_Sic_Zip_To_Address
	//*** Superfile name: ~thor_data400::key::hri_sic_zip_to_address_qa
	//*** Logicalfile name: ~prte::key::business_header::<versiondate>::hri::sic.z5
	//*** **********************************************************************************
	shared rthor_data400__key__business_header__hri__sic__zip	:= record
		string4  sic_code;
		string5  z5;
		real8 	 lat;
		real8 	 long;
		string10 prim_range;
		string2  predir;
		string28 prim_name;
		string4  suffix;
		string2  postdir;
		string5  unit_desig;
		string8  sec_range;
		string25 city;
		string2  state;
		string4  z4;
		string12 bdid;
		string2  source;
		unsigned8 __internal_fpos__;
	end;
	
	File_HRIAddrSic2 := distribute(Risk_Indicators.files(,true).HRIAddressSicCode2.qa((integer)zip<>0 and ~mdr.sourceTools.SourceIsACA(source) and ~mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(source)), hash(bdid));
	File_BH_Best		 := distribute(Business_Header.files(,true).base.Business_Header_Best.qa, hash(bdid));
	
	layout_ext := record	
		recordof(File_HRIAddrSic2);
		File_BH_Best.company_name;
	end;
	
	File_HRIAddrSic2_Cname := join( File_BH_Best, File_HRIAddrSic2,
																	left.bdid = right.bdid, 
																	transform(layout_ext,																						
																						self.company_name := left.company_name,
																						self := right),
																	right outer, local
																);
										
	File_HRIAddrSic2_Proj := project(File_HRIAddrSic2_Cname, 
																	 transform(recordof(File_HRIAddrSic2), 
																						 self.bdid := PRTE2.fn_AppendFakeID.bdid(left.company_name, left.prim_range, left.prim_name, left.city, left.state, left.zip,''),
																						 self := left));

	export HRI_Sic_Zip_To_Addr := File_HRIAddrSic2_Proj;
																			 
	//*** ******************* Key3 GOOD *********************************************************
	//*** Key attibute Risk_Indicators.Key_Address_To_Sic
	//*** Superfile name: ~thor_data400::key::business_header::qa::address_siccode
	//*** Logicalfile name: ~prte::key::business_header::<versiondate>::address_siccode
	//*** **********************************************************************************
	shared rthor_data400__key__business_header__address_siccode	:= record
		string10 prim_range;
		string2  predir;
		string28 prim_name;
		string4  addr_suffix;
		string2  postdir;
		string5  unit_desig;
		string8  sec_range;
		string25 city;
		string2  state;
		string5  zip;
		string4  zip4;
		string8  sic_code;
		string2	 source;
	end;
	
	//*** Filtered Dunn_Bradstreet_Fein records from PRTE key build process
	//*** 
	export Addr_To_Siccode := Risk_Indicators.files(,true).AddressSicCode.qa((integer)zip<>0 and ~mdr.sourceTools.SourceIsACA(source) and ~mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(source));
	
	
	//*** ******************* Key4 GOOD *********************************************************
	//*** Key attibute Risk_Indicators.Key_Address_To_Sic_Full_HRI
	//*** Superfile name: ~thor_data400::key::business_header::qa::hri::address_siccode
	//*** Logicalfile name: ~prte::key::business_header::<versiondate>::hri::address_siccode	
	//*** **********************************************************************************
	shared rthor_data400__key__business_header__hri__address_siccode := record
		string10 prim_range;
		string2  predir;
		string28 prim_name;
		string4  addr_suffix;
		string2  postdir;
		string5  unit_desig;
		string8  sec_range;
		string25 city;
		string2  state;
		string5  zip;
		string4  zip4;
		string8  sic_code;
		string2  source;
	end;
	
	export Address_To_Sic_Full_HRI := Risk_Indicators.files(,true).AddressSicCode.qa((integer)zip<>0, sic_code in Risk_Indicators.set_HRI_Sics and ~mdr.sourceTools.SourceIsACA(source) and ~mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(source));
	
	//*** ******************* Key5 GOOD *********************************************************
	//*** Key attibute Risk_Indicators.Key_Sic_Description
	//*** Superfile name: ~thor_data400::key::business_header::qa::siccode_description
	//*** Logicalfile name: ~prte::key::business_header::<versiondate>::siccode_description
	//*** **********************************************************************************
	shared rthor_data400__key__business_header__siclookup := record
		string8		sic_code				;
		string80	sic_description	;
	end;
	
	export Sic_Desc := Risk_Indicators.files(,true).SicLookup.qa;
	
		
	//*** ******************* FCRA Key6 GOOD *********************************************************
	//*** Key attibute Risk_Indicators.Key_HRI_Address_To_Sic_filtered
	//*** Superfile name: ~thor_data400::key::hri_address_to_sic_filtered_qa
	//*** Logicalfile name: ~prte::key::business_header::filtered::<versiondate>::hri::address
	//*** **********************************************************************************
	shared rthor_data400__key__business_header__filtered__hri__address	:= record
		rthor_data400__key__business_header__hri__address;
	end;

	export HRI_Addr_To_Sic_Filtered := project(dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__filtered____hri__address.csv', rthor_data400__key__business_header__filtered__hri__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single))),
																						 transform(Risk_Indicators.Layout_HRI_Address_Sic, 
																											 self.addr_suffix := left.suffix,
																											 self.zip := left.z5,
																											 self := left,
																											 self := [])) +
																		 Risk_Indicators.files(,true).HRIAddressSicCodeFCRA.qa((integer)zip<>0 and ~mdr.sourceTools.SourceIsACA(source) and ~mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(source));
	
	
	//*** ******************* FCRA Key7 GOOD *********************************************************	
	//*** Key attibute Risk_Indicators.Key_HRI_Address_To_Sic_filtered_FCRA
	//*** Superfile name: ~thor_data400::key::business_header::filtered::fcra::qa::hri::address
	//*** Logicalfile name: ~prte::key::business_header::filtered::fcra::<versiondate>::hri::address
	//*** **********************************************************************************
	shared rthor_data400__key__business_header__filtered__fcra__hri__address	:= record
		rthor_data400__key__business_header__hri__address;
	end;

	export HRI_Addr_To_Sic_Filtered_Fcra := project(dataset(lCSVFileNamePrefix + 'thor_data400__key__business_header__filtered____hri__address.csv'	,rthor_data400__key__business_header__filtered__fcra__hri__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single))),
																									transform(Risk_Indicators.Layout_HRI_Address_Sic,
																														self.addr_suffix := left.suffix,
																														self.zip := left.z5,
																														self := left,
																														self := [])) +
																					Risk_Indicators.files(,true).HRIAddressSicCodeFCRA.qa((integer)zip<>0 and ~mdr.sourceTools.SourceIsACA(source) and ~mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(source));
	



end;