import Data_Services;

export constants  := module

// export constants(string filedate='') := module

/* Skip Parms: B(Biz), C(Person Contact), F(FEIN), P(Personal Phones), Q(Biz Phones), S(SSN) */
export ak_dataset := SANCTN_Mari.file_Midex_Searchautokey;
export ak_keyname := cluster_name+'key::SANCTN::NP::autokey::@version@::';
export ak_logical(string filedate) := cluster_name+'key::SANCTN::NP::'+ filedate +'::autokey::';
export ak_qa_keyname := cluster_name + 'key::SANCTN::NP::autokey::qa::';
export skipSet := [];

export type_str := 'AK';
export boolean USE_ALL_LOOKUPS  := TRUE;
end;

