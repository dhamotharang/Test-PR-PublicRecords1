#OPTION('multiplePersistInstances',FALSE);
import faa;

export PRTE_FAA_Aircraft_Reg_As_Business_Linking := FAA.fFAA_aircraft_reg_as_business_linking(prte_bip.persistnames().prepped_faa)
																								 :  persist(prte_bip.persistnames('faa').abl);																						 