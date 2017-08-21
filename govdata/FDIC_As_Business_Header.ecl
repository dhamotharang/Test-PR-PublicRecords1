#OPTION('multiplePersistInstances',FALSE);
import business_headerV2;

export FDIC_As_Business_Header := fFDIC_As_Business_Header(Business_HeaderV2.Source_Files.fdic.BusinessHeader)
	: PERSIST(persistnames.AsBusinessHeader.FDIC);