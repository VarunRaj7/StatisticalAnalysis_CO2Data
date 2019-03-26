/* Generated Code (IMPORT) */
/* Source File: co2_n.csv */
/* Source Path: /folders/myfolders/Project */
/* Code generated on: 3/26/19, 4:30 PM */

%web_drop_table(LPROJECT.co2_n);


FILENAME REFFILE '/folders/myfolders/Project/co2_n.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=LPROJECT.co2_n;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=LPROJECT.co2_n; RUN;


%web_open_table(LPROJECT.co2_n);
