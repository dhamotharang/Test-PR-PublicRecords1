import Births;

d01 := output(choosen(Births.BaseFile_births, 1000),named('Births_sample_QA'));

export Sample_data := parallel(
								d01
								);
	