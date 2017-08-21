import demo_data_scrambler;
import votersv2;

#workunit('name','Voters V2 keybuilds and superfile tx')

wuid := '20080930a';
filedate:= wuid;

s1:= fileservices.clearsuperfile('~thor_data400::base::voters::vote_history');
s2:= output(dataset([],votersv2.Layout_Voters_VoteHistory),,'~thor::base::demo_data_file_vote_history'+wuid+'_null',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::voters::vote_history','~thor::base::demo_data_file_vote_history'+wuid+'_null');

s4:= fileservices.clearsuperfile('~thor_data400::base::voters_reg');
s5:= output(demo_data_scrambler.scramble_votersv2_base,,'~thor::base::demo_data_file_votersv2'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::voters_reg','~thor::base::demo_data_file_votersv2'+wuid+'_scrambled');

s7 := VotersV2.Proc_build_voters_keys(filedate);
s8 := VotersV2.Proc_Build_Boolean_keys(filedate);

sequential(s1,s2,s3,s4,s5,s6,s7,s8);

