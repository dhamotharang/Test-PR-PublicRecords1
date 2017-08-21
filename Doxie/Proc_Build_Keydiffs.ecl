import business_header_ss, business_risk, doxie_cbrs,RoxieKeyBuild,address_file,header,AID_Build,lssi;
/*
	doxie.Proc_Build_Keydiffs
		Builds Keydiffs on largest keys built in the Person header build.
		The parameters allow flexibility in selecting the versions of the keys to do keydiffs on
		They can be either specific versions that translate into logical keys. i.e. '20100715'
		Or, they can be superfile versions for superfiles, i.e. 'built' (the code will find the logical subfile and use that)
		The defaults of 'qa' and 'built' are tailored for the Person header build.  This function will be run 
		during the Person header build after all the keys have been built, but before they are moved to the qa superfiles.
		So, in that case, what's in the built	superfiles will be the new keys, and what's in the qa superfiles will 
		be the previous build's keys.
		It outputs a dataset first of all of the information it has gathered on the keys.  Take a look at this 
		to make sure it is doing keydiffs on the correct keys
*/
export Proc_Build_Keydiffs(

	 string		pversion_new					= 'built'
	,string		pversion_old					= 'qa'		// if don't pass in versions, takes them from built and qa superfiles
	,boolean	pIsTesting						= false		// if false, run the keydiffs, else just output dataset of keydiff info
	,boolean	pUseOtherEnvironment	= false		// if true, pull keys from other environment.

) :=
function

	oldkeyname		:= keynames	(pversion_old	,pUseOtherEnvironment);
	newkeyname		:= keynames	(pversion_new	,pUseOtherEnvironment);
	
	// -- Gather up information about keydiffs--old filename, new filename, old version, new version, keydiff filenames, etc
  dKeydiffInfo := dataset([
		 {pversion_old,pversion_new,oldkeyname.AID_Build_Key_AID_Base.version                  ,newkeyname.AID_Build_Key_AID_Base.version               ,oldkeyname.AID_Build_Key_AID_Base.sub              ,newkeyname.AID_Build_Key_AID_Base.sub              ,keynames(newkeyname.AID_Build_Key_AID_Base.version               ,,'keydiff').AID_Build_Key_AID_Base.new               }
		,{pversion_old,pversion_new,oldkeyname.Business_Risk_Key_SSN_Address.version           ,newkeyname.Business_Risk_Key_SSN_Address.version        ,oldkeyname.Business_Risk_Key_SSN_Address.sub       ,newkeyname.Business_Risk_Key_SSN_Address.sub       ,keynames(newkeyname.Business_Risk_Key_SSN_Address.version        ,,'keydiff').Business_Risk_Key_SSN_Address.new        }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Address.version                       ,newkeyname.Doxie_Key_Address.version                    ,oldkeyname.Doxie_Key_Address.sub                   ,newkeyname.Doxie_Key_Address.sub                   ,keynames(newkeyname.Doxie_Key_Address.version                    ,,'keydiff').Doxie_Key_Address.new                    }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Did_Rid.version                       ,newkeyname.Doxie_Key_Did_Rid.version                    ,oldkeyname.Doxie_Key_Did_Rid.sub                   ,newkeyname.Doxie_Key_Did_Rid.sub                   ,keynames(newkeyname.Doxie_Key_Did_Rid.version                    ,,'keydiff').Doxie_Key_Did_Rid.new                    }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Did_Rid2.version                      ,newkeyname.Doxie_Key_Did_Rid2.version                   ,oldkeyname.Doxie_Key_Did_Rid2.sub                  ,newkeyname.Doxie_Key_Did_Rid2.sub                  ,keynames(newkeyname.Doxie_Key_Did_Rid2.version                   ,,'keydiff').Doxie_Key_Did_Rid2.new                   }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header.version                        ,newkeyname.Doxie_Key_Header.version                     ,oldkeyname.Doxie_Key_Header.sub                    ,newkeyname.Doxie_Key_Header.sub                    ,keynames(newkeyname.Doxie_Key_Header.version                     ,,'keydiff').Doxie_Key_Header.new                     }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_Address.version                ,newkeyname.Doxie_Key_Header_Address.version             ,oldkeyname.Doxie_Key_Header_Address.sub            ,newkeyname.Doxie_Key_Header_Address.sub            ,keynames(newkeyname.Doxie_Key_Header_Address.version             ,,'keydiff').Doxie_Key_Header_Address.new             }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_DA.version                     ,newkeyname.Doxie_Key_Header_DA.version                  ,oldkeyname.Doxie_Key_Header_DA.sub                 ,newkeyname.Doxie_Key_Header_DA.sub                 ,keynames(newkeyname.Doxie_Key_Header_DA.version                  ,,'keydiff').Doxie_Key_Header_DA.new                  }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_DTS_Address.version            ,newkeyname.Doxie_Key_Header_DTS_Address.version         ,oldkeyname.Doxie_Key_Header_DTS_Address.sub        ,newkeyname.Doxie_Key_Header_DTS_Address.sub        ,keynames(newkeyname.Doxie_Key_Header_DTS_Address.version         ,,'keydiff').Doxie_Key_Header_DTS_Address.new         }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_DTS_StreetZipName.version      ,newkeyname.Doxie_Key_Header_DTS_StreetZipName.version   ,oldkeyname.Doxie_Key_Header_DTS_StreetZipName.sub  ,newkeyname.Doxie_Key_Header_DTS_StreetZipName.sub  ,keynames(newkeyname.Doxie_Key_Header_DTS_StreetZipName.version   ,,'keydiff').Doxie_Key_Header_DTS_StreetZipName.new   }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_Name.version                   ,newkeyname.Doxie_Key_Header_Name.version                ,oldkeyname.Doxie_Key_Header_Name.sub               ,newkeyname.Doxie_Key_Header_Name.sub               ,keynames(newkeyname.Doxie_Key_Header_Name.version                ,,'keydiff').Doxie_Key_Header_Name.new                }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_Name_alt.version               ,newkeyname.Doxie_Key_Header_Name_alt.version            ,oldkeyname.Doxie_Key_Header_Name_alt.sub           ,newkeyname.Doxie_Key_Header_Name_alt.sub           ,keynames(newkeyname.Doxie_Key_Header_Name_alt.version            ,,'keydiff').Doxie_Key_Header_Name_alt.new            }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_StCityLFName.version           ,newkeyname.Doxie_Key_Header_StCityLFName.version        ,oldkeyname.Doxie_Key_Header_StCityLFName.sub       ,newkeyname.Doxie_Key_Header_StCityLFName.sub       ,keynames(newkeyname.Doxie_Key_Header_StCityLFName.version        ,,'keydiff').Doxie_Key_Header_StCityLFName.new        }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_StFnameLname.version           ,newkeyname.Doxie_Key_Header_StFnameLname.version        ,oldkeyname.Doxie_Key_Header_StFnameLname.sub       ,newkeyname.Doxie_Key_Header_StFnameLname.sub       ,keynames(newkeyname.Doxie_Key_Header_StFnameLname.version        ,,'keydiff').Doxie_Key_Header_StFnameLname.new        }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_StreetZipName.version          ,newkeyname.Doxie_Key_Header_StreetZipName.version       ,oldkeyname.Doxie_Key_Header_StreetZipName.sub      ,newkeyname.Doxie_Key_Header_StreetZipName.sub      ,keynames(newkeyname.Doxie_Key_Header_StreetZipName.version       ,,'keydiff').Doxie_Key_Header_StreetZipName.new       }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_Wild_Address.version           ,newkeyname.Doxie_Key_Header_Wild_Address.version        ,oldkeyname.Doxie_Key_Header_Wild_Address.sub       ,newkeyname.Doxie_Key_Header_Wild_Address.sub       ,keynames(newkeyname.Doxie_Key_Header_Wild_Address.version        ,,'keydiff').Doxie_Key_Header_Wild_Address.new        }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_Wild_Address_EN.version        ,newkeyname.Doxie_Key_Header_Wild_Address_EN.version     ,oldkeyname.Doxie_Key_Header_Wild_Address_EN.sub    ,newkeyname.Doxie_Key_Header_Wild_Address_EN.sub    ,keynames(newkeyname.Doxie_Key_Header_Wild_Address_EN.version     ,,'keydiff').Doxie_Key_Header_Wild_Address_EN.new     }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_Wild_Address_Loose.version     ,newkeyname.Doxie_Key_Header_Wild_Address_Loose.version  ,oldkeyname.Doxie_Key_Header_Wild_Address_Loose.sub ,newkeyname.Doxie_Key_Header_Wild_Address_Loose.sub ,keynames(newkeyname.Doxie_Key_Header_Wild_Address_Loose.version  ,,'keydiff').Doxie_Key_Header_Wild_Address_Loose.new  }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_Wild_Name.version              ,newkeyname.Doxie_Key_Header_Wild_Name.version           ,oldkeyname.Doxie_Key_Header_Wild_Name.sub          ,newkeyname.Doxie_Key_Header_Wild_Name.sub          ,keynames(newkeyname.Doxie_Key_Header_Wild_Name.version           ,,'keydiff').Doxie_Key_Header_Wild_Name.new           }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_Wild_StCityLFName.version      ,newkeyname.Doxie_Key_Header_Wild_StCityLFName.version   ,oldkeyname.Doxie_Key_Header_Wild_StCityLFName.sub  ,newkeyname.Doxie_Key_Header_Wild_StCityLFName.sub  ,keynames(newkeyname.Doxie_Key_Header_Wild_StCityLFName.version   ,,'keydiff').Doxie_Key_Header_Wild_StCityLFName.new   }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_Wild_StFnameLname.version      ,newkeyname.Doxie_Key_Header_Wild_StFnameLname.version   ,oldkeyname.Doxie_Key_Header_Wild_StFnameLname.sub  ,newkeyname.Doxie_Key_Header_Wild_StFnameLname.sub  ,keynames(newkeyname.Doxie_Key_Header_Wild_StFnameLname.version   ,,'keydiff').Doxie_Key_Header_Wild_StFnameLname.new   }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_Wild_StreetZipName.version     ,newkeyname.Doxie_Key_Header_Wild_StreetZipName.version  ,oldkeyname.Doxie_Key_Header_Wild_StreetZipName.sub ,newkeyname.Doxie_Key_Header_Wild_StreetZipName.sub ,keynames(newkeyname.Doxie_Key_Header_Wild_StreetZipName.version  ,,'keydiff').Doxie_Key_Header_Wild_StreetZipName.new  }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_Wild_Zip.version               ,newkeyname.Doxie_Key_Header_Wild_Zip.version            ,oldkeyname.Doxie_Key_Header_Wild_Zip.sub           ,newkeyname.Doxie_Key_Header_Wild_Zip.sub           ,keynames(newkeyname.Doxie_Key_Header_Wild_Zip.version            ,,'keydiff').Doxie_Key_Header_Wild_Zip.new            }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_Zip.version                    ,newkeyname.Doxie_Key_Header_Zip.version                 ,oldkeyname.Doxie_Key_Header_Zip.sub                ,newkeyname.Doxie_Key_Header_Zip.sub                ,keynames(newkeyname.Doxie_Key_Header_Zip.version                 ,,'keydiff').Doxie_Key_Header_Zip.new                 }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Header_ZipPRLName.version             ,newkeyname.Doxie_Key_Header_ZipPRLName.version          ,oldkeyname.Doxie_Key_Header_ZipPRLName.sub         ,newkeyname.Doxie_Key_Header_ZipPRLName.sub         ,keynames(newkeyname.Doxie_Key_Header_ZipPRLName.version          ,,'keydiff').Doxie_Key_Header_ZipPRLName.new          }
		,{pversion_old,pversion_new,oldkeyname.Doxie_Key_Zip_Did_Full.version                  ,newkeyname.Doxie_Key_Zip_Did_Full.version               ,oldkeyname.Doxie_Key_Zip_Did_Full.sub              ,newkeyname.Doxie_Key_Zip_Did_Full.sub              ,keynames(newkeyname.Doxie_Key_Zip_Did_Full.version               ,,'keydiff').Doxie_Key_Zip_Did_Full.new               }
		,{pversion_old,pversion_new,oldkeyname.Doxie_key_nbr_headers_uid.version               ,newkeyname.Doxie_key_nbr_headers_uid.version            ,oldkeyname.Doxie_key_nbr_headers_uid.sub           ,newkeyname.Doxie_key_nbr_headers_uid.sub           ,keynames(newkeyname.Doxie_key_nbr_headers_uid.version            ,,'keydiff').Doxie_key_nbr_headers_uid.new            }
		,{pversion_old,pversion_new,oldkeyname.Header_Key_Nbr_Address.version                  ,newkeyname.Header_Key_Nbr_Address.version               ,oldkeyname.Header_Key_Nbr_Address.sub              ,newkeyname.Header_Key_Nbr_Address.sub              ,keynames(newkeyname.Header_Key_Nbr_Address.version               ,,'keydiff').Header_Key_Nbr_Address.new               }

	],{string oldpversion,string newpversion,string oldlogicalversion,string newlogicalversion,string oldlogicalkeyname,string newlogicalkeyname,string keydiffname});
	
	dBadKeydiffInfo 			:= dKeydiffInfo((oldlogicalversion = newlogicalversion) or (oldlogicalversion = '') or (newlogicalversion = '') or (oldlogicalversion > newlogicalversion));
	dLogicalVersionsequal	:= dBadKeydiffInfo(oldlogicalversion = newlogicalversion and oldlogicalversion != oldpversion and newlogicalversion != newpversion);
	dOldLogicalBlank			:= dBadKeydiffInfo(oldlogicalversion = '' and oldpversion != '');
	dNewLogicalBlank			:= dBadKeydiffInfo(newlogicalversion = '' and newpversion != '');
	dOldVersionGtNew			:= dBadKeydiffInfo(oldlogicalversion > newlogicalversion);
	
	// -- Index Definitions
	oldKey_AID_Build_Key_AID_Base                := INDEX(AID_Build.Key_AID_Base              ,oldkeyname.AID_Build_Key_AID_Base.sub                );
	oldKey_Business_Risk_Key_SSN_Address         := INDEX(Business_Risk.Key_SSN_Address       ,oldkeyname.Business_Risk_Key_SSN_Address.sub         );
	oldKey_Doxie_Key_Address                     := INDEX(Doxie.Key_Address                   ,oldkeyname.Doxie_Key_Address.sub                     );
	oldKey_Doxie_Key_Did_Rid                     := INDEX(Doxie.Key_Did_Rid                   ,oldkeyname.Doxie_Key_Did_Rid.sub                     );
	oldKey_Doxie_Key_Did_Rid2                    := INDEX(Doxie.Key_Did_Rid2                  ,oldkeyname.Doxie_Key_Did_Rid2.sub                    );
	oldKey_Doxie_Key_Header                      := INDEX(Doxie.Key_Header                    ,oldkeyname.Doxie_Key_Header.sub                      );
	oldKey_Doxie_Key_Header_Address              := INDEX(Doxie.Key_Header_Address            ,oldkeyname.Doxie_Key_Header_Address.sub              );
	oldKey_Doxie_Key_Header_DA                   := INDEX(Doxie.Key_Header_DA                 ,oldkeyname.Doxie_Key_Header_DA.sub                   );
	oldKey_Doxie_Key_Header_DOBName              := INDEX(Doxie.Key_Header_DOBName            ,oldkeyname.Doxie_Key_Header_DOBName.sub              );
	oldKey_Doxie_Key_Header_DTS_Address          := INDEX(Doxie.Key_Header_DTS_Address        ,oldkeyname.Doxie_Key_Header_DTS_Address.sub          );
	oldKey_Doxie_Key_Header_DTS_StreetZipName    := INDEX(Doxie.Key_Header_DTS_StreetZipName  ,oldkeyname.Doxie_Key_Header_DTS_StreetZipName.sub    );
	oldKey_Doxie_Key_Header_Name                 := INDEX(Doxie.Key_Header_Name               ,oldkeyname.Doxie_Key_Header_Name.sub                 );
	oldKey_Doxie_Key_Header_Name_alt             := INDEX(Doxie.Key_Header_Name_alt           ,oldkeyname.Doxie_Key_Header_Name_alt.sub             );
	oldKey_Doxie_Key_Header_StCityLFName         := INDEX(Doxie.Key_Header_StCityLFName       ,oldkeyname.Doxie_Key_Header_StCityLFName.sub         );
	oldKey_Doxie_Key_Header_StFnameLname         := INDEX(Doxie.Key_Header_StFnameLname       ,oldkeyname.Doxie_Key_Header_StFnameLname.sub         );
	oldKey_Doxie_Key_Header_StreetZipName        := INDEX(Doxie.Key_Header_StreetZipName      ,oldkeyname.Doxie_Key_Header_StreetZipName.sub        );
	oldKey_Doxie_Key_Header_Wild_Address         := INDEX(Doxie.Key_Header_Wild_Address       ,oldkeyname.Doxie_Key_Header_Wild_Address.sub         );                  
	oldKey_Doxie_Key_Header_Wild_Address_EN      := INDEX(Doxie.Key_Header_Wild_Address_EN    ,oldkeyname.Doxie_Key_Header_Wild_Address_EN.sub      );
	oldKey_Doxie_Key_Header_Wild_Address_Loose   := INDEX(Doxie.Key_Header_Wild_Address_Loose ,oldkeyname.Doxie_Key_Header_Wild_Address_Loose.sub   );
	oldKey_Doxie_Key_Header_Wild_Name            := INDEX(Doxie.Key_Header_Wild_Name          ,oldkeyname.Doxie_Key_Header_Wild_Name.sub            );                  
	oldKey_Doxie_Key_Header_Wild_StCityLFName    := INDEX(Doxie.Key_Header_Wild_StCityLFName  ,oldkeyname.Doxie_Key_Header_Wild_StCityLFName.sub    );
	oldKey_Doxie_Key_Header_Wild_StFnameLname    := INDEX(Doxie.Key_Header_Wild_StFnameLname  ,oldkeyname.Doxie_Key_Header_Wild_StFnameLname.sub    );
	oldKey_Doxie_Key_Header_Wild_StreetZipName   := INDEX(Doxie.Key_Header_Wild_StreetZipName ,oldkeyname.Doxie_Key_Header_Wild_StreetZipName.sub   );
	oldKey_Doxie_Key_Header_Wild_Zip             := INDEX(Doxie.Key_Header_Wild_Zip           ,oldkeyname.Doxie_Key_Header_Wild_Zip.sub             );
	oldKey_Doxie_Key_Header_Zip                  := INDEX(Doxie.Key_Header_Zip                ,oldkeyname.Doxie_Key_Header_Zip.sub                  );
	oldKey_Doxie_Key_Header_ZipPRLName           := INDEX(Doxie.Key_Header_ZipPRLName         ,oldkeyname.Doxie_Key_Header_ZipPRLName.sub           );
	oldKey_Doxie_Key_Zip_Did_Full                := INDEX(Doxie.Key_Zip_Did_Full              ,oldkeyname.Doxie_Key_Zip_Did_Full.sub                );
	oldKey_Doxie_key_nbr_headers_uid             := INDEX(Doxie.key_nbr_headers_uid           ,oldkeyname.Doxie_key_nbr_headers_uid.sub             );
	oldKey_Header_Key_Nbr_Address                := INDEX(Header.Key_Nbr_Address              ,oldkeyname.Header_Key_Nbr_Address.sub                );

	newKey_AID_Build_Key_AID_Base                := INDEX(AID_Build.Key_AID_Base              ,newkeyname.AID_Build_Key_AID_Base.sub                );
	newKey_Business_Risk_Key_SSN_Address         := INDEX(Business_Risk.Key_SSN_Address       ,newkeyname.Business_Risk_Key_SSN_Address.sub         );
	newKey_Doxie_Key_Address                     := INDEX(Doxie.Key_Address                   ,newkeyname.Doxie_Key_Address.sub                     );
	newKey_Doxie_Key_Did_Rid                     := INDEX(Doxie.Key_Did_Rid                   ,newkeyname.Doxie_Key_Did_Rid.sub                     );
	newKey_Doxie_Key_Did_Rid2                    := INDEX(Doxie.Key_Did_Rid2                  ,newkeyname.Doxie_Key_Did_Rid2.sub                    );
	newKey_Doxie_Key_Header                      := INDEX(Doxie.Key_Header                    ,newkeyname.Doxie_Key_Header.sub                      );
	newKey_Doxie_Key_Header_Address              := INDEX(Doxie.Key_Header_Address            ,newkeyname.Doxie_Key_Header_Address.sub              );
	newKey_Doxie_Key_Header_DA                   := INDEX(Doxie.Key_Header_DA                 ,newkeyname.Doxie_Key_Header_DA.sub                   );
	newKey_Doxie_Key_Header_DOBName              := INDEX(Doxie.Key_Header_DOBName            ,newkeyname.Doxie_Key_Header_DOBName.sub              );
	newKey_Doxie_Key_Header_DTS_Address          := INDEX(Doxie.Key_Header_DTS_Address        ,newkeyname.Doxie_Key_Header_DTS_Address.sub          );
	newKey_Doxie_Key_Header_DTS_StreetZipName    := INDEX(Doxie.Key_Header_DTS_StreetZipName  ,newkeyname.Doxie_Key_Header_DTS_StreetZipName.sub    );
	newKey_Doxie_Key_Header_Name                 := INDEX(Doxie.Key_Header_Name               ,newkeyname.Doxie_Key_Header_Name.sub                 );
	newKey_Doxie_Key_Header_Name_alt             := INDEX(Doxie.Key_Header_Name_alt           ,newkeyname.Doxie_Key_Header_Name_alt.sub             );
	newKey_Doxie_Key_Header_StCityLFName         := INDEX(Doxie.Key_Header_StCityLFName       ,newkeyname.Doxie_Key_Header_StCityLFName.sub         );
	newKey_Doxie_Key_Header_StFnameLname         := INDEX(Doxie.Key_Header_StFnameLname       ,newkeyname.Doxie_Key_Header_StFnameLname.sub         );
	newKey_Doxie_Key_Header_StreetZipName        := INDEX(Doxie.Key_Header_StreetZipName      ,newkeyname.Doxie_Key_Header_StreetZipName.sub        );
	newKey_Doxie_Key_Header_Wild_Address         := INDEX(Doxie.Key_Header_Wild_Address       ,newkeyname.Doxie_Key_Header_Wild_Address.sub         );
	newKey_Doxie_Key_Header_Wild_Address_EN      := INDEX(Doxie.Key_Header_Wild_Address_EN    ,newkeyname.Doxie_Key_Header_Wild_Address_EN.sub      );
	newKey_Doxie_Key_Header_Wild_Address_Loose   := INDEX(Doxie.Key_Header_Wild_Address_Loose ,newkeyname.Doxie_Key_Header_Wild_Address_Loose.sub   );
	newKey_Doxie_Key_Header_Wild_Name            := INDEX(Doxie.Key_Header_Wild_Name          ,newkeyname.Doxie_Key_Header_Wild_Name.sub            );                     
	newKey_Doxie_Key_Header_Wild_StCityLFName    := INDEX(Doxie.Key_Header_Wild_StCityLFName  ,newkeyname.Doxie_Key_Header_Wild_StCityLFName.sub    );
	newKey_Doxie_Key_Header_Wild_StFnameLname    := INDEX(Doxie.Key_Header_Wild_StFnameLname  ,newkeyname.Doxie_Key_Header_Wild_StFnameLname.sub    );
	newKey_Doxie_Key_Header_Wild_StreetZipName   := INDEX(Doxie.Key_Header_Wild_StreetZipName ,newkeyname.Doxie_Key_Header_Wild_StreetZipName.sub   );
	newKey_Doxie_Key_Header_Wild_Zip             := INDEX(Doxie.Key_Header_Wild_Zip           ,newkeyname.Doxie_Key_Header_Wild_Zip.sub             );
	newKey_Doxie_Key_Header_Zip                  := INDEX(Doxie.Key_Header_Zip                ,newkeyname.Doxie_Key_Header_Zip.sub                  );
	newKey_Doxie_Key_Header_ZipPRLName           := INDEX(Doxie.Key_Header_ZipPRLName         ,newkeyname.Doxie_Key_Header_ZipPRLName.sub           );
	newKey_Doxie_Key_Zip_Did_Full                := INDEX(Doxie.Key_Zip_Did_Full              ,newkeyname.Doxie_Key_Zip_Did_Full.sub                );
	newKey_Doxie_key_nbr_headers_uid             := INDEX(Doxie.key_nbr_headers_uid           ,newkeyname.Doxie_key_nbr_headers_uid.sub             );
	newKey_Header_Key_Nbr_Address                := INDEX(Header.Key_Nbr_Address              ,newkeyname.Header_Key_Nbr_Address.sub                );

	// -- Keydiff Macro calls

	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_AID_Build_Key_AID_Base              ,newKey_AID_Build_Key_AID_Base               ,keynames(newkeyname.AID_Build_Key_AID_Base.version               ,,'keydiff').AID_Build_Key_AID_Base.new               ,kdheader1  );       
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Business_Risk_Key_SSN_Address       ,newKey_Business_Risk_Key_SSN_Address        ,keynames(newkeyname.Business_Risk_Key_SSN_Address.version        ,,'keydiff').Business_Risk_Key_SSN_Address.new        ,kdheader2  );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Address                   ,newKey_Doxie_Key_Address                    ,keynames(newkeyname.Doxie_Key_Address.version                    ,,'keydiff').Doxie_Key_Address.new                    ,kdheader3  );       
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Did_Rid                   ,newKey_Doxie_Key_Did_Rid                    ,keynames(newkeyname.Doxie_Key_Did_Rid.version                    ,,'keydiff').Doxie_Key_Did_Rid.new                    ,kdheader4  );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Did_Rid2                  ,newKey_Doxie_Key_Did_Rid2                   ,keynames(newkeyname.Doxie_Key_Did_Rid2.version                   ,,'keydiff').Doxie_Key_Did_Rid2.new                   ,kdheader5  );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header                    ,newKey_Doxie_Key_Header                     ,keynames(newkeyname.Doxie_Key_Header.version                     ,,'keydiff').Doxie_Key_Header.new                     ,kdheader6  );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_Address            ,newKey_Doxie_Key_Header_Address             ,keynames(newkeyname.Doxie_Key_Header_Address.version             ,,'keydiff').Doxie_Key_Header_Address.new             ,kdheader7  );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_DA                 ,newKey_Doxie_Key_Header_DA                  ,keynames(newkeyname.Doxie_Key_Header_DA.version                  ,,'keydiff').Doxie_Key_Header_DA.new                  ,kdheader8  );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_DOBName            ,newKey_Doxie_Key_Header_DOBName             ,keynames(newkeyname.Doxie_Key_Header_DOBName.version             ,,'keydiff').Doxie_Key_Header_DOBName.new             ,kdheader9  );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_DTS_Address        ,newKey_Doxie_Key_Header_DTS_Address         ,keynames(newkeyname.Doxie_Key_Header_DTS_Address.version         ,,'keydiff').Doxie_Key_Header_DTS_Address.new         ,kdheader10 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_DTS_StreetZipName  ,newKey_Doxie_Key_Header_DTS_StreetZipName   ,keynames(newkeyname.Doxie_Key_Header_DTS_StreetZipName.version   ,,'keydiff').Doxie_Key_Header_DTS_StreetZipName.new   ,kdheader11 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_Name               ,newKey_Doxie_Key_Header_Name                ,keynames(newkeyname.Doxie_Key_Header_Name.version                ,,'keydiff').Doxie_Key_Header_Name.new                ,kdheader12 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_Name_alt           ,newKey_Doxie_Key_Header_Name_alt            ,keynames(newkeyname.Doxie_Key_Header_Name_alt.version            ,,'keydiff').Doxie_Key_Header_Name_alt.new            ,kdheader13 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_StCityLFName       ,newKey_Doxie_Key_Header_StCityLFName        ,keynames(newkeyname.Doxie_Key_Header_StCityLFName.version        ,,'keydiff').Doxie_Key_Header_StCityLFName.new        ,kdheader15 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_StFnameLname       ,newKey_Doxie_Key_Header_StFnameLname        ,keynames(newkeyname.Doxie_Key_Header_StFnameLname.version        ,,'keydiff').Doxie_Key_Header_StFnameLname.new        ,kdheader16 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_StreetZipName      ,newKey_Doxie_Key_Header_StreetZipName       ,keynames(newkeyname.Doxie_Key_Header_StreetZipName.version       ,,'keydiff').Doxie_Key_Header_StreetZipName.new       ,kdheader17 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_Wild_Address       ,newKey_Doxie_Key_Header_Wild_Address        ,keynames(newkeyname.Doxie_Key_Header_Wild_Address.version        ,,'keydiff').Doxie_Key_Header_Wild_Address.new        ,kdheader18 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_Wild_Address_EN    ,newKey_Doxie_Key_Header_Wild_Address_EN     ,keynames(newkeyname.Doxie_Key_Header_Wild_Address_EN.version     ,,'keydiff').Doxie_Key_Header_Wild_Address_EN.new     ,kdheader19 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_Wild_Address_Loose ,newKey_Doxie_Key_Header_Wild_Address_Loose  ,keynames(newkeyname.Doxie_Key_Header_Wild_Address_Loose.version  ,,'keydiff').Doxie_Key_Header_Wild_Address_Loose.new  ,kdheader20 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_Wild_Name          ,newKey_Doxie_Key_Header_Wild_Name           ,keynames(newkeyname.Doxie_Key_Header_Wild_Name.version           ,,'keydiff').Doxie_Key_Header_Wild_Name.new           ,kdheader21 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_Wild_StCityLFName  ,newKey_Doxie_Key_Header_Wild_StCityLFName   ,keynames(newkeyname.Doxie_Key_Header_Wild_StCityLFName.version   ,,'keydiff').Doxie_Key_Header_Wild_StCityLFName.new   ,kdheader22 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_Wild_StFnameLname  ,newKey_Doxie_Key_Header_Wild_StFnameLname   ,keynames(newkeyname.Doxie_Key_Header_Wild_StFnameLname.version   ,,'keydiff').Doxie_Key_Header_Wild_StFnameLname.new   ,kdheader23 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_Wild_StreetZipName ,newKey_Doxie_Key_Header_Wild_StreetZipName  ,keynames(newkeyname.Doxie_Key_Header_Wild_StreetZipName.version  ,,'keydiff').Doxie_Key_Header_Wild_StreetZipName.new  ,kdheader24 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_Wild_Zip           ,newKey_Doxie_Key_Header_Wild_Zip            ,keynames(newkeyname.Doxie_Key_Header_Wild_Zip.version            ,,'keydiff').Doxie_Key_Header_Wild_Zip.new            ,kdheader25 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_Zip                ,newKey_Doxie_Key_Header_Zip                 ,keynames(newkeyname.Doxie_Key_Header_Zip.version                 ,,'keydiff').Doxie_Key_Header_Zip.new                 ,kdheader26 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Header_ZipPRLName         ,newKey_Doxie_Key_Header_ZipPRLName          ,keynames(newkeyname.Doxie_Key_Header_ZipPRLName.version          ,,'keydiff').Doxie_Key_Header_ZipPRLName.new          ,kdheader27 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_Key_Zip_Did_Full              ,newKey_Doxie_Key_Zip_Did_Full               ,keynames(newkeyname.Doxie_Key_Zip_Did_Full.version               ,,'keydiff').Doxie_Key_Zip_Did_Full.new               ,kdheader28 );
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Doxie_key_nbr_headers_uid           ,newKey_Doxie_key_nbr_headers_uid            ,keynames(newkeyname.Doxie_key_nbr_headers_uid.version            ,,'keydiff').Doxie_key_nbr_headers_uid.new            ,kdheader29 );	
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(oldKey_Header_Key_Nbr_Address              ,newKey_Header_Key_Nbr_Address               ,keynames(newkeyname.Header_Key_Nbr_Address.version               ,,'keydiff').Header_Key_Nbr_Address.new               ,kdheader30 );

	build_keydiffs :=
	parallel(
		 kdheader1
		,kdheader2	
		,kdheader3	
		,kdheader4	
		,kdheader5	
		,kdheader6	
		,kdheader7	
		,kdheader8	
		,kdheader9	
		,kdheader10
		,kdheader11
		,kdheader12
		,kdheader13
		,kdheader15
		,kdheader16
		,kdheader17
		,kdheader18
		,kdheader19
		,kdheader20
		,kdheader21
		,kdheader22
		,kdheader23
		,kdheader24
		,kdheader25
		,kdheader26
		,kdheader27
		,kdheader28
		,kdheader29
		,kdheader30
	);

	return 
	sequential(
		 nothor(output(dKeydiffInfo	,named('Person_Header_Proc_Build_Keydiffs_Info')))
		,if(				pversion_old 					!= ''
					 and	pversion_new 					!= ''
					 and	pversion_old 					!= pversion_new
					 and	nothor(count(dBadKeydiffInfo)) = 0 
					 and	not pIstesting													
			, build_keydiffs
			,sequential(
				 nothor(output(dBadKeydiffInfo													,named('Bad_Keydiff_Info')))
				,output('doxie.Proc_Build_Keydiffs: Testing.')
				,fail(nothor('doxie.Proc_Build_Keydiffs ERROR:  ' 
					+ if(pIsTesting	,'Parameter pIsTesting set to true, testing turned on.  ','')
					+ 'Person_Header Keydiffs have not been run because of the following:  '
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