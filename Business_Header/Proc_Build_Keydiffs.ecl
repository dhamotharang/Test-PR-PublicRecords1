import business_header_ss, business_risk, doxie_cbrs,RoxieKeyBuild;
/*
	Business_Header.Proc_Build_Keydiffs
		Builds Keydiffs on largest keys built in the business header build.
		The parameters allow flexibility in selecting the versions of the keys to do keydiffs on
		They can be either specific versions that translate into logical keys. i.e. '20100715'
		Or, they can be superfile versions for superfiles, i.e. 'built' (the code will find the logical subfile and use that)
		The defaults of 'qa' and 'built' are tailored for the business header build.  This function will be run 
		during the business header build after all the keys have been built, but before they are moved to the qa superfiles.
		So, in that case, what's in the built	superfiles will be the new keys, and what's in the qa superfiles will 
		be the previous build's keys.
		It outputs a dataset first of all of the information it has gathered on the keys.  Take a look at this 
		to make sure it is doing keydiffs on the correct keys
*/
export Proc_Build_Keydiffs(

	 string		pversion_old	= 'qa'		// if don't pass in versions, takes them from built and qa superfiles
	,string		pversion_new	= 'built'
	,boolean	pIsTesting		=  false	// if false, run the keydiffs, else just output dataset of keydiff info

) :=
function

	oldbhkeyname		:= business_header.keynames	(pversion_old	);
	newbhkeyname		:= business_header.keynames	(pversion_new	);
	
	// -- Gather up information about keydiffs--old filename, new filename, old version, new version, keydiff filenames, etc
  dKeydiffInfo := dataset([
		 {pversion_old,pversion_new,oldbhkeyname.Base.BdidPl.version         ,newbhkeyname.Base.BdidPl.version         ,oldbhkeyname.Base.BdidPl.sub         ,newbhkeyname.Base.BdidPl.sub         ,business_header.keynames(newbhkeyname.Base.BdidPl.version         ,,'keydiff').Base.BdidPl.New         }
		,{pversion_old,pversion_new,oldbhkeyname.Contacts.Bdid.version       ,newbhkeyname.Contacts.Bdid.version       ,oldbhkeyname.Contacts.Bdid.sub       ,newbhkeyname.Contacts.Bdid.sub       ,business_header.keynames(newbhkeyname.Contacts.Bdid.version       ,,'keydiff').Contacts.Bdid.New       }
		,{pversion_old,pversion_new,oldbhkeyname.Contacts.filepos.version    ,newbhkeyname.Contacts.filepos.version    ,oldbhkeyname.Contacts.filepos.sub    ,newbhkeyname.Contacts.filepos.sub    ,business_header.keynames(newbhkeyname.Contacts.filepos.version    ,,'keydiff').Contacts.filepos.New    }
		,{pversion_old,pversion_new,oldbhkeyname.NewFetch.Address.version    ,newbhkeyname.NewFetch.Address.version    ,oldbhkeyname.NewFetch.Address.sub    ,newbhkeyname.NewFetch.Address.sub    ,business_header.keynames(newbhkeyname.NewFetch.Address.version    ,,'keydiff').NewFetch.Address.new    }
		,{pversion_old,pversion_new,oldbhkeyname.NewFetch.Name.version       ,newbhkeyname.NewFetch.Name.version       ,oldbhkeyname.NewFetch.Name.sub       ,newbhkeyname.NewFetch.Name.sub       ,business_header.keynames(newbhkeyname.NewFetch.Name.version       ,,'keydiff').NewFetch.Name.New       }
		,{pversion_old,pversion_new,oldbhkeyname.NewFetch.Stcityname.version ,newbhkeyname.NewFetch.Stcityname.version ,oldbhkeyname.NewFetch.Stcityname.sub ,newbhkeyname.NewFetch.Stcityname.sub ,business_header.keynames(newbhkeyname.NewFetch.Stcityname.version ,,'keydiff').NewFetch.Stcityname.New }
		,{pversion_old,pversion_new,oldbhkeyname.NewFetch.Stname.version     ,newbhkeyname.NewFetch.Stname.version     ,oldbhkeyname.NewFetch.Stname.sub     ,newbhkeyname.NewFetch.Stname.sub     ,business_header.keynames(newbhkeyname.NewFetch.Stname.version     ,,'keydiff').NewFetch.Stname.New     }
		,{pversion_old,pversion_new,oldbhkeyname.NewFetch.Street.version     ,newbhkeyname.NewFetch.Street.version     ,oldbhkeyname.NewFetch.Street.sub     ,newbhkeyname.NewFetch.Street.sub     ,business_header.keynames(newbhkeyname.NewFetch.Street.version     ,,'keydiff').NewFetch.Street.New     }
		,{pversion_old,pversion_new,oldbhkeyname.NewFetch.Zip.version        ,newbhkeyname.NewFetch.Zip.version        ,oldbhkeyname.NewFetch.Zip.sub        ,newbhkeyname.NewFetch.Zip.sub        ,business_header.keynames(newbhkeyname.NewFetch.Zip.version        ,,'keydiff').NewFetch.Zip.New        }
		,{pversion_old,pversion_new,oldbhkeyname.relatives.bdid1.version     ,newbhkeyname.relatives.bdid1.version     ,oldbhkeyname.relatives.bdid1.sub     ,newbhkeyname.relatives.bdid1.sub     ,business_header.keynames(newbhkeyname.relatives.bdid1.version     ,,'keydiff').relatives.bdid1.new     }
		,{pversion_old,pversion_new,oldbhkeyname.risk.BHAddress.version      ,newbhkeyname.risk.BHAddress.version      ,oldbhkeyname.risk.BHAddress.sub      ,newbhkeyname.risk.BHAddress.sub      ,business_header.keynames(newbhkeyname.risk.BHAddress.version      ,,'keydiff').risk.BHAddress.New      }
	
	],{string oldpversion,string newpversion,string oldlogicalversion,string newlogicalversion,string oldlogicalkeyname,string newlogicalkeyname,string keydiffname});
	
	dBadKeydiffInfo 			:= dKeydiffInfo((oldlogicalversion = newlogicalversion) or (oldlogicalversion = '') or (newlogicalversion = '') or (oldlogicalversion > newlogicalversion));
	dLogicalVersionsequal	:= dBadKeydiffInfo(oldlogicalversion = newlogicalversion and oldlogicalversion != oldpversion and newlogicalversion != newpversion);
	dOldLogicalBlank			:= dBadKeydiffInfo(oldlogicalversion = '' and oldpversion != '');
	dNewLogicalBlank			:= dBadKeydiffInfo(newlogicalversion = '' and newpversion != '');
	dOldVersionGtNew			:= dBadKeydiffInfo(oldlogicalversion > newlogicalversion);
	
	// -- Old Index Definitions
	oldKey_BH_BDID_pl              := INDEX(Business_Header_SS.Key_BH_BDID_pl           ,oldbhkeyname.Base.BdidPl.sub      );
	oldKey_Business_Contacts       := INDEX(business_header.Key_Business_Contacts_FP    ,oldbhkeyname.Contacts.filepos.sub );
	oldKey_Business_Contacts_bdid  := INDEX(business_header.Key_Business_Contacts_BDID  ,oldbhkeyname.Contacts.Bdid.sub    );
	oldKey_Business_Relatives      := INDEX(business_header.Key_Business_Relatives      ,oldbhkeyname.relatives.bdid1.sub  );
	oldKey_Business_risk_address   := INDEX(Business_Risk.Key_Business_Header_Address   ,oldbhkeyname.risk.BHAddress.sub   );
	oldKey_Newfetch_address        := business_header.RoxieKeys(oldbhkeyname.NewFetch.Address.version    ).NewFetch.key_Address.New    ;
	oldKey_Newfetch_name           := business_header.RoxieKeys(oldbhkeyname.NewFetch.Name.version       ).NewFetch.key_Name.New       ;
	oldKey_Newfetch_stcityname     := business_header.RoxieKeys(oldbhkeyname.NewFetch.Stcityname.version ).NewFetch.key_Stcityname.New ;
	oldKey_Newfetch_stname         := business_header.RoxieKeys(oldbhkeyname.NewFetch.Stname.version     ).NewFetch.key_Stname.New     ;
	oldKey_Newfetch_street         := business_header.RoxieKeys(oldbhkeyname.NewFetch.Street.version     ).NewFetch.key_Street.New     ;
	oldKey_Newfetch_zip            := business_header.RoxieKeys(oldbhkeyname.NewFetch.Zip.version        ).NewFetch.key_Zip.New        ;

	// -- New Index Definitions
	newKey_BH_BDID_pl              := INDEX(Business_Header_SS.Key_BH_BDID_pl           ,newbhkeyname.Base.BdidPl.sub      );
	newKey_Business_Contacts       := INDEX(business_header.Key_Business_Contacts_FP    ,newbhkeyname.Contacts.filepos.sub );
	newKey_Business_Contacts_bdid  := INDEX(business_header.Key_Business_Contacts_BDID  ,newbhkeyname.Contacts.Bdid.sub    );
	newKey_Business_Relatives      := INDEX(business_header.Key_Business_Relatives      ,newbhkeyname.relatives.bdid1.sub  );
	newKey_Business_risk_address   := INDEX(Business_Risk.Key_Business_Header_Address   ,newbhkeyname.risk.BHAddress.sub   );
	newKey_Newfetch_address        := business_header.RoxieKeys(newbhkeyname.NewFetch.Address.version    ).NewFetch.key_Address.New    ;
	newKey_Newfetch_name           := business_header.RoxieKeys(newbhkeyname.NewFetch.Name.version       ).NewFetch.key_Name.New       ;
	newKey_Newfetch_stcityname     := business_header.RoxieKeys(newbhkeyname.NewFetch.Stcityname.version ).NewFetch.key_Stcityname.New ;
	newKey_Newfetch_stname         := business_header.RoxieKeys(newbhkeyname.NewFetch.Stname.version     ).NewFetch.key_Stname.New     ;
	newKey_Newfetch_street         := business_header.RoxieKeys(newbhkeyname.NewFetch.Street.version     ).NewFetch.key_Street.New     ;
	newKey_Newfetch_zip            := business_header.RoxieKeys(newbhkeyname.NewFetch.Zip.version        ).NewFetch.key_Zip.New        ;

	// -- Keydiff Macro calls

	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_BH_BDID_pl             ,newKey_BH_BDID_pl             ,business_header.keynames(newbhkeyname.Base.BdidPl.version         ,,'keydiff').Base.BdidPl.New         ,kdbheader1	);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Business_Contacts      ,newKey_Business_Contacts      ,business_header.keynames(newbhkeyname.Contacts.filepos.version    ,,'keydiff').Contacts.filepos.New    ,kdbheader2	);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Business_Contacts_bdid ,newKey_Business_Contacts_bdid ,business_header.keynames(newbhkeyname.Contacts.Bdid.version       ,,'keydiff').Contacts.Bdid.New       ,kdbheader3	);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Business_Relatives     ,newKey_Business_Relatives     ,business_header.keynames(newbhkeyname.relatives.bdid1.version     ,,'keydiff').relatives.bdid1.new     ,kdbheader4	);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Business_risk_address  ,newKey_Business_risk_address  ,business_header.keynames(newbhkeyname.risk.BHAddress.version      ,,'keydiff').risk.BHAddress.New      ,kdbheader5	);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Newfetch_address       ,newKey_Newfetch_address       ,business_header.keynames(newbhkeyname.NewFetch.Address.version    ,,'keydiff').NewFetch.Address.new    ,kdbheader6	);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Newfetch_name          ,newKey_Newfetch_name          ,business_header.keynames(newbhkeyname.NewFetch.Name.version       ,,'keydiff').NewFetch.Name.New       ,kdbheader7	);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Newfetch_stcityname    ,newKey_Newfetch_stcityname    ,business_header.keynames(newbhkeyname.NewFetch.Stcityname.version ,,'keydiff').NewFetch.Stcityname.New ,kdbheader8	);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Newfetch_stname        ,newKey_Newfetch_stname        ,business_header.keynames(newbhkeyname.NewFetch.Stname.version     ,,'keydiff').NewFetch.Stname.New     ,kdbheader9	);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Newfetch_street        ,newKey_Newfetch_street        ,business_header.keynames(newbhkeyname.NewFetch.Street.version     ,,'keydiff').NewFetch.Street.New     ,kdbheader10	);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Newfetch_zip           ,newKey_Newfetch_zip           ,business_header.keynames(newbhkeyname.NewFetch.Zip.version        ,,'keydiff').NewFetch.Zip.New        ,kdbheader11	);

	build_keydiffs :=
	parallel(
		 kdbheader1	
		,kdbheader2	
		,kdbheader3	
		,kdbheader4	
		,kdbheader5	
		,kdbheader6	
		,kdbheader7	
		,kdbheader8	
		,kdbheader9	
		,kdbheader10
		,kdbheader11
	);

	return 
	sequential(
		 nothor(output(dKeydiffInfo	,named('Business_Header_Proc_Build_Keydiffs_Info')))
		,if(				pversion_old 					!= ''
					 and	pversion_new 					!= ''
					 and	pversion_old 					!= pversion_new
					 and	nothor(count(dBadKeydiffInfo)) = 0 
					 and	not pIstesting													
			, build_keydiffs
			,sequential(
				 nothor(output(dBadKeydiffInfo													,named('Bad_Keydiff_Info')))
				,output('Business_Header.Proc_Build_Keydiffs: Testing.')
				,fail(nothor('Business_Header.Proc_Build_Keydiffs ERROR:  ' 
					+ if(pIsTesting	,'Parameter pIsTesting set to true, testing turned on.  ','')
					+ 'Business_Header Keydiffs have not been run because of the following:  '
					+ if(pversion_old 														= pversion_new	,'The versions passed in are the same.  '									,'')
					+ if(pversion_old 														= ''						,'Parameter pversion_old is blank. '											,'')
					+ if(pversion_new 														= ''						,'Parameter pversion_new is blank. '											,'')
					+ if(count(dLogicalVersionsequal	)   != 0							,'Some Logical Subfile(s) of superfile(s) are the same.  ','')
					+ if(count(dOldLogicalBlank				)   != 0							,'Some old superfile(s) do not contain subfile(s).  '			,'')	
					+ if(count(dNewLogicalBlank				)   != 0							,'Some new superfile(s) do not contain subfile(s).  '			,'')	
					+ if(count(dOldVersionGtNew				)   != 0							,'Some old versions are greater than the new versions.  '	,'')	
					+ 'Check the Bad_Keydiff_Info named dataset in the results to find out the details'
				))
			)
		)
	);
end;