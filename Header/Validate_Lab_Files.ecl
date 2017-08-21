// function to validate files for LAB project
import lib_workunitservices, doxie_build, header_slimsort,_control,PersonLinkingADL2V3,ut;
export Validate_Lab_Files() := function

	isvalidkey(inkey,retval) := macro
		retval := if (regexreplace('thor400_84::',
						fileservices.getsuperfilesubname('~thor400_84::'+trim(inkey,left,right),1),'')
						not in set(fileset,filename),
						fail(inkey + ' is being used instead of LAB key'),
						output(fileservices.getsuperfilesubname('~thor400_84::'+trim(inkey,left,right),1))
						);

	endmacro;

// list of all possible LAB files

	fileset := dataset([{'base::header_qctest_w20120919-062353'},
{'base::transunion_did_w20120919-080641'},
{'base::tucs_did_w20120919-080641'},
{'base::transunioncred_did_w20120919-080641'},
{'base::file_header_building_W20120921-150108'},
{'key::20120726c::personlinkingadl2v3personheaderaddress3refs'},
{'key::20120726c::personlinkingadl2v3personheaderdorefs'},
{'key::20120726c::personlinkingadl2v3personheaderflstrefs'},
{'key::20120726c::personlinkingadl2v3personheaderlfzrefs'},
{'key::20120726c::personlinkingadl2v3personheaderphrefs'},
{'key::20120726c::personlinkingadl2v3personheadersrefs'},
{'key::20120726c::personlinkingadl2v3personheaderssn4refs'},
{'key::20120726c::personlinkingadl2v3personheaderzprfrefs'},
{'base::hss_name_dayob_w20120919-080641'},
{'base::hss_name_ssn_w20120919-080641'},
{'base::hss_name_address_w20120919-080641'},
{'base::hss_name_phone_w20120919-080641'},
{'base::hss_name_zip_age_ssn4_w20120919-080641'},
{'base::hss_name_source_w20120919-080641'},
{'BASE::Relatives_W20120920-072055-2'},
{'BASE::HHID_W20120920-072055-2'}],{string filename});

// list of files used in this WU

inwufiles := lib_workunitservices.WorkunitServices.WorkunitFilesRead(WORKUNIT);

string_rec := record
	string name;
end;

string_rec proj_recs(inwufiles l) := transform
	self.name := regexreplace(ut.Word(l.name,1,':')+'::',l.name,'');
end;

wufiles := project(inwufiles,proj_recs(left));

// keys

isvalidkey(PersonLinkingADL2V3.Filename_Keys.kaddress3,r1);
isvalidkey(PersonLinkingADL2V3.Filename_Keys.kDOB,r2);
isvalidkey(PersonLinkingADL2V3.Filename_Keys.kFLST,r3);
isvalidkey(PersonLinkingADL2V3.Filename_Keys.kLFZ,r4);
isvalidkey(PersonLinkingADL2V3.Filename_Keys.kphone,r5);
isvalidkey(PersonLinkingADL2V3.Filename_Keys.kSSN,r6);
isvalidkey(PersonLinkingADL2V3.Filename_Keys.kSSN4,r7);
isvalidkey(PersonLinkingADL2V3.Filename_Keys.kZPRF,r8);


return sequential(
// output base files
parallel(output(choosen(dataset(header.Filename_Header,header.Layout_Header_v2,flat),1)),
output(choosen(Header.file_Transunion_did,1)),
output(choosen(Header.file_TUCS_did,1)),
output(choosen(Header.file_TN_did,1)),
output(choosen(Doxie_build.file_header_building,1)),
output(choosen(Header_SlimSort.RawFile_Name_Dayob,1)),
output(choosen(Header_SlimSort.RawFile_Name_SSN,1)),
output(choosen(Header_SlimSort.RawFile_Name_Address,1)),
output(choosen(Header_SlimSort.RawFile_Name_Phone,1)),
output(choosen(Header_SlimSort.RawFile_Name_Zip_Age_Ssn4,1)),
output(choosen(Header_SlimSort.RawFile_Name_Source,1)),
output(choosen(Header.File_Relatives,1)),
output(choosen(Header.File_HHID,1))),
// for each LAB file confirm that attribute is pointing to right file
apply(fileset,
		if(stringlib.stringtolowercase(filename) not in set(wufiles,name),
				if( ~regexfind('key',filename),
					fail(filename + ' not being used, check the sandboxed code')
					)
				)
			),
r1,r2,r3,r4,r5,r6,r7,r8
		
);
end;