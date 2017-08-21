/*


The algorithm will follow the basic PR(A) = (1-d) + d(PR(T1)/C(T1) + .....PR(Tn)/C(Tn)) to solve the 
score values for each page where Tx refers to the pages containing links to page "A".

See http://www.webworkshop.net/pagerank.html and http://www.webrankinfo.com/english/pagerank/ for 
explanations.

To build a terabyte of data the one million row row Python/RMAT generated file must be sprayed to the system.
After taht has completed execute BWR_FabricateRawData and then BWR_BuildSandiaDataFile. These two BWR's
will put the Python generated million rows into the Sandia format.

Test notes:
	Run one iteration without the initial distribute and without the JOIN needed for the multiple iterations.
	Provide that time in the report.
*/