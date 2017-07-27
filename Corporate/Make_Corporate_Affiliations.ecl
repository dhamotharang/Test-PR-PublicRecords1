#workunit('name', 'Build Corporate Affiliations ' + corporate.Corp4_Build_Date);

import NID;

basefile := output(Corporate.Corporate_Affiliations,,'BASE::Corporate_Affiliations_' + corporate.Corp4_Build_Date, overwrite);

// Build BDID Index
ca := Corporate.File_Corporate_Affiliations_Plus;

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

keyfile1 := buildindex(bdid_records,,'key::corporate_affiliations.bdid_' + corporate.Corp4_Build_Date,overwrite);

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

keyfile2 := buildindex(stlfname_records,,'key::corporate_affiliations.state.lfname_' + corporate.Corp4_Build_Date,overwrite);

// Build DID Index

did_rec := record
t.did;
t.__filepos
end;

did_records := table(t, did_rec);

keyfile3 := buildindex(did_records,,'key::corporate_affiliations.did_' + corporate.Corp4_Build_Date,overwrite);

// Build Filepos/Payload Index
keyfile4 := buildindex(corporate.Key_Corporate_Affiliations_Filepos, overwrite);

// Build Superkeys
superkey1D := sequential(FileServices.startsuperfiletransaction(),
			 FileServices.clearsuperfile('~thor_data400::key::corporate_affiliations.did_DEV'),
			 fileservices.addsuperfile('~thor_data400::key::corporate_affiliations.did_DEV','~thor_data400::key::corporate_affiliations.did_' + corporate.Corp4_Build_Date),
			 fileservices.finishsuperfiletransaction()
			);
			
superkey1P := sequential(FileServices.startsuperfiletransaction(),
			 FileServices.clearsuperfile('~thor_data400::key::corporate_affiliations.did_PROD'),
			 fileservices.addsuperfile('~thor_data400::key::corporate_affiliations.did_PROD','~thor_data400::key::corporate_affiliations.did_' + corporate.Corp4_Build_Date),
			 fileservices.finishsuperfiletransaction()
			);

superkey2D := sequential(FileServices.startsuperfiletransaction(),
			 FileServices.clearsuperfile('~thor_data400::key::corporate_affiliations.filepos_DEV'),
			 fileservices.addsuperfile('~thor_data400::key::corporate_affiliations.filepos_DEV','~thor_data400::key::corporate_affiliations.filepos_' + corporate.Corp4_Build_Date),
			 fileservices.finishsuperfiletransaction()
			);
			
superkey2P := sequential(FileServices.startsuperfiletransaction(),
			 FileServices.clearsuperfile('~thor_data400::key::corporate_affiliations.filepos_PROD'),
			 fileservices.addsuperfile('~thor_data400::key::corporate_affiliations.filepos_PROD','~thor_data400::key::corporate_affiliations.filepos_' + corporate.Corp4_Build_Date),
			 fileservices.finishsuperfiletransaction()
			);


sequential(basefile,
           parallel(keyfile1, keyfile2, keyfile3, keyfile4),
		   superkey1D,
		   superkey1P,
		   superkey2D,
		   superkey2P);