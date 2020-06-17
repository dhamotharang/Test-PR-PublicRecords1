IMPORT _control;
EXPORT Constants  := MODULE

    //Base/Input/Key Prefix/Key Suffix(s)
     EXPORT IN_PREFIX := '~prte::in::infutorcid::';
     EXPORT BASE_PREFIX := '~prte::base::infutor_cid::';
     EXPORT KEY_PREFIX := '~prte::key::infutorcid::';
     EXPORT FCRA_KEY_PREFIX := '~prte_fcra::key::infutorcid::';
     EXPORT ssn_set_exception := ['666326901','666253620',
                                  '666514992','666447324',
                                  '666946500','121984514',
                                  '093355823','093358339',
                                  '666205638','666441009',
                                  '666990130','666162567',
                                  '666501193','666505902',
                                  '666616404','666405378',
                                  '666273309','666299097',
                                  '666511026','666160713',
                                  '666281879','666400658',
                                  '666403646','666626605'
                                 ];
     
     
     
END;