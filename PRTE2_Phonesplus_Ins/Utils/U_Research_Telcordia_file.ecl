// PRTE2_Phonesplus_Ins.U_Research_Telcordia_file
IMPORT ut;

KeyFileName := ut.foreign_prod+'prte::key::telcordia::20110920::tds';

Layout_In_EclWatch := RECORD
  string1 tb;
  string2 state;
  string1 timezone;
  string3 coctype;
  string4 ssc;
  string4 wireless_ind;
  unsigned8 __internal_fpos__;
END;
IndexFields := RECORD
  string3 npa;
  string3 nxx;
END;

prct_data_key := INDEX({IndexFields}, Layout_In_EclWatch, keyFileName);
OUTPUT(prct_data_key);
// just get an idea what sort of NPA go with each state.
prct_data_key_ded := DEDUP(SORT(prct_data_key,npa,state),npa,state);

// Research AK data
prct_data_key_AK := SORT(prct_data_key(state='AK' AND ssc='C'),npa,nxx,state);
prct_data_key_AKL := SORT(prct_data_key(state='AK' AND ssc='N' and coctype='EOC'),npa,nxx,state);

// OUTPUT NJ data just to see if any obvious differences in a populous state
prct_data_key_NJ := SORT(prct_data_key(state='NJ' AND ssc='C'),npa,nxx,state);

OUTPUT(COUNT(prct_data_key_ded));
OUTPUT(prct_data_key_ded);

OUTPUT(COUNT(prct_data_key_AK));			//There are 1290 AK Exchanges with a "C"
OUTPUT(prct_data_key_AK);
OUTPUT(COUNT(prct_data_key_AKL));			//There are 4276 AK Exchanges with EOC-N
OUTPUT(prct_data_key_AKL);

OUTPUT(COUNT(prct_data_key_NJ));
OUTPUT(prct_data_key_NJ);

// just check a known landline set of numbers
bap_test := prct_data_key(npa='770' and nxx='439' and tb='0');
OUTPUT(bap_test);

