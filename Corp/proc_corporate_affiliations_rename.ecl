import ut,roxiekeybuild,NID;


////output(Corp.Corporate_Affiliations,,'BASE::Corporate_Affiliations_' + corp.Corp_Build_Date, overwrite);
ut.MAC_SF_BuildProcess(Corp.Corporate_Affiliations,'~thor_data400::base::corporate_affiliations',basefile,2);

// Build BDID Index
ca := Corp.File_Corporate_Affiliations_Plus;

keyfields := record
ca.bdid;
ca.did;
ca.st;
ca.lname;
string6  dph_lname := metaphonelib.DMetaPhone1(ca.lname);
ca.fname;
typeof(ca.fname) pfname := NID.PreferredFirstVersionedStr(ca.fname, NID.version);
ca.__filepos;
end;

t := table(ca,keyfields);

bdid_rec := record
t.bdid;
t.__filepos
end;

bdid_records := table(t, bdid_rec);

////keyfile1 := buildindex(bdid_records,,'key::corporate_affiliations.bdid_' + corp.Corp_Build_Date,overwrite);
//k1 := index(bdid_records,,'~thor_data400::key::corporate_affiliations.bdid' + thorlib.wuid());
//ut.MAC_SK_BuildProcess_v2(k1,'~thor_data400::key::corporate_affiliations.bdid',keyfile1)

// Build State, Last Name, First Name Index

stlfname_rec := record
t.st;
t.dph_lname;
t.lname;
t.pfname;
t.fname;
t.__filepos;
end;

stlfname_records := table(t, stlfname_rec);

////keyfile2 := buildindex(stlfname_records,,'key::corporate_affiliations.state.lfname_' + corp.Corp_Build_Date,overwrite);
//k2 := index(stlfname_records,,'~thor_Data400::key::corporate_affiliations.state.lfname' + thorlib.wuid());
//ut.MAC_SK_BuildProcess_v2(k2,'~thor_data400::key::corporate_affiliations.state.lfname',keyfile2);

// Build DID Index

did_rec := record
t.did;
t.__filepos
end;

did_records := table(t, did_rec)((unsigned)did<>0);

//keyfile3 := buildindex(did_records,,'key::corporate_affiliations.did_' + corp.Corp_Build_Date,overwrite);
k3 := index(did_records,,'~thor_data400::key::corporate_affiliations.did' + thorlib.wuid());
//ut.MAC_SK_BuildProcess_v2(k3,'~thor_data400::key::corporate_affiliations.did',keyfile3);
roxiekeybuild.Mac_SK_BuildProcess_v2_local(k3,'~thor_data400::key::corporate_affiliations.did','~thor_data400::key::corporate_affiliations::'+corp.version_development+'::did', keyfile3);
roxiekeybuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::corporate_affiliations.did','~thor_data400::key::corporate_affiliations::'+corp.version_development+'::did', keyfile3a);

// Build Filepos/Payload Index
//keyfile4 := buildindex(corp.Key_Corporate_Affiliations_Filepos, overwrite);
k4 := index(
   corp.File_Corporate_Affiliations_Plus,
   {unsigned8 filepos := __filepos},
   {corp.File_Corporate_Affiliations_Plus},
   '~thor_data400::key::corporate_affiliations.filepos' + thorlib.wuid());
//ut.MAC_SK_BuildProcess_v2(k4,'~thor_data400::key::corporate_affiliations.filepos',keyfile4);
roxiekeybuild.Mac_SK_BuildProcess_v2_local(k4,'~thor_data400::key::corporate_affiliations.filepos','~thor_data400::key::corporate_affiliations::'+corp.version_development+'::filepos', keyfile4);
roxiekeybuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::corporate_affiliations.filepos','~thor_data400::key::corporate_affiliations::'+corp.version_development+'::filepos', keyfile4a);

//// Build Superkeys
///*
//superkey1D := sequential(FileServices.startsuperfiletransaction(),
//			 FileServices.clearsuperfile('~thor_data400::key::corporate_affiliations.did_DEV'),
//			 fileservices.addsuperfile('~thor_data400::key::corporate_affiliations.did_DEV','~thor_data400::key::corporate_affiliations.did_' + corp.Corp_Build_Date),
//			 fileservices.finishsuperfiletransaction()
//			);
			
//superkey1P := sequential(FileServices.startsuperfiletransaction(),
//			 FileServices.clearsuperfile('~thor_data400::key::corporate_affiliations.did_PROD'),
//			 fileservices.addsuperfile('~thor_data400::key::corporate_affiliations.did_PROD','~thor_data400::key::corporate_affiliations.did_' + corp.Corp_Build_Date),
//			 fileservices.finishsuperfiletransaction()
//			);

//superkey2D := sequential(FileServices.startsuperfiletransaction(),
//			 FileServices.clearsuperfile('~thor_data400::key::corporate_affiliations.filepos_DEV'),
//			 fileservices.addsuperfile('~thor_data400::key::corporate_affiliations.filepos_DEV','~thor_data400::key::corporate_affiliations.filepos_' + corp.Corp_Build_Date),
//			 fileservices.finishsuperfiletransaction()
//			);
			
//superkey2P := sequential(FileServices.startsuperfiletransaction(),
//			 FileServices.clearsuperfile('~thor_data400::key::corporate_affiliations.filepos_PROD'),
//			 fileservices.addsuperfile('~thor_data400::key::corporate_affiliations.filepos_PROD','~thor_data400::key::corporate_affiliations.filepos_' + corp.Corp_Build_Date),
//			 fileservices.finishsuperfiletransaction()
//			);

//*/
//export proc_corporate_affiliations := sequential(basefile,
//           parallel(keyfile1, keyfile2, keyfile3, keyfile4));
		   
export proc_corporate_affiliations_rename := sequential(basefile, 
				parallel(keyfile3, keyfile4),
				parallel(keyfile3a, keyfile4a));