/*2012-11-05T20:25:37Z (Shannon Lucero)

*/
Import ut;
export file_firearms_explosives_base_Bid := dataset('~thor_data400::base::atf_firearms_explosives',atf.layout_firearms_explosives_out_bid,flat);
//export file_firearms_explosives_base_Bid := dataset(ut.foreign_prod+'~thor_data400::base::atf_firearms_explosives',atf.layout_firearms_explosives_out_bid,flat);