IMPORT ML;
IMPORT ML.Types AS Types;
/*
Dataset from UCI Machine Learning Repository: MONK's Problems Data Set
http://archive.ics.uci.edu/ml/datasets/MONK's+Problems
We are using monks-1.train and monks-1.test without the 8th attribute: 'Id'.
Go to http://archive.ics.uci.edu/ml/machine-learning-databases/monks-problems/monks.names
for more details about the dataset; 
*/
EXPORT MonkDS := MODULE
	SHARED monkRecord := RECORD
		Types.t_FieldNumber class;
		Types.t_FieldNumber a1;
		Types.t_FieldNumber a2;
		Types.t_FieldNumber a3;
		Types.t_FieldNumber a4;
		Types.t_FieldNumber a5;
		Types.t_FieldNumber a6;
		Types.t_RecordID id;
	END;
	EXPORT Train_Data := DATASET([
		{1,1,1,1,1,3,1,5},
		{1,1,1,1,1,3,2,6},
		{1,1,1,1,3,2,1,19},
		{1,1,1,1,3,3,2,22},
		{1,1,1,2,1,2,1,27},
		{1,1,1,2,1,2,2,28},
		{1,1,1,2,2,3,1,37},
		{1,1,1,2,2,4,1,39},
		{1,1,1,2,3,1,2,42},
		{1,1,2,1,1,1,2,50},
		{0,1,2,1,1,2,1,51},
		{0,1,2,1,1,3,1,53},
		{0,1,2,1,1,4,2,56},
		{1,1,2,1,2,1,1,57},
		{0,1,2,1,2,3,1,61},
		{0,1,2,1,2,3,2,62},
		{0,1,2,1,2,4,2,64},
		{0,1,2,1,3,2,1,67},
		{0,1,2,1,3,4,2,72},
		{0,1,2,2,1,2,2,76},
		{0,1,2,2,2,3,2,86},
		{0,1,2,2,2,4,1,87},
		{0,1,2,2,2,4,2,88},
		{0,1,2,2,3,2,2,92},
		{0,1,2,2,3,3,1,93},
		{0,1,2,2,3,3,2,94},
		{0,1,3,1,1,2,1,99},
		{0,1,3,1,1,4,1,103},
		{0,1,3,1,2,2,1,107},
		{0,1,3,1,2,4,1,111},
		{1,1,3,1,3,1,2,114},
		{0,1,3,1,3,2,2,116},
		{0,1,3,1,3,3,1,117},
		{0,1,3,1,3,4,1,119},
		{0,1,3,1,3,4,2,120},
		{0,1,3,2,1,2,2,124},
		{1,1,3,2,2,1,2,130},
		{0,1,3,2,2,2,2,132},
		{0,1,3,2,2,3,2,134},
		{0,1,3,2,2,4,1,135},
		{0,1,3,2,2,4,2,136},
		{1,1,3,2,3,1,1,137},
		{0,1,3,2,3,2,1,139},
		{0,1,3,2,3,4,1,143},
		{0,1,3,2,3,4,2,144},
		{0,2,1,1,1,3,1,149},
		{0,2,1,1,1,3,2,150},
		{1,2,1,1,2,1,1,153},
		{1,2,1,1,2,1,2,154},
		{0,2,1,1,2,2,2,156},
		{0,2,1,1,2,3,1,157},
		{0,2,1,1,2,4,1,159},
		{0,2,1,1,2,4,2,160},
		{0,2,1,1,3,4,1,167},
		{0,2,1,2,1,2,2,172},
		{0,2,1,2,1,3,1,173},
		{0,2,1,2,1,4,2,176},
		{0,2,1,2,2,3,1,181},
		{0,2,1,2,2,4,2,184},
		{0,2,1,2,3,2,2,188},
		{0,2,1,2,3,4,1,191},
		{1,2,2,1,1,2,1,195},
		{1,2,2,1,1,2,2,196},
		{1,2,2,1,1,3,1,197},
		{1,2,2,1,2,3,2,206},
		{1,2,2,1,3,1,1,209},
		{1,2,2,1,3,1,2,210},
		{1,2,2,1,3,2,2,212},
		{1,2,2,1,3,3,2,214},
		{1,2,2,1,3,4,2,216},
		{1,2,2,2,1,1,1,217},
		{1,2,2,2,1,3,2,222},
		{1,2,2,2,1,4,1,223},
		{1,2,2,2,1,4,2,224},
		{1,2,2,2,2,2,1,227},
		{1,2,2,2,3,4,1,239},
		{1,2,3,1,1,1,1,241},
		{1,2,3,1,2,1,1,249},
		{0,2,3,1,2,3,1,253},
		{1,2,3,1,3,1,2,258},
		{0,2,3,1,3,3,1,261},
		{0,2,3,1,3,4,2,264},
		{0,2,3,2,1,3,2,270},
		{1,2,3,2,2,1,1,273},
		{1,2,3,2,2,1,2,274},
		{0,2,3,2,2,2,1,275},
		{0,2,3,2,3,3,2,286},
		{1,3,1,1,1,1,1,289},
		{1,3,1,1,1,1,2,290},
		{1,3,1,1,2,1,1,297},
		{0,3,1,1,2,2,2,300},
		{0,3,1,1,3,2,2,308},
		{1,3,1,2,1,1,1,313},
		{0,3,1,2,1,2,2,316},
		{0,3,1,2,2,2,2,324},
		{0,3,1,2,2,3,2,326},
		{0,3,1,2,3,2,2,332},
		{1,3,2,1,1,1,1,337},
		{0,3,2,1,1,4,2,344},
		{1,3,2,1,2,1,2,346},
		{0,3,2,1,2,4,2,352},
		{1,3,2,2,1,1,1,361},
		{1,3,2,2,1,1,2,362},
		{0,3,2,2,1,3,2,366},
		{1,3,2,2,3,1,1,377},
		{0,3,2,2,3,2,1,379},
		{0,3,2,2,3,4,1,383},
		{1,3,3,1,1,1,1,385},
		{1,3,3,1,1,2,1,387},
		{1,3,3,1,1,4,2,392},
		{1,3,3,1,2,3,2,398},
		{1,3,3,1,2,4,2,400},
		{1,3,3,1,3,1,2,402},
		{1,3,3,1,3,2,1,403},
		{1,3,3,1,3,2,2,404},
		{1,3,3,1,3,4,2,408},
		{1,3,3,2,1,1,1,409},
		{1,3,3,2,1,3,2,414},
		{1,3,3,2,1,4,1,415},
		{1,3,3,2,1,4,2,416},
		{1,3,3,2,3,1,2,426},
		{1,3,3,2,3,2,2,428},
		{1,3,3,2,3,3,2,430},
		{1,3,3,2,3,4,2,432}],
	monkRecord);
	EXPORT Test_Data := DATASET([
		{1,1,1,1,1,1,1,1},
		{1,1,1,1,1,1,2,2},
		{1,1,1,1,1,2,1,3},
		{1,1,1,1,1,2,2,4},
		{1,1,1,1,1,3,1,5},
		{1,1,1,1,1,3,2,6},
		{1,1,1,1,1,4,1,7},
		{1,1,1,1,1,4,2,8},
		{1,1,1,1,2,1,1,9},
		{1,1,1,1,2,1,2,10},
		{1,1,1,1,2,2,1,11},
		{1,1,1,1,2,2,2,12},
		{1,1,1,1,2,3,1,13},
		{1,1,1,1,2,3,2,14},
		{1,1,1,1,2,4,1,15},
		{1,1,1,1,2,4,2,16},
		{1,1,1,1,3,1,1,17},
		{1,1,1,1,3,1,2,18},
		{1,1,1,1,3,2,1,19},
		{1,1,1,1,3,2,2,20},
		{1,1,1,1,3,3,1,21},
		{1,1,1,1,3,3,2,22},
		{1,1,1,1,3,4,1,23},
		{1,1,1,1,3,4,2,24},
		{1,1,1,2,1,1,1,25},
		{1,1,1,2,1,1,2,26},
		{1,1,1,2,1,2,1,27},
		{1,1,1,2,1,2,2,28},
		{1,1,1,2,1,3,1,29},
		{1,1,1,2,1,3,2,30},
		{1,1,1,2,1,4,1,31},
		{1,1,1,2,1,4,2,32},
		{1,1,1,2,2,1,1,33},
		{1,1,1,2,2,1,2,34},
		{1,1,1,2,2,2,1,35},
		{1,1,1,2,2,2,2,36},
		{1,1,1,2,2,3,1,37},
		{1,1,1,2,2,3,2,38},
		{1,1,1,2,2,4,1,39},
		{1,1,1,2,2,4,2,40},
		{1,1,1,2,3,1,1,41},
		{1,1,1,2,3,1,2,42},
		{1,1,1,2,3,2,1,43},
		{1,1,1,2,3,2,2,44},
		{1,1,1,2,3,3,1,45},
		{1,1,1,2,3,3,2,46},
		{1,1,1,2,3,4,1,47},
		{1,1,1,2,3,4,2,48},
		{1,1,2,1,1,1,1,49},
		{1,1,2,1,1,1,2,50},
		{0,1,2,1,1,2,1,51},
		{0,1,2,1,1,2,2,52},
		{0,1,2,1,1,3,1,53},
		{0,1,2,1,1,3,2,54},
		{0,1,2,1,1,4,1,55},
		{0,1,2,1,1,4,2,56},
		{1,1,2,1,2,1,1,57},
		{1,1,2,1,2,1,2,58},
		{0,1,2,1,2,2,1,59},
		{0,1,2,1,2,2,2,60},
		{0,1,2,1,2,3,1,61},
		{0,1,2,1,2,3,2,62},
		{0,1,2,1,2,4,1,63},
		{0,1,2,1,2,4,2,64},
		{1,1,2,1,3,1,1,65},
		{1,1,2,1,3,1,2,66},
		{0,1,2,1,3,2,1,67},
		{0,1,2,1,3,2,2,68},
		{0,1,2,1,3,3,1,69},
		{0,1,2,1,3,3,2,70},
		{0,1,2,1,3,4,1,71},
		{0,1,2,1,3,4,2,72},
		{1,1,2,2,1,1,1,73},
		{1,1,2,2,1,1,2,74},
		{0,1,2,2,1,2,1,75},
		{0,1,2,2,1,2,2,76},
		{0,1,2,2,1,3,1,77},
		{0,1,2,2,1,3,2,78},
		{0,1,2,2,1,4,1,79},
		{0,1,2,2,1,4,2,80},
		{1,1,2,2,2,1,1,81},
		{1,1,2,2,2,1,2,82},
		{0,1,2,2,2,2,1,83},
		{0,1,2,2,2,2,2,84},
		{0,1,2,2,2,3,1,85},
		{0,1,2,2,2,3,2,86},
		{0,1,2,2,2,4,1,87},
		{0,1,2,2,2,4,2,88},
		{1,1,2,2,3,1,1,89},
		{1,1,2,2,3,1,2,90},
		{0,1,2,2,3,2,1,91},
		{0,1,2,2,3,2,2,92},
		{0,1,2,2,3,3,1,93},
		{0,1,2,2,3,3,2,94},
		{0,1,2,2,3,4,1,95},
		{0,1,2,2,3,4,2,96},
		{1,1,3,1,1,1,1,97},
		{1,1,3,1,1,1,2,98},
		{0,1,3,1,1,2,1,99},
		{0,1,3,1,1,2,2,100},
		{0,1,3,1,1,3,1,101},
		{0,1,3,1,1,3,2,102},
		{0,1,3,1,1,4,1,103},
		{0,1,3,1,1,4,2,104},
		{1,1,3,1,2,1,1,105},
		{1,1,3,1,2,1,2,106},
		{0,1,3,1,2,2,1,107},
		{0,1,3,1,2,2,2,108},
		{0,1,3,1,2,3,1,109},
		{0,1,3,1,2,3,2,110},
		{0,1,3,1,2,4,1,111},
		{0,1,3,1,2,4,2,112},
		{1,1,3,1,3,1,1,113},
		{1,1,3,1,3,1,2,114},
		{0,1,3,1,3,2,1,115},
		{0,1,3,1,3,2,2,116},
		{0,1,3,1,3,3,1,117},
		{0,1,3,1,3,3,2,118},
		{0,1,3,1,3,4,1,119},
		{0,1,3,1,3,4,2,120},
		{1,1,3,2,1,1,1,121},
		{1,1,3,2,1,1,2,122},
		{0,1,3,2,1,2,1,123},
		{0,1,3,2,1,2,2,124},
		{0,1,3,2,1,3,1,125},
		{0,1,3,2,1,3,2,126},
		{0,1,3,2,1,4,1,127},
		{0,1,3,2,1,4,2,128},
		{1,1,3,2,2,1,1,129},
		{1,1,3,2,2,1,2,130},
		{0,1,3,2,2,2,1,131},
		{0,1,3,2,2,2,2,132},
		{0,1,3,2,2,3,1,133},
		{0,1,3,2,2,3,2,134},
		{0,1,3,2,2,4,1,135},
		{0,1,3,2,2,4,2,136},
		{1,1,3,2,3,1,1,137},
		{1,1,3,2,3,1,2,138},
		{0,1,3,2,3,2,1,139},
		{0,1,3,2,3,2,2,140},
		{0,1,3,2,3,3,1,141},
		{0,1,3,2,3,3,2,142},
		{0,1,3,2,3,4,1,143},
		{0,1,3,2,3,4,2,144},
		{1,2,1,1,1,1,1,145},
		{1,2,1,1,1,1,2,146},
		{0,2,1,1,1,2,1,147},
		{0,2,1,1,1,2,2,148},
		{0,2,1,1,1,3,1,149},
		{0,2,1,1,1,3,2,150},
		{0,2,1,1,1,4,1,151},
		{0,2,1,1,1,4,2,152},
		{1,2,1,1,2,1,1,153},
		{1,2,1,1,2,1,2,154},
		{0,2,1,1,2,2,1,155},
		{0,2,1,1,2,2,2,156},
		{0,2,1,1,2,3,1,157},
		{0,2,1,1,2,3,2,158},
		{0,2,1,1,2,4,1,159},
		{0,2,1,1,2,4,2,160},
		{1,2,1,1,3,1,1,161},
		{1,2,1,1,3,1,2,162},
		{0,2,1,1,3,2,1,163},
		{0,2,1,1,3,2,2,164},
		{0,2,1,1,3,3,1,165},
		{0,2,1,1,3,3,2,166},
		{0,2,1,1,3,4,1,167},
		{0,2,1,1,3,4,2,168},
		{1,2,1,2,1,1,1,169},
		{1,2,1,2,1,1,2,170},
		{0,2,1,2,1,2,1,171},
		{0,2,1,2,1,2,2,172},
		{0,2,1,2,1,3,1,173},
		{0,2,1,2,1,3,2,174},
		{0,2,1,2,1,4,1,175},
		{0,2,1,2,1,4,2,176},
		{1,2,1,2,2,1,1,177},
		{1,2,1,2,2,1,2,178},
		{0,2,1,2,2,2,1,179},
		{0,2,1,2,2,2,2,180},
		{0,2,1,2,2,3,1,181},
		{0,2,1,2,2,3,2,182},
		{0,2,1,2,2,4,1,183},
		{0,2,1,2,2,4,2,184},
		{1,2,1,2,3,1,1,185},
		{1,2,1,2,3,1,2,186},
		{0,2,1,2,3,2,1,187},
		{0,2,1,2,3,2,2,188},
		{0,2,1,2,3,3,1,189},
		{0,2,1,2,3,3,2,190},
		{0,2,1,2,3,4,1,191},
		{0,2,1,2,3,4,2,192},
		{1,2,2,1,1,1,1,193},
		{1,2,2,1,1,1,2,194},
		{1,2,2,1,1,2,1,195},
		{1,2,2,1,1,2,2,196},
		{1,2,2,1,1,3,1,197},
		{1,2,2,1,1,3,2,198},
		{1,2,2,1,1,4,1,199},
		{1,2,2,1,1,4,2,200},
		{1,2,2,1,2,1,1,201},
		{1,2,2,1,2,1,2,202},
		{1,2,2,1,2,2,1,203},
		{1,2,2,1,2,2,2,204},
		{1,2,2,1,2,3,1,205},
		{1,2,2,1,2,3,2,206},
		{1,2,2,1,2,4,1,207},
		{1,2,2,1,2,4,2,208},
		{1,2,2,1,3,1,1,209},
		{1,2,2,1,3,1,2,210},
		{1,2,2,1,3,2,1,211},
		{1,2,2,1,3,2,2,212},
		{1,2,2,1,3,3,1,213},
		{1,2,2,1,3,3,2,214},
		{1,2,2,1,3,4,1,215},
		{1,2,2,1,3,4,2,216},
		{1,2,2,2,1,1,1,217},
		{1,2,2,2,1,1,2,218},
		{1,2,2,2,1,2,1,219},
		{1,2,2,2,1,2,2,220},
		{1,2,2,2,1,3,1,221},
		{1,2,2,2,1,3,2,222},
		{1,2,2,2,1,4,1,223},
		{1,2,2,2,1,4,2,224},
		{1,2,2,2,2,1,1,225},
		{1,2,2,2,2,1,2,226},
		{1,2,2,2,2,2,1,227},
		{1,2,2,2,2,2,2,228},
		{1,2,2,2,2,3,1,229},
		{1,2,2,2,2,3,2,230},
		{1,2,2,2,2,4,1,231},
		{1,2,2,2,2,4,2,232},
		{1,2,2,2,3,1,1,233},
		{1,2,2,2,3,1,2,234},
		{1,2,2,2,3,2,1,235},
		{1,2,2,2,3,2,2,236},
		{1,2,2,2,3,3,1,237},
		{1,2,2,2,3,3,2,238},
		{1,2,2,2,3,4,1,239},
		{1,2,2,2,3,4,2,240},
		{1,2,3,1,1,1,1,241},
		{1,2,3,1,1,1,2,242},
		{0,2,3,1,1,2,1,243},
		{0,2,3,1,1,2,2,244},
		{0,2,3,1,1,3,1,245},
		{0,2,3,1,1,3,2,246},
		{0,2,3,1,1,4,1,247},
		{0,2,3,1,1,4,2,248},
		{1,2,3,1,2,1,1,249},
		{1,2,3,1,2,1,2,250},
		{0,2,3,1,2,2,1,251},
		{0,2,3,1,2,2,2,252},
		{0,2,3,1,2,3,1,253},
		{0,2,3,1,2,3,2,254},
		{0,2,3,1,2,4,1,255},
		{0,2,3,1,2,4,2,256},
		{1,2,3,1,3,1,1,257},
		{1,2,3,1,3,1,2,258},
		{0,2,3,1,3,2,1,259},
		{0,2,3,1,3,2,2,260},
		{0,2,3,1,3,3,1,261},
		{0,2,3,1,3,3,2,262},
		{0,2,3,1,3,4,1,263},
		{0,2,3,1,3,4,2,264},
		{1,2,3,2,1,1,1,265},
		{1,2,3,2,1,1,2,266},
		{0,2,3,2,1,2,1,267},
		{0,2,3,2,1,2,2,268},
		{0,2,3,2,1,3,1,269},
		{0,2,3,2,1,3,2,270},
		{0,2,3,2,1,4,1,271},
		{0,2,3,2,1,4,2,272},
		{1,2,3,2,2,1,1,273},
		{1,2,3,2,2,1,2,274},
		{0,2,3,2,2,2,1,275},
		{0,2,3,2,2,2,2,276},
		{0,2,3,2,2,3,1,277},
		{0,2,3,2,2,3,2,278},
		{0,2,3,2,2,4,1,279},
		{0,2,3,2,2,4,2,280},
		{1,2,3,2,3,1,1,281},
		{1,2,3,2,3,1,2,282},
		{0,2,3,2,3,2,1,283},
		{0,2,3,2,3,2,2,284},
		{0,2,3,2,3,3,1,285},
		{0,2,3,2,3,3,2,286},
		{0,2,3,2,3,4,1,287},
		{0,2,3,2,3,4,2,288},
		{1,3,1,1,1,1,1,289},
		{1,3,1,1,1,1,2,290},
		{0,3,1,1,1,2,1,291},
		{0,3,1,1,1,2,2,292},
		{0,3,1,1,1,3,1,293},
		{0,3,1,1,1,3,2,294},
		{0,3,1,1,1,4,1,295},
		{0,3,1,1,1,4,2,296},
		{1,3,1,1,2,1,1,297},
		{1,3,1,1,2,1,2,298},
		{0,3,1,1,2,2,1,299},
		{0,3,1,1,2,2,2,300},
		{0,3,1,1,2,3,1,301},
		{0,3,1,1,2,3,2,302},
		{0,3,1,1,2,4,1,303},
		{0,3,1,1,2,4,2,304},
		{1,3,1,1,3,1,1,305},
		{1,3,1,1,3,1,2,306},
		{0,3,1,1,3,2,1,307},
		{0,3,1,1,3,2,2,308},
		{0,3,1,1,3,3,1,309},
		{0,3,1,1,3,3,2,310},
		{0,3,1,1,3,4,1,311},
		{0,3,1,1,3,4,2,312},
		{1,3,1,2,1,1,1,313},
		{1,3,1,2,1,1,2,314},
		{0,3,1,2,1,2,1,315},
		{0,3,1,2,1,2,2,316},
		{0,3,1,2,1,3,1,317},
		{0,3,1,2,1,3,2,318},
		{0,3,1,2,1,4,1,319},
		{0,3,1,2,1,4,2,320},
		{1,3,1,2,2,1,1,321},
		{1,3,1,2,2,1,2,322},
		{0,3,1,2,2,2,1,323},
		{0,3,1,2,2,2,2,324},
		{0,3,1,2,2,3,1,325},
		{0,3,1,2,2,3,2,326},
		{0,3,1,2,2,4,1,327},
		{0,3,1,2,2,4,2,328},
		{1,3,1,2,3,1,1,329},
		{1,3,1,2,3,1,2,330},
		{0,3,1,2,3,2,1,331},
		{0,3,1,2,3,2,2,332},
		{0,3,1,2,3,3,1,333},
		{0,3,1,2,3,3,2,334},
		{0,3,1,2,3,4,1,335},
		{0,3,1,2,3,4,2,336},
		{1,3,2,1,1,1,1,337},
		{1,3,2,1,1,1,2,338},
		{0,3,2,1,1,2,1,339},
		{0,3,2,1,1,2,2,340},
		{0,3,2,1,1,3,1,341},
		{0,3,2,1,1,3,2,342},
		{0,3,2,1,1,4,1,343},
		{0,3,2,1,1,4,2,344},
		{1,3,2,1,2,1,1,345},
		{1,3,2,1,2,1,2,346},
		{0,3,2,1,2,2,1,347},
		{0,3,2,1,2,2,2,348},
		{0,3,2,1,2,3,1,349},
		{0,3,2,1,2,3,2,350},
		{0,3,2,1,2,4,1,351},
		{0,3,2,1,2,4,2,352},
		{1,3,2,1,3,1,1,353},
		{1,3,2,1,3,1,2,354},
		{0,3,2,1,3,2,1,355},
		{0,3,2,1,3,2,2,356},
		{0,3,2,1,3,3,1,357},
		{0,3,2,1,3,3,2,358},
		{0,3,2,1,3,4,1,359},
		{0,3,2,1,3,4,2,360},
		{1,3,2,2,1,1,1,361},
		{1,3,2,2,1,1,2,362},
		{0,3,2,2,1,2,1,363},
		{0,3,2,2,1,2,2,364},
		{0,3,2,2,1,3,1,365},
		{0,3,2,2,1,3,2,366},
		{0,3,2,2,1,4,1,367},
		{0,3,2,2,1,4,2,368},
		{1,3,2,2,2,1,1,369},
		{1,3,2,2,2,1,2,370},
		{0,3,2,2,2,2,1,371},
		{0,3,2,2,2,2,2,372},
		{0,3,2,2,2,3,1,373},
		{0,3,2,2,2,3,2,374},
		{0,3,2,2,2,4,1,375},
		{0,3,2,2,2,4,2,376},
		{1,3,2,2,3,1,1,377},
		{1,3,2,2,3,1,2,378},
		{0,3,2,2,3,2,1,379},
		{0,3,2,2,3,2,2,380},
		{0,3,2,2,3,3,1,381},
		{0,3,2,2,3,3,2,382},
		{0,3,2,2,3,4,1,383},
		{0,3,2,2,3,4,2,384},
		{1,3,3,1,1,1,1,385},
		{1,3,3,1,1,1,2,386},
		{1,3,3,1,1,2,1,387},
		{1,3,3,1,1,2,2,388},
		{1,3,3,1,1,3,1,389},
		{1,3,3,1,1,3,2,390},
		{1,3,3,1,1,4,1,391},
		{1,3,3,1,1,4,2,392},
		{1,3,3,1,2,1,1,393},
		{1,3,3,1,2,1,2,394},
		{1,3,3,1,2,2,1,395},
		{1,3,3,1,2,2,2,396},
		{1,3,3,1,2,3,1,397},
		{1,3,3,1,2,3,2,398},
		{1,3,3,1,2,4,1,399},
		{1,3,3,1,2,4,2,400},
		{1,3,3,1,3,1,1,401},
		{1,3,3,1,3,1,2,402},
		{1,3,3,1,3,2,1,403},
		{1,3,3,1,3,2,2,404},
		{1,3,3,1,3,3,1,405},
		{1,3,3,1,3,3,2,406},
		{1,3,3,1,3,4,1,407},
		{1,3,3,1,3,4,2,408},
		{1,3,3,2,1,1,1,409},
		{1,3,3,2,1,1,2,410},
		{1,3,3,2,1,2,1,411},
		{1,3,3,2,1,2,2,412},
		{1,3,3,2,1,3,1,413},
		{1,3,3,2,1,3,2,414},
		{1,3,3,2,1,4,1,415},
		{1,3,3,2,1,4,2,416},
		{1,3,3,2,2,1,1,417},
		{1,3,3,2,2,1,2,418},
		{1,3,3,2,2,2,1,419},
		{1,3,3,2,2,2,2,420},
		{1,3,3,2,2,3,1,421},
		{1,3,3,2,2,3,2,422},
		{1,3,3,2,2,4,1,423},
		{1,3,3,2,2,4,2,424},
		{1,3,3,2,3,1,1,425},
		{1,3,3,2,3,1,2,426},
		{1,3,3,2,3,2,1,427},
		{1,3,3,2,3,2,2,428},
		{1,3,3,2,3,3,1,429},
		{1,3,3,2,3,3,2,430},
		{1,3,3,2,3,4,1,431},
		{1,3,3,2,3,4,2,432}],
		monkRecord);
END;
