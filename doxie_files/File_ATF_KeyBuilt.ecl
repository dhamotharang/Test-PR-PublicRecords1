/*2011-12-05T17:16:48Z (Giri_Prod Rajulapalli)

*/
import atf,ut;

ATF_Base := dataset('~thor_Data400::base::atf_firearms_explosives_BUILT',{atf.layout_firearms_explosives_out_Bid,unsigned8 __fpos {virtual(fileposition)}},flat);

ATF_base_KeyBuild := project(ATF_Base, transform({atf.layout_firearms_explosives_out_Bid - [bid, bid_score],unsigned8 __fpos {virtual(fileposition)}}, self := left));

export File_ATF_KeyBuilt := ATF_base_KeyBuild;
//export File_ATF_KeyBuilt := dataset('~thor_Data400::base::atf_firearms_explosives_BUILT',{atf.layout_firearms_explosives_out_Bid,unsigned8 __fpos {virtual(fileposition)}},flat);