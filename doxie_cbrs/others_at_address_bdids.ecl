import doxie,business_header;
doxie_cbrs.mac_Selection_Declare()

subadd := doxie_cbrs.best_address(Include_BusinessesAtAddress_val);

//get other bdids at this address
otherbdids := doxie.bdid_from_address(subadd, true);

export others_at_address_bdids := otherbdids;