IMPORT PRTE2_PhonesPlus, PRTE2_Common, PhonesPlus_V2, CellPhone, Address, ut, doxie, autokey, Data_Services;

EXPORT Files := MODULE

	EXPORT Alpharetta_base_in := DATASET(PRTE2_Common.Cross_Module_Files.PhonesPlus_Base_SF_Name, Layouts.Alpha_CSV_Layout, THOR);
	
	EXPORT Boca_GE_in	:= DATASET(PRTE2_PhonesPlus.Constants.IN_PREFIX + 'boca::ge', PRTE2_PhonesPlus.Layouts.Base_in,
																																CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
																		
	EXPORT PhonesHist_in	:= DATASET(PRTE2_PhonesPlus.Constants.IN_PREFIX + 'boca::hist', PRTE2_PhonesPlus.Layouts.Base_common,
																			CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
																		
	EXPORT f_phonesplus_ext	:= DATASET(PRTE2_PhonesPlus.Constants.BASE_PREFIX + 'base_all', PRTE2_PhonesPlus.Layouts.Base_ext, THOR);
	
	EXPORT f_phonesplus		:= 	PROJECT(f_phonesplus_ext, Phonesplus_v2.Layout_Phonesplus_Base);
	
	EXPORT fphonesplus_did :=	sort(f_phonesplus((unsigned)did<>0, (unsigned)cellphone<>0), did);

//For AutoKeys
Address.MAC_Multi_City(f_phonesplus,p_city_name,zip5,multiCityPhonesplus);

xl_phonesplus := RECORD
	Phonesplus_v2.File_Phonesplus_Base;
	unsigned6 fdid;
	zero := 0;
	blk := '';
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('NXTO'))| ut.bit_set(0,0);
END;

xl_phonesplus xpand_phonesplus(multiCityPhonesplus le,integer phonesplus_cntr) :=  TRANSFORM 
	SELF.fdid := phonesplus_cntr + autokey.did_adder('NXTO'); 
	SELF := le; 
END;

	EXPORT DS_phonesplus := PROJECT(multiCityPhonesplus,xpand_phonesplus(LEFT,COUNTER));
	EXPORT dist_DSphonesplus := distribute(DS_phonesplus,random());
	EXPORT dist_DSphonesplus_roy := dataset([], recordof(DS_phonesplus));
	

PRTE2_PhonesPlus.Layouts.DSphonesplus_slim slim_it(dist_DSphonesplus l) := TRANSFORM
	self := l;
END;

	EXPORT dist_DSphonesplus_slim := sort(project(dist_DSphonesplus, slim_it(left)),fdid,skew(1));

//Blank keys in Prod
	EXPORT iverification := dataset([], recordof(phonesplus_v2.File_Iverification.base)); 
	
	EXPORT neustar := CellPhone.fileNeuStar;
	
	EXPORT neustar_history := Phonesplus_V2.File_Neustar_History; 
	
	EXPORT scoring := dataset([], recordof(Phonesplus_v2.File_Scoring.base));

END;