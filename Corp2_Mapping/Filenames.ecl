﻿/*2014-04-01T15:20:48Z (mgould_prod)
C:\Users\goulmi01\AppData\Roaming\HPCC Systems\eclide\mgould_prod\Boca_Prod\Corp2_Mapping\Filenames\2014-04-01T15_20_48Z.ecl
*/
/*2013-12-06T19:54:44Z (mgould_prod)
C:\Users\goulmi01\AppData\Roaming\HPCC Systems\eclide\mgould_prod\Boca_Prod\Corp2_Mapping\Filenames\2013-12-06T19_54_44Z.ecl
*/
import VersionControl; 
string landing_zone := 'uspr-edata10.risk.regn.net';
export Filenames(
 
	 string 	pversion							= ''
	,string 	pGroupname						= VersionControl.Groupname('31')
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lthor				:= _Dataset(pUseOtherEnvironment).thor_cluster_Files;
	
	export ak_raw :=
	module
		export Corporations          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corporations::ak',landing_zone,,,,,pGroupname,,,'VARIABLE',,,',','\\n',);
		export Officials                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officials::ak',landing_zone,,,,,pGroupname,,,'VARIABLE',,,',','\\n',);

		export dAll_filenames :=
			    Corporations.dAll_filenames
			+ Officials.dAll_filenames
			;

	end;

	export al_raw :=
	module

		export CRANLPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRANLPF::al',landing_zone,,,956,,pGroupname,,,'FIXED',,,,,);
		export CRBUSPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRBUSPF::al',landing_zone,,,222,,pGroupname,,,'FIXED',,,,,);
		export CRHSTPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRHSTPF::al',landing_zone,,,192,,pGroupname,,,'FIXED',,,,,);
		export CRINCPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRINCPF::al',landing_zone,,,172,,pGroupname,,,'FIXED',,,,,);
		export CRMSTPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRMSTPF::al',landing_zone,,,663,,pGroupname,,,'FIXED',,,,,);
		export CRNAMPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRNAMPF::al',landing_zone,,,238,,pGroupname,,,'FIXED',,,,,);
		export CROFFPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CROFFPF::al',landing_zone,,,134,,pGroupname,,,'FIXED',,,,,);
		export CRSERPF                   := VersionControl.mInputFileNameVersions( lthor + 'in::corp2::@version@::CRSERPF::al',landing_zone,,,170,,pGroupname,,,'FIXED',,,,,);
                                                                                                                               
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

		export CorpData                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpData::ar',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);
		export CorpNames                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpNames::ar',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);
		export CorpOfficer               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpOfficer::ar',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n',);

		export dAll_filenames :=
			  CorpData.dAll_filenames
			+ CorpNames.dAll_filenames
			+ CorpOfficer.dAll_filenames
			;

	end;

	export az_raw :=
	module

			export CHGEXT                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::chgext::az',landing_zone,,,,, pGroupname,,,'VARIABLE');
			export COREXT                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corext::az',landing_zone,,,,, pGroupname,,,'VARIABLE');
			export FLMEXT                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::flmext::az',landing_zone,,,,, pGroupname,,,'VARIABLE');
			export OFFEXT                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::offext::az',landing_zone,,,,, pGroupname,,,'VARIABLE');
			export INACTV                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::inactv::az',landing_zone,,,,, pGroupname,,,'VARIABLE');
				
		export dAll_filenames :=
		    CHGEXT.dAll_filenames
			+ COREXT.dAll_filenames
			+ FLMEXT.dAll_filenames
			+ OFFEXT.dAll_filenames
			+ INACTV.dAll_filenames
      ;
			
	end;

	export ca_raw :=
	module

		export lp                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::lp::ca'		,landing_zone,,,1455	,,pGroupname,,,'FIXED',, ,,,);
		export hist                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::hist::ca'	,landing_zone,,,424	,,pGroupname,,,'FIXED',, ,,,);
		export mast                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::mast::ca'	,landing_zone,,,1282	,,pGroupname,,,'FIXED',, ,,,);
                                                                                                                            
		export dAll_filenames :=
			  lp.dAll_filenames
			+ hist.dAll_filenames
			+ mast.dAll_filenames
			;

	end;

	export co_raw :=
	module

		export corpHist                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpHist::co',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',',');
		export corpHist2                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpHist2::co',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',',');
		export corpMstr                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpMstr::co',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',',');
		export corpTrdnm                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpTrdnm::co',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',',');
		export tmChange                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmChange::co',landing_zone,,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');
		export tmCorrection              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmCorrection::co',landing_zone,,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');
		export tmExpired                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmExpired::co',landing_zone,,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');
		export tmRegistration            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmRegistration::co',landing_zone,,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');
		export tmRenewal                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmRenewal::co',landing_zone,,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');
		export tmTransfer                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmTransfer::co',landing_zone,,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');
		export tmWithdraw                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmWithdraw::co',landing_zone,,,,,pGroupname,,,'VARIABLE',,3000,'|','\\r',',');

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


		export BusFiling              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpBusFiling::ct',landing_zone,,,125	,,pGroupname,,,'FIXED',, ,,,);
		export BusMaster              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpBusMaster::ct',landing_zone,,,1158,,pGroupname,,,'FIXED',, ,,,);
		export busmergr               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpbusmergr::ct'	,landing_zone,,,40	,,pGroupname,,,'FIXED',, ,,,);
		export busother               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpbusother::ct'	,landing_zone,,,134	,,pGroupname,,,'FIXED',, ,,,);
		export busrsvr                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpbusrsvr::ct'	,landing_zone,,,360	,,pGroupname,,,'FIXED',, ,,,);
		export corp                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpcorp::ct'			,landing_zone,,,165	,,pGroupname,,,'FIXED',, ,,,);
		export dlmlpart               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpdlmlpart::ct'	,landing_zone,,,38	,,pGroupname,,,'FIXED',, ,,,);
		export dlmtcorp               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpdlmtcorp::ct'	,landing_zone,,,46	,,pGroupname,,,'FIXED',, ,,,);
		export dlmtpart               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpdlmtpart::ct'	,landing_zone,,,28	,,pGroupname,,,'FIXED',, ,,,);
		export filmindx               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpfilmindx::ct'	,landing_zone,,,64	,,pGroupname,,,'FIXED',, ,,,);
		export flmlpart               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpflmlpart::ct'	,landing_zone,,,151	,,pGroupname,,,'FIXED',, ,,,);
		export flmtcorp               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpflmtcorp::ct'	,landing_zone,,,352	,,pGroupname,,,'FIXED',, ,,,);
		export flmtpart               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpflmtpart::ct'	,landing_zone,,,335	,,pGroupname,,,'FIXED',, ,,,);
		export forstat                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpforstat::ct'	,landing_zone,,,326	,,pGroupname,,,'FIXED',, ,,,);
		export generalp               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpgeneralp::ct'	,landing_zone,,,228	,,pGroupname,,,'FIXED',, ,,,);
		export namechng               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpnamechng::ct'	,landing_zone,,,329	,,pGroupname,,,'FIXED',, ,,,);
		export prncipal               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpprncipal::ct'	,landing_zone,,,513	,,pGroupname,,,'FIXED',, ,,,);
		export stock                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmpstock::ct'		,landing_zone,,,67	,,pGroupname,,,'FIXED',, ,,,);
                                                                                                                                   
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

		export corporations              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporations::dc',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,', '\\r\\n', '"',);

		export dAll_filenames :=
			  corporations.dAll_filenames
			;

	end;

	export fl_raw :=
	module

		export corpFile                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpFile::fl'	,landing_zone,,,1442	,,pGroupname,,,'FIXED',,,,,);
		export eventFile                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::eventFile::fl',landing_zone,,,664	,,pGroupname,,,'FIXED',,,,,);
                                                                                                                                
		export dAll_filenames :=
			  corpFile.dAll_filenames
			+ eventFile.dAll_filenames
			;

	end;

	export fltm_raw :=
	module

		export tmFile                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmFile::fltm',landing_zone,,,1906,,pGroupname,,,'FIXED',,,,,);

		export dAll_filenames :=
			  tmFile.dAll_filenames
			;

	end;

  //Added '\\' as the QUOTE input so that quotes in the data will be ignored.  Quotes in the data causes some data to be dropped.
	export ga_raw :=
	module

		export address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::address::ga',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n','\\',);
		export corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporation::ga',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n','\\',);
		export filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::ga',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n','\\',);
		export officer                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::officer::ga',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n','\\',);
		export ragent                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ragent::ga',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n','\\',);
		export stock                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::stock::ga',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'\\t','\\n','\\',);
		
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

		export companymaster             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companymaster::hi',landing_zone,,,,,pGroupname       ,,,'VARIABLE',,8192,,'\\n',',');
		export companyofficer            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companyofficer::hi',landing_zone,,,,,pGroupname      ,,,'VARIABLE',,8192,,'\\n',',');
		export companystock              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companystock::hi',landing_zone,,,,,pGroupname        ,,,'VARIABLE',,8192,,'\\n',',');
		export companytransaction        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companytransaction::hi',landing_zone,,,,,pGroupname  ,,,'VARIABLE',,8192,,'\\n',',');
		export ttsmaster                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ttsmaster::hi',landing_zone,,,,,pGroupname           ,,,'VARIABLE',,8192,,'\\n',',');
		export ttstransaction            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ttstransaction::hi',landing_zone,,,,,pGroupname      ,,,'VARIABLE',,8192,,'\\n',',');

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

		export crpAdd                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpAdd::ia',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpAgt                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpAgt::ia',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpDes                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpDes::ia',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpFil                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpFil::ia',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpHis                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpHis::ia',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpNam                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpNam::ia',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n','');
		export crpOff                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpOff::ia',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpPrt                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpPrt::ia',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpRem                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpRem::ia',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export crpStk                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::crpStk::ia',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\t','\\n',);
		export ChapterCodes_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::ChapterCodes_Table::ia'	,landing_zone,,,57	,,pGroupname,,,'FIXED',, ,,,);
		export OfficerType_Table         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::OfficerType_Table::ia'	,landing_zone,,,28	,,pGroupname,,,'FIXED',, ,,,);
		export PageNo_Table              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PageNo_Table::ia'				,landing_zone,,,64	,,pGroupname,,,'FIXED',, ,,,);
		export FilingType_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::FilingType_Table::ia'		,landing_zone,,,88	,,pGroupname,,,'FIXED',, ,,,);
		export CountryCodes_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CountryCodes_Table::ia'	,landing_zone,,,164,,pGroupname,,,'FIXED',, ,,,);
		export StateCodes_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StateCodes_Table::ia'		,landing_zone,,,34	,,pGroupname,,,'FIXED',, ,,,);
                                                                                                                                            
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
		export Filing 						       := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::id',landing_zone,,,,,pGroupname,,,'VARIABLE');
		export FilingName 					     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filingname::id',landing_zone,,,,,pGroupname,,,'VARIABLE');
		export Party 						         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::party::id',landing_zone,,,,,pGroupname,,,'VARIABLE');
		
		export dAll_filenames :=
			  Filing.dAll_filenames
			+ FilingName.dAll_filenames
			+ Party.dAll_filenames
			;

	end;

	export il_raw :=
	module

      shared dailyraw(string pfrequency) :=
      module
				 export master     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::' + pfrequency +'_master::il',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'',,'');
      end;

      shared monthlyraw(string pfrequency) :=
      module
				 export master     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::' + pfrequency +'_master::il',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'',,'');
         export corpnames  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::' + pfrequency +'_corpnames::il',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,',');
         export stock      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::' + pfrequency +'_stock::il',landing_zone,,,,,pGroupname,,,'VARIABLE');
      end;
			
      export daily   := dailyraw('daily');
      export monthly := monthlyraw('monthly');

			export llc     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::llc::il',landing_zone,,,,,pGroupname,,,'VARIABLE','',8192,,'\\n',);
			export lp      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::lp::il',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,,'\\n',);
                                                                                        
      
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

		export Corp_Agents               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corp_agents::in',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Corp_Corporations         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corp_corporations::in',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Corp_Filings              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Filings::in',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Corp_Mergers              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Mergers::in',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Corp_Names                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Names::in',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Corp_Officers             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corp_Officers::in',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');

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

		export cpabrep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpabrep::ks'		,landing_zone,,,317,,pGroupname,,,'FIXED',,,,,);
		export cpadrep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpadrep::ks'		,landing_zone,,,186,,pGroupname,,,'FIXED',,,,,);
		export cpaerep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpaerep::ks'		,landing_zone,,,75	,,pGroupname,,,'FIXED',,,,,);
		export cpahst                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpahst::ks'			,landing_zone,,,83	,,pGroupname,,,'FIXED',,,,,);
		export cpaqrep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpaqrep::ks'		,landing_zone,,,41	,,pGroupname,,,'FIXED',,,,,);
		export cpbcrep                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::cpbcrep::ks'		,landing_zone,,,148,,pGroupname,,,'FIXED',,,,,);
		export Cpasrep                   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Cpasrep::ks',landing_zone,,,58	,,pGroupname,,,'FIXED',,,,,);
		export Cpakrep                   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Cpakrep::ks',landing_zone,,,78	,,pGroupname,,,'FIXED',,,,,);
		export Cpalrep                   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Cpalrep::ks',landing_zone,,,68	,,pGroupname,,,'FIXED',,,,,);
		export Cpanrep                   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Cpanrep::ks',landing_zone,,,34	,,pGroupname,,,'FIXED',,,,,);
		export Crptyp                    := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Crptyp::ks'	,landing_zone,,,33	,,pGroupname,,,'FIXED',,,,,);
                                                                                                                                                                                                                                                               
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

		export companies                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::companies::ky',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export officer                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::officer::ky',landing_zone,,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);
		export initialofficers					 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::initialofficers::ky',landing_zone,,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);

		export dAll_filenames :=
			  companies.dAll_filenames
			+ officer.dAll_filenames
			+ initialofficers.dAll_filenames
			;

	end;

	export la_raw :=
	module

		export entities                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corps_entities::la'	,landing_zone,,,,,pGroupname,,,'XML','Entity',,,,);
		export agents                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::agents::la'	,landing_zone,,,,,pGroupname,,,'XML','Entity',,,,);
		export filings                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filings::la'	,landing_zone,,,,,pGroupname,,,'XML','Entity',,,,);
		export mergers                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::mergers::la'	,landing_zone,,,,,pGroupname,,,'XML','Entity',,,,);
		export previous_names             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::previous_names::la',landing_zone,,,,,pGroupname,,,'XML','Entity',,,,);
		export name_reservs               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name_reservs::la'	,landing_zone,,,,,pGroupname,,,'XML','NameReservationEntry',,,,);
		export trade_services             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::trade_services::la',landing_zone,,,,,pGroupname,,,'XML','TradeServiceEntity',,,,);

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

		export corpdataexport            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpdataexport::ma'				,landing_zone,,,,,pGroupname ,,,'VARIABLE',,8192,'|',,',');
		export corpindividualexport      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpindividualexport::ma'	,landing_zone,,,,,pGroupname ,,,'VARIABLE',,8192,'|',,',');
		export corpstockexport           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpstockexport::ma'			,landing_zone,,,,,pGroupname ,,,'VARIABLE',,8192,'|',,',');
		export corpdetailexport          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpdetailexport::ma'			,landing_zone,,,,,pGroupname ,,,'VARIABLE',,8192,'|',,',');
		export corpmerger                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpmerger::ma'						,landing_zone,,,,,pGroupname ,,,'VARIABLE',,8192,'|',,',');
		export corpnamechange            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpnamechange::ma'				,landing_zone,,,,,pGroupname ,,,'VARIABLE',,8192,'|',,',');

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

		export AmendHist                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::AmendHist::md'		,landing_zone,,,154,,pGroupname,,,'FIXED',, ,,,);
		export BusAddr_clean             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusAddr::md'			,landing_zone,,,698,,pGroupname,,,'FIXED',, ,,,);
		export BusEntity                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusEntity::md'		,landing_zone,,,101,,pGroupname,,,'FIXED',, ,,,);
		export BusNmIndx_clean           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusNmIndx::md'	  ,landing_zone,,,620,,pGroupname,,,'FIXED',, ,,,);
		export BusType_clean             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusType::md'		  ,landing_zone,,,77,,pGroupname,,,'FIXED',, ,,,);
		export BusComment_clean          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::BusComment::md'	,landing_zone,,,1062,,pGroupname,,,'FIXED',, ,,,);
		export EntityStatus              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::EntityStatus::md',landing_zone,,,54,,pGroupname,,,'FIXED',, ,,,);
		export FilingType_clean          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::FilingType::md'	,landing_zone,,,68,,pGroupname,,,'FIXED',, ,,,);
		export TradeName                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::TradeName::md'		,landing_zone,,,86,,pGroupname,,,'FIXED',, ,,,);
		export FilmIndx                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::FilmIndx::md'		,landing_zone,,,65,,pGroupname,,,'FIXED',, ,,,);
		export ReserveName               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ReserveName::md'	,landing_zone,,,79,,pGroupname,,,'FIXED',, ,,,);
 		export ArcAmendHist              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ArcAmendHist::md',landing_zone,,,154,,pGroupname,,,'FIXED',, ,,,);
		export ArcBusAddr_clean          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ArcBusAddr::md'	,landing_zone,,,698,,pGroupname,,,'FIXED',, ,,,);
    export ArcBusNmIndx_clean        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ArcBusNmIndx::md',landing_zone,,,620,,pGroupname,,,'FIXED',, ,,,);
                                                                                                                                     
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

		export corp_bulk                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corp_bulk::me',landing_zone,,,1210,,pGroupname,,,'FIXED',,,,,);

		export dAll_filenames :=
			  corp_bulk.dAll_filenames
			;

	end;

	export mi_raw :=
	module

				export CorpMaster	    			:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporation::mi',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);
				export AssumedName	    		:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::assumedname::mi',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);
				export GeneralPartner  			:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::generalpartner::mi',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);
				export History	    				:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::history::mi',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);
				export LLC            			:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::limitedliabilityco::mi',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',); 
				export LP             			:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::limitedpartnership::mi',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);
				export NameRegistration			:= VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::nameregistration::mi',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);

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
		export fullfile       := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::fullfile::mn',landing_zone,,,,,pGroupname,,,'VARIABLE',,,',','\\r\\n',);
		export dAll_filenames := fullfile.dAll_filenames;
  end;
  
	export mo_raw :=
	module

		export address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::address::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);		
		export corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporation::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,,'\\n',);
		export name                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export Officer                 	 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officer::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export Stock                   	 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Stock::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export AddressType_Table         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::AddressType_Table::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export CorporationStatus_Table   := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationStatus_Table::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export CorporationType_Table     := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationType_Table::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export DocumentType_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentType_Table::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,200,,'\\n',);
		export NameType_Table            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::NameType_Table::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export StockClass_Table          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StockClass_Table::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export PartyType_Table           := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PartyType_Table::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export officerpartyType_table    := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::officerpartyType_table::mo',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);

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

		export PROFILES                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::PROFILES::ms',landing_zone,,,,,pGroupname,,,'XML','Document',,,,);
		export FORMS                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::FORMS::ms',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\t',,);
		

		export dAll_filenames :=
			  PROFILES.dAll_filenames
			+ FORMS.dAll_filenames
			;

	end;

	export mt_raw :=
	module

		export vendor_raw                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::vendor_raw::mt',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'\\,',, '"',);
	
		export dAll_filenames :=  vendor_raw.dAll_filenames;


	end;

	export nc_raw :=
	module

		export Addresses                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Addresses::nc',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
		export Corporations              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corporations::nc',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
		export Filings                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Filings::nc',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
		export NameReservations          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::NameReservations::nc',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
		export Names                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Names::nc',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\t',,);
		export CorpOfficers              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorpOfficers::nc',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
	  export PendingFilings            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::PendingFilings::nc',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
		export Stock                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Stock::nc',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\t',,',');
		export DocumentType              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentType::nc',landing_zone,,,,, pGroupname,,,'VARIABLE',,500,,'\\n',',');

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

		export Filing                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::nd'				    ,landing_zone,,,,, pGroupname,,,'VARIABLE');
		export Owner                      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::owner::nd'				    ,landing_zone,,,,, pGroupname,,,'VARIABLE');
		export Trademark                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::trademark::nd'	      ,landing_zone,,,,, pGroupname,,,'VARIABLE');
		export TrademarkClass             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::trademark_class::nd'	,landing_zone,,,,, pGroupname,,,'VARIABLE');

		export dAll_filenames :=
			  Filing.dAll_filenames
			+ Owner.dAll_filenames
			+ Trademark.dAll_filenames
			+ TrademarkClass.dAll_filenames
			;

	end;

	export ne_raw :=
	module

		export CorporateActions          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporateactions::ne',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'','},{,]',);
		export CorporateOfficers         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporateofficers::ne',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'','},{,]',);
		export CorporationEntity         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporationentity::ne',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'','},{,]',);
		export RegisteredAgent           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::registeredagent::ne',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'','},{,]',);
		export CorporationType           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporationtype::ne',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'','\\]',);
		export NECountryCodes            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::countrycodes::ne',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'','\\]',);
		export ListOfStates              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::listofStates::ne',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'','\\]',);

		export dAll_filenames :=
				CorporateActions.dAll_filenames
			+ CorporateOfficers.dAll_filenames
			+ CorporationEntity.dAll_filenames
			+ RegisteredAgent.dAll_filenames
			+ CorporationType.dAll_filenames
			+ NECountryCodes.dAll_filenames
			+ ListOfStates.dAll_filenames
		  ;

  end;
  
 
  export nh_raw :=
	module

		export address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::address::nh',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'|','\\n',);
		export corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporation::nh',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'|','\\n',);
		export prevnames                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::prev_names::nh',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'|','\\n',);
		export filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::nh',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'|','\\n',);
		export regagent                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::reg_agent::nh',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'|','\\n',);
		export principals                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::principals::nh',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'|','\\n',);
		export prinpurp                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::prin_purpose::nh',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'|','\\n',);
		export stock                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::stock::nh',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192,'|','\\n',);

		export dAll_filenames :=
					 address.dall_filenames
				 + corporation.dall_filenames
				 + prevnames.dall_filenames
				 + filing.dall_filenames
				 + regagent.dall_filenames
				 + principals.dall_filenames
				 + prinpurp.dall_filenames
				 + stock.dall_filenames
				;

	end;

	export nj_raw :=
	module

		export Business                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Business::nj',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,',');

		export dAll_filenames :=
			  Business.dAll_filenames
			;

	end;

	export nm_raw :=
	module
		//export Import_Master   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Import_Master::nm'		,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\t','\\r\\n',);
		export Import_Master   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Import_Master::nm'		,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\t','\\n',);
		export dAll_filenames  := Import_Master.dAll_filenames;

	end;

	export nv_raw :=
	module

		export ACTIONS                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::actions::nv',landing_zone,,,,,pGroupname    ,,,'VARIABLE',,,'~','\\n',);
		export Corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporation::nv',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'~','\\n',);
		export OFFICERS                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::officers::nv',landing_zone,,,,,pGroupname   ,,,'VARIABLE',,,'~','\\n',);
		export RA                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ra::nv',landing_zone,,,,,pGroupname         ,,,'VARIABLE',,,'~','\\n',);
		export STOCK                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::stocks::nv',landing_zone,,,,,pGroupname     ,,,'VARIABLE',,,'~','\\n',);
		export TMActions                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tmactions::nv',landing_zone,,,,,pGroupname  ,,,'VARIABLE',,,'~','\\n',);
		export TM                        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tm::nv',landing_zone,,,,,pGroupname         ,,,'VARIABLE',,,'~','\\n',);
		
		export dAll_filenames :=
			  ACTIONS.dAll_filenames
			+ Corporation.dAll_filenames
			+ OFFICERS.dAll_filenames
			+ RA.dAll_filenames
			+ STOCK.dAll_filenames
			+ TMActions.dAll_filenames
			+ TM.dAll_filenames
			;

	end;

	export ny_raw :=
	module
	
		export master                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::master::ny',landing_zone,,,252,,pGroupname,,,'FIXED',,,,,);
		export merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger::ny',landing_zone,,,252,,pGroupname,,,'FIXED',,,,,);
		export Constituent               := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Constituent::ny',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export Country_Principal         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Country_Principal::ny',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export Document_Types            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Document_Types::ny',landing_zone,,,,,pGroupname,,,'VARIABLE',,500,,'\\n',);
		export State_Possession          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::State_Possession::ny',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		
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
		export master1                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@g1::master::ny',landing_zone,,,262,,pGroupname,,,'FIXED',,,,,);
		export master2                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@g2::master::ny',landing_zone,,,262,,pGroupname,,,'FIXED',,,,,);
		export master3                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@g3::master::ny',landing_zone,,,262,,pGroupname,,,'FIXED',,,,,);
		export merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@g1::merger::ny',landing_zone,,,252,,pGroupname,,,'FIXED',,,,,);
		export Constituent               := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Constituent::ny',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export Country_Principal         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Country_Principal::ny',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);
		export Document_Types            := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::Document_Types::ny',landing_zone,,,,,pGroupname,,,'VARIABLE',,500,,'\\n',);
		export State_Possession          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::State_Possession::ny',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,,'\\n',);

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

		export Business_Address          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Business_Address::oh',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export Agent_Contact             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Agent_Contact::oh',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',',');
		export Business_Associate        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Business_Associate::oh',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export Business                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Business::oh',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,,'\\n',',');
		export CountyCodeType_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CountyCodeType_Table::oh',landing_zone,,,,,pGroupname,,,'VARIABLE',,200,'|','\\n',);
		export Explanation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Explanation::oh',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export Text_Information          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Text_Information::oh',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',',');
		export Old_Name                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Old_Name::oh',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',',');
		export Authorized_Share          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Authorized_Share::oh',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export StateCodeType_Table       := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StateCodeType_Table::oh',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,'|','\\n',);
		export TranCodeType_Table        := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::TranCodeType_Table::oh',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,'|','\\n',);
		export Document_Transaction      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Document_Transaction::oh',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'|','\\n',);
		export shareType_Table		       := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::shareType_Table::oh',landing_zone,,,,,pGroupname,,,'VARIABLE',,100,'|','\\n',);

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

		export AllRecs                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::all::ok',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'~');

		export dAll_filenames :=
			  AllRecs.dAll_filenames
			;

	end;
	
 export or_raw :=
	module

   	//export county_db_extract         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::county_db_extract::or',landing_zone,,,51,,pGroupname,,,'FIXED',,,,,,false,false,false);  
		//export entity_db_extract         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::entity_db_extract::or',landing_zone,,,241,,pGroupname,,,'FIXED',,,,,,false,false,false);  
		//export merger_share_db_extract   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger_share_db_extract::or',landing_zone,,,162,,pGroupname,,,'FIXED',,,,,,false,false,false);  
		//export name_db_extract           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name_db_extract::or',landing_zone,,,336,,pGroupname,,,'FIXED',,,,,,false,false,false);      
		//export rel_assoc_name_db_extract := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::rel_assoc_name_db_extract::or',landing_zone,,,484,,pGroupname,,,'FIXED',,,,,,false,false,false);  
		//export tran_db_extract           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tran_db_extract::or',landing_zone,,,131,,pGroupname,,,'FIXED',,,,,,false,false,false);  

    // From Dataland.
	   export county_db_extract         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::county_db_extract::or',landing_zone,,,,,pGroupname          ,,,'VARIABLE',,8192,,,);
		 export entity_db_extract         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::entity_db_extract::or',landing_zone,,,,,pGroupname          ,,,'VARIABLE',,8192,,,);
		 export merger_share_db_extract   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::merger_share_db_extract::or',landing_zone,,,,,pGroupname   ,,,'VARIABLE',,8192,,,);
		 export name_db_extract           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::name_db_extract::or',landing_zone,,,,,pGroupname            ,,,'VARIABLE',,8192,,,);
		 export rel_assoc_name_db_extract := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::rel_assoc_name_db_extract::or',landing_zone,,,,,pGroupname  ,,,'VARIABLE',,8192,,,);
		 export tran_db_extract           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::tran_db_extract::or',landing_zone,,,,,pGroupname            ,,,'VARIABLE',,8192,,,);

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

		export Address                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Address::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export AddressType               := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::AddressType::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export Corporation               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corporation::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export CorporationName           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::CorporationName::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export CorporationStatus         := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationStatus::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export CorporationType           := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CorporationType::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export DocumentType              := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::DocumentType::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export Filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Filing::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export Merger                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Merger::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export NameType                  := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::NameType::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export Officer                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officer::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export OfficerPartyType          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::OfficerPartyType::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export PartyType                 := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::PartyType::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);
		export StockOrig                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::StockOrig::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',,,,true);
		export StockClass                := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::StockClass::pa',landing_zone,,,,,pGroupname,,,'VARIABLE',, 2000,,'\\n',);

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

		export Amendments                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Amendments::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Amendments       := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Amendments::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export Entities                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Entities::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Entities         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Entities::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export Mergers                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Mergers::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Mergers          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Mergers::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export Names                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Names::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Names            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Names::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export Officers                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officers::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Officers         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Officers::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export Stocks                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Stocks::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export Inactive_Stocks           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Inactive_Stocks::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export corp_filings              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::corp_filings::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export country                   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::country::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);
		export state                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::lookup::@version@::state::ri',landing_zone,,,,,pGroupname,,,'VARIABLE',,,,,);

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

		export corpNameFile              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpNameFile::sc',landing_zone,,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);
		export corpTxnFile               := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpTxnFile::sc',landing_zone,,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);
		export corpFile                  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corpFile::sc',landing_zone,,,,,pGroupname,,,'VARIABLE',, 800,,'\\n',);

		export dAll_filenames :=
			  corpNameFile.dAll_filenames
			+ corpTxnFile.dAll_filenames
			+ corpFile.dAll_filenames
			;

	end;
		
	export sd_raw :=
	module

		export vendor_main							 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::vendor_main::sd',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'|','\\n',);
		export vendor_amendments				 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::vendor_amendments::sd',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'|','\\n',);
		export vendor_ar  							 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::vendor_ar::sd',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'|','\\n',);
	
		export dAll_filenames :=
			  Vendor_Main.dAll_filenames
			+ Vendor_amendments.dAll_filenames
			+ Vendor_ar.dAll_filenames;

	end;

	export tn_raw :=
	module

		export Filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing::tn'				,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'|','\\n',',');
		export FilingName                := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::filing_name::tn'		,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'|','\\n',);
		export Party                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::party::tn'					,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'|','\\n',);
		export AnnualReport              := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::annual_report::tn'	,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'|','\\n',);
		export BusinessTypeCode_Table    := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::BusinessTypeCode_Table::tn',landing_zone,,,,, pGroupname,,,'VARIABLE',,100,'\\t','\\n',);
		export ChargeCodeDesc_Table      := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::ChargeCodeDesc_Table::tn',landing_zone,,,,, pGroupname,,,'VARIABLE',,350,'\\t','\\n',);
		export CountyStateCode_Table     := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::CountyStateCode_Table::tn',landing_zone,,,,, pGroupname,,,'VARIABLE',,100,,'\\n',);

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

		export Master              			 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::master::tx',landing_zone,,,,,pGroupname,,,'VARIABLE',, ,,'\\n',);
		export nonprofitsubtype          := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::nonprofitsubtype::tx',landing_zone,,,,,pGroupname,,,'VARIABLE',, 100,,'\\n',);
		export mem_part_offi_title       := VersionControl.mInputFileNameVersions(lthor + 'lookup::corp2::@version@::mem_part_offi_title::tx',landing_zone,,,,,pGroupname,,,'VARIABLE',, 200,'\\|','\\n',);

		export dAll_filenames :=
			  Master.dAll_filenames
			+ nonprofitsubtype.dAll_filenames
			+ mem_part_offi_title.dAll_filenames
			; 

	end;

	export txbus_raw :=
	module

		export ftact                      := VersionControl.mInputFileNameVersions(lthor + 'in::Corp2::@version@::ftact::txbus'		,landing_zone,,,218,,pGroupname,,,'FIXED',,,,,);

		export dAll_filenames :=
			  ftact.dAll_filenames
			;

	end;

	export ut_raw :=
	module

		export Busentity1             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Busentity::ut',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export Busentity2             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Principals::ut',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
		export Busentity3             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Businfo::ut',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,,'\\n',);
          
		export dAll_filenames :=
			  Busentity1.dAll_filenames
			+ Busentity2.dAll_filenames
			+ Busentity3.dAll_filenames
			; 

	end;

		export va_raw :=
	module

		export Corps          := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Corps::va',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export LLC            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::LLC::va',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export LP             := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::LP::va',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Merger         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Merger::va',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export NamesHist      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::NamesHist::va',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Officer        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Officer::va',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Amendmt        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Amendment::va',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export ResrvdName     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::ResrvdName::va',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');
		export Tables         := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Tables::va',landing_zone,,,,,pGroupname,,,'VARIABLE',,8192 ,'\\t',,',');

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

		export Domestic_LLC_Bus     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_llc_bus::vt'       ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
 		export Domestic_MBE_Bus     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_mbe_bus::vt'       ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Domestic_NPC_Bus     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_npc_bus::vt'       ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Domestic_Prof_Bus    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_prof_bus::vt'      ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Domestic_LLC_Prin    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_llc_prn::vt'       ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
 		export Domestic_MBE_Prin    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_mbe_prn::vt'       ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Domestic_NPC_Prin    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_npc_prn::vt'       ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Domestic_Prof_Prin   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dom_prof_prn::vt'      ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
 		export Foreign_LLC_Bus      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::for_llc_bus::vt'       ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Foreign_NPC_Bus      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::for_npc_bus::vt'       ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Foreign_Prof_Bus     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::for_prof_bus::vt'      ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Foreign_LLC_Prin     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::for_llc_prn::vt'       ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Foreign_NPC_Prin     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::for_npc_prn::vt'       ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Foreign_Prof_Prin    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::for_prof_prn::vt'      ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
    export Partnerships_Bus     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::pships_bus::vt'        ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export Partnerships_Prin    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::pships_prn::vt'        ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
    export TradeNames_Bus       := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::trade_names_bus::vt'   ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export TradeNames_Prin      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::trade_names_prn::vt'   ,landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);
		export TradeNames_Owners    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::trade_names_owners::vt',landing_zone,,,,,pGroupname,,,'VARIABLE',,,'\\,','\\n',);

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
	
			export Corporations            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporations::wa',landing_zone,,,,,pGroupname,,,'XML','Corporation',512*500,,,); 
			export GoverningPersons        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::governingpersons::wa',landing_zone,,,,,pGroupname,,,'XML','Governor',512*500,,,); 
  		export DocumentTypes           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::documenttypes::wa',landing_zone,,,,,pGroupname,,,'XML','DocumentType',512*500,,,); 
			export BusinessInfo            := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::businessinfo::wa',landing_zone,,,,,pGroupname,,,'XML','BusinessInfo',512*500,,,); 


			export dAll_filenames :=
				  Corporations.dAll_filenames
				+ GoverningPersons.dAll_filenames
				+ DocumentTypes.dAll_filenames
				+ BusinessInfo.dAll_filenames
				;
	
	end;
	
	export wi_raw :=
	module

		export comfichex                 := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::comfichex::wi',landing_zone,,,,,pGroupname,,,'VARIABLE',,140,,,',');

		export dAll_filenames :=
			  comfichex.dAll_filenames
			;

	end;

	export wv_raw :=
	module

		export ds_Addresses	     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::addresses::wv',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_subsidiaries   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::subsidiaries::wv',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_amendments     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::amendments::wv',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_annualreports  := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::annualreports::wv',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_corporations   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::corporations::wv',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_dbas           := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dbas::wv',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_mergers        := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::mergers::wv',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_namechanges    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::namechanges::wv',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		export ds_Dissolutions   := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::dissolutions::wv',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000000,'\\~','\\n',);
		
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
	
		export Filing                    := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Filing::wy',landing_zone,,,,,pGroupname,,,'VARIABLE',,1000,'\\|','\\n',',');
		export Filing_Annual_Report      := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Filing_Annual_Report::wy',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'\\|','\\n',',');
		export Party                     := VersionControl.mInputFileNameVersions(lthor + 'in::corp2::@version@::Party::wy',landing_zone,,,,,pGroupname,,,'VARIABLE',,800,'\\|','\\n',);

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