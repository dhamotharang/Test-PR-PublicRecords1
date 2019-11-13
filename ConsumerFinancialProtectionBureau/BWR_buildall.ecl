import ConsumerFinancialProtectionBureau;

version := '20191114';
pUseProd := false; //change this to true on production

MAC_Build_fcra_and_not(version, pUseProd) :success(ConsumerFinancialProtectionBureau.Send_Email(Version).Build_Success)
            ,failure(ConsumerFinancialProtectionBureau.Send_Email(Version).Build_Failure);
