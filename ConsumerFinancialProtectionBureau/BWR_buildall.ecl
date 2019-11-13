import ConsumerFinancialProtectionBureau, std;

version := '20191116';
pUseProd := false;

MAC_Build_fcra_and_not(version, pUseProd) :success(ConsumerFinancialProtectionBureau.Send_Email(Version).Build_Success)
            ,failure(ConsumerFinancialProtectionBureau.Send_Email(Version).Build_Failure);
