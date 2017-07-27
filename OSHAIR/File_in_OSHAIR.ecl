import OSHAIR;
#option('skipFileFormatCrcCheck', 1);

export File_in_OSHAIR := dataset(OSHAIR.cluster + 'in::oshair::payload'
                                  ,OSHAIR.layout_OSHAIR_in_ASCII.inspection_rec
								  ,thor);