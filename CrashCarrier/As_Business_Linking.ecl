#OPTION('multiplePersistInstances',FALSE);
import business_header,Business_HeaderV2;

EXPORT As_Business_Linking := CrashCarrier.fCrashCarrier_As_Business_Linking(,CrashCarrier.files().base.qa)
   	: PERSIST(business_header.Bus_Thor() + 'persist::CrashCarrier::As_Business_Linking');