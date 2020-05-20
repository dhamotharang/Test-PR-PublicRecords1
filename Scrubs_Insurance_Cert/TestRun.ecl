IMPORT Scrubs_Insurance_Cert as x;

r1 := {
    x.Cert_Layout_Insurance_Cert;
    COUNT(GROUP);
};

T1 := TABLE(X.Cert_In_Insurance_Cert,r1);