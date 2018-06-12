/*2014-04-01T15:20:48Z (mgould_prod)
C:\Users\goulmi01\AppData\Roaming\HPCC Systems\eclide\mgould_prod\Boca_Prod\Corp2_Mapping\Filenames\2014-04-01T15_20_48Z.ecl
*/
/*2013-12-06T19:54:44Z (mgould_prod)
C:\Users\goulmi01\AppData\Roaming\HPCC Systems\eclide\mgould_prod\Boca_Prod\Corp2_Mapping\Filenames\2013-12-06T19_54_44Z.ecl
*/
import VersionControl; 

export Filenames(

	 string 	pversion							= ''
	,string 	pGroupname						= VersionControl.Groupname('31')
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lthor				:= _Dataset(pUseOtherEnvironment).thor_cluster_Files;
	
	export ak_raw :=
	module
		export Corporations          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corporations::ak','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,',','\\n',);
		export Officials                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officials::ak','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,',','\\n',);

		export dAll_filenames :=
			    Corporations.dAll_filenames
			+ Officials.dAll_filenames
			;

	end;

	export al_raw :=
	module

		export CRANLPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRANLPF::al','bctlpedata10',,,956,,pGroupname,,,'FIXED',,,,,);
		export CRBUSPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRBUSPF::al','bctlpedata10',,,222,,pGroupname,,,'FIXED',,,,,);
		export CRHSTPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRHSTPF::al','bctlpedata10',,,192,,pGroupname,,,'FIXED',,,,,);
		export CRINCPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRINCPF::al','bctlpedata10',,,172,,pGroupname,,,'FIXED',,,,,);
		export CRMSTPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRMSTPF::al','bctlpedata10',,,663,,pGroupname,,,'FIXED',,,,,);
		export CRNAMPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRNAMPF::al','bctlpedata10',,,238,,pGroupname,,,'FIXED',,,,,);
		export CROFFPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CROFFPF::al','bctlpedata10',,,134,,pGroupname,,,'FIXED',,,,,);
		export CRSERPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRSERPF::al','bctlpedata10',,,170,,pGroupname,,,'FIXED',,,,,);
                                                                                                                               
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

		export CorpData                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpData::ar','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);
		export CorpNames                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpNames::ar','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);
		export CorpOfficer               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpOfficer::ar','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);

		export dAll_filenames :=
			  CorpData.dAll_filenames
			+ CorpNames.dAll_filenames
			+ CorpOfficer.dAll_filenames
			;

	end;

	export az_raw :=
	module

		export CHGEXT                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CHGEXT::az','bctlpedata10',,,143,,pGroupname,,,'FIXED',,,,,);
		export COREXT                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::COREXT::az','bctlpedata10',,,903,,pGroupname,,,'FIXED',,,,,);
		export FLMEXT                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::FLMEXT::az','bctlpedata10',,,143,,pGroupname,,,'FIXED',,,,,);
		export OFFEXT                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::OFFEXT::az','bctlpedata10',,,163,,pGroupname,,,'FIXED',,,,,);
		export StatusCodeType_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StatusCodeType_Table::az','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,100,'\\t','\\n',);

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

		export lp                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::lp::ca'		,'bctlpedata10',,,1455	,,pGroupname,,,'FIXED',, ,,,);
		export hist                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::hist::ca'	,'bctlpedata10',,,424	,,pGroupname,,,'FIXED',, ,,,);
		export mast                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::mast::ca'	,'bctlpedata10',,,1282	,,pGroupname,,,'FIXED',, ,,,);
                                                                                                                            
		export dAll_filenames :=
			  lp.dAll_filenames
			+ hist.dAll_filenames
			+ mast.dAll_filenames
			;

	end;

	export co_raw :=
	module

		export corpHist                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpHist::co','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',',');
		export corpHist2                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpHist2::co','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',',');
		export corpMstr                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpMstr::co','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',',');
		export corpTrdnm                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpTrdnm::co','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',',');
		export tmChange                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmChange::co','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');
		export tmCorrection              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmCorrection::co','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');
		export tmExpired                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmExpired::co','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');
		export tmRegistration            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmRegistration::co','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');
		export tmRenewal                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmRenewal::co','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');
		export tmTransfer                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmTransfer::co','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');
		export tmWithdraw                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmWithdraw::co','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');

		export dAll_filenames :=
			  corpHist.dAll_filenames
			+ corpHist2.dAll_filenames				
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


		export BusFiling              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpBusFiling::ct','bctlpedata10',,,125	,,pGroupname,,,'FIXED',, ,,,);
		export BusMaster              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpBusMaster::ct','bctlpedata10',,,1158,,pGroupname,,,'FIXED',, ,,,);
		export busmergr               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpbusmergr::ct'	,'bctlpedata10',,,40	,,pGroupname,,,'FIXED',, ,,,);
		export busother               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpbusother::ct'	,'bctlpedata10',,,134	,,pGroupname,,,'FIXED',, ,,,);
		export busrsvr                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpbusrsvr::ct'	,'bctlpedata10',,,360	,,pGroupname,,,'FIXED',, ,,,);
		export corp                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpcorp::ct'			,'bctlpedata10',,,165	,,pGroupname,,,'FIXED',, ,,,);
		export dlmlpart               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpdlmlpart::ct'	,'bctlpedata10',,,38	,,pGroupname,,,'FIXED',, ,,,);
		export dlmtcorp               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpdlmtcorp::ct'	,'bctlpedata10',,,46	,,pGroupname,,,'FIXED',, ,,,);
		export dlmtpart               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpdlmtpart::ct'	,'bctlpedata10',,,28	,,pGroupname,,,'FIXED',, ,,,);
		export filmindx               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpfilmindx::ct'	,'bctlpedata10',,,64	,,pGroupname,,,'FIXED',, ,,,);
		export flmlpart               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpflmlpart::ct'	,'bctlpedata10',,,151	,,pGroupname,,,'FIXED',, ,,,);
		export flmtcorp               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpflmtcorp::ct'	,'bctlpedata10',,,352	,,pGroupname,,,'FIXED',, ,,,);
		export flmtpart               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpflmtpart::ct'	,'bctlpedata10',,,335	,,pGroupname,,,'FIXED',, ,,,);
		export forstat                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpforstat::ct'	,'bctlpedata10',,,326	,,pGroupname,,,'FIXED',, ,,,);
		export generalp               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpgeneralp::ct'	,'bctlpedata10',,,228	,,pGroupname,,,'FIXED',, ,,,);
		export namechng               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpnamechng::ct'	,'bctlpedata10',,,329	,,pGroupname,,,'FIXED',, ,,,);
		export prncipal               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpprncipal::ct'	,'bctlpedata10',,,513	,,pGroupname,,,'FIXED',, ,,,);
		export stock                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpstock::ct'		,'bctlpedata10',,,67	,,pGroupname,,,'FIXED',, ,,,);
                                                                                                                                   
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

		export corporations              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporations::dc','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,', '\\r\\n', '"',);

		export dAll_filenames :=
			  corporations.dAll_filenames
			;

	end;

	export fl_raw :=
	module

		export corpFile                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpFile::fl'	,'bctlpedata10',,,1442	,,pGroupname,,,'FIXED',,,,,);
		export eventFile                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::eventFile::fl','bctlpedata10',,,664	,,pGroupname,,,'FIXED',,,,,);
                                                                                                                                
		export dAll_filenames :=
			  corpFile.dAll_filenames
			+ eventFile.dAll_filenames
			;

	end;

	export fltm_raw :=
	module

		export tmFile                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmFile::fltm','bctlpedata10',,,1906,,pGroupname,,,'FIXED',,,,,);

		export dAll_filenames :=
			  tmFile.dAll_filenames
			;

	end;

  //Added '\\' as the QUOTE input so that quotes in the data will be ignored.  Quotes in the data causes some data to be dropped.
	export ga_raw :=
	module

		export address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::address::ga','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n','\\',);
		export corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporation::ga','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n','\\',);
		export filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::ga','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n','\\',);
		export officer                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::officer::ga','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n','\\',);
		export ragent                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ragent::ga','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n','\\',);
		export stock                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::stock::ga','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n','\\',);
		
		export dAll_filenames :=
			    address.dAll_filenames
				+ corporation.dAll_filenames
			  + filing.dAll_filenames
			  + officer.dAll_filenames
			  + ragent.dAll_filenames
			  + stock.dAll_filenames;

	end;

	export hi_raw :=
	module

		export companymaster             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companymaster::hi','bctlpedata10',,,,,pGroupname       ,,,'VARIABLE',,8192,,'\\n',',');
		export companyofficer            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companyofficer::hi','bctlpedata10',,,,,pGroupname      ,,,'VARIABLE',,8192,,'\\n',',');
		export companystock              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companystock::hi','bctlpedata10',,,,,pGroupname        ,,,'VARIABLE',,8192,,'\\n',',');
		export companytransaction        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companytransaction::hi','bctlpedata10',,,,,pGroupname  ,,,'VARIABLE',,8192,,'\\n',',');
		export ttsmaster                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ttsmaster::hi','bctlpedata10',,,,,pGroupname           ,,,'VARIABLE',,8192,,'\\n',',');
		export ttstransaction            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ttstransaction::hi','bctlpedata10',,,,,pGroupname      ,,,'VARIABLE',,8192,,'\\n',',');

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

		export crpAdd                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpAdd::ia','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpAgt                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpAgt::ia','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpDes                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpDes::ia','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpFil                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpFil::ia','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpHis                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpHis::ia','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpNam                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpNam::ia','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n','');
		export crpOff                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpOff::ia','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpPrt                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpPrt::ia','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpRem                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpRem::ia','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpStk                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpStk::ia','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export ChapterCodes_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::ChapterCodes_Table::ia'	,'bctlpedata10',,,57	,,pGroupname,,,'FIXED',, ,,,);
		export OfficerType_Table         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::OfficerType_Table::ia'	,'bctlpedata10',,,28	,,pGroupname,,,'FIXED',, ,,,);
		export PageNo_Table              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PageNo_Table::ia'				,'bctlpedata10',,,64	,,pGroupname,,,'FIXED',, ,,,);
		export FilingType_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::FilingType_Table::ia'		,'bctlpedata10',,,88	,,pGroupname,,,'FIXED',, ,,,);
		export CountryCodes_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CountryCodes_Table::ia'	,'bctlpedata10',,,164,,pGroupname,,,'FIXED',, ,,,);
		export StateCodes_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StateCodes_Table::ia'		,'bctlpedata10',,,34	,,pGroupname,,,'FIXED',, ,,,);
                                                                                                                                            
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

		export vendorRaw                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::vendorRaw::id','bctlpedata10',,,547,,pGroupname,,,'FIXED',,,,,);

		export dAll_filenames :=
			  vendorRaw.dAll_filenames
			;

	end;

	export il_raw :=
	module

      shared dailyraw(string pfrequency) :=
      module
				 export master     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::' + pfrequency +'_master::il','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'',,'');
      end;

      shared monthlyraw(string pfrequency) :=
      module
				 export master     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::' + pfrequency +'_master::il','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'',,'');
         export corpnames  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::' + pfrequency +'_corpnames::il','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,',');
         export stock      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::' + pfrequency +'_stock::il','bctlpedata10',,,,,pGroupname,,,'VARIABLE');
      end;
			
      export daily   := dailyraw('daily');
      export monthly := monthlyraw('monthly');

			export llc     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::llc::il','bctlpedata10',,,,,pGroupname,,,'VARIABLE','',8192,,'\\n',);
			export lp      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::lp::il','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192,,'\\n',);
                                                                                        
      
      export dall_filenames :=
           daily.master.dall_filenames         
         + monthly.master.dall_filenames             
         + monthly.corpnames.dall_filenames             
         + monthly.stock.dall_filenames             
				 + llc.dAll_filenames
				 + lp.dAll_filenames
         ;

	end;

	export in_raw :=
	module

		export Corp_Agents               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corp_agents::in','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Corp_Corporations         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corp_corporations::in','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Corp_Filings              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Filings::in','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Corp_Mergers              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Mergers::in','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Corp_Names                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Names::in','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Corp_Officers             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Officers::in','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');

		export dAll_filenames :=
			  Corp_Agents.dAll_filenames
			+ Corp_Corporations.dAll_filenames
			+ Corp_Filings.dAll_filenames
			+ Corp_Mergers.dAll_filenames
			+ Corp_Names.dAll_filenames
			+ Corp_Officers.dAll_filenames;

	end;

	export ks_raw :=
	module

		export cpabrep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpabrep::ks'		,'bctlpedata10',,,317,,pGroupname,,,'FIXED',,,,,);
		export cpadrep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpadrep::ks'		,'bctlpedata10',,,186,,pGroupname,,,'FIXED',,,,,);
		export cpaerep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpaerep::ks'		,'bctlpedata10',,,75	,,pGroupname,,,'FIXED',,,,,);
		export cpahst                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpahst::ks'			,'bctlpedata10',,,83	,,pGroupname,,,'FIXED',,,,,);
		export cpaqrep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpaqrep::ks'		,'bctlpedata10',,,41	,,pGroupname,,,'FIXED',,,,,);
		export cpbcrep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpbcrep::ks'		,'bctlpedata10',,,148,,pGroupname,,,'FIXED',,,,,);
		export Cpasrep                   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Cpasrep::ks','bctlpedata10',,,58	,,pGroupname,,,'FIXED',,,,,);
		export Cpakrep                   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Cpakrep::ks','bctlpedata10',,,78	,,pGroupname,,,'FIXED',,,,,);
		export Cpalrep                   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Cpalrep::ks','bctlpedata10',,,68	,,pGroupname,,,'FIXED',,,,,);
		export Cpanrep                   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Cpanrep::ks','bctlpedata10',,,34	,,pGroupname,,,'FIXED',,,,,);
		export Crptyp                    := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Crptyp::ks'	,'bctlpedata10',,,33	,,pGroupname,,,'FIXED',,,,,);
                                                                                                                                                                                                                                                               
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

		export companies                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companies::ky','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export officer                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::officer::ky','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);
		export initialofficers					 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::initialofficers::ky','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);

		export dAll_filenames :=
			  companies.dAll_filenames
			+ officer.dAll_filenames
			+ initialofficers.dAll_filenames
			;

	end;

	export la_raw :=
	module

		export entities                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corps_entities::la'	,'bctlpedata10',,,,,pGroupname,,,'XML','Entity',,,,);
		export agents                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::agents::la'	,'bctlpedata10',,,,,pGroupname,,,'XML','Entity',,,,);
		export filings                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filings::la'	,'bctlpedata10',,,,,pGroupname,,,'XML','Entity',,,,);
		export mergers                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::mergers::la'	,'bctlpedata10',,,,,pGroupname,,,'XML','Entity',,,,);
		export previous_names             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::previous_names::la','bctlpedata10',,,,,pGroupname,,,'XML','Entity',,,,);
		export name_reservs               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name_reservs::la'	,'bctlpedata10',,,,,pGroupname,,,'XML','NameReservationEntry',,,,);
		export trade_services             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::trade_services::la','bctlpedata10',,,,,pGroupname,,,'XML','TradeServiceEntity',,,,);

		export dAll_filenames :=
			  entities.dAll_filenames
			+ agents.dAll_filenames
			+ filings.dAll_filenames
			+ mergers.dAll_filenames
			+ previous_names.dAll_filenames
			+ name_reservs.dAll_filenames
			+ trade_services.dAll_filenames
			;

	end;

	export ma_raw :=
	module

		export corpdataexport            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpdataexport::ma'				,'bctlpedata10',,,,,pGroupname ,,,'VARIABLE',,8192,'|',,',');
		export corpindividualexport      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpindividualexport::ma'	,'bctlpedata10',,,,,pGroupname ,,,'VARIABLE',,8192,'|',,',');
		export corpstockexport           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpstockexport::ma'			,'bctlpedata10',,,,,pGroupname ,,,'VARIABLE',,8192,'|',,',');
		export corpdetailexport          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpdetailexport::ma'			,'bctlpedata10',,,,,pGroupname ,,,'VARIABLE',,8192,'|',,',');
		export corpmerger                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpmerger::ma'						,'bctlpedata10',,,,,pGroupname ,,,'VARIABLE',,8192,'|',,',');
		export corpnamechange            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpnamechange::ma'				,'bctlpedata10',,,,,pGroupname ,,,'VARIABLE',,8192,'|',,',');

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

		export AmendHist                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::AmendHist::md'		,'bctlpedata10',,,154,,pGroupname,,,'FIXED',, ,,,);
		export BusAddr_clean             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusAddr::md'			,'bctlpedata10',,,698,,pGroupname,,,'FIXED',, ,,,);
		export BusEntity                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusEntity::md'		,'bctlpedata10',,,101,,pGroupname,,,'FIXED',, ,,,);
		export BusNmIndx_clean           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusNmIndx::md'	  ,'bctlpedata10',,,620,,pGroupname,,,'FIXED',, ,,,);
		export BusType_clean             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusType::md'		  ,'bctlpedata10',,,77,,pGroupname,,,'FIXED',, ,,,);
		export BusComment_clean          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusComment::md'	,'bctlpedata10',,,1062,,pGroupname,,,'FIXED',, ,,,);
		export EntityStatus              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::EntityStatus::md','bctlpedata10',,,54,,pGroupname,,,'FIXED',, ,,,);
		export FilingType_clean          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::FilingType::md'	,'bctlpedata10',,,68,,pGroupname,,,'FIXED',, ,,,);
		export TradeName                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::TradeName::md'		,'bctlpedata10',,,86,,pGroupname,,,'FIXED',, ,,,);
		export FilmIndx                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::FilmIndx::md'		,'bctlpedata10',,,65,,pGroupname,,,'FIXED',, ,,,);
		export ReserveName               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ReserveName::md'	,'bctlpedata10',,,79,,pGroupname,,,'FIXED',, ,,,);
 		export ArcAmendHist              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ArcAmendHist::md','bctlpedata10',,,154,,pGroupname,,,'FIXED',, ,,,);
		export ArcBusAddr_clean          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ArcBusAddr::md'	,'bctlpedata10',,,698,,pGroupname,,,'FIXED',, ,,,);
    export ArcBusNmIndx_clean        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ArcBusNmIndx::md','bctlpedata10',,,620,,pGroupname,,,'FIXED',, ,,,);
                                                                                                                                     
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
			+ ArcAmendHist.dAll_filenames
			+ ArcBusAddr_clean.dAll_filenames
			+ ArcBusNmIndx_clean.dAll_filenames
			;

	end;

	export me_raw :=
	module

		export corp_bulk                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corp_bulk::me','bctlpedata10',,,1210,,pGroupname,,,'FIXED',,,,,);

		export dAll_filenames :=
			  corp_bulk.dAll_filenames
			;

	end;

	export mi_raw :=
	module

				export CorpMaster	    			:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporation::mi','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);
				export AssumedName	    		:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::assumedname::mi','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);
				export GeneralPartner  			:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::generalpartner::mi','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);
				export History	    				:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::history::mi','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);
				export LLC            			:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::limitedliabilityco::mi','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',); 
				export LP             			:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::limitedpartnership::mi','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);
				export NameRegistration			:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::nameregistration::mi','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);

		export dAll_filenames :=
			  CorpMaster.dAll_filenames + 
				AssumedName.dAll_filenames + 
				GeneralPartner.dAll_filenames + 
				History.dAll_filenames + 
				LLC.dAll_filenames + 
				LP.dAll_filenames + 
				NameRegistration.dAll_filenames 
			;

	end;

  export mn_raw := 
  module
		export fullfile       := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::fullfile::mn','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,',','\\r\\n',);
		export dAll_filenames := fullfile.dAll_filenames;
  end;
  
	export mo_raw :=
	module

		export address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::address::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);		
		export corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporation::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,,'\\n',);
		export name                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export Officer                 	 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officer::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export Stock                   	 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Stock::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export AddressType_Table         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::AddressType_Table::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export CorporationStatus_Table   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationStatus_Table::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export CorporationType_Table     := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationType_Table::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export DocumentType_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentType_Table::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,200,,'\\n',);
		export NameType_Table            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::NameType_Table::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export StockClass_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StockClass_Table::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export PartyType_Table           := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PartyType_Table::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export officerpartyType_table    := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::officerpartyType_table::mo','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);

		export dAll_filenames :=
			  address.dAll_filenames			
			+ corporation.dAll_filenames
			+ name.dAll_filenames
			+ Officer.dAll_filenames
			+ Stock.dAll_filenames			
			+ filing.dAll_filenames
			+ merger.dAll_filenames
			+ AddressType_Table.dAll_filenames
			+ CorporationStatus_Table.dAll_filenames
			+ CorporationType_Table.dAll_filenames
			+ DocumentType_Table.dAll_filenames
			+ NameType_Table.dAll_filenames
			+ StockClass_Table.dAll_filenames
			+ PartyType_Table.dAll_filenames
			+ officerpartyType_table.dAll_filenames
			;

	end;

	export ms_raw :=
	module

		export PROFILES                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::PROFILES::ms','bctlpedata10',,,,,pGroupname,,,'XML','Document',,,,);
		export FORMS                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::FORMS::ms','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,);
		

		export dAll_filenames :=
			  PROFILES.dAll_filenames
			+ FORMS.dAll_filenames
			;

	end;

	export mt_raw :=
	module

		export vendor_raw                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::vendor_raw::mt','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);
	
		export dAll_filenames :=  vendor_raw.dAll_filenames;


	end;

	export nc_raw :=
	module

		export Addresses                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Addresses::nc','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
		export Corporations              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corporations::nc','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
		export Filings                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Filings::nc','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
		export NameReservations          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::NameReservations::nc','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
		export Names                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Names::nc','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,);
		export CorpOfficers              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpOfficers::nc','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
	  export PendingFilings            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::PendingFilings::nc','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
		export Stock                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Stock::nc','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
		export DocumentType              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentType::nc','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,500,,'\\n',',');

		export dAll_filenames :=
			  Addresses.dAll_filenames
			+ Corporations.dAll_filenames
			+ Filings.dAll_filenames
			+ NameReservations.dAll_filenames
			+ Names.dAll_filenames
			+ CorpOfficers.dAll_filenames
			+ PendingFilings.dAll_filenames
			+ Stock.dAll_filenames
			+ DocumentType.dAll_filenames
			;

	end;

	export nd_raw :=
	module

		export Corpa_Vendor              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corpa_Vendor::nd'				,'bctlpedata10',,,1901	,,pGroupname,,,'FIXED',,,,,);
		export Corpb_Vendor              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corpb_Vendor::nd'				,'bctlpedata10',,,1901	,,pGroupname,,,'FIXED',,,,,);
		export Fictitios1_Vendor         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Fictitios1_Vendor::nd'	,'bctlpedata10',,,2601	,,pGroupname,,,'FIXED',,,,,);
		export Fictitios2_Vendor         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Fictitios2_Vendor::nd'	,'bctlpedata10',,,2601	,,pGroupname,,,'FIXED',,,,,);
		export Partnership_Vendor        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Partnership_Vendor::nd'	,'bctlpedata10',,,15001,,pGroupname,,,'FIXED',,,,,);
		export Trademarks1_Vendor        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Trademarks1_Vendor::nd'	,'bctlpedata10',,,2601	,,pGroupname,,,'FIXED',,,,,);
		export Trademarks2_Vendor        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Trademarks2_Vendor::nd'	,'bctlpedata10',,,2601	,,pGroupname,,,'FIXED',,,,,);
		export Tradename1_Vendor         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Tradename1_Vendor::nd'	,'bctlpedata10',,,2651	,,pGroupname,,,'FIXED',,,,,);
		export Tradename2_Vendor         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Tradename2_Vendor::nd'	,'bctlpedata10',,,2651	,,pGroupname,,,'FIXED',,,,,);
		export State_Country_Table       := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::State_Country_Table::nd','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,350,,'\\n',);

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

		export CorpAction                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpAction::ne','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);
		export CorpOfficers              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpOfficers::ne','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',',');
		export CorpEntity                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpEntity::ne','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);
		export CorporationType           := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationType::ne','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,250,'\\t','\\n',);
		export NECountryCodes            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::NECountryCodes::ne','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,250,'\\t','\\n',);
		export ListOfStates              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::ListOfStates::ne','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,250,'\\t','\\n',);
		export PositionHeld              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PositionHeld::ne','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,250,'\\t','\\n',);
		export RegisterAgent             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::RegisterAgent::ne','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);
		export ServiceType               := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::ServiceType::ne','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,250,'\\t','\\n',);

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

		export address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::address::nh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporation::nh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,,'\\n',);
		export name                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name::nh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::nh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger::nh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export officer                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::officer::nh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export stock                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::stock::nh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export AddressType_Table	       := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::AddressType_Table::nh','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);		
		export OffPartyType_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::OffPartyType_Table::nh','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export PartyType_Table           := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PartyType_Table::nh','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export NameType_Table            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::NameType_Table::nh','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export StockClass_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StockClass_Table::nh','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export StatusCode_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StatusCode_Table::nh','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export CorpType_Table            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorpType_Table::nh','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);
		export DocumentTypeID_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentTypeID_Table::nh','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);

		export dAll_filenames :=
					 address.dall_filenames
				 + corporation.dall_filenames
				 + name.dall_filenames
				 + statuscode_table.dall_filenames
				 + corptype_table.dall_filenames
				 + documenttypeid_table.dall_filenames
				 + filing.dall_filenames
				 + merger.dall_filenames
				 + nametype_table.dall_filenames
				 + officer.dall_filenames
				 + addresstype_table.dall_filenames
				 + offpartytype_table.dall_filenames
				 + partytype_table.dall_filenames
				 + stock.dall_filenames
				 + stockclass_table.dall_filenames
				;

	end;

	export nj_raw :=
	module

		export Business                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Business::nj','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,',');

		export dAll_filenames :=
			  Business.dAll_filenames
			;

	end;

	export nm_raw :=
	module
		//export Import_Master   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Import_Master::nm'		,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\t','\\r\\n',);
		export Import_Master   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Import_Master::nm'		,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\t','\\n',);
		export dAll_filenames  := Import_Master.dAll_filenames;

	end;

	export nv_raw :=
	module

		export ACTIONS                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ACTIONS::nv','bctlpedata10',,,,,pGroupname    ,,,'VARIABLE',,,'~','\\n',);
		export Corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corporation::nv','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'~','\\n',);
		export OFFICERS                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::OFFICERS::nv','bctlpedata10',,,,,pGroupname      ,,,'VARIABLE',,,'~','\\n',);
		export RA                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::RA::nv','bctlpedata10',,,,,pGroupname               ,,,'VARIABLE',,,'~','\\n',);
		export STOCK                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::STOCKs::nv','bctlpedata10',,,,,pGroupname  ,,,'VARIABLE',,,'~','\\n',);

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
	
		export master                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::master::ny','bctlpedata10',,,252,,pGroupname,,,'FIXED',,,,,);
		export merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger::ny','bctlpedata10',,,252,,pGroupname,,,'FIXED',,,,,);
		export Constituent               := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Constituent::ny','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export Country_Principal         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Country_Principal::ny','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export Document_Types            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Document_Types::ny','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,500,,'\\n',);
		export State_Possession          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::State_Possession::ny','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		
		export dAll_filenames := master.dAll_filenames
														 + merger.dAll_filenames
														 + Constituent.dAll_filenames
														 + Country_Principal.dAll_filenames
														 + Document_Types.dAll_filenames
														 + State_Possession.dAll_filenames;

	end;
		export ny_raw_fullLoad :=
	  module
		
    //Ny-Corp vendor notified that each quarterly, master file will be split into 3 small files because of huge data ,there is no change in merger file !
		export master1                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@g1::master::ny','bctlpedata10',,,262,,pGroupname,,,'FIXED',,,,,);
		export master2                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@g2::master::ny','bctlpedata10',,,262,,pGroupname,,,'FIXED',,,,,);
		export master3                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@g3::master::ny','bctlpedata10',,,262,,pGroupname,,,'FIXED',,,,,);
		export merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@g1::merger::ny','bctlpedata10',,,252,,pGroupname,,,'FIXED',,,,,);
		export Constituent               := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Constituent::ny','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export Country_Principal         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Country_Principal::ny','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export Document_Types            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Document_Types::ny','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,500,,'\\n',);
		export State_Possession          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::State_Possession::ny','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);

		export dAll_filenames := master1.dAll_filenames
														+ master2.dAll_filenames	
														+ master3.dAll_filenames
														+ merger.dAll_filenames
														+ Constituent.dAll_filenames
														+ Country_Principal.dAll_filenames
														+ Document_Types.dAll_filenames
														+ State_Possession.dAll_filenames;

	end;
	
	export oh_raw :=
	module

		export Business_Address          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Business_Address::oh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export Agent_Contact             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Agent_Contact::oh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',',');
		export Business_Associate        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Business_Associate::oh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export Business                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Business::oh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',',');
		export CountyCodeType_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CountyCodeType_Table::oh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,200,'|','\\n',);
		export Explanation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Explanation::oh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export Text_Information          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Text_Information::oh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',',');
		export Old_Name                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Old_Name::oh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',',');
		export Authorized_Share          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Authorized_Share::oh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export StateCodeType_Table       := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StateCodeType_Table::oh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,'|','\\n',);
		export TranCodeType_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::TranCodeType_Table::oh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,'|','\\n',);
		export Document_Transaction      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Document_Transaction::oh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export shareType_Table		       := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::shareType_Table::oh','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,100,'|','\\n',);

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

		export AllRecs                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::all::ok','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'~');

		export dAll_filenames :=
			  AllRecs.dAll_filenames
			;

	end;
	
 export or_raw :=
	module

   	//export county_db_extract         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::county_db_extract::or','bctlpedata10',,,51,,pGroupname,,,'FIXED',,,,,,false,false,false);  
		//export entity_db_extract         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::entity_db_extract::or','bctlpedata10',,,241,,pGroupname,,,'FIXED',,,,,,false,false,false);  
		//export merger_share_db_extract   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger_share_db_extract::or','bctlpedata10',,,162,,pGroupname,,,'FIXED',,,,,,false,false,false);  
		//export name_db_extract           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name_db_extract::or','bctlpedata10',,,336,,pGroupname,,,'FIXED',,,,,,false,false,false);      
		//export rel_assoc_name_db_extract := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::rel_assoc_name_db_extract::or','bctlpedata10',,,484,,pGroupname,,,'FIXED',,,,,,false,false,false);  
		//export tran_db_extract           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tran_db_extract::or','bctlpedata10',,,131,,pGroupname,,,'FIXED',,,,,,false,false,false);  

    // From Dataland.
	   export county_db_extract         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::county_db_extract::or','bctlpedata10',,,,,pGroupname          ,,,'VARIABLE',,8192,,,);
		 export entity_db_extract         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::entity_db_extract::or','bctlpedata10',,,,,pGroupname          ,,,'VARIABLE',,8192,,,);
		 export merger_share_db_extract   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger_share_db_extract::or','bctlpedata10',,,,,pGroupname   ,,,'VARIABLE',,8192,,,);
		 export name_db_extract           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name_db_extract::or','bctlpedata10',,,,,pGroupname            ,,,'VARIABLE',,8192,,,);
		 export rel_assoc_name_db_extract := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::rel_assoc_name_db_extract::or','bctlpedata10',,,,,pGroupname  ,,,'VARIABLE',,8192,,,);
		 export tran_db_extract           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tran_db_extract::or','bctlpedata10',,,,,pGroupname            ,,,'VARIABLE',,8192,,,);

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

		export Address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Address::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export AddressType               := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::AddressType::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export Corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corporation::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export CorporationName           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorporationName::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export CorporationStatus         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationStatus::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export CorporationType           := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationType::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export DocumentType              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentType::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export Filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Filing::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export Merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Merger::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export NameType                  := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::NameType::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export Officer                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officer::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export OfficerPartyType          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::OfficerPartyType::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export PartyType                 := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PartyType::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export StockOrig                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::StockOrig::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',,,,true);
		export StockClass                := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StockClass::pa','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);

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

		export Amendments                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Amendments::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Amendments       := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Amendments::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Entities                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Entities::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Entities         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Entities::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Mergers                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Mergers::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Mergers          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Mergers::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Names                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Names::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Names            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Names::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Officers                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officers::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Officers         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Officers::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Stocks                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Stocks::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Stocks           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Stocks::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export corp_filings              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::corp_filings::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export country                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::country::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);
		export state                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::state::ri','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,,,);

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

		export corpNameFile              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpNameFile::sc','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);
		export corpTxnFile               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpTxnFile::sc','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);
		export corpFile                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpFile::sc','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);

		export dAll_filenames :=
			  corpNameFile.dAll_filenames
			+ corpTxnFile.dAll_filenames
			+ corpFile.dAll_filenames
			;

	end;
		
	export sd_raw :=
	module

		export vendor_main							 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::vendor_main::sd','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'|','\\n',);
		export vendor_amendments				 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::vendor_amendments::sd','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'|','\\n',);
		export vendor_ar  							 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::vendor_ar::sd','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'|','\\n',);
	
		export dAll_filenames :=
			  Vendor_Main.dAll_filenames
			+ Vendor_amendments.dAll_filenames
			+ Vendor_ar.dAll_filenames;

	end;

	export tn_raw :=
	module

		export Filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::tn'				,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'|','\\n',',');
		export FilingName                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing_name::tn'		,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'|','\\n',);
		export Party                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::party::tn'					,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'|','\\n',);
		export AnnualReport              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::annual_report::tn'	,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'|','\\n',);
		export BusinessTypeCode_Table    := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::BusinessTypeCode_Table::tn','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,100,'\\t','\\n',);
		export ChargeCodeDesc_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::ChargeCodeDesc_Table::tn','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,350,'\\t','\\n',);
		export CountyStateCode_Table     := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CountyStateCode_Table::tn','bctlpedata10',,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);

		export dAll_filenames :=
			  Filing.dAll_filenames
			+	FilingName.dAll_filenames
			+	Party.dAll_filenames
			+	AnnualReport.dAll_filenames
			+ BusinessTypeCode_Table.dAll_filenames
			+ ChargeCodeDesc_Table.dAll_filenames
			+ CountyStateCode_Table.dAll_filenames
			;

	end;
	
	export tx_raw :=
	module

		export Master              			 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::master::tx','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, ,,'\\n',);
		export nonprofitsubtype          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::nonprofitsubtype::tx','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 100,,'\\n',);
		export mem_part_offi_title       := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::mem_part_offi_title::tx','bctlpedata10',,,,,pGroupname,,,'VARIABLE',, 200,'\\|','\\n',);

		export dAll_filenames :=
			  Master.dAll_filenames
			+ nonprofitsubtype.dAll_filenames
			+ mem_part_offi_title.dAll_filenames
			; 

	end;

	export txbus_raw :=
	module

		export ftact                      := VersionControl.mInputFileNameVersions(lthor + 'in::Corp2::@version@::ftact::txbus'		,'bctlpedata10',,,218,,pGroupname,,,'FIXED',,,,,);

		export dAll_filenames :=
			  ftact.dAll_filenames
			;

	end;

	export ut_raw :=
	module

		export Busentity1             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Busentity::ut','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export Busentity2             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Principals::ut','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export Busentity3             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Businfo::ut','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
          
		export dAll_filenames :=
			  Busentity1.dAll_filenames
			+ Busentity2.dAll_filenames
			+ Busentity3.dAll_filenames
			; 

	end;

		export va_raw :=
	module

		export Corps          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corps::va','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export LLC            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::LLC::va','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export LP             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::LP::va','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Merger         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Merger::va','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export NamesHist      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::NamesHist::va','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Officer        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officer::va','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Amendmt        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Amendment::va','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export ResrvdName     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ResrvdName::va','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Tables         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Tables::va','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');

		export dAll_filenames :=
			  corps.dAll_filenames 
			+ LLC.dAll_filenames
			+ LP.dAll_filenames
			+ Merger.dAll_filenames
			+ NamesHist.dAll_filenames
      + Officer.dAll_filenames
			+ Amendmt.dAll_filenames
			+ ResrvdName.dAll_filenames
			+ Tables.dAll_filenames
			;

	end;

	export vt_raw :=
	module

		export Domestic_LLC_Bus     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_llc_bus::vt'       ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
 		export Domestic_MBE_Bus     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_mbe_bus::vt'       ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Domestic_NPC_Bus     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_npc_bus::vt'       ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Domestic_Prof_Bus    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_prof_bus::vt'      ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Domestic_LLC_Prin    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_llc_prn::vt'       ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
 		export Domestic_MBE_Prin    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_mbe_prn::vt'       ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Domestic_NPC_Prin    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_npc_prn::vt'       ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Domestic_Prof_Prin   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_prof_prn::vt'      ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
 		export Foreign_LLC_Bus      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::for_llc_bus::vt'       ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Foreign_NPC_Bus      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::for_npc_bus::vt'       ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Foreign_Prof_Bus     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::for_prof_bus::vt'      ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Foreign_LLC_Prin     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::for_llc_prn::vt'       ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Foreign_NPC_Prin     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::for_npc_prn::vt'       ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Foreign_Prof_Prin    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::for_prof_prn::vt'      ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
    export Partnerships_Bus     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::pships_bus::vt'        ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Partnerships_Prin    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::pships_prn::vt'        ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
    export TradeNames_Bus       := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::trade_names_bus::vt'   ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export TradeNames_Prin      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::trade_names_prn::vt'   ,'bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export TradeNames_Owners    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::trade_names_owners::vt','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);

		export dAll_filenames :=
			 Domestic_LLC_Bus.dAll_filenames
			+ Domestic_MBE_Bus.dAll_filenames
			+ Domestic_NPC_Bus.dAll_filenames
			+ Domestic_Prof_Bus.dAll_filenames
			+ Domestic_LLC_Prin.dAll_filenames
			+ Domestic_MBE_Prin.dAll_filenames
			+ Domestic_NPC_Prin.dAll_filenames
			+ Domestic_Prof_Prin.dAll_filenames
			+ Foreign_LLC_Bus.dAll_filenames
			+ Foreign_NPC_Bus.dAll_filenames
			+ Foreign_Prof_Bus.dAll_filenames
			+ Foreign_LLC_Prin.dAll_filenames
			+ Foreign_NPC_Prin.dAll_filenames
			+ Foreign_Prof_Prin.dAll_filenames
			+ Partnerships_Bus.dAll_filenames
			+ Partnerships_Prin.dAll_filenames
			+ TradeNames_Bus.dAll_filenames
			+ TradeNames_Prin.dAll_filenames
			+ TradeNames_Owners.dAll_filenames
			;

	end;

	export wa_raw :=
		module
	
			export Corporations            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporations::wa','bctlpedata10',,,,,pGroupname,,,'XML','Corporation',512*500,,,); 
			export GoverningPersons        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::governingpersons::wa','bctlpedata10',,,,,pGroupname,,,'XML','Governor',512*500,,,); 
  		export DocumentTypes           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::documenttypes::wa','bctlpedata10',,,,,pGroupname,,,'XML','DocumentType',512*500,,,); 

			export dAll_filenames :=
				  Corporations.dAll_filenames
				+ GoverningPersons.dAll_filenames
				+ DocumentTypes.dAll_filenames
				;
	
	end;

	export wi_raw :=
	module

		export comfichex                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::comfichex::wi','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,140,,,',');

		export dAll_filenames :=
			  comfichex.dAll_filenames
			;

	end;

	export wv_raw :=
	module

		export ds_Addresses	     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::addresses::wv','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_subsidiaries   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::subsidiaries::wv','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_amendments     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::amendments::wv','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_annualreports  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::annualreports::wv','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_corporations   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporations::wv','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_dbas           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dbas::wv','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_mergers        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::mergers::wv','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_namechanges    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::namechanges::wv','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_Dissolutions   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dissolutions::wv','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		
		export dAll_filenames :=
			  ds_Addresses.dAll_filenames
			+ ds_subsidiaries .dAll_filenames
			+ ds_amendments.dAll_filenames
			+ ds_annualreports.dAll_filenames
			+ ds_corporations.dAll_filenames
			+ ds_dbas.dAll_filenames
			+ ds_mergers.dAll_filenames
			+ ds_namechanges.dAll_filenames
			+ ds_Dissolutions.dAll_filenames
			;
	
	end;
			
	export wy_raw :=
	module
	
		export Filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Filing::wy','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,1000,'\\|','\\n',',');
		export Filing_Annual_Report      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Filing_Annual_Report::wy','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\|','\\n',',');
		export Party                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Party::wy','bctlpedata10',,,,,pGroupname,,,'VARIABLE',,800,'\\|','\\n',);

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
		+ ny_raw_fullLoad.dAll_filenames
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
		+ wy_raw.dAll_filenames : INDEPENDENT;
		;
end;