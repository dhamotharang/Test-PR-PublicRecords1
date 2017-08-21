IMPORT VersionControl;

EXPORT Versions := MODULE
	EXPORT BankOfEngland_Version	 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::bank_of_england') : STORED('BANK_OF_ENGLAND_DATE');
	EXPORT DebbaredParties_Version := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::debarred_parties') : STORED('DEBARRED_PARTIES_DATE');
	EXPORT DeniedEntity_Version		 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::denied_entity') : STORED('DENIED_ENTITY_DATE');
	EXPORT DeniedPersons_Version	 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::denied_persons') : STORED('DENIED_PERSONS_DATE');
	EXPORT EUTerrorist_Version		 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::eu_terrorist_list::groups') : STORED('EUROPEAN_UNION_DESIGNATED_TERRORISTS'); //Both Persons & Group
	EXPORT Foreign_Agents_Version	 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::foreign_agents_registration::sre') : STORED('FOREIGN_AGENT_REGISTRATIONS_DATE');
	EXPORT InnovativeUNS_Version	 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::innovative_systems::UNS') : STORED('UNITED_NATIONS_SANCTIONS');
	EXPORT InnovativePEP_Version	 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::innovative_systems::PEP') : STORED('POLITICALLY_EXPOSED_PERSONS');
	EXPORT InnovativeOSC_Version	 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::innovative_systems::OSC') : STORED('OFAC_SANCTIONED_COUNTRIES');
	EXPORT InnovativeOCC_Version	 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::innovative_systems::OCC') : STORED('OFFICE_OF_THE_COMPTROLLER_OF_CURRENCY');
	EXPORT InnovativeFBI_Version	 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::innovative_systems::FBI') : STORED('FBI_MOST_WANTED');
	EXPORT InnovativeFIN_Version	 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::innovative_systems::FIN_GWL') : STORED('FINANCIAL_CRIMES_ENFORCEMENT'); //historical file
	EXPORT InnovativeCFT_Version	 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::innovative_systems::CFT') : STORED('COMMODITY_FUTURES_TRADING_COMMISSION');
	EXPORT IMW_Version 	 		 			 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::interpol_most_wanted') : STORED('INTERPOL_DATE');
	EXPORT IMW_INT_Version 	 		   := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::innovative_systems::INT') : STORED('INTERPOL_MOST_WANTED_RED_NOTICE');
	EXPORT OFAC_Version				 		 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::ofac') : STORED('OFAC_DATE'); //sdn file
	EXPORT OFAC_PLC_Version				 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::ofac::new_plc') : STORED('OFAC_PLC_DATE'); //nsp file
	EXPORT OSFI_Ent_Version 			 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::osfi_canada::entities') : STORED('OSFI_CANADA_ENTITIES_DATE');
	EXPORT OSFI_Ind_Version 			 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::osfi_canada::individuals') : STORED('OSFI_CANADA_INDIVIDUALS_DATE');
	EXPORT StateDeptForeign_Version	:= (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::state_department_terrorist'): STORED('STATE_DEPARTMENT_FOREIGN_TERRORIST');
	EXPORT StateDeptExcl_Version	 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::state_department_terrorist_exclusion') : STORED('STATE_DEPARTMENT_TERRORIST_EXCLUSIONS');
	EXPORT Unverified_Version 		 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::unverified') : STORED('UNVERIFIED_DATE');
	//EXPORT WorldBankRep_Version 	 := '20160210' : STORED('WORLD_BANK_REPRIMAND_DATE');
	EXPORT WorldBankDeb_Version 	 := (string)VersionControl.fGetFilenameVersion('~thor::in::GlobalWatchLists::world_bank') : STORED('WORLD_BANK_DEBARRED_DATE');
END;