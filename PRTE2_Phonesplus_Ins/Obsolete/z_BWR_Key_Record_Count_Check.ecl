import	_control, PRTE_CSV, phonesplus_v2, doxie, cellphone,RoxieKeyBuild, Address, ut, autokey, NID;

ge_data := PRTE_CSV.Phonesplus.dthor_data400__key__phonesplus__did_ge;
boca_did_data := PRTE_CSV.Phonesplus.dthor_data400__key__phonesplus__did;
alpha_did_data := PRTE_CSV.Phonesplus.Alpharetta_phonesplus_did;
OUTPUT(COUNT(boca_did_data));
OUTPUT(COUNT(ge_data));
OUTPUT(COUNT(alpha_did_data));

Tmp1 := COUNT(boca_did_data)+COUNT(ge_data);
TotalBoca := Tmp1-1;		// one header record
Tmp2 := COUNT(alpha_did_data);
TotalAlpha := Tmp2-1;		// one header record
Total := TotalBoca+TotalAlpha;
OUTPUT(TotalBoca);	
OUTPUT(TotalAlpha);	
		
// NOTE: The key prte::key::phonesplusv2::<DATE>::did should contain this number of records 
//       (unless records exist with blank DIDs or blank cellphones)
//  Other keys end up with more than this number.
didsGE := ge_data(did>0);
didsB := boca_did_data(did>0);
didsA := alpha_did_data(did>0);
didsCnt := COUNT(didsGE)+COUNT(didsB)+COUNT(didsA);

OUTPUT(Total);					//81,223
OUTPUT(didsCnt);				//81,224
OUTPUT(Total-didsCnt);			
