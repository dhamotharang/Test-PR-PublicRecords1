import Data_Services;

export constants  := module

/* Skip Parms: B(Biz), C(Person Contact), F(FEIN), P(Personal Phones), Q(Biz Phones), S(SSN) */
export ak_keyname := cluster_name+'key::SANCTN::@version@::autokey::';
export ak_logical(string filedate) := cluster_name+'key::SANCTN::'+ filedate +'::autokey::';
export ak_qa_keyname := cluster_name + 'key::SANCTN::qa::autokey::';
export skipSet := ['P','Q','F'];

export type_str := 'AK';
export boolean USE_ALL_LOOKUPS  := TRUE;
end;

import Data_Services;


