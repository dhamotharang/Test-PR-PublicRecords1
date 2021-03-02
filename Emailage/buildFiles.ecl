import PromoteSupers;
#OPTION ('multiplePersistInstances',FALSE);

dsNames   := join($.names, $.AllowedLexids, left.lexid = right.lexid, transform(left), local);
dsAddress := join($.address, $.AllowedLexids, left.lexid = right.lexid, transform(left), local);

PromoteSupers.MAC_SF_BuildProcess(dsNames,'~thor::base::emailage::names',buildNames,2,,true);
PromoteSupers.MAC_SF_BuildProcess(dsAddress,'~thor::base::emailage::address',buildAddress,2,,true);
PromoteSupers.MAC_SF_BuildProcess($.Metadata,'~thor::base::emailage::metadata',buildMetadata,2,,true);
PromoteSupers.MAC_SF_BuildProcess($.Emails,'~thor::base::emailage::emails',buildEmails,2,,true);
PromoteSupers.MAC_SF_BuildProcess($.Phones,'~thor::base::emailage::phones',buildPhones,2,,true);
PromoteSupers.MAC_SF_BuildProcess($.Relatives,'~thor::base::emailage::relatives',buildRelatives,2,,true);
PromoteSupers.MAC_SF_BuildProcess($.Fraudflags,'~thor::base::emailage::fraudflags',buildFraudflags,2,,true);

// buildAddress;
// buildPhones;
// buildRelatives;
buildEmails;

buildFiles := SEQUENTIAL(
			buildNames,
			buildAddress,
			buildMetadata,
			buildEmails,
			buildPhones,
			buildRelatives,
			buildFraudflags);

			// buildFiles;