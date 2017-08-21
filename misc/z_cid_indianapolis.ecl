
layout_cid_indi := record
string cellPhone;
string PhType;
string DID;
string RecType;
string FirstDate;
string LastDate;
string TelcoName;
string BusName;
string Fname;
string Mi;
string Lname;
string House;
string Predir;
string Street;
string StrType;
string Postdir;
string apttype;
string aptnbr;
string City;
string State;
string Zip;
string Zip_plus_4;
string DPC;
string CRTE;
string CNTY;
string Z4_Type;
string DPV;
string Deliverable;
string AddrValdate;
string Filler1;
string Filler2;
string Filler3;

end;
ds_cid_indi := dataset('~thor200::in::infutor_cid_indianapolist',layout_cid_indi,csv(heading(1),separator('\t'),terminator('\n'), separator(',')));

output(ds_cid_indi);

cellphone.mac_evaluateCellFile(ds_cid_indi,cellPhone,my_outfile);
sequential(my_outfile);

