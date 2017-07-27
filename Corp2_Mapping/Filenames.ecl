import VersionControl;

export Filenames(

	 string 	pversion							= ''
	,string 	pGroupname						= VersionControl.Groupname('92')
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lthor				:= _Dataset(pUseOtherEnvironment).thor_cluster_Files;
	
	export ak_raw :=
	module

		export address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::address::ak','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporation::ak','edata10',,,,,pGroupname,,,'VARIABLE',,1000,,'\\n',);
		export name                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name::ak','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export StatusCode_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StatusCode_Table::ak','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export CorpType_Table            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorpType_Table::ak','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export DocumentTypeID_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentTypeID_Table::ak','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::ak','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger::ak','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export NameType_Table            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::NameType_Table::ak','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export officer                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::officer::ak','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export OffPartyType_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::OffPartyType_Table::ak','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export PartyType_Table           := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PartyType_Table::ak','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export stock                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::stock::ak','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export StockClass_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StockClass_Table::ak','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);

		export dAll_filenames :=
			  address.dAll_filenames
			+ corporation.dAll_filenames
			+ name.dAll_filenames
			+ StatusCode_Table.dAll_filenames
			+ CorpType_Table.dAll_filenames
			+ DocumentTypeID_Table.dAll_filenames
			+ filing.dAll_filenames
			+ merger.dAll_filenames
			+ NameType_Table.dAll_filenames
			+ officer.dAll_filenames
			+ OffPartyType_Table.dAll_filenames
			+ PartyType_Table.dAll_filenames
			+ stock.dAll_filenames
			+ StockClass_Table.dAll_filenames
			;

	end;

	export al_raw :=
	module

		export CRANLPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRANLPF::al','edata10',,,956,,pGroupname,,,'FIXED',,,,,);
		export CRBUSPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRBUSPF::al','edata10',,,222,,pGroupname,,,'FIXED',,,,,);
		export CRHSTPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRHSTPF::al','edata10',,,192,,pGroupname,,,'FIXED',,,,,);
		export CRINCPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRINCPF::al','edata10',,,172,,pGroupname,,,'FIXED',,,,,);
		export CRMSTPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRMSTPF::al','edata10',,,663,,pGroupname,,,'FIXED',,,,,);
		export CRNAMPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRNAMPF::al','edata10',,,238,,pGroupname,,,'FIXED',,,,,);
		export CROFFPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CROFFPF::al','edata10',,,134,,pGroupname,,,'FIXED',,,,,);
		export CRSERPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRSERPF::al','edata10',,,170,,pGroupname,,,'FIXED',,,,,);
                                                                                                                               
		export dAll_filenames :=
			  CRANLPF.dAll_filenames
			+ CRBUSPF.dAll_filenames
			+ CRHSTPF.dAll_filenames
			+ CRINCPF.dAll_filenames
			+ CRMSTPF.dAll_filenames
			+ CRNAMPF.dAll_filenames
			+ CROFFPF.dAll_filenames
			+ CRSERPF.dAll_filenames
			;

	end;

	export ar_raw :=
	module

		export CorpData                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpData::ar','edata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);
		export CorpNames                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpNames::ar','edata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);
		export CorpOfficer               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpOfficer::ar','edata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);

		export dAll_filenames :=
			  CorpData.dAll_filenames
			+ CorpNames.dAll_filenames
			+ CorpOfficer.dAll_filenames
			;

	end;

	export az_raw :=
	module

		export CHGEXT                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CHGEXT::az','edata10',,,143,,pGroupname,,,'FIXED',,,,,);
		export COREXT                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::COREXT::az','edata10',,,903,,pGroupname,,,'FIXED',,,,,);
		export FLMEXT                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::FLMEXT::az','edata10',,,143,,pGroupname,,,'FIXED',,,,,);
		export OFFEXT                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::OFFEXT::az','edata10',,,163,,pGroupname,,,'FIXED',,,,,);
		export StatusCodeType_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StatusCodeType_Table::az','edata10',,,,, pGroupname,,,'VARIABLE',,100,'\\t','\\n',);

		export dAll_filenames :=
			  CHGEXT.dAll_filenames
			+ COREXT.dAll_filenames
			+ FLMEXT.dAll_filenames
			+ OFFEXT.dAll_filenames
			+ StatusCodeType_Table.dAll_filenames
			;

	end;

	export ca_raw :=
	module

		export lp                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::lp::ca'		,'edata10',,,1454,, pGroupname,,,'FIXED',,,,,);
		export hist                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::hist::ca'	,'edata10',,,423	,, pGroupname,,,'FIXED',,,,,);
		export mast                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::mast::ca'	,'edata10',,,1281,, pGroupname,,,'FIXED',,,,,);
                                                                                                                            
		export dAll_filenames :=
			  lp.dAll_filenames
			+ hist.dAll_filenames
			+ mast.dAll_filenames
			;

	end;

	export co_raw :=
	module

		export corpHist                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpHist::co','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export corpMstr                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpMstr::co','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export corpTrdnm                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpTrdnm::co','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export tmChange                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmChange::co','edata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',);
		export tmCorrection              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmCorrection::co','edata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',);
		export tmExpired                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmExpired::co','edata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',);
		export tmRegistration            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmRegistration::co','edata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',);
		export tmRenewal                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmRenewal::co','edata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',);
		export tmTransfer                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmTransfer::co','edata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',);
		export tmWithdraw                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmWithdraw::co','edata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',);

		export dAll_filenames :=
			  corpHist.dAll_filenames
			+ corpMstr.dAll_filenames
			+ corpTrdnm.dAll_filenames
			+ tmChange.dAll_filenames
			+ tmCorrection.dAll_filenames
			+ tmExpired.dAll_filenames
			+ tmRegistration.dAll_filenames
			+ tmRenewal.dAll_filenames
			+ tmTransfer.dAll_filenames
			+ tmWithdraw.dAll_filenames
			;

	end;

	export ct_raw :=
	module

		export BusFiling              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpBusFiling::ct','edata10',,,125	,,pGroupname,,,'FIXED',, ,,,);
		export BusMaster              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpBusMaster::ct','edata10',,,1158,,pGroupname,,,'FIXED',, ,,,);
		export busmergr               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpbusmergr::ct'	,'edata10',,,40	,,pGroupname,,,'FIXED',, ,,,);
		export busother               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpbusother::ct'	,'edata10',,,134	,,pGroupname,,,'FIXED',, ,,,);
		export busrsvr                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpbusrsvr::ct'	,'edata10',,,360	,,pGroupname,,,'FIXED',, ,,,);
		export corp                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpcorp::ct'			,'edata10',,,165	,,pGroupname,,,'FIXED',, ,,,);
		export dlmlpart               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpdlmlpart::ct'	,'edata10',,,38	,,pGroupname,,,'FIXED',, ,,,);
		export dlmtcorp               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpdlmtcorp::ct'	,'edata10',,,46	,,pGroupname,,,'FIXED',, ,,,);
		export dlmtpart               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpdlmtpart::ct'	,'edata10',,,28	,,pGroupname,,,'FIXED',, ,,,);
		export filmindx               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpfilmindx::ct'	,'edata10',,,64	,,pGroupname,,,'FIXED',, ,,,);
		export flmlpart               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpflmlpart::ct'	,'edata10',,,151	,,pGroupname,,,'FIXED',, ,,,);
		export flmtcorp               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpflmtcorp::ct'	,'edata10',,,352	,,pGroupname,,,'FIXED',, ,,,);
		export flmtpart               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpflmtpart::ct'	,'edata10',,,335	,,pGroupname,,,'FIXED',, ,,,);
		export forstat                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpforstat::ct'	,'edata10',,,326	,,pGroupname,,,'FIXED',, ,,,);
		export generalp               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpgeneralp::ct'	,'edata10',,,228	,,pGroupname,,,'FIXED',, ,,,);
		export namechng               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpnamechng::ct'	,'edata10',,,329	,,pGroupname,,,'FIXED',, ,,,);
		export prncipal               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpprncipal::ct'	,'edata10',,,513	,,pGroupname,,,'FIXED',, ,,,);
		export stock                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpstock::ct'		,'edata10',,,67	,,pGroupname,,,'FIXED',, ,,,);
                                                                                                                                   
		export dAll_filenames :=
			  BusFiling.dAll_filenames
			+ BusMaster.dAll_filenames
			+ busmergr.dAll_filenames
			+ busother.dAll_filenames
			+ busrsvr.dAll_filenames
			+ corp.dAll_filenames
			+ dlmlpart.dAll_filenames
			+ dlmtcorp.dAll_filenames
			+ dlmtpart.dAll_filenames
			+ filmindx.dAll_filenames
			+ flmlpart.dAll_filenames
			+ flmtcorp.dAll_filenames
			+ flmtpart.dAll_filenames
			+ forstat.dAll_filenames
			+ generalp.dAll_filenames
			+ namechng.dAll_filenames
			+ prncipal.dAll_filenames
			+ stock.dAll_filenames
			;

	end;

	export dc_raw :=
	module

		export corporations              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporations::dc','edata10',,,,,pGroupname,,,'VARIABLE',,13000,,,'\"');

		export dAll_filenames :=
			  corporations.dAll_filenames
			;

	end;

	export fl_raw :=
	module

		export corpFile                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpFile::fl'	,'edata10',,,1172	,,pGroupname,,,'FIXED',,,,,);
		export eventFile                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::eventFile::fl','edata10',,,664	,,pGroupname,,,'FIXED',,,,,);
                                                                                                                                
		export dAll_filenames :=
			  corpFile.dAll_filenames
			+ eventFile.dAll_filenames
			;

	end;

	export fltm_raw :=
	module

		export tmFile                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmFile::fltm','edata10',,,1906,,pGroupname,,,'FIXED',,,,,);

		export dAll_filenames :=
			  tmFile.dAll_filenames
			;

	end;

	export ga_raw :=
	module

		export address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::address::ga'									,'edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export AddressTypeID_Table       := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::AddressTypeID_Table::ga'	,'edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporation::ga'							,'edata10',,,,,pGroupname,,,'VARIABLE',,1000,,'\\n',);
		export name                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name::ga'											,'edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export StatusCode_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StatusCode_Table::ga'			,'edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export CorpType_Table            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorpType_Table::ga'				,'edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export DocumentTypeID_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentTypeID_Table::ga'	,'edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::ga'										,'edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger::ga'										,'edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export NameType_Table            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::NameType_Table::ga'				,'edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export officer                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::officer::ga'									,'edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export OffPartyType_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::OffPartyType_Table::ga'		,'edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export PartyType_Table           := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PartyType_Table::ga'			,'edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export ragent                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ragent::ga'										,'edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export stock                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::stock::ga'										,'edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export StockClass_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StockClass_Table::ga'			,'edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);

		export dAll_filenames :=
			  address.dAll_filenames
			+ AddressTypeID_Table.dAll_filenames
			+ corporation.dAll_filenames
			+ name.dAll_filenames
			+ StatusCode_Table.dAll_filenames
			+ CorpType_Table.dAll_filenames
			+ DocumentTypeID_Table.dAll_filenames
			+ filing.dAll_filenames
			+ merger.dAll_filenames
			+ NameType_Table.dAll_filenames
			+ officer.dAll_filenames
			+ OffPartyType_Table.dAll_filenames
			+ PartyType_Table.dAll_filenames
			+ ragent.dAll_filenames
			+ stock.dAll_filenames
			+ StockClass_Table.dAll_filenames
			;

	end;

	export hi_raw :=
	module

		export companymaster             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companymaster::hi','edata10',,,,,pGroupname       ,,,'VARIABLE',,800,,'\\n',);
		export companyofficer            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companyofficer::hi','edata10',,,,,pGroupname      ,,,'VARIABLE',,800,,'\\n',);
		export companystock              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companystock::hi','edata10',,,,,pGroupname        ,,,'VARIABLE',,800,,'\\n',);
		export companytransaction        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companytransaction::hi','edata10',,,,,pGroupname  ,,,'VARIABLE',,800,,'\\n',);
		export ttsmaster                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ttsmaster::hi','edata10',,,,,pGroupname           ,,,'VARIABLE',,800,,'\\n',);
		export ttstransaction            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ttstransaction::hi','edata10',,,,,pGroupname      ,,,'VARIABLE',,800,,'\\n',);

		export dAll_filenames :=
			  companymaster.dAll_filenames
			+ companyofficer.dAll_filenames
			+ companystock.dAll_filenames
			+ companytransaction.dAll_filenames
			+ ttsmaster.dAll_filenames
			+ ttstransaction.dAll_filenames
			;

	end;

	export ia_raw :=
	module

		export crpAdd                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpAdd::ia','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpAgt                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpAgt::ia','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpDes                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpDes::ia','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpFil                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpFil::ia','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpHis                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpHis::ia','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpNam                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpNam::ia','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpOff                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpOff::ia','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpPrt                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpPrt::ia','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpRem                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpRem::ia','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpStk                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpStk::ia','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export ChapterCodes_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::ChapterCodes_Table::ia'	,'edata10',,,57	,,pGroupname,,,'FIXED',, ,,,);
		export OfficerType_Table         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::OfficerType_Table::ia'	,'edata10',,,28	,,pGroupname,,,'FIXED',, ,,,);
		export PageNo_Table              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PageNo_Table::ia'				,'edata10',,,64	,,pGroupname,,,'FIXED',, ,,,);
		export FilingType_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::FilingType_Table::ia'		,'edata10',,,88	,,pGroupname,,,'FIXED',, ,,,);
		export CountryCodes_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CountryCodes_Table::ia'	,'edata10',,,164,,pGroupname,,,'FIXED',, ,,,);
		export StateCodes_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StateCodes_Table::ia'		,'edata10',,,34	,,pGroupname,,,'FIXED',, ,,,);
                                                                                                                                            
		export dAll_filenames :=
			  crpAdd.dAll_filenames
			+ crpAgt.dAll_filenames
			+ crpDes.dAll_filenames
			+ crpFil.dAll_filenames
			+ crpHis.dAll_filenames
			+ crpNam.dAll_filenames
			+ crpOff.dAll_filenames
			+ crpPrt.dAll_filenames
			+ crpRem.dAll_filenames
			+ crpStk.dAll_filenames
			+ ChapterCodes_Table.dAll_filenames
			+ OfficerType_Table.dAll_filenames
			+ PageNo_Table.dAll_filenames
			+ FilingType_Table.dAll_filenames
			+ CountryCodes_Table.dAll_filenames
			+ StateCodes_Table.dAll_filenames
			;

	end;

	export id_raw :=
	module

		export vendorRaw                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::vendorRaw::id','edata10',,,547,,pGroupname,,,'FIXED',,,,,);

		export dAll_filenames :=
			  vendorRaw.dAll_filenames
			;

	end;

	export il_raw :=
	module

      shared frequency(string pfrequency) :=
      module
         export master     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::' + pfrequency +'_master::il','edata10',,,,,pGroupname,,,'VARIABLE');
         export corpnames  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::' + pfrequency +'_corpnames::il','edata10',,,,,pGroupname,,,'VARIABLE');
         export stock      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::' + pfrequency +'_stock::il','edata10',,,,,pGroupname,,,'VARIABLE');
      end;
      
      export daily   := frequency('daily');
      export monthly := frequency('monthly');

			export llc     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::llc::il','edata10',,,,,pGroupname,,,'VARIABLE',,2000,,'\\r\\n',);
			export lp      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::lp::il','edata10',,,,,pGroupname,,,'VARIABLE',,8192,,'\\n',);
                                                                                        
      
      export dall_filenames :=
           daily.master.dall_filenames         
         + daily.corpnames.dall_filenames             
//       + daily.stock.dall_filenames             //no stock for daily files
         + monthly.master.dall_filenames             
         + monthly.corpnames.dall_filenames             
         + monthly.stock.dall_filenames             
				 + llc.dAll_filenames
				 + lp.dAll_filenames
         ;        


	end;

	export in_raw :=
	module

		export Corp_Agents               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Agents::in','edata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,);
		export Corp_Corporations         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Corporations::in','edata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,);
		export Corp_Filings              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Filings::in','edata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,);
		export Corp_Mergers              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Mergers::in','edata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,);
		export Corp_Names                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Names::in','edata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,);
		export Corp_Officers             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Officers::in','edata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,);
		export Corp_Reports              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Reports::in','edata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,);
		export EntityType_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::EntityType_Table::in','edata10',,,,, pGroupname,,,'VARIABLE',,,'\\t',,);
		export FilingType_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::FilingType_Table::in','edata10',,,,, pGroupname,,,'VARIABLE',,,'\\t',,);

		export dAll_filenames :=
			  Corp_Agents.dAll_filenames
			+ Corp_Corporations.dAll_filenames
			+ Corp_Filings.dAll_filenames
			+ Corp_Mergers.dAll_filenames
			+ Corp_Names.dAll_filenames
			+ Corp_Officers.dAll_filenames
			+ Corp_Reports.dAll_filenames
			+ EntityType_Table.dAll_filenames
			+ FilingType_Table.dAll_filenames
			;

	end;

	export ks_raw :=
	module

		export cpabrep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpabrep::ks'		,'edata10',,,317,,pGroupname,,,'FIXED',,,,,);
		export cpadrep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpadrep::ks'		,'edata10',,,186,,pGroupname,,,'FIXED',,,,,);
		export cpaerep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpaerep::ks'		,'edata10',,,75	,,pGroupname,,,'FIXED',,,,,);
		export cpahst                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpahst::ks'			,'edata10',,,83	,,pGroupname,,,'FIXED',,,,,);
		export cpaqrep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpaqrep::ks'		,'edata10',,,41	,,pGroupname,,,'FIXED',,,,,);
		export cpbcrep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpbcrep::ks'		,'edata10',,,148,,pGroupname,,,'FIXED',,,,,);
		export Cpasrep                   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Cpasrep::ks','edata10',,,58	,,pGroupname,,,'FIXED',,,,,);
		export Cpakrep                   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Cpakrep::ks','edata10',,,78	,,pGroupname,,,'FIXED',,,,,);
		export Cpalrep                   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Cpalrep::ks','edata10',,,68	,,pGroupname,,,'FIXED',,,,,);
		export Cpanrep                   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Cpanrep::ks','edata10',,,34	,,pGroupname,,,'FIXED',,,,,);
		export Crptyp                    := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Crptyp::ks'	,'edata10',,,33	,,pGroupname,,,'FIXED',,,,,);
                                                                                                                                 
		export dAll_filenames :=
			  cpabrep.dAll_filenames
			+ cpadrep.dAll_filenames
			+ cpaerep.dAll_filenames
			+ cpahst.dAll_filenames
			+ Cpakrep.dAll_filenames
			+ Cpalrep.dAll_filenames
			+ Cpanrep.dAll_filenames
			+ cpaqrep.dAll_filenames
			+ Cpasrep.dAll_filenames
			+ cpbcrep.dAll_filenames
			+ Crptyp.dAll_filenames
			;

	end;

	export ky_raw :=
	module

		export companies                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companies::ky','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export Officer                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officer::ky','edata10',,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);

		export dAll_filenames :=
			  companies.dAll_filenames
			+ Officer.dAll_filenames
			;

	end;

	export la_raw :=
	module

		export crpam                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpam::la'	,'edata10',,,43	,,pGroupname,,,'FIXED',,,,,);
		export crpca                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpca::la'	,'edata10',,,228,,pGroupname,,,'FIXED',,,,,);
		export crpcm                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpcm::la'	,'edata10',,,322,,pGroupname,,,'FIXED',,,,,);
		export crppn                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crppn::la'	,'edata10',,,138,,pGroupname,,,'FIXED',,,,,);
		export crprma                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crprma::la'	,'edata10',,,564,,pGroupname,,,'FIXED',,,,,);
		export crpta                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpta::la'	,'edata10',,,43	,,pGroupname,,,'FIXED',,,,,);
		export crptsa                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crptsa::la'	,'edata10',,,984,,pGroupname,,,'FIXED',,,,,);
		export crpcc                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpcc::la','edata10',,,,,pGroupname,,,'VARIABLE',,75,'[^]','\\r\\n',);
		export crpce                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpce::la','edata10',,,,,pGroupname,,,'VARIABLE',,75,'[^]','\\r\\n',);
		export crppe                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crppe::la','edata10',,,,,pGroupname,,,'VARIABLE',,80,'[^]','\\r\\n',);

		export dAll_filenames :=
			  crpam.dAll_filenames
			+ crpca.dAll_filenames
			+ crpcc.dAll_filenames
			+ crpce.dAll_filenames
			+ crpcm.dAll_filenames
			+ crppe.dAll_filenames
			+ crppn.dAll_filenames
			+ crprma.dAll_filenames
			+ crpta.dAll_filenames
			+ crptsa.dAll_filenames
			;

	end;

	export ma_raw :=
	module

		export corpdataexport            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpdataexport::ma'				,'edata10',,,,,pGroupname ,,,'VARIABLE',,8192,'|',,);
		export corpindividualexport      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpindividualexport::ma'	,'edata10',,,,,pGroupname ,,,'VARIABLE',,8192,'|',,);
		export corpstockexport           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpstockexport::ma'			,'edata10',,,,,pGroupname ,,,'VARIABLE',,8192,'|',,);
		export corpdetailexport          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpdetailexport::ma'			,'edata10',,,,,pGroupname ,,,'VARIABLE',,8192,'|',,);
		export corpmerger                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpmerger::ma'						,'edata10',,,,,pGroupname ,,,'VARIABLE',,8192,'|',,);
		export corpnamechange            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpnamechange::ma'				,'edata10',,,,,pGroupname ,,,'VARIABLE',,8192,'|',,);

		export dAll_filenames :=
			  corpdataexport.dAll_filenames
			+ corpindividualexport.dAll_filenames
			+ corpstockexport.dAll_filenames
			+ corpdetailexport.dAll_filenames
			+ corpmerger.dAll_filenames
			+ corpnamechange.dAll_filenames
			;

	end;

	export md_raw :=
	module

		export AmendHist                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::AmendHist::md'				,'edata10',,,154	,,pGroupname,,,'FIXED',, ,,,);
		export BusAddr_clean             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusAddr_clean::md'		,'edata10',,,1196,,pGroupname,,,'FIXED',, ,,,);
		export BusEntity                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusEntity::md'				,'edata10',,,98	,,pGroupname,,,'FIXED',, ,,,);
		export BusNmIndx_clean           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusNmIndx_clean::md'	,'edata10',,,894	,,pGroupname,,,'FIXED',, ,,,);
		export BusType_clean             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusType_clean::md'		,'edata10',,,77	,,pGroupname,,,'FIXED',, ,,,);
		export BusComment_clean          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusComment_clean::md'	,'edata10',,,1062,,pGroupname,,,'FIXED',, ,,,);
		export EntityStatus              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::EntityStatus::md'			,'edata10',,,54	,,pGroupname,,,'FIXED',, ,,,);
		export FilingType_clean          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::FilingType_clean::md'	,'edata10',,,68	,,pGroupname,,,'FIXED',, ,,,);
		export TradeName                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::TradeName::md'				,'edata10',,,83	,,pGroupname,,,'FIXED',, ,,,);
		export FilmIndx                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::FilmIndx::md'					,'edata10',,,65	,,pGroupname,,,'FIXED',, ,,,);
		export ReserveName               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ReserveName::md'			,'edata10',,,79	,,pGroupname,,,'FIXED',, ,,,);
                                                                                                                                       
		export dAll_filenames :=
			  AmendHist.dAll_filenames
			+ BusAddr_clean.dAll_filenames
			+ BusEntity.dAll_filenames
			+ BusNmIndx_clean.dAll_filenames
			+ BusType_clean.dAll_filenames
			+ BusComment_clean.dAll_filenames
			+ EntityStatus.dAll_filenames
			+ FilingType_clean.dAll_filenames
			+ TradeName.dAll_filenames
			+ FilmIndx.dAll_filenames
			+ ReserveName.dAll_filenames
			;

	end;

	export me_raw :=
	module

		export corp_bulk                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corp_bulk::me','edata10',,,910,,pGroupname,,,'FIXED',,,,,);

		export dAll_filenames :=
			  corp_bulk.dAll_filenames
			;

	end;

	export mi_raw :=
	module

		export master1                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::master1::mi','edata10',,,,,pGroupname,,,'VARIABLE',,8192,,,);

		export dAll_filenames :=
			  master1.dAll_filenames
			;

	end;

	export mn_raw :=
	module

		export an                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::an::mn','edata10',,,,,pGroupname,,,'VARIABLE',, 200,'|','\\r\\n',);
		export bt                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::bt::mn','edata10',,,,,pGroupname,,,'VARIABLE',, 200,'|','\\r\\n',);
		export dc_mn                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dc::mn','edata10',,,,,pGroupname,,,'VARIABLE',, 200,'|','\\r\\n',);
		export fc                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::fc::mn','edata10',,,,,pGroupname,,,'VARIABLE',, 200,'|','\\r\\n',);
		export llc                       := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::llc::mn','edata10',,,,,pGroupname,,,'VARIABLE',, 200,'|','\\r\\n',);
		export lp                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::lp::mn','edata10',,,,,pGroupname,,,'VARIABLE',, 200,'|','\\r\\n',);
		export np                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::np::mn','edata10',,,,,pGroupname,,,'VARIABLE',, 200,'|','\\r\\n',);
		export rn                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::rn::mn','edata10',,,,,pGroupname,,,'VARIABLE',, 200,'|','\\r\\n',);
		export tm                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tm::mn','edata10',,,,,pGroupname,,,'VARIABLE',, 200,'|','\\r\\n',);

		export dAll_filenames :=
			  an.dAll_filenames
			+ bt.dAll_filenames
			+ dc_mn.dAll_filenames
			+ fc.dAll_filenames
			+ llc.dAll_filenames
			+ lp.dAll_filenames
			+ np.dAll_filenames
			+ rn.dAll_filenames
			+ tm.dAll_filenames
			;

	end;

	export mo_raw :=
	module

		export address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::address::mo','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export AddressType_Table         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::AddressType_Table::mo','edata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporation::mo','edata10',,,,,pGroupname,,,'VARIABLE',,1000,,'\\n',);
		export name                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name::mo','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export CorporationStatus_Table   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationStatus_Table::mo','edata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export CorporationType_Table     := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationType_Table::mo','edata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export DocumentType_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentType_Table::mo','edata10',,,,,pGroupname,,,'VARIABLE',,200,,'\\n',);
		export filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::mo','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger::mo','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export NameType_Table            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::NameType_Table::mo','edata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);

		export dAll_filenames :=
			  address.dAll_filenames
			+ AddressType_Table.dAll_filenames
			+ corporation.dAll_filenames
			+ name.dAll_filenames
			+ CorporationStatus_Table.dAll_filenames
			+ CorporationType_Table.dAll_filenames
			+ DocumentType_Table.dAll_filenames
			+ filing.dAll_filenames
			+ merger.dAll_filenames
			+ NameType_Table.dAll_filenames
			;

	end;

	export ms_raw :=
	module

		export ADDRESS                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ADDRESS::ms','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export CORPORATION               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CORPORATION::ms','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export CORPORATIONNAME           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CORPORATIONNAME::ms','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export FILING                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::FILING::ms','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export MERGER                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::MERGER::ms','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export OFFICER                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::OFFICER::ms','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export OFFICERPARTYTYPE          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::OFFICERPARTYTYPE::ms','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export STOCK_FILE                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::STOCK_FILE::ms','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export DocumentType              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentType::ms','edata10',,,,, pGroupname,,,'VARIABLE',,500,,'\\n',);

		export dAll_filenames :=
			  ADDRESS.dAll_filenames
			+ CORPORATION.dAll_filenames
			+ CORPORATIONNAME.dAll_filenames
			+ FILING.dAll_filenames
			+ MERGER.dAll_filenames
			+ OFFICER.dAll_filenames
			+ OFFICERPARTYTYPE.dAll_filenames
			+ STOCK_FILE.dAll_filenames
			+ DocumentType.dAll_filenames
			;

	end;

	export mt_raw :=
	module

		export Iso_State                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::Iso_State::mt','edata10',,,34,,pGroupname,,,'FIXED',,,,,);
		export vendor_raw                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::vendor_raw::mt','edata10',,,200,,pGroupname,,,'FIXED',,,,,);
		export Activity_Type             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::Activity_Type::mt','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Bus_Entity_Type           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::Bus_Entity_Type::mt','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Bus_Purpose_Type          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::Bus_Purpose_Type::mt','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Change_Code               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::Change_Code::mt','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Corp_Type                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::Corp_Type::mt','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Owner_Type                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::Owner_Type::mt','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Record_Type               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::Record_Type::mt','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Status_Reason_Code        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::Status_Reason_Code::mt','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Trademark_Class           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::Trademark_Class::mt','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);

		export dAll_filenames :=
			  Iso_State.dAll_filenames
			+ vendor_raw.dAll_filenames
			+ Activity_Type.dAll_filenames
			+ Bus_Entity_Type.dAll_filenames
			+ Bus_Purpose_Type.dAll_filenames
			+ Change_Code.dAll_filenames
			+ Corp_Type.dAll_filenames
			+ Owner_Type.dAll_filenames
			+ Record_Type.dAll_filenames
			+ Status_Reason_Code.dAll_filenames
			+ Trademark_Class.dAll_filenames
			;

	end;

	export nc_raw :=
	module

		export Addresses                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Addresses::nc','edata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,);
		export Corporations              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corporations::nc','edata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,);
		export Directors                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Directors::nc','edata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,);
		export Filings                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Filings::nc','edata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,);
		export NameReservations          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::NameReservations::nc','edata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,);
		export Names                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Names::nc','edata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,);
		export Officers                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officers::nc','edata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,);
		export Partners                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Partners::nc','edata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,);
		export Stock                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Stock::nc','edata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,);
		export DocumentType              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentType::nc','edata10',,,,, pGroupname,,,'VARIABLE',,500,,'\\n',);

		export dAll_filenames :=
			  Addresses.dAll_filenames
			+ Corporations.dAll_filenames
			+ Directors.dAll_filenames
			+ Filings.dAll_filenames
			+ NameReservations.dAll_filenames
			+ Names.dAll_filenames
			+ Officers.dAll_filenames
			+ Partners.dAll_filenames
			+ Stock.dAll_filenames
			+ DocumentType.dAll_filenames
			;

	end;

	export nd_raw :=
	module

		export Corpa_Vendor              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corpa_Vendor::nd'				,'edata10',,,1901	,,pGroupname,,,'FIXED',,,,,);
		export Corpb_Vendor              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corpb_Vendor::nd'				,'edata10',,,1901	,,pGroupname,,,'FIXED',,,,,);
		export Fictitios1_Vendor         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Fictitios1_Vendor::nd'	,'edata10',,,2601	,,pGroupname,,,'FIXED',,,,,);
		export Fictitios2_Vendor         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Fictitios2_Vendor::nd'	,'edata10',,,2601	,,pGroupname,,,'FIXED',,,,,);
		export Partnership_Vendor        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Partnership_Vendor::nd'	,'edata10',,,15001,,pGroupname,,,'FIXED',,,,,);
		export Trademarks1_Vendor        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Trademarks1_Vendor::nd'	,'edata10',,,2601	,,pGroupname,,,'FIXED',,,,,);
		export Trademarks2_Vendor        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Trademarks2_Vendor::nd'	,'edata10',,,2601	,,pGroupname,,,'FIXED',,,,,);
		export Tradename1_Vendor         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Tradename1_Vendor::nd'	,'edata10',,,2651	,,pGroupname,,,'FIXED',,,,,);
		export Tradename2_Vendor         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Tradename2_Vendor::nd'	,'edata10',,,2651	,,pGroupname,,,'FIXED',,,,,);
		export State_Country_Table       := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::State_Country_Table::nd','edata10',,,,, pGroupname,,,'VARIABLE',,350,,'\\n',);

		export dAll_filenames :=
			  Corpa_Vendor.dAll_filenames
			+ Corpb_Vendor.dAll_filenames
			+ Fictitios1_Vendor.dAll_filenames
			+ Fictitios2_Vendor.dAll_filenames
			+ Partnership_Vendor.dAll_filenames
			+ Trademarks1_Vendor.dAll_filenames
			+ Trademarks2_Vendor.dAll_filenames
			+ Tradename1_Vendor.dAll_filenames
			+ Tradename2_Vendor.dAll_filenames
			+ State_Country_Table.dAll_filenames
			;

	end;

	export ne_raw :=
	module

		export CorpAction                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpAction::ne','edata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);
		export CorpOfficers              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpOfficers::ne','edata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);
		export CorpEntity                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpEntity::ne','edata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);
		export CorporationType           := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationType::ne','edata10',,,,,pGroupname,,,'VARIABLE',,250,'\\t','\\n',);
		export NECountryCodes            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::NECountryCodes::ne','edata10',,,,,pGroupname,,,'VARIABLE',,250,'\\t','\\n',);
		export ListOfStates              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::ListOfStates::ne','edata10',,,,,pGroupname,,,'VARIABLE',,250,'\\t','\\n',);
		export PositionHeld              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PositionHeld::ne','edata10',,,,,pGroupname,,,'VARIABLE',,250,'\\t','\\n',);
		export RegisterAgent             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::RegisterAgent::ne','edata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);
		export ServiceType               := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::ServiceType::ne','edata10',,,,,pGroupname,,,'VARIABLE',,250,'\\t','\\n',);

		export dAll_filenames :=
			  CorpAction.dAll_filenames
			+ CorpOfficers.dAll_filenames
			+ CorpEntity.dAll_filenames
			+ CorporationType.dAll_filenames
			+ NECountryCodes.dAll_filenames
			+ ListOfStates.dAll_filenames
			+ PositionHeld.dAll_filenames
			+ RegisterAgent.dAll_filenames
			+ ServiceType.dAll_filenames
			;

	end;

	export nh_raw :=
	module

		export address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::address::nh','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporation::nh','edata10',,,,,pGroupname,,,'VARIABLE',,1000,,'\\n',);
		export name                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name::nh','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::nh','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger::nh','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export officer                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::officer::nh','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export stock                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::stock::nh','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export OffPartyType_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::OffPartyType_Table::nh','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export PartyType_Table           := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PartyType_Table::nh','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export NameType_Table            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::NameType_Table::nh','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export StockClass_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StockClass_Table::nh','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export StatusCode_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StatusCode_Table::nh','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export CorpType_Table            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorpType_Table::nh','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export DocumentTypeID_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentTypeID_Table::nh','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);

		export dAll_filenames :=
			  address.dAll_filenames
			+ corporation.dAll_filenames
			+ name.dAll_filenames
			+ StatusCode_Table.dAll_filenames
			+ CorpType_Table.dAll_filenames
			+ DocumentTypeID_Table.dAll_filenames
			+ filing.dAll_filenames
			+ merger.dAll_filenames
			+ NameType_Table.dAll_filenames
			+ officer.dAll_filenames
			+ OffPartyType_Table.dAll_filenames
			+ PartyType_Table.dAll_filenames
			+ stock.dAll_filenames
			+ StockClass_Table.dAll_filenames
			;

	end;

	export nj_raw :=
	module

		export Business                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Business::nj','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);

		export dAll_filenames :=
			  Business.dAll_filenames
			;

	end;

	export nm_raw :=
	module

		export Import_Master             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Import_Master::nm'		,'edata10',,,680,,pGroupname,,,'FIXED',,,,,);
		export Import2_directors         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Import2_directors::nm','edata10',,,48	,,pGroupname,,,'FIXED',,,,,);
		export Import1_History           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Import1_History::nm'	,'edata10',,,357,,pGroupname,,,'FIXED',,,,,);
                                                                                                                                        
		export dAll_filenames :=
			  Import_Master.dAll_filenames
			+ Import2_directors.dAll_filenames
			+ Import1_History.dAll_filenames
			;  

	end;

	export nv_raw :=
	module

		export ACTIONS                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ACTIONS::nv','edata10',,,,,pGroupname    ,,,'VARIABLE',,2000,,'\\n',);
		export Corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corporation::nv','edata10',,,,,pGroupname,,,'VARIABLE',,2000,,'\\n',);
		export OFFICERS                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::OFFICERS::nv','edata10',,,,,pGroupname      ,,,'VARIABLE',,2000,,'\\n',);
		export RA                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::RA::nv','edata10',,,,,pGroupname               ,,,'VARIABLE',,2000,,'\\n',);
		export STOCK                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::STOCKs::nv','edata10',,,,,pGroupname  ,,,'VARIABLE',,2000,,'\\n',);

		export dAll_filenames :=
			  ACTIONS.dAll_filenames
			+ Corporation.dAll_filenames
			+ OFFICERS.dAll_filenames
			+ RA.dAll_filenames
			+ STOCK.dAll_filenames
			;

	end;

	export ny_raw :=
	module

		export master                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::master::ny','edata10',,,250,,pGroupname,,,'FIXED',,,,,);
		export merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger::ny','edata10',,,250,,pGroupname,,,'FIXED',,,,,);
		export Constituent               := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Constituent::ny','edata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export Country_Principal         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Country_Principal::ny','edata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export Document_Types            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Document_Types::ny','edata10',,,,,pGroupname,,,'VARIABLE',,500,,'\\n',);
		export State_Possession          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::State_Possession::ny','edata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);

		export dAll_filenames :=
			  master.dAll_filenames
			+ merger.dAll_filenames
			+ Constituent.dAll_filenames
			+ Country_Principal.dAll_filenames
			+ Document_Types.dAll_filenames
			+ State_Possession.dAll_filenames
			;

	end;

	export oh_raw :=
	module

		export Business_Address          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Business_Address::oh','edata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export Agent_Contact             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Agent_Contact::oh','edata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export Business_Associate        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Business_Associate::oh','edata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export Business                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Business::oh','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export CountyCodeType_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CountyCodeType_Table::oh','edata10',,,,,pGroupname,,,'VARIABLE',,200,'|','\\n',);
		export Explanation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Explanation::oh','edata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export Text_Information          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Text_Information::oh','edata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export Old_Name                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Old_Name::oh','edata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export Authorized_Share          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Authorized_Share::oh','edata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export StateCodeType_Table       := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StateCodeType_Table::oh','edata10',,,,,pGroupname,,,'VARIABLE',,100,'|','\\n',);
		export TranCodeType_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::TranCodeType_Table::oh','edata10',,,,,pGroupname,,,'VARIABLE',,100,'|','\\n',);
		export Document_Transaction      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Document_Transaction::oh','edata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export shareType_Table		       := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::shareType_Table::oh','edata10',,,,,pGroupname,,,'VARIABLE',,100,'|','\\n',);


		export dAll_filenames :=
			  Business_Address.dAll_filenames
			+ Agent_Contact.dAll_filenames
			+ Business_Associate.dAll_filenames
			+ Business.dAll_filenames
			+ CountyCodeType_Table.dAll_filenames
			+ Explanation.dAll_filenames
			+ Text_Information.dAll_filenames
			+ Old_Name.dAll_filenames
			+ Authorized_Share.dAll_filenames
			+ StateCodeType_Table.dAll_filenames
			+ TranCodeType_Table.dAll_filenames
			+ Document_Transaction.dAll_filenames
			+ shareType_Table.dAll_filenames
			;

	end;

	export ok_raw :=
	module

		export Address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Address::ok'		,'edata10',,,202,,pGroupname,,,'FIXED',,,,,);
		export Agent                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Agent::ok'			,'edata10',,,511,,pGroupname,,,'FIXED',,,,,);
		export AssocEntity               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::AssocEntity::ok','edata10',,,241,,pGroupname,,,'FIXED',,,,,);
		export AuditLog                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::AuditLog::ok'		,'edata10',,,897,,pGroupname,,,'FIXED',,,,,);
		export Capacity                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Capacity::ok'		,'edata10',,,66	,,pGroupname,,,'FIXED',,,,,);
		export CorpFiling                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpFiling::ok'	,'edata10',,,175,,pGroupname,,,'FIXED',,,,,);
		export CorpStatus                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpStatus::ok'	,'edata10',,,40	,,pGroupname,,,'FIXED',,,,,);
		export CorpType                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpType::ok'		,'edata10',,,96	,,pGroupname,,,'FIXED',,,,,);
		export Entity                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Entity::ok'			,'edata10',,,515,,pGroupname,,,'FIXED',,,,,);
		export FilingType                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::FilingType::ok'	,'edata10',,,112,,pGroupname,,,'FIXED',,,,,);
		export NameStatus                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::NameStatus::ok'	,'edata10',,,96	,,pGroupname,,,'FIXED',,,,,);
		export NameType                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::NameType::ok'		,'edata10',,,32	,,pGroupname,,,'FIXED',,,,,);
		export Names                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Names::ok'			,'edata10',,,277,,pGroupname,,,'FIXED',,,,,);
		export Officer                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officer::ok'		,'edata10',,,550,,pGroupname,,,'FIXED',,,,,);
		export StockType                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::StockType::ok'	,'edata10',,,80	,,pGroupname,,,'FIXED',,,,,);
		export StockData                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::StockData::ok'	,'edata10',,,378,,pGroupname,,,'FIXED',,,,,);
		export StockInfo                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::StockInfo::ok'	,'edata10',,,138,,pGroupname,,,'FIXED',,,,,);
		export Suffix                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Suffix::ok'			,'edata10',,,66	,,pGroupname,,,'FIXED',,,,,);
                                                                                                                                 
		export dAll_filenames :=
			  Address.dAll_filenames
			+ Agent.dAll_filenames
			+ AssocEntity.dAll_filenames
			+ AuditLog.dAll_filenames
			+ Capacity.dAll_filenames
			+ CorpFiling.dAll_filenames
			+ CorpStatus.dAll_filenames
			+ CorpType.dAll_filenames
			+ Entity.dAll_filenames
			+ FilingType.dAll_filenames
			+ NameStatus.dAll_filenames
			+ NameType.dAll_filenames
			+ Names.dAll_filenames
			+ Officer.dAll_filenames
			+ StockType.dAll_filenames
			+ StockData.dAll_filenames
			+ StockInfo.dAll_filenames
			+ Suffix.dAll_filenames
			;

	end;

	export or_raw :=
	module

		export county_db_extract         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::county_db_extract::or','edata10',,,,,pGroupname          ,,,'VARIABLE',,8192,,,);
		export entity_db_extract         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::entity_db_extract::or','edata10',,,,,pGroupname          ,,,'VARIABLE',,8192,,,);
		export merger_share_db_extract   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger_share_db_extract::or','edata10',,,,,pGroupname   ,,,'VARIABLE',,8192,,,);
		export name_db_extract           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name_db_extract::or','edata10',,,,,pGroupname            ,,,'VARIABLE',,8192,,,);
		export rel_assoc_name_db_extract := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::rel_assoc_name_db_extract::or','edata10',,,,,pGroupname  ,,,'VARIABLE',,8192,,,);
		export tran_db_extract           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tran_db_extract::or','edata10',,,,,pGroupname            ,,,'VARIABLE',,8192,,,);

		export dAll_filenames :=
			  county_db_extract.dAll_filenames
			+ entity_db_extract.dAll_filenames
			+ merger_share_db_extract.dAll_filenames
			+ name_db_extract.dAll_filenames
			+ rel_assoc_name_db_extract.dAll_filenames
			+ tran_db_extract.dAll_filenames
			;

	end;

	export pa_raw :=
	module

		export Address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Address::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export AddressType               := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::AddressType::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export Corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corporation::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export CorporationName           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorporationName::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export CorporationStatus         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationStatus::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export CorporationType           := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationType::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export DocumentType              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentType::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export Filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Filing::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export Merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Merger::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export NameType                  := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::NameType::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export Officer                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officer::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export OfficerPartyType          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::OfficerPartyType::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export PartyType                 := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PartyType::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export StockOrig                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::StockOrig::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',,,,true);
		export StockClass                := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StockClass::pa','edata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);

		export dAll_filenames :=
			  Address.dAll_filenames
			+ AddressType.dAll_filenames
			+ Corporation.dAll_filenames
			+ CorporationName.dAll_filenames
			+ CorporationStatus.dAll_filenames
			+ CorporationType.dAll_filenames
			+ DocumentType.dAll_filenames
			+ Filing.dAll_filenames
			+ Merger.dAll_filenames
			+ NameType.dAll_filenames
			+ Officer.dAll_filenames
			+ OfficerPartyType.dAll_filenames
			+ PartyType .dAll_filenames
			+ StockOrig.dAll_filenames
			+ StockClass.dAll_filenames
			;

	end;

	export ri_raw :=
	module

		export Amendments                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Amendments::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Amendments       := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Amendments::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Entities                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Entities::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Entities         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Entities::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Mergers                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Mergers::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Mergers          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Mergers::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Names                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Names::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Names            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Names::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Officers                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officers::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Officers         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Officers::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Stocks                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Stocks::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Stocks           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Stocks::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export corp_filings              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::corp_filings::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export country                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::country::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export state                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::state::ri','edata10',,,,,pGroupname,,,'VARIABLE',,,,,);

		export dAll_filenames :=
			  Amendments.dAll_filenames
			+ Inactive_Amendments.dAll_filenames
			+ Entities.dAll_filenames
			+ Inactive_Entities.dAll_filenames
			+ Mergers.dAll_filenames
			// + Mergers.dAll_filenames
			+ Inactive_Mergers.dAll_filenames
			+ Names.dAll_filenames
			+ Inactive_Names.dAll_filenames
			+ Officers.dAll_filenames
			+ Inactive_Officers.dAll_filenames
			+ Stocks.dAll_filenames
			+ Inactive_Stocks.dAll_filenames
			+ corp_filings.dAll_filenames
			+ country.dAll_filenames
			+ state.dAll_filenames
			;

	end;

	export sc_raw :=
	module

		export corpNameFile              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpNameFile::sc','edata10',,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);
		export corpTxnFile               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpTxnFile::sc','edata10',,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);
		export corpFile                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpFile::sc','edata10',,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);

		export dAll_filenames :=
			  corpNameFile.dAll_filenames
			+ corpTxnFile.dAll_filenames
			+ corpFile.dAll_filenames
			;

	end;

	export sd_raw :=
	module

		export Vender_Main               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Vender_Main::sd'				,'edata10',,,910,,pGroupname,,,'FIXED',,,,,);
		export Vendor_Subordinate        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Vendor_Subordinate::sd'	,'edata10',,,531,,pGroupname,,,'FIXED',,,,,);
		export StatusCodeType_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StatusCodeType_Table::sd','edata10',,,,,pGroupname,,,'VARIABLE',,100,'\\t','\\n',);
		export CorpFilingType_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorpFilingType_Table::sd','edata10',,,,,pGroupname,,,'VARIABLE',,100,'\\t','\\n',);
		export HistCodeType_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::HistCodeType_Table::sd','edata10',,,,,pGroupname,,,'VARIABLE',,100,'\\t','\\n',);

		export dAll_filenames :=
			  Vender_Main.dAll_filenames
			+ Vendor_Subordinate.dAll_filenames
			+ StatusCodeType_Table.dAll_filenames
			+ CorpFilingType_Table.dAll_filenames
			+ HistCodeType_Table.dAll_filenames
			;

	end;

	export tn_raw :=
	module

		export MAIN                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tn_vendor::tn'				,'edata10',,,,,pGroupname,,,'VARIABLE',,450,'\\t','\\n',);
		export BusinessTypeCode_Table    := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::BusinessTypeCode_Table::tn','edata10',,,,, pGroupname,,,'VARIABLE',,100,'\\t','\\n',);
		export ChargeCodeDesc_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::ChargeCodeDesc_Table::tn','edata10',,,,, pGroupname,,,'VARIABLE',,350,'\\t','\\n',);
		export CountyStateCode_Table     := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CountyStateCode_Table::tn','edata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);

		export dAll_filenames :=
			  MAIN.dAll_filenames
			+ BusinessTypeCode_Table.dAll_filenames
			+ ChargeCodeDesc_Table.dAll_filenames
			+ CountyStateCode_Table.dAll_filenames
			;

	end;
	
	export tx_raw :=
	module

		export Master              			 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::master::tx','edata10',,,,,pGroupname,,,'VARIABLE',, ,,'\\n',);
		export nonprofitsubtype          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::nonprofitsubtype::tx','edata10',,,,,pGroupname,,,'VARIABLE',, 100,,'\\n',);
		export mem_part_offi_title       := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::mem_part_offi_title::tx','edata10',,,,,pGroupname,,,'VARIABLE',, 200,'\\|','\\n',);

		export dAll_filenames :=
			  Master.dAll_filenames
			+ nonprofitsubtype.dAll_filenames
			+ mem_part_offi_title.dAll_filenames
			; 

	end;

	export txbus_raw :=
	module

		export ftact                      := VersionControl.mInputFileNameVersions(lthor + 'in::Corp2::@version@::ftact::txbus'		,'edata10',,,218,,pGroupname,,,'FIXED',,,,,);

		export dAll_filenames :=
			  ftact.dAll_filenames
			;

	end;

	export ut_raw :=
	module

		export Busentity1             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Busentity::ut','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export Busentity2             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Principals::ut','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export Busentity3             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Businfo::ut','edata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
          
		export dAll_filenames :=
			  Busentity1.dAll_filenames
			+ Busentity2.dAll_filenames
			+ Busentity3.dAll_filenames
			; 

	end;

	export va_raw :=
	module

		export corps                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corps::va','edata10',,,RECFMVB_RECSIZE,,pGroupname,,,'FIXED',,,,,);

		export dAll_filenames :=
			  corps.dAll_filenames
			;

	end;

	export vt_raw :=
	module

		export LLC_VendorData            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::LLC_VendorData::vt'				,'edata10',,,2600	,,pGroupname,,,'FIXED',,,,,);
		export vendor_Data               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::vendor_Data::vt'					,'edata10',,,720	,,pGroupname,,,'FIXED',,,,,);
		export Tradenames_VendorData     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Tradenames_VendorData::vt','edata10',,,495	,,pGroupname,,,'FIXED',,,,,);
		export corpCountryState_table    := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::corpCountryState_table::vt','edata10',,,,,pGroupname,,,'VARIABLE',,250,'\\t','\\n',);

		export dAll_filenames :=
			  LLC_VendorData.dAll_filenames
			+ vendor_Data.dAll_filenames
			+ Tradenames_VendorData.dAll_filenames
			+ corpCountryState_table.dAll_filenames
			;

	end;

	export wa_raw :=
	module

		export Wa_Vendor_Data            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Wa_Vendor_Data::wa','edata10',,,467,,pGroupname,,,'FIXED',,,,,);

		export dAll_filenames :=
			  Wa_Vendor_Data.dAll_filenames
			;

	end;

	export wi_raw :=
	module

		export comfichex                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::comfichex::wi','edata10',,,,,pGroupname,,,'VARIABLE',,140,,,'\"');

		export dAll_filenames :=
			  comfichex.dAll_filenames
			;

	end;

	export wv_raw :=
	module

		export Business	                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::business::wv','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\|','\\n',);
		export Party										 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::party::wv','edata10',,,,,pGroupname,,,'VARIABLE',,800,'\\|','\\n',);
		export Status                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::status::wv','edata10',,,,,pGroupname,,,'VARIABLE',,800,'\\|','\\n',);
		export Stock                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::stock::wv','edata10',,,,,pGroupname,,,'VARIABLE',,800,'\\|','\\n',);

		export dAll_filenames :=
			  Business.dAll_filenames
			+ Party.dAll_filenames
			+ Status.dAll_filenames
			+ Stock.dAll_filenames
			;
	
	end;
			
	export wy_raw :=
	module

		export Filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Filing::wy','edata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\|','\\n',);
		export Filing_Annual_Report      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Filing_Annual_Report::wy','edata10',,,,,pGroupname,,,'VARIABLE',,800,'\\|','\\n',);
		export Party                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Party::wy','edata10',,,,,pGroupname,,,'VARIABLE',,800,'\\|','\\n',);

		export dAll_filenames :=
			  Filing.dAll_filenames
			+ Filing_Annual_Report.dAll_filenames
			+ Party.dAll_filenames
			;

	end;


	export dAll_filenames :=
		  ak_raw.dAll_filenames
		+ al_raw.dAll_filenames
		+ ar_raw.dAll_filenames
		+ az_raw.dAll_filenames
		+ ca_raw.dAll_filenames
		+ co_raw.dAll_filenames
		+ ct_raw.dAll_filenames
		+ dc_raw.dAll_filenames
		+ fl_raw.dAll_filenames
		+ fltm_raw.dAll_filenames
		+ ga_raw.dAll_filenames
		+ hi_raw.dAll_filenames
		+ ia_raw.dAll_filenames
		+ id_raw.dAll_filenames
		+ il_raw.dAll_filenames
		+ in_raw.dAll_filenames
		+ ks_raw.dAll_filenames
		+ ky_raw.dAll_filenames
		+ la_raw.dAll_filenames
		+ ma_raw.dAll_filenames
		+ md_raw.dAll_filenames
		+ me_raw.dAll_filenames
		+ mi_raw.dAll_filenames
		+ mn_raw.dAll_filenames
		+ mo_raw.dAll_filenames
		+ ms_raw.dAll_filenames
		+ mt_raw.dAll_filenames
		+ nc_raw.dAll_filenames
		+ nd_raw.dAll_filenames
		+ ne_raw.dAll_filenames
		+ nh_raw.dAll_filenames
		+ nj_raw.dAll_filenames
		+ nm_raw.dAll_filenames
		+ nv_raw.dAll_filenames
		+ ny_raw.dAll_filenames
		+ oh_raw.dAll_filenames
		+ ok_raw.dAll_filenames
		+ or_raw.dAll_filenames
		+ pa_raw.dAll_filenames
		+ ri_raw.dAll_filenames
		+ sc_raw.dAll_filenames
		+ sd_raw.dAll_filenames
		+ tn_raw.dAll_filenames
		+ tx_raw.dAll_filenames
		+ txbus_raw.dAll_filenames
		+ ut_raw.dAll_filenames
		+ va_raw.dAll_filenames
		+ vt_raw.dAll_filenames
		+ wa_raw.dAll_filenames
		+ wi_raw.dAll_filenames
		+ wv_raw.dAll_filenames
		+ wy_raw.dAll_filenames
		;
end;