import ebr;
import demo_data_scrambler;

#workunit('name','EBR keybuilds and superfile tx')

wuid := '20081110';
filedate:= wuid;



c1 :=  fileservices.clearsuperfile('~thor_data400::base::ebr_0010_Header');
c2 :=  fileservices.clearsuperfile('~thor_data400::base::ebr_1000_Executive_Summary');
c3 :=  fileservices.clearsuperfile('~thor_data400::base::ebr_2000_Trade');
c4 :=  fileservices.clearsuperfile('~thor_data400::base::ebr_2015_Trade_Payment_Totals');
c5 :=  fileservices.clearsuperfile('~thor_data400::base::ebr_2020_Trade_Payment_Trends');
c6 :=  fileservices.clearsuperfile('~thor_data400::base::ebr_2025_Trade_Quarterly_Averages');
c7 :=  fileservices.clearsuperfile('~thor_data400::base::ebr_4010_Bankruptcy');
c8 :=  fileservices.clearsuperfile('~thor_data400::base::ebr_4020_Tax_Liens');
c9 :=  fileservices.clearsuperfile('~thor_data400::base::ebr_4030_Judgement');
c10 := fileservices.clearsuperfile('~thor_data400::base::ebr_4035_Attachment_Lien');
c11 := fileservices.clearsuperfile('~thor_data400::base::ebr_4040_Bulk_Transfers');
c12 := fileservices.clearsuperfile('~thor_data400::base::ebr_4500_Collateral_Accounts');;
c13 := fileservices.clearsuperfile('~thor_data400::base::ebr_4510_UCC_Filings');
c14 := fileservices.clearsuperfile('~thor_data400::base::ebr_5000_Bank_Details');
c15 := fileservices.clearsuperfile('~thor_data400::base::ebr_5600_Demographic_Data');
c16 := fileservices.clearsuperfile('~thor_data400::base::ebr_5610_Demographic_Data');
c17 := fileservices.clearsuperfile('~thor_data400::base::ebr_6000_Inquiries');
c18 := fileservices.clearsuperfile('~thor_data400::base::ebr_6500_Government_Trade');
c19 := fileservices.clearsuperfile('~thor_data400::base::ebr_6510_Government_Debarred_Contractor');
c20 := fileservices.clearsuperfile('~thor_data400::base::ebr_7000_SNP_Parent_Name_Address');
c21 := fileservices.clearsuperfile('~thor_data400::base::ebr_7010_SNP_Data');



b1:=  output(demo_data_scrambler.scramble_ebr_0010,,'~thor::base::demo_data_file_ebr_0010'+wuid+'_scrambled',overwrite);
b2:=  output(demo_data_scrambler.scramble_ebr_1000,,'~thor::base::demo_data_file_ebr_1000'+wuid+'_scrambled',overwrite);
b3:=  output(demo_data_scrambler.scramble_ebr_2000,,'~thor::base::demo_data_file_ebr_2000'+wuid+'_scrambled',overwrite);
b4:=  output(demo_data_scrambler.scramble_ebr_2015,,'~thor::base::demo_data_file_ebr_2015'+wuid+'_scrambled',overwrite);
b5:=  output(demo_data_scrambler.scramble_ebr_2020,,'~thor::base::demo_data_file_ebr_2020'+wuid+'_scrambled',overwrite);
b6:=  output(demo_data_scrambler.scramble_ebr_2025,,'~thor::base::demo_data_file_ebr_2025'+wuid+'_scrambled',overwrite);
b7:=  output(demo_data_scrambler.scramble_ebr_4010,,'~thor::base::demo_data_file_ebr_4010'+wuid+'_scrambled',overwrite);
b8:=  output(demo_data_scrambler.scramble_ebr_4020,,'~thor::base::demo_data_file_ebr_4020'+wuid+'_scrambled',overwrite);
b9:=  output(demo_data_scrambler.scramble_ebr_4030,,'~thor::base::demo_data_file_ebr_4030'+wuid+'_scrambled',overwrite);
b10:= output(demo_data_scrambler.scramble_ebr_4035,,'~thor::base::demo_data_file_ebr_4035'+wuid+'_scrambled',overwrite);
b11:= output(demo_data_scrambler.scramble_ebr_4040,,'~thor::base::demo_data_file_ebr_4040'+wuid+'_scrambled',overwrite);
b12:= output(demo_data_scrambler.scramble_ebr_4500,,'~thor::base::demo_data_file_ebr_4500'+wuid+'_scrambled',overwrite);
b13:= output(demo_data_scrambler.scramble_ebr_4510,,'~thor::base::demo_data_file_ebr_4510'+wuid+'_scrambled',overwrite);
b14:= output(demo_data_scrambler.scramble_ebr_5000,,'~thor::base::demo_data_file_ebr_5000'+wuid+'_scrambled',overwrite);
b15:= output(demo_data_scrambler.scramble_ebr_5600,,'~thor::base::demo_data_file_ebr_5600'+wuid+'_scrambled',overwrite);
b16:= output(demo_data_scrambler.scramble_ebr_5610,,'~thor::base::demo_data_file_ebr_5610'+wuid+'_scrambled',overwrite);
b17:= output(demo_data_scrambler.scramble_ebr_6000,,'~thor::base::demo_data_file_ebr_6000'+wuid+'_scrambled',overwrite);
b18:= output(demo_data_scrambler.scramble_ebr_6500,,'~thor::base::demo_data_file_ebr_6500'+wuid+'_scrambled',overwrite);
b19:= output(demo_data_scrambler.scramble_ebr_6510,,'~thor::base::demo_data_file_ebr_6510'+wuid+'_scrambled',overwrite);
b20:= output(demo_data_scrambler.scramble_ebr_7000,,'~thor::base::demo_data_file_ebr_7000'+wuid+'_scrambled',overwrite);
b21:= output(demo_data_scrambler.scramble_ebr_7010,,'~thor::base::demo_data_file_ebr_7010'+wuid+'_scrambled',overwrite);


a1:=  fileservices.addsuperfile('~thor_data400::base::ebr_0010_header','~thor::base::demo_data_file_ebr_0010'+wuid+'_scrambled');
a2:=  fileservices.addsuperfile('~thor_data400::base::ebr_1000_executive_summary','~thor::base::demo_data_file_ebr_1000'+wuid+'_scrambled');
a3:=  fileservices.addsuperfile('~thor_data400::base::ebr_2000_trade','~thor::base::demo_data_file_ebr_2000'+wuid+'_scrambled');
a4:=  fileservices.addsuperfile('~thor_data400::base::ebr_2015_trade_payment_totals','~thor::base::demo_data_file_ebr_2015'+wuid+'_scrambled');
a5:=  fileservices.addsuperfile('~thor_data400::base::ebr_2020_Trade_Payment_Trends','~thor::base::demo_data_file_ebr_2020'+wuid+'_scrambled');
a6:=  fileservices.addsuperfile('~thor_data400::base::ebr_2025_Trade_Quarterly_Averages','~thor::base::demo_data_file_ebr_2025'+wuid+'_scrambled');
a7:=  fileservices.addsuperfile('~thor_data400::base::ebr_4010_Bankruptcy','~thor::base::demo_data_file_ebr_4010'+wuid+'_scrambled');
a8:=  fileservices.addsuperfile('~thor_data400::base::ebr_4020_Tax_Liens','~thor::base::demo_data_file_ebr_4020'+wuid+'_scrambled');
a9:=  fileservices.addsuperfile('~thor_data400::base::ebr_4030_Judgement','~thor::base::demo_data_file_ebr_4030'+wuid+'_scrambled');
a10:= fileservices.addsuperfile('~thor_data400::base::ebr_4035_Attachment_Lien','~thor::base::demo_data_file_ebr_4035'+wuid+'_scrambled');
a11:= fileservices.addsuperfile('~thor_data400::base::ebr_4040_Bulk_Transfers','~thor::base::demo_data_file_ebr_4040'+wuid+'_scrambled');
a12:= fileservices.addsuperfile('~thor_data400::base::ebr_4500_Collateral_Accounts','~thor::base::demo_data_file_ebr_4500'+wuid+'_scrambled');
a13:= fileservices.addsuperfile('~thor_data400::base::ebr_4510_UCC_Filings','~thor::base::demo_data_file_ebr_4510'+wuid+'_scrambled');
a14:= fileservices.addsuperfile('~thor_data400::base::ebr_5000_Bank_Details','~thor::base::demo_data_file_ebr_5000'+wuid+'_scrambled');
a15:= fileservices.addsuperfile('~thor_data400::base::ebr_5600_Demographic_Data','~thor::base::demo_data_file_ebr_5600'+wuid+'_scrambled');
a16:= fileservices.addsuperfile('~thor_data400::base::ebr_5610_Demographic_Data','~thor::base::demo_data_file_ebr_5610'+wuid+'_scrambled');
a17:= fileservices.addsuperfile('~thor_data400::base::ebr_6000_Inquiries','~thor::base::demo_data_file_ebr_6000'+wuid+'_scrambled');
a18:= fileservices.addsuperfile('~thor_data400::base::ebr_6500_Government_Trade','~thor::base::demo_data_file_ebr_6500'+wuid+'_scrambled');
a19:= fileservices.addsuperfile('~thor_data400::base::ebr_6510_Government_Debarred_Contractor','~thor::base::demo_data_file_ebr_6510'+wuid+'_scrambled');
a20:= fileservices.addsuperfile('~thor_data400::base::ebr_7000_SNP_Parent_Name_Address','~thor::base::demo_data_file_ebr_7000'+wuid+'_scrambled');
a21:= fileservices.addsuperfile('~thor_data400::base::ebr_7010_SNP_Data','~thor::base::demo_data_file_ebr_7010'+wuid+'_scrambled');


build_keys			:= ebr.Proc_Build_Keys(filedate);
build_autokeys			:= ebr.Proc_Buildautokeys(filedate);
accept_sk_to_qa		:= ebr.Proc_Accept_SK_to_QA(filedate);

sequential( 
parallel(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21),
parallel(b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21),
parallel(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21),
build_keys,
build_autokeys,
accept_sk_to_qa);

