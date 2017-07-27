import fieldstats,ut;
#workunit('name', 'ATF firearms explosives did ' + atf.version);

//----------[ IMPORTANT ]----------//
//							//
//     Remember to set version     //
//							//
//---------------------------------//


pre := sequential(
	fileservices.startsuperfiletransaction(),
	fileservices.clearsuperfile('in::atf_firearms_explosives_FATHER'),
	fileservices.addsuperfile('in::atf_firearms_explosives_FATHER','~thor_data400::in::atf_firearms_explosives_IN',0,true),
	fileservices.clearsuperfile('in::atf_firearms_explosives_IN'),
	fileservices.addsuperfile('in::atf_firearms_explosives_IN','~thor_data400::in::atf_firearms_explosives_' + atf.version),
	fileservices.finishsuperfiletransaction()
	);

inf := atf.file_firearms_explosives_in;

fieldstats.Mac_Stat_File(inf,pre2,'atf_firearms_explosives',50,5,false,
				license_number,'string','M',
				License_Name,'string','M',
				premise_prim_name,'string','M',
				Business_Name,'string','M',
				Lic_Type,'string','F')

df := atf.firearms_explosives_did_ssn;

ut.MAC_SF_BuildProcess(df,'base::atf_firearms_explosives',b,3)
			
c := atf.proc_build_keys;

//ds := dataset('base::atf_firearms_explosives', atf.layout_firearms_explosives_out, flat);
//d := output(count(ds), NAMED('RecordCount'));
//e := output(count(ds((integer)DID_out > 0)), NAMED('RecordCountWithDID'));


export proc_build_test := sequential(b);