
import corp2;
import demo_data_scrambler;

#workunit('name','Corp V2 keybuilds and superfile tx')

wuid := '20080930a';
filedate:= wuid;

// repeat for all 4 ardata,eventdata,stockdata,corpdata,contdata

s1:= fileservices.clearsuperfile('~thor_data400::base::corp2::built::ar');
s2:= output(demo_data_scrambler.scramble_ardata,,'~thor::base::demo_data_file_ardata'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::corp2::built::ar','~thor::base::demo_data_file_ardata'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_data400::base::corp2::built::corp');
s5:= output(demo_data_scrambler.scramble_corpdata2,,'~thor::base::demo_data_file_corpdata'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::corp2::built::corp','~thor::base::demo_data_file_corpdata'+wuid+'_scrambled');

s7:= fileservices.clearsuperfile('~thor_data400::base::corp2::built::cont');
s8:= output(demo_data_scrambler.scramble_contdata2,,'~thor::base::demo_data_file_contdata'+wuid+'_scrambled',overwrite);
s9:= fileservices.addsuperfile('~thor_data400::base::corp2::built::cont','~thor::base::demo_data_file_contdata'+wuid+'_scrambled');

s10:= fileservices.clearsuperfile('~thor_data400::base::corp2::built::event');
s11:= output(demo_data_scrambler.scramble_eventdata,,'~thor::base::demo_data_file_eventdata'+wuid+'_scrambled',overwrite);
s12:= fileservices.addsuperfile('~thor_data400::base::corp2::built::event','~thor::base::demo_data_file_eventdata'+wuid+'_scrambled');

s13:= fileservices.clearsuperfile('~thor_data400::base::corp2::built::stock');
s14:= output(demo_data_scrambler.scramble_stockdata,,'~thor::base::demo_data_file_stockdata'+wuid+'_scrambled',overwrite);
s15:= fileservices.addsuperfile('~thor_data400::base::corp2::built::stock','~thor::base::demo_data_file_stockdata'+wuid+'_scrambled');

//event,stock

build_roxie_keys	:= corp2.mBuild_Roxie_Keys(filedate).Build_All;
promote2QA			:= corp2.Promote_Built_To_QA;
build_boolean		:= corp2.Proc_Build_Boolean_Keys(filedate);

sequential(s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,build_roxie_keys,promote2QA,build_boolean);

